// Inclue as bibliotecas padrões para uma compilação de um módulo do Kernel 
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/usb.h>

// Define Informações sobre o produto
	// Define o número do fornecedor do dispositivo
#define VENDOR_ID	0x08f7
	// Define o número do produto a ser conectado
#define PRODUCT_ID	0x0002

/* table of devices that work with this driver */
// Definição dos devices que irão trabalhar com o driver
static struct usb_device_id id_table [] = {
	{ USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
	{ },
};

// Inicialização dos campos da estrutura usb_driver.
static struct usb_driver gotemp_driver = {
	.owner =	THIS_MODULE, // Constante
	.name =		"gotemp", // String
	.probe =	gotemp_probe, // Função
	.disconnect =	gotemp_disconnect, // Função
	.id_table =	id_table,
};


// Isso é necessário para permitir ferramentas do espaço do usuário descobrir quais devices o driver pode controlar.
MODULE_DEVICE_TABLE(usb, id_table);


// Função de Sonda. Quando é realizado uma sonda, esta função é executada.
static int gotemp_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	dev_info(&interface->dev, "USB GoTemp device now attached\n");
	return 0;
}

// Função de desconexão. Quando é realizado a desconeção, esta função é executada.
static void gotemp_disconnect(struct usb_interface *interface)
{
	dev_info(&interface->dev, "USB GoTemp now disconnected\n");
}



// Função de inicialização. Quando o módulo é carregado para o kernel, esta função é executada.
static int __init gotemp_init(void)
{
	return usb_register(&gotemp_driver);
}

// Função de finalizada. Quando o módulo é descarregado do kernel, esta função é executada.
static void __exit gotemp_exit(void)
{
	usb_deregister(&gotemp_driver);
}


// Funções do módulo Kernel para Execução do código
module_init(gotemp_init);
module_exit(gotemp_exit);

MODULE_AUTHOR("My name here");
MODULE_DESCRIPTION("Simple driver");
MODULE_LICENSE("GPL");
