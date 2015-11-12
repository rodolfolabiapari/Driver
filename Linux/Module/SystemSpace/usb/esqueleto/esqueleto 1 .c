/*
 * USB Skeleton driver - 2.0
 *
 * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License as
 *	published by the Free Software Foundation, version 2.
 *
 * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c 
 * but has been rewritten to be easy to read and use, as no locks are now
 * needed anymore.
 */

//#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/kref.h>
//#include <linux/smp_lock.h>
#include <linux/usb.h>
#include <asm/uaccess.h>


static struct usb_device_id skel_table [] = {
	//{ USB_DEVICE(USB_SKEL_VENDOR_ID, USB_SKEL_PRODUCT_ID) },
	{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{ }					// Terminating entry 
};
MODULE_DEVICE_TABLE (usb, skel_table);


#define USB_SKEL_MINOR_BASE	192

// Structure to hold all of our device specific stuff 
struct usb_skel {
	struct usb_device *	udev;			// the usb device for this device 
	struct usb_interface *	interface;		// the interface for this device 
	unsigned char *		bulk_in_buffer;		// the buffer to receive data 
	size_t			bulk_in_size;		// the size of the receive buffer 
	__u8			bulk_in_endpointAddr;	// the address of the bulk in endpoint 
	__u8			bulk_out_endpointAddr;	// the address of the bulk out endpoint 
	struct kref		kref;
};
#define to_skel_dev(d) container_of(d, struct usb_skel, kref)

static struct usb_driver skel_driver;


static void skel_delete(struct kref *kref)
{	
	struct usb_skel *dev = to_skel_dev(kref);

	usb_put_dev(dev->udev);
	kfree (dev->bulk_in_buffer);
	kfree (dev);
}

static int skel_open(struct inode *inode, struct file *file)
{
	struct usb_skel *dev;
	struct usb_interface *interface;
	int subminor;
	int retval = 0;

	printk(KERN_ERR "|- - - - INICIANDO OPEN();\n");
	subminor = iminor(inode);

	interface = usb_find_interface(&skel_driver, subminor);
	if (!interface) {
		printk(KERN_ERR "|- - - - - - %s - error, can't find device for minor %d",
		     __FUNCTION__, subminor);
		retval = -ENODEV;
		goto exit;
	}
	printk(KERN_ERR "|- - - - - - Interface do dispositivo foi encontrada\n");

	dev = usb_get_intfdata(interface);
	if (!dev) {
		retval = -ENODEV;
		goto exit;
	}
	printk(KERN_ERR "|- - - - - - Estrutura Geral do dispositivo foi encontrada\n");
	
	// increment our usage count for the device 
	kref_get(&dev->kref);
	printk(KERN_ERR "|- - - - - - kref_get Feito com sucesso (increment our usage count for the device)\n");

	// save our object in the file's private structure 
	file->private_data = NULL;
	file->private_data = dev;

	if (!file->private_data) {
		retval = -ENODEV;
		printk(KERN_ERR "|- - - - - - Estrutura Geral NAO salvada no file->private_data\n");
		goto exit;
	}
	printk(KERN_ERR "|- - - - - - Estrutura Geral salvada no file->private_data\n");

	printk(KERN_ERR "|- - - - - - FUNCAO OPEN() FINALIZADA. ARQUIVO ABERTO\n");

exit:
	return retval;
}

static int skel_release(struct inode *inode, struct file *file)
{
	struct usb_skel *dev;
	printk(KERN_ERR "|- - - - - - INICIANDO RELEASE();\n");

	dev = (struct usb_skel *)file->private_data;
	if (dev == NULL)
		return -ENODEV;
	printk(KERN_ERR "|- - - - - - Dispositivo encontrado com sucesso\n");

	// decrement the count on our device 
	kref_put(&dev->kref, skel_delete);
	printk(KERN_ERR "|- - - - - - kref_put Feito com sucesso (decrement the count on our device)\n");

	printk(KERN_ERR "|- - - - FUNCAO RELEASE() FINALIZADA. ARQUIVO FECHADO\n");
	return 0;
}

static ssize_t skel_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
{
	struct usb_skel *dev;
	int retval = 0;
	int count_wrote = 0;

	dev = (struct usb_skel *)file->private_data;
	
	// do a blocking bulk read to get data from the device 
	retval = usb_bulk_msg(dev->udev,
			      usb_rcvbulkpipe(dev->udev, dev->bulk_in_endpointAddr),
			      dev->bulk_in_buffer,
			      min(dev->bulk_in_size, count),
			      &count_wrote, HZ*10);

	// if the read was successful, copy the data to userspace 
	if (!retval) {
		if (copy_to_user(buffer, dev->bulk_in_buffer, count))
			retval = -EFAULT;
		else
			retval = count;
	}

	count = (size_t) count_wrote;

	return retval;
}

char *buf = NULL;
static void skel_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
{
	// sync/async unlink faults aren't errors 
	if (urb->status && 
	    !(urb->status == -ENOENT || 
	      urb->status == -ECONNRESET ||
	      urb->status == -ESHUTDOWN)) {
		printk(KERN_DEBUG "%s - nonzero write bulk status received: %d",
		    __FUNCTION__, urb->status);
	}

	// free up our allocated buffer 
	//usb_buffer_free(urb->dev, urb->transfer_buffer_length, 
			//urb->transfer_buffer, urb->transfer_dma);
	kfree(buf);

}

static ssize_t skel_write(struct file *file, const char __user *user_buffer, size_t count, loff_t *ppos)
{
	struct usb_skel *dev;
	int retval = 0, int_count;
	struct urb *urb = NULL;

	printk(KERN_ERR "|- - - - - - INICIANDO WRITE()\n");


	if (!file->private_data) {
		retval = -ENODEV;
		printk(KERN_ERR "|- - - - - - - - Estrutura Geral NAO encontrada dentro do file->private_data\n");
		goto error;
	}
	printk(KERN_ERR "|- - - - - - - - Estrutura Geral encontrada dentro do file->private_data\n");

	dev = (struct usb_skel *) file->private_data;

	if (!dev) {
		retval = -ENODEV;
		printk(KERN_ERR "|- - - - - - - - Estrutura Geral NAO encontrada\n");
		goto error;
	}
	printk(KERN_ERR "|- - - - - - - - Estrutura Geral encontrada\n");

	// verify that we actually have some data to write 
	if (count == 0)
		goto exit;

	// create a urb, and a buffer for it, and copy the data to the urb 
	urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!urb) {
		retval = -ENOMEM;
		printk(KERN_ERR "|- - - - - - - - URB NAO ALOCADO %d\n", retval);
		goto error;
	}
	printk(KERN_ERR "|- - - - - - - - URB alocado com sucesso\n");

	//buf = usb_buffer_alloc(dev->udev, count, GFP_KERNEL, &urb->transfer_dma);
	buf = kmalloc(count, GFP_KERNEL);

	if (buf == NULL) {
		retval = -ENOMEM;
		printk(KERN_ERR "|- - - - - - - - BUFFER NAO ALOCADO %d\n", retval);
		goto error;
	}
	memset(buf, 0x00, count);
	printk(KERN_ERR "|- - - - - - - - Buffer alocado com sucesso\n");

	if (copy_from_user(buf, user_buffer, count)) {
		retval = -EFAULT;
		printk(KERN_ERR "|- - - - - - - - Nao foi possivel capturar os dados do usuario.\n");
		goto error;
	}

	int_count = (int) count;
	// initialize the urb properly 
	usb_fill_bulk_urb(urb, dev->udev, 
			  usb_sndbulkpipe(dev->udev, dev->bulk_out_endpointAddr), buf, 
			  int_count, skel_write_bulk_callback,
			  dev);

	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

	// send the data out the bulk port 
	retval = usb_submit_urb(urb, GFP_KERNEL);
	if (retval) {
		printk(KERN_ERR "|- - - - - - - - %s - failed submitting write urb, error %d", __FUNCTION__, retval);
		goto error;
	}
	
	printk(KERN_ERR "|- - - - - - - - URB enviado com sucesso (%d)\n", retval);

	// release our reference to this urb, the USB core will eventually free it entirely 
	usb_free_urb(urb);
	printk(KERN_ERR "|- - - - - - FINALIZANDO WRITE()\n");

exit:
	return count;

error:
	//usb_buffer_free(dev->udev, count, buf, urb->transfer_dma);
	usb_free_urb(urb);
	kfree(buf);
	return retval;
}

static struct file_operations skel_fops = {
	//.owner =	THIS_MODULE,
	.read =		skel_read,
	.write =	skel_write,
	.open =		skel_open,
	.release =	skel_release,
};

/*
 * usb class driver info in order to get a minor number from the usb core,
 * and to have the device registered with devfs and the driver core
 */
static struct usb_class_driver skel_class = {
	.name = "usb/skel%d",
	.fops = &skel_fops,
	//.mode = S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
	.minor_base = USB_SKEL_MINOR_BASE,
};

static int skel_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	struct usb_skel *dev = NULL;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;
	size_t buffer_size;
	int i;
	int retval = -ENOMEM;

	printk(KERN_INFO "|- - - - INICIANDO PROBE();\n"); 

	// allocate memory for our device state and initialize it 
	dev = kmalloc(sizeof(struct usb_skel), GFP_KERNEL);
	if (dev == NULL) {
		printk(KERN_ERR "|- - - - - - Out of memory\n");
		goto error;
	}
	memset(dev, 0x00, sizeof (*dev));
	kref_init(&dev->kref);
	printk(KERN_INFO "|- - - - - - Memoria alocada\n"); 

	dev->udev = usb_get_dev(interface_to_usbdev(interface));
	dev->interface = interface;

	// set up the endpoint information 
	// use only the first bulk-in and bulk-out endpoints 
	iface_desc = interface->cur_altsetting;
	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
		endpoint = &iface_desc->endpoint[i].desc;

		if (!dev->bulk_in_endpointAddr &&
		    (endpoint->bEndpointAddress & USB_DIR_IN) &&
		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
					== USB_ENDPOINT_XFER_BULK)) {
			// we found a bulk in endpoint 
			buffer_size = endpoint->wMaxPacketSize;
			dev->bulk_in_size = buffer_size;
			dev->bulk_in_endpointAddr = endpoint->bEndpointAddress;
			dev->bulk_in_buffer = kmalloc(buffer_size, GFP_KERNEL);
			if (!dev->bulk_in_buffer) {
				printk(KERN_ERR "|- - - - - - Could not allocate bulk_in_buffer\n");
				goto error;
			}
		}

		if (!dev->bulk_out_endpointAddr &&
		    !(endpoint->bEndpointAddress & USB_DIR_IN) &&
		    ((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK)
					== USB_ENDPOINT_XFER_BULK)) {
			// we found a bulk out endpoint 
			dev->bulk_out_endpointAddr = endpoint->bEndpointAddress;
		}
	}
	if (!(dev->bulk_in_endpointAddr && dev->bulk_out_endpointAddr)) {
		printk(KERN_ERR "|- - - - - - Could not find both bulk-in and bulk-out endpoints\n");
		goto error;
	}
	printk(KERN_INFO "|- - - - - - Estrutura geral do device (dev) foi preenchida com sucesso\n"); 

	// save our data pointer in this interface device 
	usb_set_intfdata(interface, dev);

	// we can register the device now, as it is ready 
	retval = usb_register_dev(interface, &skel_class);
	if (retval) {
		// something prevented us from registering this driver 
		printk(KERN_ERR "|- - - - - - Not able to get a minor for this device.\n");
		usb_set_intfdata(interface, NULL);
		goto error;
	}
	printk(KERN_INFO "|- - - - - - Registro do device realizado com sucesso\n"); 

	// let the user know what node this device is now attached to 
	printk(KERN_INFO "|- - - - USB ADICIONADO COM SUCESSO. Nomeacao: skel%d\n", interface->minor);
	return 0;

error:
	if (dev)
		kref_put(&dev->kref, skel_delete);
	return retval;
}

static void skel_disconnect(struct usb_interface *interface)
{
	struct usb_skel *dev;
	int minor = interface->minor;
	printk(KERN_INFO "|- - - - INICIANDO DISCONNECT();\n"); 

	// prevent skel_open() from racing skel_disconnect() 
	//lock_kernel();

	dev = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);

	// give back our minor 
	usb_deregister_dev(interface, &skel_class);

	//unlock_kernel();

	// decrement our usage count 
	kref_put(&dev->kref, skel_delete);

	printk(KERN_INFO "|- - - - USB skel%d FOI DESACOPLADO DO COMPUTADOR\n", minor);
}

static struct usb_driver skel_driver = {
	.name = "skeleton",
	.id_table = skel_table,
	.probe = skel_probe,
	.disconnect = skel_disconnect,
};

static int __init usb_skel_init(void)
{
	int result;

	printk(KERN_INFO "\n\n|- - INICIANDO MODULO\n"); 

	result = usb_register(&skel_driver);
	if (result)
		printk(KERN_ERR "usb_register failed. Error number %d\n", result);

	printk(KERN_INFO "|- - MODULO PRONTO PARA EXECUCAO\n"); 
	return result;
}

static void __exit usb_skel_exit(void)
{
	usb_deregister(&skel_driver);
	printk(KERN_INFO "|- - MODULO RETIRADO DO SISTEMA COM SUCESSO\n"); 
}

module_init (usb_skel_init);
module_exit (usb_skel_exit);

MODULE_LICENSE("GPL");
