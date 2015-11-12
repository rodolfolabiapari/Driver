#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/usb.h>
#include <linux/slab.h> //http://stackoverflow.com/questions/13656913/compile-error-kernel-module

//#define VENDOR_ID	0x08f7
//#define PRODUCT_ID	0x0002
#define VENDOR_ID 0x09fb //Altera
#define PRODUCT_ID 0x6001 //Blaster

// Devices do driver.
static struct usb_device_id id_table [] = {
	{ USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
	{ },
};

// Estrutura do dispositivo a ser trabalhado
	// Para facilitar o trabalho agrupando várias variáveis.
struct dispositivo {
	struct usb_device *udev;
	int temp;
};

// Macro de adição da tabela de dispositivos no módulo kernel
MODULE_DEVICE_TABLE(usb, id_table);


// Função que retorna o tamanho da string 
	// Parâmetros:
		// struct device *dev : Ponteiro para a estrutura do dispositivo
		// struct device_attribute *attr : ponteiro para os atributos do dispositivo
		// char *buf : Parâmetro que será usado como um dos retorno da função no qual será retornado a string calculada
static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
{
	// Retorna a interface do Dispositivo
	struct usb_interface *intf = to_usb_interface(dev);
	// Retorna a estrutura de informacoes do dispositivo
	struct dispositivo *gdev = usb_get_intfdata(intf);

	// Calcula o tamnho da string dentro de gdev->temp no qual será feita uma cópia em buf o seu tamaho é retornado
	return sprintf(buf, "%d\n", gdev->temp);
}

// macro
static DEVICE_ATTR(temp, S_IRUGO, show_temp, NULL);


// Função de busca do dispositivo
	// Parâmetros:
		// struct usb_interface *interface : Ponteiro para a interface do dispositivo
		// const struct usb_device_id *id : Ponteiro para a estrutura do identificador do usb do dispositivo
static int dispositivo_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	// Recebe a estrutura do usb do dispositivo
	struct usb_device *udev = interface_to_usbdev(interface);
	// Retorna a estrutura de informacoes do dispositivo
	struct dispositivo *gdev;

	// Aloca o espaço de memória do Kernel uma estrutura do dispositivo
	gdev = kmalloc(sizeof(struct dispositivo), GFP_KERNEL);
	// Verifica se a alocação foi bem sucedida
	if (gdev == NULL) {
		dev_err(&interface->dev, "Out of memory\n");
		return -ENOMEM;
	}

	// Preenche o local com com o valor 0
	memset(gdev, 0x00, sizeof(*gdev));

	// Direciona para o novo espaço uma copia da estrutura usb_device
	gdev->udev = usb_get_dev(udev);

	// ????
	usb_set_intfdata(interface, gdev);

	// Define uma temperatura
	gdev->temp = 42;

	// Após isso é criado um arquivo de escrita do device para registro
	device_create_file(&interface->dev, &dev_attr_temp);

	// Imprime no terminal informações do dispositivo.
	dev_info(&interface->dev, "USB GoTemp device now attached\n");
	// Retorna sucesso
	return 0;
}




// Função de desconexão
static void dispositivo_disconnect(struct usb_interface *interface)
{
	struct dispositivo *gdev;

	gdev = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);

	device_remove_file(&interface->dev, &dev_attr_temp);

	usb_put_dev(gdev->udev);

	kfree(gdev);

	dev_info(&interface->dev, "USB dispositivo now disconnected\n");
}


// Estrutura do driver usb no qual possui
static struct usb_driver dispositivo_driver = {
	//.owner =	THIS_MODULE, // o dono
	.name =		"| USB Altera Blaster Pequenininho", // nome
	.probe =	dispositivo_probe, // Função de sonda
	.disconnect =	dispositivo_disconnect, // Função de desconexão
	.id_table =	id_table, // Tabela de dispositivos
};

static int __init dispositivo_init(void)
{
	// Realiza o registro do dispositivo no sistema para operações
	printk("\n\n\n| Iniciando mo'dulo no sistema!\n");
	return usb_register(&dispositivo_driver);
}


static void __exit dispositivo_exit(void)
{
	// Retira o registro do dispositivo no sistema
	usb_deregister(&dispositivo_driver);
	// Avisa a conclusão da opeção
	printk("\n| Mo'dulo FINALIZADO com sucesso!\n");
}

module_init(dispositivo_init);
module_exit(dispositivo_exit);

MODULE_AUTHOR("Rodolfo Labiapari mansur");
MODULE_DESCRIPTION("Simple driver");
MODULE_LICENSE("GPL");