// Inclusão das bibliotecas padrões
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/usb.h>

// Define os identificadores do dispositivo acoplado ao sistema
#define VENDOR_ID	0x08f7
#define PRODUCT_ID	0x0002

// Tabela de devices que o driver irá trabalhar.
static struct usb_device_id id_table [] = {
	{ USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
	{ },
};

// Macro que define a tabela no kernel do linux
MODULE_DEVICE_TABLE(usb, id_table);

// Estrutura que armazena as informações básicas do device
struct gotemp {
	struct usb_device *udev; // Ponteiro para a a estrutura do dispositivo.
	int temp; // Valor de uma temperatura.
	unsigned char *int_in_buffer;	// Buffer para os dados de entrada.
	struct urb *int_in_urb; // Estrutura de envio e recebimento de dados do device.
};

// Estrutura de dados do Kernel.
struct measurement_packet {
	u8	measurements_in_packet; // Leitura no pacote
	u8	rolling_counter; // Contador
	__le16	measurement0; // Leitura 0
	__le16	measurement1; // Leitura 1
	__le16	measurement2; // Leitura 2
} __attribute__ ((packed));

// Comando de início de leitra
#define CMD_ID_START_MEASUREMENTS	0x18
// Comando de início do device
#define CMD_ID_INIT			0x1A

// Estrutura de saída de dados.
struct output_packet {
	u8	cmd; // Comando
	u8	params[7]; // ???
} __attribute__ ((packed));


// Função de envio do comando para o device.
	// Parâmetros:
	// Estrutura do device, comando
static int send_cmd(struct gotemp *gdev, u8 cmd)
{
	// Ponteiro para um tipo de pacote de saída
	struct output_packet *pkt;

	// Cria uma estrutura do tamanho de 'output_packet'
		// GFP_KERNEL: Flag specifies the behavior of the memory allocator while trying 
			//to obtain the memory to return to the caller of kmalloc().
	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);

	// Caso não seja possível alocar, retorna mensagem de erro.
	if (!pkt)
		return -ENOMEM;

	// Sets the first num bytes of the block of memory pointed by ptr to the specified value
	memset(pkt, 0x00, sizeof(*pkt));

	// Adiciona o comando cmd na estrutura criada.
	pkt->cmd = cmd;

	// Valor de retorno de criação da estrutura
	int retval;

	retval = usb_control_msg(gdev->udev,
				 usb_sndctrlpipe(gdev->udev, 0),
				 0x09,		/* bRequest = SET_REPORT */
				 0x21,		/* bRequestType = 00100001 */
				 0x0200,	/* or is it 0x0002? */
				 0x0000,	/* interface 0 */
				 pkt,
				 sizeof(*pkt),
				 10000);

	if (retval == sizeof(*pkt))
		retval = 0;

	kfree(pkt);
	return retval;
}

static void init_dev(struct gotemp *gdev)
{
	int retval;

	/* First send an init message */
	send_cmd(gdev, CMD_ID_INIT);

	/* kick off interrupt urb */
	retval = usb_submit_urb(gdev->int_in_urb, GFP_KERNEL);
	if (retval)
		dev_err(&gdev->udev->dev, "%s - Error %d submitting interrupt urb\n",
			__FUNCTION__, retval);

	/* Start sending measurements */
	send_cmd(gdev, CMD_ID_START_MEASUREMENTS);
}

static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
{
	struct usb_interface *intf = to_usb_interface(dev);
	struct gotemp *gdev = usb_get_intfdata(intf);

	return sprintf(buf, "%d\n", gdev->temp);
}
static DEVICE_ATTR(temp, S_IRUGO, show_temp, NULL);

static void read_int_callback(struct urb *urb, struct pt_regs *regs)
{
	struct gotemp *gdev = urb->context;
	struct measurement_packet *measurement = urb->transfer_buffer;
	int retval;

	switch (urb->status) {
	case 0:
		/* success */
		break;
	case -ECONNRESET:
	case -ENOENT:
	case -ESHUTDOWN:
		/* this urb is terminated, clean up */
		dbg("%s - urb shutting down with status: %d",
		    __FUNCTION__, urb->status);
		return;
	default:
		dbg("%s - nonzero urb status received: %d",
		    __FUNCTION__, urb->status);
		goto exit;
	}

	dev_info(&urb->dev->dev, "counter %d, temp=%d\n",
		 measurement->rolling_counter,
		 measurement->measurement0);
	gdev->temp = le16_to_cpu(measurement->measurement0);

exit:
	retval = usb_submit_urb(urb, GFP_ATOMIC);
	if (retval)
		dev_err(&urb->dev->dev, "%s - Error %d submitting interrupt urb\n",
			__FUNCTION__, retval);
}

static int gotemp_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	struct usb_device *udev = interface_to_usbdev(interface);
	struct gotemp *gdev;
	struct usb_endpoint_descriptor *endpoint;
	size_t buffer_size;

	gdev = kmalloc(sizeof(struct gotemp), GFP_KERNEL);
	if (gdev == NULL) {
		dev_err(&interface->dev, "Out of memory\n");
		return -ENOMEM;
	}
	memset(gdev, 0x00, sizeof(*gdev));

	gdev->udev = usb_get_dev(udev);

	/* find the one control endpoint of this device */
	endpoint = &interface->cur_altsetting->endpoint[0].desc;
	buffer_size = le16_to_cpu(endpoint->wMaxPacketSize);
	gdev->int_in_buffer = kmalloc(buffer_size, GFP_KERNEL);
	if (!gdev->int_in_buffer) {
		dev_err(&interface->dev, "Could not allocate buffer");
		goto error;
	}

	gdev->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
	if (!gdev->int_in_urb) {
		dev_err(&interface->dev, "No free urbs available\n");
		goto error;
	}
	usb_fill_int_urb(gdev->int_in_urb, udev,
			 usb_rcvintpipe(udev,
					endpoint->bEndpointAddress),
			 gdev->int_in_buffer, buffer_size,
			 read_int_callback, gdev,
			 endpoint->bInterval);

	usb_set_intfdata(interface, gdev);

	init_dev(gdev);

	device_create_file(&interface->dev, &dev_attr_temp);

	dev_info(&interface->dev, "USB GoTemp device now attached\n");
	return 0;
error:
	usb_free_urb(gdev->int_in_urb);
	kfree(gdev->int_in_buffer);
	kfree(gdev);
	return -ENOMEM;
}

static void gotemp_disconnect(struct usb_interface *interface)
{
	struct gotemp *gdev;

	gdev = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);

	device_remove_file(&interface->dev, &dev_attr_temp);

	usb_put_dev(gdev->udev);

	usb_kill_urb(gdev->int_in_urb);
	usb_free_urb(gdev->int_in_urb);
	kfree(gdev->int_in_buffer);
	kfree(gdev);

	dev_info(&interface->dev, "USB GoTemp now disconnected\n");
}

static struct usb_driver gotemp_driver = {
	.owner =	THIS_MODULE,
	.name =		"gotemp",
	.probe =	gotemp_probe,
	.disconnect =	gotemp_disconnect,
	.id_table =	id_table,
};

static int __init gotemp_init(void)
{
	return usb_register(&gotemp_driver);
}

static void __exit gotemp_exit(void)
{
	usb_deregister(&gotemp_driver);
}

module_init(gotemp_init);
module_exit(gotemp_exit);

MODULE_AUTHOR("My name here");
MODULE_DESCRIPTION("Simple driver");
MODULE_LICENSE("GPL");
