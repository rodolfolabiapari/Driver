#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/usb.h>
#include <linux/slab.h> //http://stackoverflow.com/questions/13656913/compile-error-kernel-module

#define VENDOR_ID 0x10c4 //Cygnal Integrated Products, Inc.
#define PRODUCT_ID 0xea60 //CP210x UART Bridge / myAVR mySmartUSB light
//#define VENDOR_ID 0x09fb //Altera
//#define PRODUCT_ID 0x6001 //Blaster


#define CMD_ID_START_MEASUREMENTS	0x18
#define CMD_ID_INIT			0x1A



// Devices do driver.
//To enable the linux-hotplug system to load the driver automatically when the device 
	//is plugged in, you need to create a MODULE_DEVICE_TABLE. The following code tells 
	//the hotplug scripts that this module supports a single device with a specific 
	//vendor and product ID. https://www.kernel.org/doc/htmldocs/writing_usb_driver/basics.html
static struct usb_device_id id_table [] = {
	{ USB_DEVICE(VENDOR_ID, PRODUCT_ID) },
	{ },
};
// Macro de adição da tabela de dispositivos no módulo kernel
MODULE_DEVICE_TABLE(usb, id_table);



struct output_packet {
	u8	cmd;
	u8	params[7];
} __attribute__ ((packed));
// Define os atributos do dispositivo
	//#define DEVICE_ATTR(name,mode,show,store)
static DEVICE_ATTR(temp, S_IRUGO, show_temp, NULL);



// Estrutura do dispositivo a ser trabalhado
	// Para facilitar o trabalho agrupando várias variáveis.
struct estrutura_usb_dispositivo {
	struct usb_device *udev;
	int variavel;
};

// Protótipo das funções
static void init_dev(struct gotemp *gdev);
static int send_cmd(struct gotemp *gdev, u8 cmd);
static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf);



static int send_cmd(struct gotemp *gdev, u8 cmd)
{	
	struct output_packet *pkt;
	int retval;

	pkt = kmalloc(sizeof(*pkt), GFP_KERNEL);
	if (!pkt)
		return -ENOMEM;
	memset(pkt, 0x00, sizeof(*pkt));
	pkt->cmd = cmd;

	retval = usb_control_msg(gdev->udev,
				 usb_sndctrlpipe(gdev->udev, 0),
				 0x09,		/* bRequest = SET_REPORT */
				 0x21,		/* bRequestType = 00100001 */
				 0x0200,	/* or is it 0x0002? */
				 0x0000,	/* interface 0 */
				 pkt, sizeof(*pkt), 10000);
	if (retval == sizeof(*pkt))
		retval = 0;

	kfree(pkt);
	return retval;
}

static void init_dev(struct gotemp *gdev)
{
	/* First send an init message */
	send_cmd(gdev, CMD_ID_INIT);

	/* Start sending measurements */
	send_cmd(gdev, CMD_ID_START_MEASUREMENTS);
}



// Função que retorna o tamanho da string 
	// Parâmetros:
		// struct device *dev : Ponteiro para a estrutura do dispositivo
		// struct device_attribute *attr : ponteiro para os atributos do dispositivo
		// char *buf : Parâmetro que será usado como um dos retorno da função no qual será retornado a string calculada
static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf) {
	// Retorna a interface do Dispositivo
	struct usb_interface *intf = to_usb_interface(dev);
	// Retorna a estrutura de informacoes do dispositivo
	struct estrutura_usb_dispositivo *gdev = usb_get_intfdata(intf);

	// Calcula o tamnho da string dentro de gdev->temp no qual será feita uma cópia em buf o seu tamaho é retornado
	return sprintf(buf, "%d\n", gdev->temp);
}




// Função de busca do dispositivo
	// Parâmetros:
		// struct usb_interface *interface : Ponteiro para a interface do dispositivo
		// const struct usb_device_id *id : Ponteiro para a estrutura do identificador do usb do dispositivo
static int dispositivo_probe(struct usb_interface *interface, const struct usb_device_id *id)
{
	// Recebe a estrutura do usb do dispositivo
	struct usb_device *udev = interface_to_usbdev(interface);
	// Retorna a estrutura de informacoes do dispositivo
	struct estrutura_usb_dispositivo *gdev;

	// Aloca o espaço de memória do Kernel uma estrutura do dispositivo
	gdev = kmalloc(sizeof(struct estrutura_usb_dispositivo), GFP_KERNEL);
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
	struct estrutura_usb_dispositivo *gdev;

	gdev = usb_get_intfdata(interface);
	usb_set_intfdata(interface, NULL);

	device_remove_file(&interface->dev, &dev_attr_temp);

	usb_put_dev(gdev->udev);

	kfree(gdev);

	dev_info(&interface->dev, "USB dispositivo now disconnected\n");
}




// 1 Estrutura do driver usb no qual possui
static struct usb_driver esqueleto_driver = {
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
	//return usb_register(&esqueleto_driver);

	int result;

	/* register this driver with the USB subsystem */
	result = usb_register(&esqueleto_driver);
	if (result < 0) {
		err("usb_register failed for the "__FILE__ "driver."
		"Error number %d", result);
		return -1;
	}

	return 0;


}


static void __exit dispositivo_exit(void)
{
	// Retira o registro do dispositivo no sistema
	usb_deregister(&esqueleto_driver);
	// Avisa a conclusão da opeção
	printk("\n| Mo'dulo FINALIZADO com sucesso!\n");
}

module_init(dispositivo_init);
module_exit(dispositivo_exit);

MODULE_AUTHOR("Rodolfo Labiapari mansur");
MODULE_DESCRIPTION("Simple driver");
MODULE_LICENSE("GPL");