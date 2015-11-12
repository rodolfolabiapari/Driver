#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/usb.h>

//#define VENDOR_ID	0x08f7
//#define PRODUCT_ID	0x0002
#define VENDOR_ID 0x09fb //Altera
#define PRODUCT_ID 0x6001 //Blaster

// Devices do driver.
static struct usb_device_id id_table [] = {
	{ USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
	{ },
};

// Macro de adição da tabela de dispositivos no módulo kernel
MODULE_DEVICE_TABLE(usb, id_table);

// Função de busca do dispositivo
static int gotemp_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	printk("\n| ----- =============================");
	dev_info(&interface->dev, "USB GoTemp device now attached");
	printk("| ----- =============================\n\n");
	return 0;
}

// Função de desconexão
static void gotemp_disconnect(struct usb_interface *interface)
{
	printk("\n| ----- =============================");
	dev_info(&interface->dev, "USB GoTemp now disconnected");
	printk("| ----- =============================\n\n");
}


// Estrutura do driver usb no qual possui
static struct usb_driver gotemp_driver = {
	//.owner =	THIS_MODULE, // o dono
	.name =		"gotemp", // nome
	.probe =	gotemp_probe, // Função de sonda
	.disconnect =	gotemp_disconnect, // Função de desconexão
	.id_table =	id_table, // Tabela de dispositivos
};

static int __init gotemp_init(void)
{
	printk("\n\n| Mo'dulo INICIADO com sucesso!\n");
	return usb_register(&gotemp_driver);
}


static void __exit gotemp_exit(void)
{
	usb_deregister(&gotemp_driver);
	printk("\n| Mo'dulo FINALIZADO com sucesso!\n");
}

module_init(gotemp_init);
module_exit(gotemp_exit);

MODULE_AUTHOR("Rodolfo Labiapari mansur");
MODULE_DESCRIPTION("Simple driver");
MODULE_LICENSE("GPL");
