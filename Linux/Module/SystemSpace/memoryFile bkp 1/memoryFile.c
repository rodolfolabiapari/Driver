/*
 * Distribuição do fonte:
 * <memory.c> =
 * 
 * <keiv initial>
 * <USB initial> 
 * <memory initial>
 * <keiv init module>
 * <keiv exit module> 
 * <USB probe>
 * <USB disconnect>
 * <USB open close read write>
 * <memory open>
 * <memory release>
 * <memory read>
 * <memory write>

 * Utilização:
 * 1 - Inserir o arquivo no diretório /dev
 *        mknod /dev/nameFile c Major Minor
 *        chmod 666 /dev/nameFile
 * 2 - Carregar o módulo
 *        insmod nomeModulo.ko
 * 3 - Inserir dados
 *        echo -n abcdef > /dev/nameFile
 * 4 - Ler dados
 *        cat /dev/nameFile

 Para trabalhar com arquivos de mais caracteres: 
 https://appusajeev.wordpress.com/2011/06/18/writing-a-linux-character-device-driver/
 */


// <keiv initial> =
/* Necessary includes for device drivers */
#include <linux/init.h>
//#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h> /* printk() */
#include <linux/usb.h>
#include <linux/slab.h> /* kmalloc() */
#include <linux/fs.h> /* everything... */
#include <linux/errno.h> /* error codes */
#include <linux/types.h> /* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h> /* O_ACCMODE */
//#include <asm/system.h> /* cli(), *_flags */
#include <asm/uaccess.h> /* copy_from/to_user */

#define MIN(a,b) (((a) <= (b)) ? (a) : (b))

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Rodolfo Labiapari Mansur Guimaraes <rodolfolabiapari@gmail.com>");
MODULE_DESCRIPTION("USB Driver");

void kiev_exit(void);
int kiev_init(void);
static int times = 0;


/* Declaration of the init and exit functions */
module_init(kiev_init);
module_exit(kiev_exit);

/* Global variables of the driver */
/* Major number */
int kiev_major = 666;
/* Buffer to store data */
char *memory_buffer;





// <USB initial> =
//conversor
//#define BULK_EP_OUT 0x01
//#define BULK_EP_IN 0x81
// mega
#define BULK_EP_OUT 0x04
#define BULK_EP_IN 0x83

#define MAX_PKT_SIZE 64

static struct usb_device_id conection_table[] = {
	//{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{} /* Terminating entry */
};
MODULE_DEVICE_TABLE (usb, conection_table);

static int conversor_probe(struct usb_interface *interface, const struct usb_device_id *id);
static void conversor_disconnect(struct usb_interface *interface);
 
static struct usb_driver conversor_driver =
{
	.name = "conversor_driver_prototipo",
	.id_table = conection_table,
	.probe = conversor_probe,
	.disconnect = conversor_disconnect,
};

// Inicializado no Probe
static struct usb_device *device;
static struct usb_class_driver class;
static unsigned char bulk_buf[MAX_PKT_SIZE];


static ssize_t conversor_write(struct file *f, const char __user *buf, size_t cnt, loff_t *off);
static ssize_t conversor_read(struct file *f, char __user *buf, size_t cnt, loff_t *off);
static int conversor_close(struct inode *i, struct file *f);
static int conversor_open(struct inode *i, struct file *f);

static struct file_operations conversor_fops =
{
    .open = conversor_open,
    .release = conversor_close,
    .read = conversor_read,
    .write = conversor_write,
};





// <memory initial> =
/* Declaration of memory.c functions */
int memory_open(struct inode *inode, struct file *filp);
int memory_release(struct inode *inode, struct file *filp);
ssize_t memory_read(struct file *filp, char *buf, size_t count, loff_t *f_pos);
ssize_t memory_write(struct file *filp, char *buf, size_t count, loff_t *f_pos);

/* Structure that declares the usual file */
/* access functions */
struct file_operations memory_fops = {
	read: memory_read,
	write: memory_write,
	open: memory_open,
	release: memory_release
};





// <keiv init module> =
int kiev_init(void) {
	int result;

	printk("\n\n  <Alerta>  Iniciando insercao do modulo.\n"); 

	/* Registering device */
	result = register_chrdev(kiev_major, "memory", &memory_fops);
	if (result < 0) {
		printk(
			"  <Alerta>  |----Memoria: Nao foi possivel obter o Major Number %d.\n"
			, kiev_major);

		return result;
	}

	/* Allocating memory for the buffer */
	memory_buffer = kmalloc(1, GFP_KERNEL); 
	if (!memory_buffer) { 
		result = -ENOMEM;
		printk(
			"  <Alerta>  |----Memoria: Nao foi possivel alocar memoria.\n");
		kiev_exit(); 
		return result;
	} 
	memset(memory_buffer, 0, 1);
	printk(
		"  <Alerta>  |----Memoria: Alocada com sucesso.\n");

	if ((result = usb_register(&conversor_driver) < 0)) {
		printk("  <Alerta>  |----USB: Registro nao realizado (erro %d).\n", result); 
	}
	printk("  <Alerta>  |----USB: Registro realizado.\n"); 

	printk("  <Alerta>  Modulo Inserido com sucesso.\n\n"); 
	return 0;
}





// <keiv exit module> =
void kiev_exit(void) {

	printk("  <Alerta>  Iniciando remocao do modulo.\n"); 
	/* Freeing the major number */
	unregister_chrdev(kiev_major, "memory");

	/* Freeing buffer memory */
	if (memory_buffer) {
		kfree(memory_buffer);
	}

	usb_deregister(&conversor_driver);

	printk("  <Alerta>  Modulo removido com sucesso.\n\n");
}





// <USB probe> =
static int conversor_probe(struct usb_interface *interface, 
	const struct usb_device_id *id)
{
	int i, result;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;

	printk(KERN_ERR "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	printk(KERN_INFO "  <Alerta>  Verificando recursos disponiveis para %04X:%04X:\n"
		, id->idVendor, id->idProduct);

 
	iface_desc = interface->cur_altsetting;
	printk(KERN_INFO "  <Alerta>  ----Dispositivo (interface: %d): (%04X:%04X)\n",
			iface_desc->desc.bInterfaceNumber, id->idVendor, id->idProduct);
	printk(KERN_INFO "  <Alerta>  ----ID->bInterfaceClass: %02X\n",
			iface_desc->desc.bInterfaceClass);
	printk(KERN_INFO "  <Alerta>  ----ID->bNumEndpoints: %02X\n",
			iface_desc->desc.bNumEndpoints);
 
	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++)
	{
		endpoint = &iface_desc->endpoint[i].desc;
 
		printk(KERN_INFO "  <Alerta>  -------ED[%d]->bEndpointAddress: 0x%02X\n",
				i, endpoint->bEndpointAddress);
		printk(KERN_INFO "  <Alerta>  -------ED[%d]->bmAttributes: 0x%02X\n",
				i, endpoint->bmAttributes);
		printk(KERN_INFO "  <Alerta>  -------ED[%d]->wMaxPacketSize: 0x%04X (%d)\n\n",
				i, endpoint->wMaxPacketSize, endpoint->wMaxPacketSize);
	}

	device = interface_to_usbdev(interface);

	class.name = "usb/ZZZ_CONVERSOR%d";
    class.fops = &conversor_fops;
    if ((result = usb_register_dev(interface, &class)) != 0)
    {
        /* Something prevented us from registering this driver */
		printk(KERN_INFO "  <Alerta>  ----Nao foi possivel registrar o dispositivo (erro %d)."
			, result);
        return result;
    }
    printk(KERN_INFO "  <Alerta>  Minor Number: %d\n", interface->minor);
	printk(KERN_INFO "  <Alerta>  Dispositivo permitido para conexao (%04X:%04X) foi conectado corretamente.\n"
		, id->idVendor, id->idProduct);
    
 
    //return result;
	return 0;
}





// <USB disconnect> = 
static void conversor_disconnect(struct usb_interface *interface)
{
	usb_deregister_dev(interface, &class);

	printk(KERN_INFO "  <Alerta>  Dispositivo permitido para conexao (interface: %d) foi removido.\n"
		, interface->cur_altsetting->desc.bInterfaceNumber);
}





// <USB open close read write> =
static int conversor_open(struct inode *i, struct file *f)
{
	printk("  <Alerta>  |----Arquivo Aberto.\n");
    return 0;
}
static int conversor_close(struct inode *i, struct file *f)
{
	printk("  <Alerta>  |----Arquivo Fechado.\n\n");
    return 0;
}
static ssize_t conversor_read(struct file *f, char __user *buf, size_t cnt, loff_t *off)
{
	printk("  <Alerta>  |----PROBE().\n");
    int retval;
    int read_cnt;
 
    // Read the data from the bulk endpoint 
    retval = usb_bulk_msg(device, usb_rcvbulkpipe(device, BULK_EP_IN),
            bulk_buf, MAX_PKT_SIZE, &read_cnt, 5000);
    if (retval < 0)
    {
        printk(KERN_ERR "  <Alerta>  Bulk message returned %d\n", retval);
        return retval;
    }
    if (copy_to_user(buf, bulk_buf, MIN(cnt, read_cnt)))
    {
        return -EFAULT;
    }
 
    return MIN(cnt, read_cnt);
}
static ssize_t conversor_write(struct file *f, const char __user *buf, size_t cnt, loff_t *off)
{
	printk("  <Alerta>  |----WRITE().\n");
    int retval;
    int wrote_cnt = MIN(cnt, MAX_PKT_SIZE);
 
    if (copy_from_user(bulk_buf, buf, MIN(cnt, MAX_PKT_SIZE)))
    {
        return -EFAULT;
    }
 
    // Write the data into the bulk endpoint 
    retval = usb_bulk_msg(device, usb_sndbulkpipe(device, BULK_EP_OUT),
            bulk_buf, MIN(cnt, MAX_PKT_SIZE), &wrote_cnt, 5000);
    if (retval)
    {
        printk(KERN_ERR "Bulk message returned %d\n", retval);
        return retval;
    }
 
    return wrote_cnt;
}





// <memory open> =
int memory_open(struct inode *inode, struct file *filp) {
	times++;
	printk("  <Alerta>  |----Arquivo Aberto pela %d vez.\n", times);
	return 0;
}





// <memory release> =
int memory_release(struct inode *inode, struct file *filp) {
 
	printk("  <Alerta>  |----Arquivo Fechado.\n\n");
	return 0;
}





// <memory read> =
ssize_t memory_read(struct file *filp, char *buf, 
				            size_t count, loff_t *f_pos) { 
 
	
	printk("  <Alerta>  |--------Lendo o arquivo (Kernel -> Usuario).\n");
	/* Transfering data to user space */ 
	copy_to_user(buf,memory_buffer,1);

	/* Changing reading position as best suits */ 
	if (*f_pos == 0) { 
		*f_pos+=1; 
		return 1; 
	} else { 
		return 0; 
	}
}





// <memory write> =
ssize_t memory_write( struct file *filp, char *buf,
	                    size_t count, loff_t *f_pos) {

	char *tmp;
	printk("  <Alerta>  |--------Escrevendo o arquivo (Usuario -> Kernel).\n");

	tmp=buf+count-1;
	copy_from_user(memory_buffer,tmp,1);
	return 1;
}
