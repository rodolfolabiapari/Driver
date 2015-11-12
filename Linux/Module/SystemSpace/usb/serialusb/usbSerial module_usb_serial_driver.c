/*
 * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c 
 */

#include <linux/kernel.h>
#include <linux/init.h>
//#include <linux/errno.h>
//#include <linux/slab.h>
#include <linux/tty.h>
//#include <linux/tty_flip.h>
#include <linux/module.h>
//#include <linux/moduleparam.h>
#include <linux/usb.h>
//#include <linux/uaccess.h>
#include <linux/usb/serial.h>
//#include <linux/mutex.h>

//#define usb_buffer_alloc(x...) usb_alloc_coherent(x)
//#define usb_buffer_free(x..) usb_free_coherent (x)

static const struct usb_device_id id_table [] = {
	//{ USB_DEVICE(USB_SKEL_VENDOR_ID, USB_SKEL_PRODUCT_ID) },:
	{ USB_DEVICE(0x067b, 0x2303) }, // Prolific Technology, Inc. PL2303 Serial Port
	{ USB_DEVICE(0x09fb, 0x6001) }, //blaster
	{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	{ },					// Terminating entry 
};
MODULE_DEVICE_TABLE (usb, id_table);

/* Config request types */
#define REQTYPE_HOST_TO_INTERFACE	0x41
#define REQTYPE_INTERFACE_TO_HOST	0xc1
#define REQTYPE_HOST_TO_DEVICE		0x40
#define REQTYPE_DEVICE_TO_HOST		0xc0

/* Config request codes */
#define CP210X_IFC_ENABLE		0x00
#define CP210X_SET_BAUDDIV		0x01
#define CP210X_GET_BAUDDIV		0x02
#define CP210X_SET_LINE_CTL		0x03
#define CP210X_GET_LINE_CTL		0x04
#define CP210X_SET_BREAK		0x05
#define CP210X_IMM_CHAR			0x06
#define CP210X_SET_MHS			0x07
#define CP210X_GET_MDMSTS		0x08
#define CP210X_SET_XON			0x09
#define CP210X_SET_XOFF			0x0A
#define CP210X_SET_EVENTMASK	0x0B
#define CP210X_GET_EVENTMASK	0x0C
#define CP210X_SET_CHAR			0x0D
#define CP210X_GET_CHARS		0x0E
#define CP210X_GET_PROPS		0x0F
#define CP210X_GET_COMM_STATUS	0x10
#define CP210X_RESET			0x11
#define CP210X_PURGE			0x12
#define CP210X_SET_FLOW			0x13
#define CP210X_GET_FLOW			0x14
#define CP210X_EMBED_EVENTS		0x15
#define CP210X_GET_EVENTSTATE	0x16
#define CP210X_SET_CHARS		0x19
#define CP210X_GET_BAUDRATE		0x1D
#define CP210X_SET_BAUDRATE		0x1E
#define CP210X_VENDOR_SPECIFIC	0xFF

/* CP210X_IFC_ENABLE */
#define UART_ENABLE			0x0001
#define UART_DISABLE		0x0000

/* CP210X_VENDOR_SPECIFIC */
#define CP210X_WRITE_LATCH	0x37E1
#define CP210X_READ_LATCH	0x00C2
#define CP210X_GET_PARTNUM	0x370B

/* CP210X_(SET|GET)_BAUDDIV */
#define BAUD_RATE_GEN_FREQ	0x384000

/* CP210X_(SET|GET)_LINE_CTL */
#define BITS_DATA_MASK		0X0f00
#define BITS_DATA_5			0X0500
#define BITS_DATA_6			0X0600
#define BITS_DATA_7			0X0700
#define BITS_DATA_8			0X0800
#define BITS_DATA_9			0X0900

#define BITS_PARITY_MASK	0x00f0
#define BITS_PARITY_NONE	0x0000
#define BITS_PARITY_ODD		0x0010
#define BITS_PARITY_EVEN	0x0020
#define BITS_PARITY_MARK	0x0030
#define BITS_PARITY_SPACE	0x0040

#define BITS_STOP_MASK		0x000f
#define BITS_STOP_1			0x0000
#define BITS_STOP_1_5		0x0001
#define BITS_STOP_2			0x0002

/* CP210X_SET_BREAK */
#define BREAK_ON			0x0001
#define BREAK_OFF			0x0000

/* CP210X_(SET_MHS|GET_MDMSTS) */
#define CONTROL_DTR			0x0001
#define CONTROL_RTS			0x0002
#define CONTROL_CTS			0x0010
#define CONTROL_DSR			0x0020
#define CONTROL_RING		0x0040
#define CONTROL_DCD			0x0080
#define CONTROL_WRITE_DTR	0x0100
#define CONTROL_WRITE_RTS	0x0200

//static int  conv_open(struct tty_struct *tty, struct usb_serial_port *);
//static void conv_cleanup(struct usb_serial_port *);
//static void conv_close(struct usb_serial_port *);
//static int  conv_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg);
/*static void conv_get_termios(struct tty_struct *, struct usb_serial_port *port);
static void conv_get_termios_port(struct usb_serial_port *port, unsigned int *cflagp, unsigned int *baudp);
static void conv_set_termios(struct tty_struct *, struct usb_serial_port *, struct ktermios*);
static int  conv_tiocmget(struct tty_struct *, struct file *);
static int  conv_tiocmset(struct tty_struct *, struct file *, unsigned int, unsigned int);
static int  conv_tiocmset_port(struct usb_serial_port *port, struct file *, unsigned int, unsigned int);
static void conv_break_ctl(struct tty_struct *, int);
static int  conv_startup(struct usb_serial *);
static void conv_release(struct usb_serial *);
static void conv_disconnect(struct usb_serial *);
static void conv_dtr_rts(struct usb_serial_port *p, int on);*/

/*struct conversor_port_private {
	__u8			bInterfaceNumber;
};*/

/*static struct usb_driver conversor_driver = {
	.name			= "conversor",
	//.probe			= usb_serial_probe,
	//.disconnect		= usb_serial_disconnect,
	.id_table		= id_table,
	//.no_dynamic_id	= 1,
};*/

static struct usb_serial_driver conversor_device = {
	.driver = {
		.owner		= THIS_MODULE,
		.name		= "conversor",
	},
	//.usb_driver		= &conversor_driver,
	.id_table		= id_table,
	.num_ports		= 1,
	//.open			= conv_open,
	//.close			= conv_close,
	//.ioctl			= conv_ioctl,
	//.break_ctl		= conv_break_ctl,
	//.set_termios	= conv_set_termios,
	//.tiocmget 		= conv_tiocmget,
	//.tiocmset		= conv_tiocmset,
	//.attach			= conv_startup,
	//.release		= conv_release,
	//.disconnect		= conv_disconnect,
	//.dtr_rts		= conv_dtr_rts
};

static struct usb_serial_driver * const serial_drivers[] = {
	&conversor_device, NULL
};

module_usb_serial_driver(serial_drivers, id_table);
//module_usb_serial_driver(serial_drivers, id_table);

/*
static int conv_set_config(struct usb_serial_port *port, u8 requestType,
		u8 request, int value)
{
	struct usb_serial *serial = port->serial;
	struct conversor_port_private *port_priv = usb_get_serial_port_data(port);
	int result;
	__le32 *buf = NULL;

	//int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request, __u8 requesttype,
	// __u16 value, __u16 index, void *data, __u16 size, int timeout);

	result = usb_control_msg(serial->dev,
			usb_sndctrlpipe(serial->dev, 0),
			request, requestType, value,
			port_priv->bInterfaceNumber, buf, 0, USB_CTRL_SET_TIMEOUT);

	if (result != 0) {
		printk(KERN_ERR "| %s    Unable to send request, "
				"request=0x%x result=%d\n",
				__func__, request, result);
		return -EPROTO;
	}

	return 0;
}

static int conv_open(struct tty_struct *tty, struct usb_serial_port *port)
{
	struct usb_serial *serial = port->serial;
	int result;

	if (conv_set_config(port, REQTYPE_HOST_TO_INTERFACE,
				CP210X_IFC_ENABLE, UART_ENABLE)) {

		printk(KERN_ERR "| %s    Unable to enable UART\n", __func__);
		return -EPROTO;
	}

	// Start reading from the device 
	usb_fill_bulk_urb(port->read_urb, serial->dev,
			usb_rcvbulkpipe(serial->dev,
			port->bulk_in_endpointAddress),
			port->read_urb->transfer_buffer,
			port->read_urb->transfer_buffer_length,
			serial->type->read_bulk_callback,
			port);
	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
	if (result) {
		printk(KERN_ERR "| %s    failed resubmitting read urb, "
				"error %d\n\n", __func__, result);
		return result;
	}

	// Configure the termios structure 
	//cp210x_get_termios(tty, port);
	return 0;
}

static void conv_close(struct usb_serial_port *port)
{
	// shutdown our urbs 
	usb_kill_urb(port->write_urb);
	usb_kill_urb(port->read_urb);
	printk(KERN_INFO "| %s    URBS removidos", __func__);

	mutex_lock(&port->serial->disc_mutex);

	if (!port->serial->disconnected)
		conv_set_config(port, REQTYPE_HOST_TO_INTERFACE,
				CP210X_IFC_ENABLE, UART_DISABLE);

	mutex_unlock(&port->serial->disc_mutex);
}


static int conv_startup(struct usb_serial *serial)
{
	struct conversor_port_private *port_priv;
	int i;

	for (i = 0; i < serial->num_ports; i++) {
		port_priv = kzalloc(sizeof(*port_priv), GFP_KERNEL);
		if (!port_priv)
			return -ENOMEM;

		port_priv->bInterfaceNumber = serial->interface->cur_altsetting->desc.bInterfaceNumber;

		usb_set_serial_port_data(serial->port[i], port_priv);
	}

	return 0;
}

static void conv_release(struct usb_serial *serial)
{
	struct conversor_port_private *port_priv;
	int i;

	for (i = 0; i < serial->num_ports; i++) {
		port_priv = usb_get_serial_port_data(serial->port[i]);
		kfree(port_priv);
		usb_set_serial_port_data(serial->port[i], NULL);
	}
}

static void conv_disconnect(struct usb_serial *serial)
{
	int i;

	printk(KERN_INFO "| %s    Desconectando", __func__);

	for (i = 0; i < serial->num_ports; ++i) {

		if (serial->dev) {
			if (serial->num_bulk_out)
				usb_kill_urb(serial->port[i]->write_urb);
			if (serial->num_bulk_in)
				usb_kill_urb(serial->port[i]->read_urb);
		}
	}
}*/

/*
static int __init usb_init(void)
{
	int retval;

	printk(KERN_INFO "\n\n| %s    INICIANDO MODULO\n", __func__); 

	retval = usb_serial_register_drivers(&conversor_device,serial_drivers);
	//retval = usb_serial_register(&conversor_device);

	if (retval) {
		printk(KERN_ERR "| %s    usb_serial_register failed. Error number %d\n", __func__, retval);

		return retval; // Failed to register 
	}

	// Realiza o registro do driver
	retval = usb_register(&conversor_driver);

	// Verifica o sucesso do registro
	if (retval) {
		printk(KERN_ERR "| %s    usb_register failed. Error number %d\n", __func__, retval);

		return retval;
	}
	else
		printk(KERN_INFO "| %s    MODULO PRONTO PARA EXECUCAO\n", __func__); 

	return retval;
}

static void __exit usb_exit(void)
{
	usb_deregister(&conversor_driver);
	//usb_serial_deregister(&conversor_device);

	printk(KERN_INFO "| %s    MODULO RETIRADO DO SISTEMA COM SUCESSO\n", __func__); 
}

// Funcoes que invocam a inicializacao e finalizacao do driver
module_init (usb_init);
module_exit (usb_exit);*/


MODULE_AUTHOR("Interwebs");
MODULE_DESCRIPTION("Em desenvolvimento");
MODULE_VERSION("0.00");
MODULE_LICENSE("GPL");
