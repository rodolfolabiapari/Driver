/*
 * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c 
 */



#include "header.h"

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

static int  conv_open(struct tty_struct *tty, struct usb_serial_port *);
//static void conv_cleanup(struct usb_serial_port *);
static void conv_close(struct usb_serial_port *);
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
	.open			= &conv_open,
	.close			= &conv_close,
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




static int usb_openclose_control(struct usb_serial_port *port, u8 request, u8 requestType, int value) {
	int retval = 0;
	struct usb_serial *serial = port->serial;
	printk(KERN_INFO "|%s - - Enviando comando para pipe %u de saida\n", __func__, usb_sndctrlpipe(serial->dev, 0));

	retval = usb_control_msg(
			serial->dev, 		//dipositivo
			usb_sndctrlpipe(serial->dev, 0), // Send to EP0OUT 
			request, 			// CP210X_IFC_ENABLE			0x00
			requestType, 		// REQTYPE_HOST_TO_INTERFACE	0x41
			value, 				// ativado(1)
			serial->interface->cur_altsetting->desc.bInterfaceNumber,
			NULL, 0,  			// There is no data stage
			5000); 				// Timeout till operation fails

	if (retval != 0) {
		printk(KERN_ERR "|%s - - Erro no envio/recebimento do controle (erro %d)\n", __func__, retval);

		return retval;
	}
	printk(KERN_INFO "|%s - - Envio realizado com sucesso (%d)\n", __func__, retval);

	return retval;
}

/*static int usb_gsi_openclose(struct usb_serial_port *port, int value)
{
	struct usb_device *dev = port->serial->dev;

	return usb_control_msg(
			dev,
			usb_sndctrlpipe(dev, 0), // Send to EP0OUT 
			GSI_VENDOR_OPENCLOSE,
			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
			value, // wValue = device is open(1) or closed(0) 
			port->serial->interface->cur_altsetting->desc.bInterfaceNumber,
			NULL, 0,  // There is no data stage 
			5000); // Timeout till operation fails 
}*/

/*

static int cp210x_set_config(struct usb_serial_port *port, u8 requestType,
		u8 request, int value, unsigned int *data, int size)
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
			port_priv->bInterfaceNumber, buf, size, USB_CTRL_SET_TIMEOUT);

	if (result != 0) {
		printk(KERN_ERR "| %s    Unable to send request, "
				"request=0x%x result=%d\n",
				__func__, request, result);
		return -EPROTO;*/

//cp210x_set_config(port, REQTYPE_HOST_TO_INTERFACE, CP210X_SET_BAUDRATE, 0, &baud, sizeof(baud))
/*static int usb_set_baudrate(struct usb_serial_port *port, u8 request, u8 requestType, unsigned int * data) {
	int retval = 0, countInts = 0, countBytes = sizeof(*data), i;
	struct usb_serial *serial = port->serial;
	__le32 *buf = NULL;

	if (countBytes % 4 != 0) 
		countInts = (countBytes / 4) + 1;
	else 
		countInts = (countBytes / 4);

	printk(KERN_INFO "|%s- - - - - Baud=%u Bytes=%d Inteiros=%d\n", __func__, *data, countBytes, countInts);

	buf = kmalloc(countInts * sizeof(__le32), GFP_KERNEL);
	if (!buf) {
		printk(KERN_ERR "|%s- - - - - Erro na alocacao do __le32\n", __func__);
		return -ENOMEM;
	}
	printk(KERN_INFO "|%s- - - - - Quantidade de Inteiros e': %d\n", __func__, countInts);

	// Array of integers into bytes 
	for (i = 0; i < countInts; i++)
		buf[i] = cpu_to_le32(data[i]);

	printk(KERN_INFO "|%s- - - - - Co'pia para o buffer realizada\n", __func__);

	printk(KERN_INFO "|%s- - - - - Enviando comando para pipe %u de saida\n", __func__, usb_sndctrlpipe(serial->dev, 0));
	retval = usb_control_msg(
			serial->dev, 		//dipositivo
			usb_sndctrlpipe(serial->dev, 0), // Send to EP0OUT 
			request, 			// CP210X_IFC_ENABLE			0x00
			requestType, 		// REQTYPE_HOST_TO_INTERFACE	0x41
			0, 					// 
			serial->interface->cur_altsetting->desc.bInterfaceNumber,
			buf, countInts,	
			5000); 				

	if (buf)
		kfree(buf);

	if (retval < 0) {
		printk(KERN_ERR "|%s- - - - - Erro no envio/recebimento do controle de baud rate (erro %d)\n", __func__, retval);

		return retval;
	}
	printk(KERN_INFO "|%s- - - - - Envio realizado com sucesso (%d)\n", __func__, retval);

	return retval;
}

static int usb_get_baudrate(struct usb_serial_port *port, u8 request, u8 requestType, unsigned int * data) {

	int retval = 0, countInts = 0, countBytes = sizeof(*data), i;
	struct usb_serial *serial = port->serial;
	__le32 *buf = NULL;

	if (countBytes % 4 != 0) 
		countInts = (countBytes / 4) + 1;
	else 
		countInts = (countBytes / 4);

	printk(KERN_INFO "|%s- - - - - Baud=%u Bytes=%d Inteiros=%d\n", __func__, *data, countBytes, countInts);

	buf = kzalloc(countInts * sizeof(__le32), GFP_KERNEL);
	if (!buf) {
		printk(KERN_ERR "|%s- - - - - Erro na alocacao do __le32\n", __func__);
		return -ENOMEM;
	}
	printk(KERN_INFO "|%s- - - - - Quantidade de Inteiros e': %d\n", __func__, countInts);

	printk(KERN_INFO "|%s- - - - - Clearning halt\n", __func__);
	retval = usb_clear_halt(serial->dev, usb_rcvctrlpipe(serial->dev, 0));
	if (retval < 0) {
		printk(KERN_ERR "|%s- - - - - Erro no Clear Halt (erro %d)\n", __func__, retval);
		return -ENOMEM;
	}
	printk(KERN_INFO "|%s- - - - - Clear Halt realizado com sucesso (%d)\n", __func__, retval);

	printk(KERN_INFO "|%s- - - - - Enviando comando para pipe %u de entrada\n", __func__, usb_rcvctrlpipe(serial->dev, 0));
	retval = usb_control_msg(
			serial->dev, 		//dipositivo
			usb_rcvctrlpipe(serial->dev, 0), // Get to EP0OUT 
			request, 			
			requestType, 		
			0, 					
			serial->interface->cur_altsetting->desc.bInterfaceNumber,
			buf, countInts,		
			5000); 				
	
	// Array of integers into bytes 
	for (i = 0; i < countInts; i++)
		data[i] = le32_to_cpu(buf[i]);

	printk(KERN_INFO "|%s- - - - - Co'pia do buffer realizada\n", __func__);

	if (buf)
		kfree(buf);

	if (retval < 0) {
		printk(KERN_ERR "|%s- - - - - Erro no envio/recebimento do controle de baud rate (baud rate %u) (erro %d)\n", __func__, *data, retval);

		return retval;
	}
	printk(KERN_INFO "|%s- - - - - Envio realizado com sucesso (%d)\n", __func__, retval);

	return retval;
}*/

static int conv_open(struct tty_struct *tty, struct usb_serial_port *port)
{
	//struct usb_serial *serial = port->serial;
	int retval = 0;
	//unsigned int baud = 0;


	printk(KERN_INFO "|%s - - - - - - - - \n|%s - - - - - - - - INICIANDO OPEN()\n", __func__, __func__);
	retval = usb_serial_generic_open(tty, port);
	if (retval != 0) {
		printk(KERN_ERR "|%s - - - - - - - - Erro no Serial Generic open() da funcao OPEN() (erro %d)\n", __func__, retval);
		return retval;
	}
	printk(KERN_INFO "|%s - - - - - - - - Serial Generic aberto com sucesso\n", __func__);


	/*printk(KERN_INFO "|%s - - - - - - - - Definindo o baud rate\n", __func__);
	baud = 9600;
	retval = usb_set_baudrate(port, CP210X_SET_BAUDRATE, REQTYPE_HOST_TO_INTERFACE, &baud);
	if (retval < 0) {
		printk(KERN_ERR "|%s - - - - - - - - Erro na definicao de baud rate\n", __func__);
		return retval;
	}
	printk(KERN_INFO "|%s - - - - - - - - Envio do sinal de baud rate\n", __func__);


	baud = 0;
	printk(KERN_INFO "|%s - - - - - - - - Recebendo o baud rate\n", __func__);
	retval = usb_get_baudrate(port, CP210X_GET_BAUDRATE, REQTYPE_INTERFACE_TO_HOST, &baud);
	if (retval < 0) {
		printk(KERN_ERR "|%s - - - - - - - - Erro no recebimento de baud rate (erro %d)\n", __func__, retval);
		return retval;
	}
	printk(KERN_INFO "|%s - - - - - - - - Recebimento do sinal de baud rate (baud %u)\n", __func__, baud);*/


	retval = usb_openclose_control(port, CP210X_IFC_ENABLE, REQTYPE_HOST_TO_INTERFACE, 1);
	if (retval < 0) {
		printk(KERN_ERR "|%s - - - - - - - - Erro no envio do pacote de controle\n", __func__);
		return retval;
	}
	printk(KERN_INFO "|%s - - - - - - - - Envio do sinal de controle\n", __func__);


	/*if (conv_set_config(port, REQTYPE_HOST_TO_INTERFACE,
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
	retval = usb_submit_urb(port->read_urb, GFP_KERNEL);
	if (retval) {
		printk(KERN_ERR "| %s    failed resubmitting read urb, "
				"error %d\n\n", __func__, retval);
		return retval;
	}

	// Configure the termios structure 
	//cp210x_get_termios(tty, port);*/
	return retval;
}

static void conv_close(struct usb_serial_port *port)
{
	int retval = 0;

	printk(KERN_ERR "|%s- - - - - - - - \n|%s- - - - - - - - INICIANDO CLOSE()\n", __func__, __func__);

	retval = usb_openclose_control(port, CP210X_IFC_ENABLE, REQTYPE_HOST_TO_INTERFACE, 0);
	if (retval != 0) 
		printk(KERN_ERR "|%s- - - - - - - - Erro no envio do pacote de controle\n", __func__);
	else
		printk(KERN_INFO "|%s- - - - - - - - Envio do sinal de controle\n", __func__);

	usb_serial_generic_close(port);
	printk(KERN_INFO "|%s- - - - - - - - Serial Generic fechado com sucesso\n", __func__);

	/*// shutdown our urbs 
	usb_kill_urb(port->write_urb);
	usb_kill_urb(port->read_urb);
	printk(KERN_INFO "| %s    URBS removidos", __func__);

	mutex_lock(&port->serial->disc_mutex);

	if (!port->serial->disconnected)
		conv_set_config(port, REQTYPE_HOST_TO_INTERFACE,
				CP210X_IFC_ENABLE, UART_DISABLE);

	mutex_unlock(&port->serial->disc_mutex);*/
}


static struct usb_serial_driver * const serial_drivers[] = {&conversor_device, NULL};

module_usb_serial_driver(serial_drivers, id_table);

MODULE_AUTHOR("Interwebs");
MODULE_DESCRIPTION("Em desenvolvimento");
MODULE_VERSION("0.00");
MODULE_LICENSE("GPL");
