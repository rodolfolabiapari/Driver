/*
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
#include <linux/module.h>
#include <linux/kernel.h> /* printk() */
//#include <linux/malloc.h>
#include <linux/usb.h>
#include <linux/slab.h> /* kmalloc() */
#include <linux/fs.h> /* everything... */
#include <linux/errno.h> /* error codes */
#include <linux/types.h> /* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h> /* O_ACCMODE */
#include <asm/uaccess.h> /* copy_from/to_user */

#define MIN(a,b) (((a) <= (b)) ? (a) : (b))


/* Global variables of the driver */
/* Major number */
int kiev_major = 666;





// <USB initial> =
static struct usb_device_id dispositvo_usb_id_table[] = {
	//{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	//{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{ USB_INTERFACE_INFO(255, 0, 0), driver_info: (unsigned long)"modulo_conversor_usb"
    },

    { USB_INTERFACE_INFO(2, 2, 1), driver_info: (unsigned long)"arduino_mega_2560"
    },
	{0} /* Terminating entry */
};

//MODULE_DEVICE_TABLE (usb, dispositvo_usb_driver);


static int dispositvo_usb_probe(struct usb_interface *udev, unsigned int interfaceNumber, const struct usb_device_id *id);
static void dispositvo_usb_disconnect(struct usb_interface *interface);
static struct usb_driver dispositvo_usb_driver = {
        name:        "MotoristaURB",
        probe:       dispositvo_usb_probe,
        disconnect:  dispositvo_usb_disconnect,
        id_table:    dispositvo_usb_id_table,
};

/*

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
};*/






struct dispositvo_usb_device {
    unsigned char dados[8];   /* enough for keyboard and mouse protocols */
    char *nome;              /* either "kdb" or "mouse" */
    struct urb urb;          /* USB Request block, to get USB data*/
    int tamanhoMaximoPacote;                /* packet len */
    char saidaPrintkIRQ[80];         /* used for printk at irq time */
};
static int dispositvo_usb_probe(struct usb_interface *udev, unsigned int interfaceNumber, const struct usb_device_id *id){
	/*
     * The probe procedure is pretty standard. Device matching has already
     * been performed based on the id_table structure (defined later)
     */
    struct usb_interface *iface;
    struct usb_interface_descriptor *interface;
    struct usb_endpoint_descriptor *endpoint;
    struct sample_device *sample;

    // Imprime qual (o nome) dispositivo foi conectado no driver
    printk(KERN_INFO "usbsample: probe called for %s device\n",
	   			(char *)id->driver_info // "mouse" or "keyboard" 
    			);


    iface = &udev->altsetting->interface[interfaceNumber];
    interface = &iface->altsetting[iface->cur_altsetting];

    if (interface->bNumEndpoints != 1) 
    	return NULL;

    /*endpoint = interface->endpoint + 0;
    if (!(endpoint->bEndpointAddress & 0x80)) return NULL;
    if ((endpoint->bmAttributes & 3) != 3) return NULL;

    usb_set_protocol(udev, interface->bInterfaceNumber, 0);
    usb_set_idle(udev, interface->bInterfaceNumber, 0, 0);

    // allocate and zero a new data structure for the new device 
    sample = kmalloc(sizeof(struct sample_device), GFP_KERNEL);
    if (!sample) return NULL; // failure 
    memset(sample, 0, sizeof(*sample));
    sample->name = (char *)id->driver_info;

    // fill the URB data structure using the FILL_INT_URB macro 
    {
	int pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
	int maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
	
	if (maxp > 8) maxp = 8; sample->maxp = maxp; // remember for later 
	FILL_INT_URB(&sample->urb, udev, pipe, sample->data, maxp,
		      sample_irq, sample, endpoint->bInterval);
    }

    // register the URB within the USB subsystem 
    if (usb_submit_urb(&sample->urb)) {
	kfree(sample);
	return NULL;
    }
    // announce yourself 
    printk(KERN_INFO "usbsample: probe successful for %s (maxp is %i)\n",
	   sample->name, sample->maxp);

    /*
     * here you might MOD_INC_USE_COUNT; if you do, you'll need to unplug
     * the device or the devices before being able to unload the module
     */

    /* and return the new structure */
    return sample;
}
static void dispositvo_usb_disconnect(struct usb_interface *interface){}




// <keiv init module> =
int kiev_init(void) {
	int result;

	printk("\n\n  <Alerta>  Iniciando insercao do modulo.\n"); 

	if ((result = usb_register(&dispositvo_usb_driver) < 0)) 
		printk("  <Alerta>  |----USB: Registro nao realizado (erro %d).\n", result); 
	else
		printk("  <Alerta>  |----USB: Registro realizado.\n"); 

	printk("  <Alerta>  Modulo Inserido com sucesso.\n\n"); 
	return 0;
}

// <keiv exit module> =
void kiev_exit(void) {

	printk("  <Alerta>  Iniciando remocao do modulo.\n"); 

	usb_deregister(&dispositvo_usb_driver);

	printk("  <Alerta>  Modulo removido com sucesso.\n\n");
}


/* Declaration of the init and exit functions */
module_init(kiev_init);
module_exit(kiev_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Rodolfo Labiapari Mansur Guimaraes <rodolfolabiapari@gmail.com>");
MODULE_DESCRIPTION("USB Driver");