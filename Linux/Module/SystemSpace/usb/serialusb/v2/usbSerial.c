#include "funcoes.h"

static const struct usb_device_id id_table [] = {
	{ USB_DEVICE(0x067b, 0x2303) }, // Prolific Technology, Inc. PL2303 Serial Port
	{ USB_DEVICE(0x09fb, 0x6001) }, //blaster
	{ USB_DEVICE(0x2341, 0x0042) }, //mega
	{ USB_DEVICE(0x10c4, 0xea60) }, //conversor
	{ },					// Terminating entry 
};
MODULE_DEVICE_TABLE (usb, id_table);


static struct usb_serial_driver conversor_device = {
	.driver = {
		.owner      = THIS_MODULE,
		.name       = "conversor",
	},
	.id_table       = id_table,
	.num_ports      = 1,
	.bulk_in_size   = 256,
	.bulk_out_size  = 256,
	.open           = &abre_driver,
	.close          = &fecha_driver,
	.set_termios    = define_nova_configuracao_termios,
	.break_ctl		= impede_controle/*,
	.attach			= inicia_conexao_device,
	.release		= finaliza_conexao_device*/
};





static int recebe_configuracao_atual(struct usb_serial_port *porto, 
	u8 tipo_requisicao, u8 requisicao, int valor, int quant_bytes, unsigned int *dado_comunicacao) {
	// Array do dado_comunicacao a ser enviado em formato proprio do kernel
	__le32 *buffer = NULL;
	// Variaveis de controle
	int retorno, i, tam_array_32 = 0;

    // Converte a quantidade de bytes para grupos de 32 bit
	tam_array_32 = quant_bytes / 4;
	if (quant_bytes % 4 != 0) {
		tam_array_32++;
	}

	// Aloca n 32 bits
	buffer = kmalloc(tam_array_32 * sizeof(__le32), GFP_KERNEL);
	if (!buffer) {
		printk(KERN_ERR "|%s - Erro ao alocar memoria para o envio do comando de controle (erro %d)\n", __func__, -ENOMEM);
		return -ENOMEM;
	}

	// envia o controle para o dispositivo
	retorno = usb_control_msg(porto->serial->dev, // Dispositivo
			usb_sndctrlpipe(porto->serial->dev, 0), // Pipe
			requisicao,                             // requisicao
			tipo_requisicao,                        // Tipo de requisicao
			valor,                                  // valor da requisicao
			1,                                      // numero da interface
			buffer,                                 // buffer de inout
			quant_bytes,                            // Tamanho do buffer
			USB_CTRL_GET_TIMEOUT                    // timeout
			);



	// Copia os valores do dado_comunicacao para a variavel do sistema
	for (i = 0; i < tam_array_32; i++)
		dado_comunicacao[i] = le32_to_cpu(buffer[i]);

	// Libera o buffer alocado
	if (buffer)
		kfree(buffer);

	// Verifica a completude do envio do controle
		// Se diferente da quantidade de bytes enviados, significa erro
	if (retorno != quant_bytes) {
		printk(KERN_ERR "|%s - Erro no retorno do envio do comando de controle (erro %d)\n", __func__, retorno);
		printk(KERN_ERR "|%s - - Valor de envio nao confere com o recebido. Enviado:%d retorno=%d\n", __func__, quant_bytes, retorno);

		// O erro deve ser negativo, se for possitivo, informa um erro padrao
		if (retorno > 0)
			return -EPROTO;

		return retorno;
	}

	return 0;
}





// Funcao que realiza o envio de pacotes de controle
static int define_nova_configuracao(struct usb_serial_port *porto, 
	u8 tipo_requisicao, u8 requisicao, int valor, int quant_bytes, unsigned int *dado_comunicacao) {
	// Array do dado_comunicacao a ser enviado em formato proprio do kernel
	__le32 *buffer = NULL;
	// Variaveis de controle
	int retorno, i, tam_array_32 = 0;

	// Verifica se tem necesside de enviar dado_comunicacao no setup
	if (quant_bytes != 0) {
		/* Operacao que converte a quantidade de 
			(((3 - 1) | 3) + 1) / 4
                 2      3    1    4
                    3        1    4
                         4        4
                              1

			(((4 - 1) | 3) + 1) / 4
                 3      3    1    4
                    3        1    4
                         4        4
                              1

			(((5 - 1) | 3) + 1) / 4
                 4      3    1    4
                    7        1    4
                         8        4
                              2
		
		tam_array_32 = (((quant_bytes - 1) | 3) + 1) / 4; */

		// Converte a quantidade de bytes para grupos de 32 bit
		tam_array_32 = quant_bytes / 4;
		if (quant_bytes % 4 != 0) {
			tam_array_32++;
		}

		// Aloca n 32 bits
		buffer = kmalloc(tam_array_32 * sizeof(__le32), GFP_KERNEL);
		if (!buffer) {
			printk(KERN_ERR "|%s - Erro ao alocar memoria para o envio do comando de controle (erro %d)\n", __func__, ENOMEM);
			return -ENOMEM;
		}

		// Copia os valores do dado_comunicacao para a variavel do sistema
		for (i = 0; i < tam_array_32; i++)
			buffer[i] = cpu_to_le32(dado_comunicacao[i]);
	}

	// envia o controle para o dispositivo
	retorno = usb_control_msg(porto->serial->dev, // Dispositivo
			usb_sndctrlpipe(porto->serial->dev, 0), // Pipe
			requisicao,                             // requisicao
			tipo_requisicao,                        // Tipo de requisicao
			valor,                                  // valor da requisicao
			1,                                      // numero da interface
			buffer,                                 // buffer de inout
			quant_bytes,                            // Tamanho do buffer
			USB_CTRL_SET_TIMEOUT                    // timeout
			);

	// Libera o buffer alocado
	if (buffer)
		kfree(buffer);

	// Verifica a completude do envio do controle
		// Se diferente da quantidade de bytes enviados, significa erro
	if (retorno != quant_bytes) {
		printk(KERN_ERR "|%s - Erro no retorno do envio do comando de controle (erro %d)\n", __func__, retorno);
		printk(KERN_ERR "|%s - - Valor de envio nao confere com o recebido. Enviado:%d retorno=%d\n", __func__, quant_bytes, retorno);

		// O erro deve ser negativo, se for possitivo, informa um erro padrao
		if (retorno > 0)
			return -EPROTO;

		return retorno;
	}

	return 0;
}





/*This routine is called when a particular tty device is opened.
 * 	This routine is mandatory; if this routine is not filled in,
 * 	the attempted open will fail with ENODEV.
 *
 *	Required method.
 */
static int abre_driver(struct tty_struct *tty, struct usb_serial_port *porto)
{
	//struct usb_serial *serial = porto->serial;
	int retorno = 0;

	printk(KERN_INFO "|%s - INICIANDO ABERTURA DO DRIVER OPEN()\n", __func__);

	// Habilita dispositivo
	printk(KERN_INFO "|%s - Habilitacao do dispositivo.\n", __func__);
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, IFC_ENABLE, 1, 0, NULL);
	//retorno = usb_openclose_control(porto, CP210X_IFC_ENABLE, REQTYPE_HOST_TO_INTERFACE, 1);
	if (retorno < 0) {
		printk(KERN_ERR "|%s - - Erro na habilitacao do dispositivo.\n", __func__);
		return retorno;
	}
	printk(KERN_INFO "|%s - - Habilitacao do dispositivo concluido com sucesso.\n", __func__);


	recebe_configuracao_atual_termios(tty, porto);


	altera_baud_rate(tty, porto, NULL);


	printk(KERN_INFO "|%s - Abre comunicacao serial.\n", __func__);
	retorno = usb_serial_generic_open(tty, porto);
	if (retorno != 0) {
		printk(KERN_ERR "|%s - - Erro no Serial Generic open() da funcao OPEN() (erro %d)\n", __func__, retorno);
		return retorno;
	}
	printk(KERN_INFO "|%s - - Serial aberto com sucesso\n", __func__);

	return 0;
}




/*This routine is called when a particular tty device is closed.
 *
 *	Required method.
 */
static void fecha_driver(struct usb_serial_port *porto)
{
	// desabilita dispositivo
	if (define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, IFC_ENABLE, 0, 0, NULL)) {
		printk(KERN_ERR "|%s - Erro na desabilitacao do dispositivo.\n", __func__);
	}
	else {
		printk(KERN_INFO "|%s - Desabilitacao do dispositivo concluido com sucesso.\n", __func__);	
	}

	usb_serial_generic_close(porto);
	printk(KERN_INFO "|%s - Serial Generic fechado com sucesso\n", __func__);
	printk(KERN_ERR "|%s - TERMINO DO FECHAMENTO DO DRIVER CLOSE()\n", __func__);
}




/*
 * 	This routine allows the tty driver to be notified when
 * 	device's termios settings have changed.
 *
 *	Optional: Called under the termios lock*/
static void define_nova_configuracao_termios(struct tty_struct *tty, struct usb_serial_port *porto, struct ktermios *old_termios) {
	int retorno;
	unsigned int flags_controle, old_flags_controle;
	unsigned int dado_comunicacao, controle_de_fluxo[4]; /* controle_de_fluxo[0] = controlHandshake
											controle_de_fluxo[1] = flowReplace
											controle_de_fluxo[2] = X-on-Limit
											controle_de_fluxo[3] = X-off-Limit */

	printk(KERN_INFO "|%s - INICIANDO NOVA CONFIGURACAO NO DEVICE\n", __func__);

	flags_controle     = tty->termios.c_cflag;
	old_flags_controle = old_termios->c_cflag;

	// Pode haver incosistencia de valores entre os componentes do sistema

	// Verifica se existe incosistencia entre os valores do sistema
	if (flags_controle != old_flags_controle) {
		// Se sim, recebe o valor antigo definido pelo sistema e o define novamente a todos
		altera_baud_rate(tty, porto, old_termios);

		printk(KERN_INFO "|%s - Recebe CTL Line.\n", __func__);
		retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_LINE_CTL, 0, 2, &dado_comunicacao);
		if (retorno < 0) 
			printk(KERN_ERR "|%s - - Erro no get line ctl.\n", __func__);
		else {
			printk(KERN_INFO "|%s - - Line CTL solicitado com sucesso.\n", __func__);

			if ((flags_controle & CSTOPB) != (old_flags_controle & CSTOPB)) {
				// Verifica dados de definicao do pacote
				dado_comunicacao &= ~BITS_STOP_MASK;
				switch (flags_controle & BITS_STOP_MASK) {
					case BITS_STOP_1:
						printk(KERN_INFO "|%s - - - (parada=1).\n", __func__);
						dado_comunicacao |= BITS_STOP_1;
						break;
					case BITS_STOP_1_5:
						printk(KERN_INFO "|%s - - - (parada=1.5 mudando para 1).\n", __func__);
						dado_comunicacao |= BITS_STOP_1;
						break;
					case BITS_STOP_2:
						printk(KERN_INFO "|%s - - - (parada=2).\n", __func__);
						dado_comunicacao |= BITS_STOP_2;
						break;
					default:
						// se desconhecido, define para 1
						printk(KERN_INFO "|%s - - - (parada=Unknown).\n", __func__);
						dado_comunicacao |= BITS_STOP_1;
						break;
				}
			}

			if ((flags_controle & (PARENB|PARODD|CMSPAR)) != (old_flags_controle & (PARENB|PARODD|CMSPAR))) {
				// PARENB - paridade habilitada
				// CMSPAR - Marcacao ou paridade
				// PARODD - marcacao ou espaco $$$ impar ou par
					// http://lxr.free-electrons.com/source/include/uapi/asm-generic/termbits.h
				dado_comunicacao &= ~BITS_PARITY_MASK;
				if (flags_controle & PARENB) {
					if (flags_controle & CMSPAR) {
						if (flags_controle & PARODD) {
							dado_comunicacao |= BITS_PARITY_MARK;
							printk(KERN_INFO "|%s - - - (paridade=marcacao).\n", __func__);
						} else {
							dado_comunicacao |= BITS_PARITY_SPACE;
							printk(KERN_INFO "|%s - - - (paridade=espaco).\n", __func__);
						}
					} else {
						if (flags_controle & PARODD) {
							dado_comunicacao |= BITS_PARITY_ODD;
							printk(KERN_INFO "|%s - - - (paridade=impar).\n", __func__);
						} else {
							dado_comunicacao |= BITS_PARITY_EVEN;
							printk(KERN_INFO "|%s - - - (paridade=par).\n", __func__);
						}
					}
				}
				else 
					printk(KERN_INFO "|%s - - - (paridade=none).\n", __func__); 
			}


			if ((flags_controle & CSTOPB) != (old_flags_controle & CSTOPB)) {
				dado_comunicacao &= ~BITS_DATA_MASK;
				switch (flags_controle & CSIZE) {
					case BITS_DATA_5:
						printk(KERN_INFO "|%s - - - (tamanhoDado=5).\n", __func__); 
						dado_comunicacao |= BITS_DATA_5;
						break;
					case BITS_DATA_6:
						printk(KERN_INFO "|%s - - - (tamanhoDado=6).\n", __func__); 
						dado_comunicacao |= BITS_DATA_6;
						break;
					case BITS_DATA_7:
						printk(KERN_INFO "|%s - - - (tamanhoDado=7).\n", __func__); 
						dado_comunicacao |= BITS_DATA_7;
						break;
					case BITS_DATA_8:
						printk(KERN_INFO "|%s - - - (tamanhoDado=8).\n", __func__); 
						dado_comunicacao |= BITS_DATA_8;
						break;
					case BITS_DATA_9:
						printk(KERN_INFO "|%s - - - (tamanhoDado=9 definindo para 8).\n", __func__); 
						dado_comunicacao |= BITS_DATA_8;
						break;
					default:
						// se desconhecido, define para 8
						printk(KERN_INFO "|%s - - - (tamanhoDado=Unknown).\n", __func__);
						dado_comunicacao |= BITS_DATA_8;
						break;
				}
			}

			printk(KERN_INFO "|%s - Define novos valores de CTL Line caso aconteca alguma alteracao na inicializacao.\n", __func__);
			// Algum valor for invalido, será enviado um comando definido o padrao correto.
			retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_LINE_CTL, dado_comunicacao, 0, NULL);
			if (retorno < 0) 
				printk(KERN_ERR "|%s - - Erro na definicao de novos valores de CTL Line.\n", __func__);
			else 
				printk(KERN_INFO "|%s - - Valores de CTL Line redefinidos com sucesso.\n", __func__);
		}


		if ((flags_controle & CRTSCTS) != (old_flags_controle)) {
			printk(KERN_INFO "|%s - Requisita informacoes de controle de fluxo.\n", __func__);
			// Algum valor for invalido, será enviado um comando definido o padrao correto.
			retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_FLOW, 0, 16, controle_de_fluxo);
			if (retorno < 0) 
				printk(KERN_ERR "|%s - - Erro na requisicao informacoes de controle de fluxo.\n", __func__);
			else { 
				printk(KERN_INFO "|%s - - Valores de controle de fluxo coletados com sucesso.\n", __func__);

				controle_de_fluxo[0] &= ~0x7B; /*
										7 = dsr_sensitivity e handshake
										B = handshake e mascara
										*/
				if (flags_controle & CRTSCTS) {
					controle_de_fluxo[0] |= 0x09; // DSR_handshake e DTR held active
					controle_de_fluxo[1] = 0x80;  // RTS é usado para recebimento de fluxo de controle
					printk(KERN_INFO "|%s - - - (controle de fluxo=CRTSCTS).\n", __func__);
				} else {
					controle_de_fluxo[0] |= 0x01; // DTR held active
					controle_de_fluxo[1] |= 0x40; // Null stripping
					printk(KERN_INFO "|%s - - - (controle de fluxo=none).\n", __func__);
				}

				printk(KERN_INFO "|%s - Define novos valores de controle de fluxo.\n", __func__);
				// Algum valor for invalido, será enviado um comando definido o padrao correto.
				retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_FLOW, 0, 16, controle_de_fluxo);
				if (retorno < 0) 
					printk(KERN_ERR "|%s - - Erro na definicao de novos valores de controle de fluxo.\n", __func__);
				else 
					printk(KERN_INFO "|%s - - Valores de controle de fluxo redefinidos com sucesso.\n", __func__);
			}
		}
	}
}



static void impede_controle(struct tty_struct *tty, int novo_estado) {
	struct usb_serial_port *porto = tty->driver_data;
	unsigned int estado_dado_comunicacao;
	int retorno;

	printk(KERN_INFO "|%s - INICIANDO BLOQUEIO-LIBERACAO DE CONTROLES\n", __func__);

	if (novo_estado == 0)
		estado_dado_comunicacao = 0x00;
	else
		estado_dado_comunicacao = 0x01;


	printk(KERN_INFO "|%s - Define a paralizacao dos controles (paralizacao=%d.\n", __func__, estado_dado_comunicacao);

	// Algum valor for invalido, será enviado um comando definido o padrao correto.
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_BREAK, estado_dado_comunicacao, 0, NULL);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro na definicao de paralizacao dos controles.\n", __func__);
	else 
		printk(KERN_INFO "|%s - - Valores de paralizacao dos controles redefinidos com sucesso.\n", __func__);
}



/*
static int inicia_conexao_device(struct usb_serial *serial)
{
	//struct usb_host_interface *cur_altsetting;
	struct cp210x_port_private *porto_privado;
	int i, numero_portas_disponiveis, retorno;
	unsigned int numero_parte;

	printk(KERN_INFO "|%s - INICIANDO A CONEXAO COM O DISPOSITIVO\n", __func__);

	numero_portas_disponiveis = serial->num_ports;

	for (i = 0; i < numero_portas_disponiveis; i++) {
		porto_privado = kzalloc(sizeof(porto_privado), GFP_KERNEL);
		if (!porto_privado)
			return -ENOMEM;

		//cur_altsetting = serial->interface->cur_altsetting;
		//porto_privado->bInterfaceNumber = cur_altsetting->desc.bInterfaceNumber;

		porto_privado.bInterfaceNumber = serial->interface->cur_altsetting->desc.bInterfaceNumber;

		usb_set_serial_port_data(serial->port[i], porto_privado);

		printk(KERN_INFO "|%s - Requisita informacao do modelo do hardware.\n", __func__);
		// Algum valor for invalido, será enviado um comando definido o padrao correto.
		retorno = recebe_configuracao_atual(serial->port[i], REQTYPE_DEVICE_TO_HOST, VENDOR_SPECIFIC, GET_PARTNUM,  1, &numero_parte);
		if (retorno < 0) {
			printk(KERN_ERR "|%s - - Erro na requisicao informacao do modelo do hardware.\n", __func__);
			return retorno;
		}
		printk(KERN_INFO "|%s - - Valores do modelo do hardware coletados com sucesso (i=%d, numero parte=%d). \n", __func__, i, numero_parte);

		porto_privado.bPartNumber = numero_parte & 0xFF;
	}

	return 0;
}

static void finaliza_conexao_device(struct usb_serial *serial)
{
	struct cp210x_port_private *porto_privado;
	int i, numero_portas_disponiveis;

	numero_portas_disponiveis = serial->num_ports;

	for (i = 0; i < numero_portas_disponiveis; i++) {
		porto_privado = usb_get_serial_port_data(serial->port[i]);
		kfree(porto_privado);
	}

	printk(KERN_INFO "|%s - FECHANDO A CONEXAO COM O DISPOSITIVO.\n", __func__);
}
*/

static struct usb_serial_driver * const serial_drivers[] = {&conversor_device, NULL};

module_usb_serial_driver(serial_drivers, id_table);

MODULE_AUTHOR("Interwebs");
MODULE_DESCRIPTION("Em desenvolvimento");
MODULE_VERSION("0.00");
MODULE_LICENSE("GPL");
