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
#include <linux/mutex.h>
#include <linux/usb.h>
#include <asm/uaccess.h>


//#define usb_buffer_alloc(x...) usb_alloc_coherent(x)
//#define usb_buffer_free(x..) usb_free_coherent (x)

static struct usb_device_id skel_table [] = {
	//{ USB_DEVICE(USB_SKEL_VENDOR_ID, USB_SKEL_PRODUCT_ID) },:
	{ USB_DEVICE(0x067b, 0x2303) }, // Prolific Technology, Inc. PL2303 Serial Port
	{ USB_DEVICE(0x09fb, 0x6001) }, //blaster
	{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	{ }					// Terminating entry 
};
MODULE_DEVICE_TABLE (usb, skel_table);


/* Config request types */
#define REQTYPE_HOST_TO_INTERFACE	0x41
#define REQTYPE_INTERFACE_TO_HOST	0xc1
#define REQTYPE_HOST_TO_DEVICE	0x40
#define REQTYPE_DEVICE_TO_HOST	0xc0

/* Config request codes */
#define CP210X_IFC_ENABLE	0x00
#define CP210X_SET_BAUDDIV	0x01
#define CP210X_GET_BAUDDIV	0x02
#define CP210X_SET_LINE_CTL	0x03
#define CP210X_GET_LINE_CTL	0x04
#define CP210X_SET_BREAK	0x05
#define CP210X_IMM_CHAR		0x06
#define CP210X_SET_MHS		0x07
#define CP210X_GET_MDMSTS	0x08
#define CP210X_SET_XON		0x09
#define CP210X_SET_XOFF		0x0A
#define CP210X_SET_EVENTMASK	0x0B
#define CP210X_GET_EVENTMASK	0x0C
#define CP210X_SET_CHAR		0x0D
#define CP210X_GET_CHARS	0x0E
#define CP210X_GET_PROPS	0x0F
#define CP210X_GET_COMM_STATUS	0x10
#define CP210X_RESET		0x11
#define CP210X_PURGE		0x12
#define CP210X_SET_FLOW		0x13
#define CP210X_GET_FLOW		0x14
#define CP210X_EMBED_EVENTS	0x15
#define CP210X_GET_EVENTSTATE	0x16
#define CP210X_SET_CHARS	0x19
#define CP210X_GET_BAUDRATE	0x1D
#define CP210X_SET_BAUDRATE	0x1E
#define CP210X_VENDOR_SPECIFIC	0xFF

/* CP210X_IFC_ENABLE */
#define UART_ENABLE		0x0001
#define UART_DISABLE		0x0000

/* CP210X_VENDOR_SPECIFIC */
#define CP210X_WRITE_LATCH	0x37E1
#define CP210X_READ_LATCH	0x00C2
#define CP210X_GET_PARTNUM	0x370B

/* CP210X_(SET|GET)_BAUDDIV */
#define BAUD_RATE_GEN_FREQ	0x384000

/* CP210X_(SET|GET)_LINE_CTL */
#define BITS_DATA_MASK		0X0f00
#define BITS_DATA_5		0X0500
#define BITS_DATA_6		0X0600
#define BITS_DATA_7		0X0700
#define BITS_DATA_8		0X0800
#define BITS_DATA_9		0X0900

#define BITS_PARITY_MASK	0x00f0
#define BITS_PARITY_NONE	0x0000
#define BITS_PARITY_ODD		0x0010
#define BITS_PARITY_EVEN	0x0020
#define BITS_PARITY_MARK	0x0030
#define BITS_PARITY_SPACE	0x0040

#define BITS_STOP_MASK		0x000f
#define BITS_STOP_1		0x0000
#define BITS_STOP_1_5		0x0001
#define BITS_STOP_2		0x0002

/* CP210X_SET_BREAK */
#define BREAK_ON		0x0001
#define BREAK_OFF		0x0000

/* CP210X_(SET_MHS|GET_MDMSTS) */
#define CONTROL_DTR		0x0001
#define CONTROL_RTS		0x0002
#define CONTROL_CTS		0x0010
#define CONTROL_DSR		0x0020
#define CONTROL_RING		0x0040
#define CONTROL_DCD		0x0080
#define CONTROL_WRITE_DTR	0x0100
#define CONTROL_WRITE_RTS	0x0200


// Structure to hold all of our device specific stuff 
struct usb_skel {
	struct usb_device 		*udev;				// the usb device for this device 
	struct usb_interface 	*interface;			// the interface for this device 
	unsigned char 			*bulk_in_buffer;	// the buffer to receive data 
	int 					bulk_in_buffer_length;
	unsigned int 			open_count;			
	struct semaphore		sem; 				// lock essa estrutura*/
	spinlock_t				cmd_spinlock;				// locks dev->command 
	size_t					bulk_in_size;		// the size of the receive buffer 
	__u8					bulk_in_endpointAddr;	// the address of the bulk in endpoint 
	__u8					bulk_out_endpointAddr;	// the address of the bulk out endpoint 
	char					command;				// Último comando enviado
	struct kref				kref;
};
#define to_skel_dev(d) container_of(d, struct usb_skel, kref)

static struct usb_driver skel_driver;
char *buf = NULL;


static void skel_delete(struct kref *kref)
{
	struct usb_skel *dev = to_skel_dev(kref);

	printk(KERN_ERR "|%s-| - - - - - INICIALIZANDO O skel_delete()\n", __func__);

	usb_put_dev(dev->udev);
	printk(KERN_ERR "|%s- - - - - - - - Estrutura usb_device desacoplada com sucesso\n", __func__);
	kfree (dev->bulk_in_buffer);
	printk(KERN_ERR "|%s- - - - - - - - Buffer do bulk de entrada removido\n", __func__);
	kfree (dev);
	printk(KERN_ERR "|%s- - - - - - - - Estrutura do Device Removido\n", __func__);
	printk(KERN_ERR "|%s- - - - - - FINALIZANDO O skel_delete();\n", __func__);
}

static int skel_open(struct inode *inode, struct file *file)
{
	struct usb_skel *dev;
	struct usb_interface *interface;
	int subminor;
	int retval = 0;

	printk(KERN_ERR "|%s- - - - \n|%s- - - - INICIANDO OPEN()\n", __func__, __func__);
	// Recebe o Minor Number do driver para abertura do arquivo.
	subminor = iminor(inode);

	// Recebe a interface do dispositivo de acordo com o driver e seu Minor
	interface = usb_find_interface(&skel_driver, subminor);
	if (!interface) {
		printk(KERN_ERR "|%s- - - - - - - error, can't find device for minor %d",
			__FUNCTION__, subminor);
		retval = -ENODEV;
		goto exit;
	}
	printk(KERN_ERR "|%s- - - - - - Interface do dispositivo foi encontrada\n", __func__);

	// Recebe o a estrutura geral através da interface
	dev = usb_get_intfdata(interface);
	if (!dev) {
		retval = -ENODEV;
		goto exit;
	}
	// Incrementa a contagem de drivers que estão usando o dispositivo
	++dev->open_count;
	printk(KERN_ERR "|%s- - - - - - Estrutura Geral do dispositivo foi encontrada (contagem de aberturas: %d)\n", __func__, dev->open_count);
	
	// increment our usage count for the device !!!
	//kref_get(&dev->kref);
	//printk(KERN_ERR "|%s- - - - - - kref_get Feito com sucesso (increment our usage count for the device)\n", __func__);

	// Salva o objeto criado na estrutura do arquivo para que possa ser obtido depois
		// save our object in the file's private structure 
	file->private_data = dev;

	// Verifica se foi atribuido corretamente
	if (!file->private_data) {
		retval = -ENODEV;
		printk(KERN_ERR "|%s- - - - - - Estrutura Geral NAO salvada no file->private_data\n", __func__);
		goto exit;
	}
	printk(KERN_ERR "|%s- - - - - - Estrutura Geral salvada no file->private_data\n", __func__);

	printk(KERN_ERR "|%s- - - - - - FUNCAO OPEN() FINALIZADA. ARQUIVO ABERTO;\n", __func__);

exit:
	return retval;
}

static int skel_release(struct inode *inode, struct file *file)
{
	struct usb_skel *dev;
	printk(KERN_ERR "|%s- - - - - - INICIANDO RELEASE();\n", __func__);

	dev = (struct usb_skel *)file->private_data;
	if (dev == NULL)
		return -ENODEV;
	printk(KERN_ERR "|%s- - - - - - Dispositivo encontrado com sucesso\n", __func__);

	--dev->open_count;

	// decrement the count on our device 
	//kref_put(&dev->kref, skel_delete);
	//printk(KERN_ERR "|%s- - - - - - kref_put Feito com sucesso (decrement the count on our device)\n", __func__);

	printk(KERN_ERR "|%s- - - - FUNCAO RELEASE() FINALIZADA. ARQUIVO FECHADO\n", __func__);
	return 0;
}

static ssize_t skel_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
{
	struct usb_skel *dev;
	int retval = 0;
	int count_wrote = 0;

	// Verifica se existe a estrutura geral pode ser carregada
	if (!file->private_data) {
		retval = -ENODEV;
		printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral NAO encontrada dentro do file->private_data\n", __func__);
		return 0;
	}
	printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral encontrada dentro do file->private_data\n", __func__);

	// Se sim, recebe a referência para o uso das informações gerais 
	dev = (struct usb_skel *) file->private_data;

	if (!dev) {
		retval = -ENODEV;
		printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral NAO encontrada\n", __func__);
		return 0;
	}
	printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral encontrada\n", __func__);

	printk(KERN_ERR "|%s- - - - - - - - Enviando\n", __func__);
	// Constroi um bloco bulk de leitura para receber o dado do dispositivo
		// do a blocking bulk read to get data from the device 
	retval = usb_bulk_msg(dev->udev,
			      usb_rcvbulkpipe(dev->udev, dev->bulk_in_endpointAddr),
			      dev->bulk_in_buffer,
			      min(dev->bulk_in_size, count),
			      &count_wrote, HZ*10);

	// Verifica se o envio foi ocorrido com sucesso.
		// if the read was successful, copy the data to userspace
	if (!retval) {
		// Caso sucesso, realiza o envio do dado lido para o espaço do usuário
		if (copy_to_user(buffer, dev->bulk_in_buffer, count)) {
			// Caso não seja enviado ao usuário com sucesso
			printk(KERN_ERR "|%s- - - - - - - - Erro ao tentar enviar o dado lido para o usuario (%d)\n", __func__, EFAULT);
			retval = -EFAULT;
		}
		// Se o envio para o usuário ocorreu com sucesso
		else {
			printk(KERN_ERR "|%s- - - - - - - - %d lidos e enviados corretamente para o usuario\n", __func__, count_wrote);
			retval = count_wrote;
		}
	// Caso não seja realizado a criação do bloco bulk com sucesso
	} else {
		printk(KERN_ERR "|%s- - - - - - - - Erro ao tentar ler um dado do device (%d)\n", __func__, retval);
	}

	// Define a contagem de bytes lidos e que será retornado ao usuário
	count = (size_t) count_wrote;

	printk(KERN_ERR "|%s- - - - - - FINAL DO READ();\n", __func__);
	return retval;
}

static void skel_write_bulk_callback(struct urb *urb)
//static void skel_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
{
	printk(KERN_ERR "|%s- - - - INICIANDO CALLBACK()\n", __func__);

	printk(KERN_ERR "|%s- - - - - - Verifica se houve algum problema no envio do pacote\n", __func__);
	// sync/async unlink faults aren't errors 
	if (urb->status && 
			!(urb->status == -ENOENT || 
			 urb->status == -ECONNRESET ||
			 urb->status == -ESHUTDOWN)) {
		printk(KERN_ERR "|%s- - - - - - - nonzero write bulk status received: %d",
		    __FUNCTION__, urb->status);
	} else {
		printk(KERN_ERR "|%s- - - - - - Nenhum erro foi encontrado no envio (%d, %d, %d, %d)\n", __func__, urb->status, ENOENT, ECONNRESET, ESHUTDOWN);
	}

	// free up our allocated buffer 
	//usb_buffer_free(urb->dev, urb->transfer_buffer_length, 
			//urb->transfer_buffer, urb->transfer_dma);

	// Remove o buffer criado
	kfree(buf);
	printk(KERN_ERR "|%s- - - - - - Espaco 'buf' desalocado com sucesso\n", __func__);

	printk(KERN_ERR "|%s- - - - FINAL DA CALLBACK()\n", __func__);
}

static ssize_t skel_write(struct file *file, const char __user *user_buffer, size_t count, loff_t *ppos)
{
	struct usb_skel *dev;
	int retval = 0, int_count;
	struct urb *urb = NULL;

	printk(KERN_ERR "|%s- - - - - - INICIANDO WRITE()\n", __func__);

	// Verifica se existe a estrutura geral pode ser carregada
	if (!file->private_data) {
		retval = -ENODEV;
		printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral NAO encontrada dentro do file->private_data\n", __func__);
		goto error;
	} else {
		printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral encontrada dentro do file->private_data\n", __func__);

		// Se foi encontrada, copia o referencial dela para que possa ser trabalhada
		dev = (struct usb_skel *) file->private_data;

		if (!dev) {
			retval = -ENODEV;
			printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral NAO encontrada\n", __func__);
			goto error;
		}
		printk(KERN_ERR "|%s- - - - - - - - Estrutura Geral encontrada\n", __func__);
	}

	printk(KERN_ERR "|%s- - - - - - - - Tentando desativar as interrupcoes\n", __func__);
	if (down_interruptible(&dev->sem)) {
		retval = -ERESTARTSYS;
		printk(KERN_ERR "|%s- - - - - - - - Erro ao tentar desativar as interrupcoes\n", __func__);
		goto exit;
	}
	printk(KERN_ERR "|%s- - - - - - - - Interrupcoes desativadas com sucesso para realizacao do write()\n", __func__);

	// Verify that the device wasn't unplugged. 
	if (! dev->udev) {
		retval = -ENODEV;
		printk(KERN_ERR "|%s- - - - - - - - No device or device unplugged (%d)\n", __func__, retval);
		goto unlock_exit;
	}
	printk(KERN_ERR "|%s- - - - - - - - Dispositivo USB ainda plugado no computador\n", __func__);

	// Se não tiver dados para serem gravados, então não necessita de enviar nada
	if (count == 0)
		goto unlock_exit;
	else 
		if (count != 1)
			count = 1;

	printk(KERN_ERR "|%s- - - - - - - - Por padrao, este driver enviara' apenas 1 caractere\n", __func__);

	// Aloca na memória do kernel um urb vazio para o envio.
		// create a urb, and a buffer for it, and copy the data to the urb 
	urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!urb) {
		retval = -ENOMEM;
		printk(KERN_ERR "|%s- - - - - - - - URB NAO ALOCADO %d\n", __func__, retval);
		goto unlock_exit;
	}
	printk(KERN_ERR "|%s- - - - - - - - URB alocado com sucesso\n", __func__);

	// Para evitar problemas com a tipagem, criou-se uma cópia no tipo int
	int_count = (int) count;

	// Aloca na memória do kernel um espaço para o envio do dado
		//buf = usb_buffer_alloc(dev->udev, int_count, GFP_KERNEL, &urb->transfer_dma);
	//buf = kzalloc(int_count, GFP_KERNEL); // !!!
	buf = kzalloc(dev->bulk_in_size, GFP_KERNEL); 

	if (buf == NULL) {
		retval = -ENOMEM;
		printk(KERN_ERR "|%s- - - - - - - - BUFFER NAO ALOCADO %d\n", __func__, retval);
		goto unlock_exit;
	}
	//memset(buf, 0x00, sizeof (*buf * int_count));
	printk(KERN_ERR "|%s- - - - - - - - Buffer alocado com sucesso\n", __func__);

	// Copia os dados do espaço do usuário para um buffer criado no espaço do kernel
	if (copy_from_user(buf, user_buffer, int_count)) {
		retval = -EFAULT;
		printk(KERN_ERR "|%s- - - - - - - - Nao foi possivel capturar os dados do usuario.\n", __func__);
		goto unlock_exit;
	}

	/*if (int_count < dev->bulk_in_size)
		buf[int_count+1] = 0;
	else
		buf[bulk_in_size] = 0;*/

	printk(KERN_INFO "|%s- - - - - - - - String recebida \"%s\" de tamanho %d\n", __func__, buf, int_count);


	printk(KERN_ERR "|%s- - - - - - - - Bloqueando as treads\n", __func__);
	spin_lock(&dev->cmd_spinlock);
	printk(KERN_ERR "|%s- - - - - - - - Treads bloqueadas com sucesso\n", __func__);

		printk(KERN_ERR "|%s- - - - - - - - Alterando a variavel 'command' da estrutura geral\n", __func__);
		dev->command = *buf;

	spin_unlock(&dev->cmd_spinlock);
	printk(KERN_ERR "|%s- - - - - - - - Threads desbloqueadas com sucesso\n", __func__);

	// Preenche os campos do URB com as informações do driver e dispositivo para o envio.
	// initialize the urb properly 
	usb_fill_bulk_urb(urb, dev->udev, 
			  usb_sndbulkpipe(dev->udev, dev->bulk_out_endpointAddr), buf, 
			  int_count, skel_write_bulk_callback,
			  dev);

	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

	// Envia os dados para a porta de saida
		// send the data out the bulk port 
	retval = usb_submit_urb(urb, GFP_KERNEL);
	if (retval) {
		printk(KERN_ERR "|%s- - - - - - - - - failed submitting write urb, error %d", __FUNCTION__, retval);
		goto unlock_exit;
	}
	
	printk(KERN_ERR "|%s- - - - - - - - URB enviado com sucesso (%d) (pipe out %u)\n", __func__, retval, usb_sndbulkpipe(dev->udev, dev->bulk_out_endpointAddr));

	// release our reference to this urb, the USB core will eventually free it entirely 
	// Libera o pacote urb após utilizado
	usb_free_urb(urb);

	printk(KERN_ERR "|%s- - - - - - - - Ativando interrupcoes...    ", __func__);
	up(&dev->sem);
	printk(KERN_ERR "|%s- - - - - - - - Interrupcoes ativadas com sucesso\n", __func__);

	printk(KERN_ERR "|%s- - - - - - FINALIZANDO WRITE()\n", __func__);

exit:
	return count;

unlock_exit:
	up(&dev->sem);

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
	.name = "usb/yskel%d",
	.fops = &skel_fops,
	//.mode = S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
	//.minor_base = USB_SKEL_MINOR_BASE,
};

static int skel_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	struct usb_skel *dev = NULL;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;
	size_t buffer_size;
	struct urb *urb = NULL;
	int i, retval = -ENOMEM;

	printk(KERN_INFO "|%s- - - - INICIANDO PROBE();\n", __func__); 

	// allocate memory for our device state and initialize it 
	// Aloca memoria para a estrutura geral de usb
	dev = kzalloc(sizeof(struct usb_skel), GFP_KERNEL);
	if (dev == NULL) {
		printk(KERN_ERR "|%s- - - - - - Out of memory\n", __func__);
		goto error;
	}
	// Define este espaço todo como 0
	//memset(dev, 0x00, sizeof (*dev));
	// Inicializa o objeto com contagem igual a 1
	//kref_init(&dev->kref);
	printk(KERN_INFO "|%s- - - - - - Memoria alocada\n", __func__); 

	dev->command = 0;

	// Quantidade de acessos simultâneos
	sema_init(&dev->sem, 1);
	printk(KERN_INFO "|%s- - - - - - Semaforo Iniciado. Valor maximo de acessos simul e' igual a 1\n", __func__); 
	// lock para as threads
	spin_lock_init(&dev->cmd_spinlock);
	printk(KERN_INFO "|%s- - - - - - Lock para treads iniciado com sucesso\n", __func__); 

	// Grava informações na estrutura geral alocada acima
		// Interface de comunicação
	dev->interface = interface;
		// Recebe a estrutura do dispositivo de acordo com a interface dada pela função
	dev->udev = usb_get_dev(interface_to_usbdev(interface));
		// Contagem de aberturas atuais
	dev->open_count = 0;

	printk(KERN_INFO "|%s- - - - - - Crianco Estrutura Geral do dispositivo\n", __func__); 
	// Define informações do endpoint 
		// Recebe a interface atual para verificar se as informações dela são as requeridas do driver
	iface_desc = interface->cur_altsetting;
	// Para cada Endpoint que ela contiver
	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
		// Recebe as descrições do endpoint atual
		endpoint = &iface_desc->endpoint[i].desc;

		// Verifica se encontrou o endpoint de entrada
		if (!dev->bulk_in_endpointAddr && // existe um endereço de entrada de mensagem
				//(endpoint->bEndpointAddress & USB_DIR_IN) && // se endpoint encontrado é 
				(endpoint->bEndpointAddress > USB_DIR_IN) && // se endpoint encontrado é 		    	
				((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_BULK)) {
			// Recebe o tamanho máximo do pacote
			buffer_size = endpoint->wMaxPacketSize;
			// Define o tamanho do pacote na estrutura geral
			dev->bulk_in_size = buffer_size; 
			// Recebe o Endpoint de entrada
			dev->bulk_in_endpointAddr = endpoint->bEndpointAddress; 
			// Aloca espaço na memória para o buffer de entrada
			dev->bulk_in_buffer = kzalloc(buffer_size, GFP_KERNEL);
			if (!dev->bulk_in_buffer) {
				printk(KERN_ERR "|%s- - - - - - ~ ~ Could not allocate bulk_in_buffer\n", __func__);
				goto error;
			}
		}

		// Verifica se encontrou o endpoint de saída
		if (!dev->bulk_out_endpointAddr && // Verifica se já foi atribuido
				(endpoint->bEndpointAddress != dev->bulk_in_endpointAddr) &&
				//!(endpoint->bEndpointAddress & USB_DIR_IN) && // Verifica se é diferente do 
				(endpoint->bEndpointAddress > USB_DIR_OUT && endpoint->bEndpointAddress < USB_DIR_IN ) && // Verifica se é diferente do 
				((endpoint->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_BULK)) {
			dev->bulk_out_endpointAddr = endpoint->bEndpointAddress;
		}
	}

	if (! (dev->bulk_in_endpointAddr && dev->bulk_out_endpointAddr)) {
		printk(KERN_ERR "|%s- - - - - - ~ ~ Could not find both bulk-in and bulk-out endpoints\n", __func__);
		goto error;
	}

	printk(KERN_INFO "|%s- - - - - - ~ ~ Numeros de Endpoint: %u\n", __func__,iface_desc->desc.bNumEndpoints);
	printk(KERN_INFO "|%s- - - - - - ~ ~ bulk_in_size: %zu\n", __func__, dev->bulk_in_size); 
	printk(KERN_INFO "|%s- - - - - - ~ ~ bulk_in_endpointAddr: %X\n", __func__, dev->bulk_in_endpointAddr); 
	printk(KERN_INFO "|%s- - - - - - ~ ~ bulk_out_endpointAddr: %X\n", __func__, dev->bulk_out_endpointAddr); 
	printk(KERN_INFO "|%s- - - - - - Estrutura geral do device (dev) foi preenchida com sucesso\n", __func__); 

	// Salva os ponteiros dos dados na interface do dispositivo
	usb_set_intfdata(interface, dev);

	// Depois de tudo, registra-se o  dispositivo conectado ao driver
	retval = usb_register_dev(interface, &skel_class);
	if (retval) {
		// something prevented us from registering this driver 
		printk(KERN_ERR "|%s- - - - - - Not able to get a minor for this device.\n", __func__);
		usb_set_intfdata(interface, NULL);
		goto error;
	}
	printk(KERN_INFO "|%s- - - - - - Registro do device realizado com sucesso\n", __func__); 

	printk(KERN_ERR "|%s- - - - - - Enviando sinal de controle para inicio de trasmissao\n", __func__);


	dev->bulk_in_buffer = kzalloc(sizeof(char) * dev->bulk_in_size, GFP_KERNEL);
	if (dev->bulk_in_buffer == NULL) {
		printk(KERN_ERR "|%s- - - - - - Out of memory\n", __func__);
		goto error;
	}

	//result = cp210x_set_config(port, REQTYPE_HOST_TO_INTERFACE, CP210X_IFC_ENABLE, UART_ENABLE, NULL, 0);
	retval = usb_control_msg(dev->udev, 
				usb_sndctrlpipe(dev->udev, 0),
				0, 0x41, 
				1, 0, 
				NULL, 0, 1000);
	if (retval) {
		// something prevented us from registering this driver 
		printk(KERN_ERR "|%s- - - - - - Erro no envio do controle (erro %d).\n", __func__, retval);
		goto error;
	}
	printk(KERN_ERR "|%s- - - - - - Sinal de controle enviado com sucesso\n", __func__);

	// baud rate
	//cp210x_set_config(port, REQTYPE_HOST_TO_INTERFACE,
	//		CP210X_SET_BAUDRATE, &baud, sizeof(baud))

	/*urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!urb) {
		retval = -ENOMEM;
		printk(KERN_ERR "|%s- - - - - - URB NAO ALOCADO %d\n", __func__, retval);
		goto error;
	}
	printk(KERN_ERR "|%s- - - - - - URB alocado com sucesso\n", __func__);
	//-----------------------------------------------------------------------------------------------------------------------------
	// Start reading from the device 
	usb_fill_bulk_urb(urb, dev->udev, 
			usb_rcvbulkpipe(dev->udev, dev->bulk_in_endpointAddr),
			dev->bulk_in_buffer,
			dev->bulk_in_buffer_length,
			skel_write_bulk_callback,
			dev);

	retval = usb_submit_urb(urb, GFP_KERNEL);
	if (retval) {
		printk(KERN_ERR "|%s- - - - - - - - URB NAO enviado %d\n", __func__, retval);
		return retval;
	}
	printk(KERN_ERR "|%s- - - - - - URB enviado com sucesso\n", __func__);

	usb_free_urb(urb);*/

	// let the user know what node this device is now attached to 
	printk(KERN_INFO "|%s- - - - USB ADICIONADO COM SUCESSO. Nomeacao: skel%d\n", __func__, interface->minor);
	return 0;

// Caso ocorra algum erro
error:
	//if (dev)
		//kref_put(&dev->kref, skel_delete);
	return retval;
}


static void skel_disconnect(struct usb_interface *interface)
{
	struct usb_skel *dev;
	int minor = interface->minor;
	printk(KERN_INFO "|%s- - - - INICIANDO DISCONNECT();\n", __func__); 

	// prevent skel_open() from racing skel_disconnect() 
	//lock_kernel();


	// Recebe a estrutura do dispositivo pelas informacoes do driver
	dev = usb_get_intfdata(interface);

	down(&dev->sem); /* Not interruptible */
	
	// Define os valores da interface como nula
	usb_set_intfdata(interface, NULL);

	// Retira o registro do dispositino do driver
		// give back our minor 
	usb_deregister_dev(interface, &skel_class);

	//unlock_kernel();

	// decrement our usage count !!!
	//kref_put(&dev->kref, skel_delete);

	printk(KERN_INFO "|%s- - - - USB skel%d FOI DESACOPLADO DO COMPUTADOR\n", __func__, minor);
}




// Estrutu do driver
static struct usb_driver skel_driver = {
	.name = "skeleton",
	.id_table = skel_table,
	.probe = skel_probe,
	//.minor = USB_SKEL_MINOR_BASE,
	.disconnect = skel_disconnect,
};




static int __init usb_skel_init(void)
{
	int result;

	printk(KERN_INFO "\n\n|%s- - INICIANDO MODULO\n", __func__); 

	// Realiza o registro do driver
	result = usb_register(&skel_driver);

	// Verifica o sucesso do registro
	if (result) 
		printk(KERN_ERR "|%s- - usb_register failed. Error number %d\n", __func__, result);
	else
		printk(KERN_INFO "|%s- - MODULO PRONTO PARA EXECUCAO\n", __func__); 
	
	return result;
}

static void __exit usb_skel_exit(void)
{
	// Retira do driver do kernel
	usb_deregister(&skel_driver);
	printk(KERN_INFO "|%s- - MODULO RETIRADO DO SISTEMA COM SUCESSO\n", __func__); 
}
// Funcoes que invocam a inicializacao e finalizacao do driver
module_init (usb_skel_init);
module_exit (usb_skel_exit);

MODULE_LICENSE("GPL");