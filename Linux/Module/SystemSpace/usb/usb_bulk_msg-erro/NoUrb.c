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
//static int times = 0;


/* Declaration of the init and exit functions */
module_init(kiev_init);
module_exit(kiev_exit);

/* Global variables of the driver */
/* Major number */
//int kiev_major = 666;
/* Buffer to store data */
//char *memory_buffer;





// <USB initial> =
#define MAX_PKT_SIZE 64

//conversor
#define BULK_EP_OUT 0x01
#define BULK_EP_IN 0x81
// mega
//#define BULK_EP_OUT 0x04
//#define BULK_EP_IN 0x83

static struct usb_device_id conection_table[] = {
	{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
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
    .open    = conversor_open,
    .release = conversor_close,
    .read    = conversor_read,
    .write   = conversor_write
};



// <keiv init module> =
int kiev_init(void) {
	int result;

	printk("\n\n  INIT INICIO\n      <Alerta>    | - -Iniciando insercao do modulo.\n"); 

	if ( (result = usb_register(&conversor_driver) < 0) ) {
		printk("      <Alerta>    | - - - -USB: Registro nao realizado (erro %d).\n", result); 
		return -1;
	}
	printk("      <Alerta>    | - - - -USB: Registro realizado.\n"); 

	printk("      <Alerta>    | - -Modulo Inserido com sucesso.\n  INIT FIM\n\n"); 
	return 0;
}





// <keiv exit module> =
void kiev_exit(void) {
	printk("  EXIT INICIO\n");
	printk("      <Alerta>    | - -Iniciando remocao do modulo.\n"); 

	usb_deregister(&conversor_driver);

	printk("      <Alerta>    | - -Modulo removido com sucesso.\n");
	printk("  EXIT FIM\n\n");
}





// <USB probe> =
static int conversor_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	int i, result;
	struct usb_host_interface *iface_desc;
	struct usb_endpoint_descriptor *endpoint;

	printk("  PROBE INICIO\n");
	printk("      <Alerta>    | - -Verificando recursos disponiveis para %04X:%04X:\n", id->idVendor, id->idProduct);
 
	iface_desc = interface->cur_altsetting;
	printk("      <Alerta>    | - - - -Dispositivo (interface: %d): (%04X:%04X)\n", iface_desc->desc.bInterfaceNumber, id->idVendor, id->idProduct);
	printk("      <Alerta>    | - - - -ID->bInterfaceClass: %02X\n", iface_desc->desc.bInterfaceClass);
	printk("      <Alerta>    | - - - -ID->bNumEndpoints: %02X\n", iface_desc->desc.bNumEndpoints);
 
	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++)
	{
		endpoint = &iface_desc->endpoint[i].desc;
 
		printk("      <Alerta>    | - - - - - -ED[%d]->bEndpointAddress: 0x%02X\n", i, endpoint->bEndpointAddress);
		printk("      <Alerta>    | - - - - - -ED[%d]->bmAttributes: 0x%02X\n", i, endpoint->bmAttributes);
		printk("      <Alerta>    | - - - - - -ED[%d]->wMaxPacketSize: 0x%04X (%d)\n", i, endpoint->wMaxPacketSize, endpoint->wMaxPacketSize);

		if (i < iface_desc->desc.bNumEndpoints - 1)
			printk("\n");
	}

	device = interface_to_usbdev(interface);


	if (id->idVendor == 0x2341) 
		class.name = "usb/yDriverA_%d";
	else
		class.name = "usb/yDriverC_%d";

    class.fops = &conversor_fops;

    if ((result = usb_register_dev(interface, &class)) != 0)
    {
		printk("      <Alerta>    | - - - -Nao foi possivel registrar o dispositivo (erro %d)." , result);
        return result;
    }

    printk("      <Alerta>    | - -Numero Minor: %d\n", interface->minor);
	printk("      <Alerta>    | - -Dispositivo permitido para conexao (%04X:%04X) foi CONECTADO corretamente.\n" , id->idVendor, id->idProduct);
	printk("  PROBE FIM\n");
    
	return 0;
}





// <USB disconnect> = 
static void conversor_disconnect(struct usb_interface *interface)
{
	printk("  DISCONNECT INICIO\n");
	usb_deregister_dev(interface, &class);

	printk("      <Alerta>    | - -Dispositivo permitido para conexao (interface: %d) foi REMOVIDO.\n", 
		interface->cur_altsetting->desc.bInterfaceNumber);
	printk("  DISCONNECT FIM\n");
}





// <USB open close read write> =
static int conversor_open(struct inode *i, struct file *f)
{
	printk("  OPEN INICIO\n");
	printk("      <Alerta>    | - - - -Arquivo Aberto.\n");
	printk("  OPEN FIM\n");
    return 0;
}
static int conversor_close(struct inode *i, struct file *f)
{
	printk("  CLOSE INICIO\n");
	printk("      <Alerta>    | - - - -Arquivo Fechado.\n");
	printk("  CLOSE FIM\n\n");
    return 0;
}
static ssize_t conversor_read(struct file *f, char __user *buf, size_t cnt, loff_t *off)
{
    int retval, read_cnt;
	printk("  READ INICIO\n");
	printk("      <Alerta>    | - - - - - -Inicio READ();.\n");
 
    // Read the data from the bulk endpoint 
    retval = usb_bulk_msg(device, 
    		usb_rcvbulkpipe(device, BULK_EP_IN),
            bulk_buf, 
            MAX_PKT_SIZE,
            &read_cnt, 5000);


    // TODO verificar porque o arduino nao envia os dados
    if (retval < 0)
    {
		printk("      <Alerta>    | - - - - - - - -Bulk message returned %d\n", retval);
		return retval;
    }

    retval = copy_to_user(buf, bulk_buf, MIN(cnt, read_cnt));

	if (retval < 0)
	{
		printk("      <Alerta>    | - - - - - - - -Erro Copy %d e %d\n", retval, -EFAULT);
		return -EFAULT;
	}

	printk("      <Alerta>    | - - - - - -Fim READ();.\n");
	printk("  READ FIM\n");
 
    return MIN(cnt, read_cnt);
}
static ssize_t conversor_write(struct file *f, const char __user *buf, size_t cnt, loff_t *off)
{
    int retval, int_cnt, wrote_cnt; void *buffer_test;
	printk("  WRITE INICIO\n");	
	printk("      <Alerta>    | - - - - - -Inicio WRITE();.\n");

	int_cnt = (int) cnt;

    wrote_cnt = MIN(int_cnt, MAX_PKT_SIZE);

	printk("      <Alerta>    | - - - - - - - -Contagem: cnt = %d; MAX_PKT_SIZE = %d; wrote_cnt (min) = %zu.\n", cnt, MAX_PKT_SIZE, wrote_cnt);
 	
 	retval = copy_from_user(bulk_buf, buf, MIN(int_cnt, MAX_PKT_SIZE));

    if (retval < 0)
    {
        return -EFAULT;
    }

    printk("      <Alerta>    | - - - - - - - -Mensagem a ser escrita: \"%s\" com tamanho %zu e %d.\n", bulk_buf, cnt, wrote_cnt);
    printk("      <Alerta>    | - - - - - - - -Bulk de saida (endereco endpoint): %X.\n", BULK_EP_OUT);
    printk("      <Alerta>    | - - - - - - - -Pipe para envio e recebimento %u e %u.\n", usb_sndbulkpipe(device, BULK_EP_OUT), 
    	usb_rcvbulkpipe(device, BULK_EP_IN));
 


	buffer_test = kmemdup(buf, int_cnt, GFP_KERNEL);
		if (!buffer_test) {
    		printk("      <Alerta>    | - - - - - - - -Erro memoria: %d.\n", -ENOMEM);
			return -ENOMEM;
		}

    printk("      <Alerta>    | - - - - - - - -Memoria criada com sucesso.\n");



 	//wrote_cnt = 0;
    // Write the data into the bulk endpoint 
    retval = usb_bulk_msg(device,
    					usb_sndbulkpipe(device, BULK_EP_OUT),
    					buffer_test,
    					//MIN(int_cnt, MAX_PKT_SIZE),
    					int_cnt,
    					//cnt,
    					NULL, 5000);
    if (retval)
    {
        printk("      <Alerta>    | - - - - - - - -Erro! Bulk message returned %d\n", retval);
        return retval;
    }

	kfree(buffer_test);

	printk("      <Alerta>    | - - - - - - - -Envio do bulk obtido com SUCESSO (Cod: %d).\n", retval);

	printk("      <Alerta>    | - - - - - -Fim WRITE();.\n");
	printk("  WRITE FIM\n");
 
    return wrote_cnt;
}