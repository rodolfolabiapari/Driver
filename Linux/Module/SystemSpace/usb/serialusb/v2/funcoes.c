#include "funcoes.h"

static unsigned int normaliza_baud_rate(unsigned int b)
{
	if (b <= 300)           b = 300;
	else if (b <= 600)      b = 600;
	else if (b <= 1200)     b = 1200;
	else if (b <= 1800)     b = 1800;
	else if (b <= 2400)     b = 2400;
	else if (b <= 4000)     b = 4000;
	else if (b <= 4803)     b = 4800;
	else if (b <= 7207)     b = 7200;
	else if (b <= 9612)     b = 9600;
	else if (b <= 14428)    b = 14400;
	else if (b <= 16062)    b = 16000;
	else if (b <= 19250)    b = 19200;
	else if (b <= 28912)    b = 28800;
	else if (b <= 38601)    b = 38400;
	else if (b <= 51558)    b = 51200;
	else if (b <= 56280)    b = 56000;
	else if (b <= 58053)    b = 57600;
	else if (b <= 64111)    b = 64000;
	else if (b <= 77608)    b = 76800;
	else if (b <= 117028)   b = 115200;
	else if (b <= 129347)   b = 128000;
	else if (b <= 156868)   b = 153600;
	else if (b <= 237832)   b = 230400;
	else if (b <= 254234)   b = 250000;
	else if (b <= 273066)   b = 256000;
	else if (b <= 491520)   b = 460800;
	else if (b <= 567138)   b = 500000;
	else if (b <= 670254)   b = 576000;
	else if (b < 1000000)   b = 921600;
	else if (b > 2000000)   b = 2000000;

	return b;
}



static void recebe_configuracao_atual_termios(struct tty_struct *tty, struct usb_serial_port *porto) {
	unsigned int flags_controle;
	unsigned int dado_comunicacao, controle_de_fluxo[4]; /* controle_de_fluxo[0] = controlHandshake
											        controle_de_fluxo[1] = flowReplace
											        controle_de_fluxo[2] = X-on-Limit
											        controle_de_fluxo[3] = X-off-Limit
											        */
	int retorno;

	flags_controle  = tty->termios.c_cflag;
	flags_controle &= ~(CSIZE | CSTOPB | CRTSCTS);

	// Verifica baud rate
	printk(KERN_INFO "|%s - Recebe baud rate.\n", __func__);
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_BAUDRATE, 0, 4, &dado_comunicacao);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro no get baud rate.\n", __func__);
	else 
		printk(KERN_INFO "|%s - - Baud rate solicitado com sucesso (baud rate=%d).\n", __func__, dado_comunicacao);


	tty_encode_baud_rate(tty, dado_comunicacao, dado_comunicacao);

	
	// Verifica dado_comunicacaos de definicao do pacote
	printk(KERN_INFO "|%s - Recebe CTL Line.\n", __func__);
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_LINE_CTL, 0, 2, &dado_comunicacao);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro no get line ctl.\n", __func__);

	else {
		printk(KERN_INFO "|%s - - Line CTL solicitado com sucesso.\n", __func__);

		switch (dado_comunicacao & BITS_STOP_MASK) {
			case BITS_STOP_1:
				printk(KERN_INFO "|%s - - - (parada=1).\n", __func__);
				// padrao
				break;
			case BITS_STOP_1_5:
				printk(KERN_INFO "|%s - - - (parada=1.5).\n", __func__);
				dado_comunicacao &= ~BITS_STOP_MASK;
				dado_comunicacao |= BITS_STOP_1;
				break;
			case BITS_STOP_2:
				printk(KERN_INFO "|%s - - - (parada=2).\n", __func__);
				flags_controle |= CSTOPB;
				break;
			default:
				// se desconhecido, define para 1
				printk(KERN_INFO "|%s - - - (parada=Unknown).\n", __func__);
				dado_comunicacao &= ~BITS_STOP_MASK;
				dado_comunicacao |= BITS_STOP_1;
				break;
		}

		switch (dado_comunicacao & BITS_PARITY_MASK) {
			// PARENB - paridade habilitada
			// CMSPAR - Marcacao ou paridade
			// PARODD - marcacao ou espaco $$$ impar ou par
				// http://lxr.free-electrons.com/source/include/uapi/asm-generic/termbits.h
			case BITS_PARITY_NONE:
				printk(KERN_INFO "|%s - - - (paridade=none).\n", __func__); 
				flags_controle &= ~PARENB;
				break;
			case BITS_PARITY_ODD:
				printk(KERN_INFO "|%s - - - (paridade=impar).\n", __func__);
				flags_controle |= (PARENB|PARODD);
				break;
			case BITS_PARITY_EVEN:
				printk(KERN_INFO "|%s - - - (paridade=par).\n", __func__);
				flags_controle &= ~PARODD;
				flags_controle |= PARENB;
				break;
			case BITS_PARITY_MARK:
				printk(KERN_INFO "|%s - - - (paridade=marcacao).\n", __func__);
				flags_controle |= (PARENB|PARODD|CMSPAR);
				break;
			case BITS_PARITY_SPACE:
				printk(KERN_INFO "|%s - - - (paridade=espaco).\n", __func__);
				flags_controle &= ~PARODD;
				flags_controle |= (PARENB|CMSPAR);
				break;
			default:
				// se desconhecido, define para none
				printk(KERN_INFO "|%s - - - (paridade=Unknown).\n", __func__);
				flags_controle &= ~PARENB;
				dado_comunicacao           &= ~BITS_PARITY_MASK;
				dado_comunicacao           |= BITS_PARITY_NONE;
				break;	
		}

		switch (dado_comunicacao & BITS_DATA_MASK) {
			case BITS_DATA_5:
				printk(KERN_INFO "|%s - - - (tamanhoDado=5).\n", __func__); 
				flags_controle |= CS5;
				break;
			case BITS_DATA_6:
				printk(KERN_INFO "|%s - - - (tamanhoDado=6).\n", __func__); 
				flags_controle |= CS6;
				break;
			case BITS_DATA_7:
				printk(KERN_INFO "|%s - - - (tamanhoDado=7).\n", __func__); 
				flags_controle |= CS7;
				break;
			case BITS_DATA_8:
				printk(KERN_INFO "|%s - - - (tamanhoDado=8).\n", __func__); 
				flags_controle |= CS8;
				break;
			case BITS_DATA_9:
				printk(KERN_INFO "|%s - - - (tamanhoDado=9).\n", __func__); 
				flags_controle |= CS8;
				dado_comunicacao &= ~BITS_DATA_MASK;
				dado_comunicacao |= BITS_DATA_8;
				break;
			default:
				// se desconhecido, define para 8
				printk(KERN_INFO "|%s - - - (tamanhoDado=Unknown).\n", __func__);
				flags_controle |= CS8;
				dado_comunicacao &= ~BITS_DATA_MASK;
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


	printk(KERN_INFO "|%s - Requisita informacoes de controle de fluxo.\n", __func__);
	// Algum valor for invalido, será enviado um comando definido o padrao correto.
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_FLOW, 0, 16, controle_de_fluxo);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro na requisicao informacoes de controle de fluxo.\n", __func__);
	else {
		printk(KERN_INFO "|%s - - Valores de controle de fluxo coletados com sucesso.\n", __func__);

		if (controle_de_fluxo[0] & 0x0008) {
			printk(KERN_INFO "|%s - - controle de fluxo=CRTSCTS.\n", __func__);
			flags_controle |= CRTSCTS;
		} else {
			printk(KERN_INFO "|%s - - controle de fluxo=NONE.\n", __func__);
		}
	}

	printk(KERN_INFO "|%s - Flags salvas non TTY com sucesso (c_cflag).\n", __func__);
	tty->termios->c_cflag = flags_controle;
}




static void altera_baud_rate(struct tty_struct *tty, struct usb_serial_port *porto, struct ktermios *old_termios) {
	unsigned int baud_rate;
	int retorno;

	// Recebe o valor de baud rate da comunicação tty atual
	baud_rate = tty->termios.c_ospeed;

	// Normaliza o baud_rate para que o dispositivo reconheca o valor enviado.
	baud_rate = normaliza_baud_rate(baud_rate);

	// Define baud rate
	printk(KERN_INFO "|%s - Define novo baud rate.\n", __func__);
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_BAUDRATE, 0, 4, &dado_comunicacao);
	if (retorno < 0) {
		printk(KERN_ERR "|%s - - Erro no set baud rate.\n", __func__);

		// Caso tenha dado_comunicacao erro em definir o novo baud rate, 
		// verifica se já existe um valor de baud rate definido dentro do sistema kernel
		if (old_termios) 
			// Se sim, define o valor do terminal do tty com este valor
			baud_rate = old_termios->c_ospeed;
		else
			// Caso contrário, define com o valor 9600
			baud_rate = 9600;
	}
	printk(KERN_INFO "|%s - - Baud rate definido com sucesso com sucesso (baud rate=%d).\n", __func__, dado_comunicacao);
	
	// Termina o processo informando para o TTY qual é o baud rate
	tty_encode_baud_rate(tty, baud_rate, baud_rate);
}
