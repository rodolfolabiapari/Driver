#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/module.h>
#include <linux/usb.h>
#include <linux/uaccess.h>
#include <linux/usb/serial.h>
#include "constantes.h"

static int  recebe_configuracao_atual        (struct usb_serial_port *, u8, u8, int, int, unsigned int *);
static int  define_nova_configuracao         (struct usb_serial_port *, u8, u8, int, int, unsigned int *);
static int  abre_driver                      (struct tty_struct *, struct usb_serial_port *);
static void fecha_driver                     (struct usb_serial_port *);
static void define_nova_configuracao_termios (struct tty_struct *, struct usb_serial_port *, struct ktermios *);
static void impede_controle                  (struct tty_struct *, int);
static unsigned int normaliza_baud_rate      (unsigned int );
static void recebe_configuracao_atual_termios(struct tty_struct *, struct usb_serial_port *) ;
static void altera_baud_rate                 (struct tty_struct *, struct usb_serial_port *, struct ktermios *) ;


// Estrutura de renconhecimento de dispositivos.
//   Estrutura que armanzena os identificadores de cada dispositivo suportado pelo driver
static const struct usb_device_id tabela_de_identificadores [] = {
	{ USB_DEVICE(0x10c4, 0xea60) }, // Silabs
	{ },                            // Terminacao de entrada
};
MODULE_DEVICE_TABLE (usb, tabela_de_identificadores);


// Estrutura que armazena as funcoes comportamentais do dispositivo
//   Estrutura especifica para determinar as funcionalidades do driver serial
static struct usb_serial_driver crypto_device = {
	.driver = { // Informacoes proprietarias do driver
		.owner      = THIS_MODULE,               // Proprietario
		.name       = "driver_Algorithm_Crypto", // Nome do driver
	},
	.id_table       = tabela_de_identificadores,        // ponteiro para Tabela de Identificadores
	.num_ports      = 1,                                // Quantidade de portas do dispositivo
	.bulk_in_size   = 256,                              // Tamanho do pacote de mensagem maximo do dispositivo
	.bulk_out_size  = 256,                              // ''
	.open           = &abre_driver,                     // Ponteiro para funcao de abertura de dispositivo
	.close          = &fecha_driver,                    // Ponteiro para funcao de fechamento de dispositivo
	.set_termios    = define_nova_configuracao_termios, // Ponteiro para funcao de configuracao comunicacao de dispositivo
	.break_ctl		= impede_controle                   // Ponteiro para funcao de bloqueio de dispositivo
};



// Funcao responsavel por SOLICITAR A CONFIGURACAO ATUAL do dispositivo.
//    E' necessaria para que novas consiguracoes nao sobrescrevam informaocoes que nao serao
//    alteradas. Quando uma nova alteracao deve ser feita, e' feito um carregamento das configuracoes
//    atuais do dispositivo, altera-se somente o necessario e depois retorna os novos valores. 
// Parametros: 
//    porto            : estrutura que possui informacoes a conexao com o dispostivo.
//    tipo_requisicao  : especifica o tipo de solicitacao, ou seja, a direcao do comando.
//    requisicao       : especifica o comando requerido

//    quando o comando utiliza valores simples
//    valor            : se o comando necessita de valores simples, serao transitados por esta variavel.

//    quando o comando utiliza variaveis com tamanho variados
//    quant_bytes      : quantidade de bytes
//    dado_comunicacao : ponteiro para o valor do dado de entrada/saida
static int recebe_configuracao_atual(struct usb_serial_port *porto, 
	u8 tipo_requisicao, u8 requisicao, int valor, int quant_bytes, unsigned int *dado_comunicacao) {


	// Array do dado a ser recebido em formato de variavel do proprio do kernel
	//   le32 significa little endian de 32 bits
	__le32 *buffer = NULL;

	// Variaveis de controle
	//   tam_array_32 armazena quantos grupo de 32 bits serao usado ao alocar o buffer.
	int retorno, i, tam_array_32 = 0;

    // Converte a quantidade de bytes para grupos de 32 bit
	tam_array_32 = quant_bytes / 4;
	if (quant_bytes % 4 != 0) {
		tam_array_32++;
	}

	// Aloca n * 32 bits
	buffer = kmalloc(tam_array_32 * sizeof(__le32), GFP_KERNEL);
	// Verifica sucesso da operacao
	if (!buffer) {
		// Caso erro.
		printk(KERN_ERR "|%s - Erro ao alocar memoria para o recebimento do comando de controle (erro %d)\n", __func__, -ENOMEM);
		// retorna aviso de falta de memoria
		return -ENOMEM;
	}

	// Criado o buffer para o armazenamento, pode-se realizar a solicitacao dos dados

	// Realiza um comando de controle solicitando os respectivos dados
	retorno = usb_control_msg(porto->serial->dev, // Dispositivo a ser solicitado
			usb_sndctrlpipe(porto->serial->dev, 0), // Pipe da comunicacao
			requisicao,                             // requisicao
			tipo_requisicao,                        // Tipo de requisicao
			valor,                                  // valor da requisicao
			1,                                      // numero da interface a ser solicitado
			buffer,                                 // buffer de inout
			quant_bytes,                            // Tamanho do buffer
			USB_CTRL_GET_TIMEOUT                    // timeout para solicitacao de dados de controle
			);


	// Realizado a solicitacao, 
	//   Copia os valores do dado para a variavel utilizada em espaco de usuario
	for (i = 0; i < tam_array_32; i++)
		// A funcao converte os dados do espaco kernel para o espaco do usuario
		dado_comunicacao[i] = le32_to_cpu(buffer[i]);

	// Libera o buffer alocado
	if (buffer)
		kfree(buffer);

	// Verifica a completude do envio do controle
	//    Se o retorno possui valor diferente da quantidade de bytes enviados, significa erro
	if (retorno != quant_bytes) {
		// informa o erro
		printk(KERN_ERR "|%s - Erro no retorno do envio do comando de controle (erro %d)\n", __func__, retorno);
		printk(KERN_ERR "|%s - - Valor de envio nao confere com o recebido. Enviado:%d retorno=%d\n", __func__, quant_bytes, retorno);

		// O erro deve ser negativo, se for possitivo, informa um erro padrao
		if (retorno > 0)
			// 71  Protocol error 
			return -EPROTO;

		return retorno;
	}

	return 0;
}






// Funcao responsavel por DEFINIR NOVA CONFIGURACAO do dispositivo.
// Parametros: 
//    porto            : estrutura que possui informacoes a conexao com o dispostivo.
//    tipo_requisicao  : especifica o tipo de solicitacao, ou seja, a direcao do comando.
//    requisicao       : especifica o comando requerido

//    quando o comando utiliza valores simples
//    valor            : se o comando necessita de valores simples, serao transitados por esta variavel.

//    quando o comando utiliza variaveis com tamanho variados
//    quant_bytes      : quantidade de bytes
//    dado_comunicacao : ponteiro para o valor do dado de entrada/saida
static int define_nova_configuracao(struct usb_serial_port *porto, 
	u8 tipo_requisicao, u8 requisicao, int valor, int quant_bytes, unsigned int *dado_comunicacao) {

	// Array do dado a ser enviado em formato de variavel do proprio do kernel caso 
	// exista algum dado a ser enviado.
	//   le32 significa little endian de 32 bits

	__le32 *buffer = NULL;
	
	// Variaveis de controle
	//   tam_array_32 armazena quantos grupo de 32 bits serao usado ao alocar o buffer.
	int retorno, i, tam_array_32 = 0;

	// Verifica se tem necesside de enviar um dado.
	//   Algumas controles nao necessitam de utilizar o dado_comunicacao e por isso
	//   nao existe necessidade de criar um buffer para transmissao de dados
	if (quant_bytes != 0) {
		// se sim

		// Converte a quantidade de bytes para grupos de 32 bit
		tam_array_32 = quant_bytes / 4;
		if (quant_bytes % 4 != 0) {
			tam_array_32++;
		}

		// Aloca n * 32 bits
		buffer = kmalloc(tam_array_32 * sizeof(__le32), GFP_KERNEL);
		// Verifica sucesso da operacao
		if (!buffer) {
			// Caso erro.
			printk(KERN_ERR "|%s - Erro ao alocar memoria para o envio do comando de controle (erro %d)\n", __func__, -ENOMEM);
			// retorna aviso de falta de memoria
			return -ENOMEM;
		}

		// Copia os valores do dado_comunicacao para a variavel do sistema
		for (i = 0; i < tam_array_32; i++)
			buffer[i] = cpu_to_le32(dado_comunicacao[i]);
	}

	// Realiza um comando de controle solicitando os respectivos dados
	retorno = usb_control_msg(porto->serial->dev, // Dispositivo a ser solicitado
			usb_sndctrlpipe(porto->serial->dev, 0), // Pipe da comunicacao
			requisicao,                             // requisicao
			tipo_requisicao,                        // Tipo de requisicao
			valor,                                  // valor da requisicao
			1,                                      // numero da interface a ser solicitado
			buffer,                                 // buffer de inout
			quant_bytes,                            // Tamanho do buffer
			USB_CTRL_SET_TIMEOUT                    // timeout para definicao de dados de controle
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
			// 71  Protocol error 
			return -EPROTO;

		return retorno;
	}

	return 0;
}



// Funcao que padroniza o baud rate do dispositivo.
//  Quando e' recebido as informacoes do dispositivo, e' realizado uma padronizacao
//  do valor encontrado com os valores padroes de comunicacao procurando o baud rate
//  que estiver mais compativem com a comunicacao
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


// Funcao que solicita os dados atuais do dispositivo e atualiza os dados do sistema.
//   O kernel possui uma copia dos dados do hardware para que ele saiba trocar informacoes corretamente
//   A funcao tambem imprime logs informando o usuario suas operacoes realizadas
static void recebe_configuracao_atual_termios(struct tty_struct *tty, struct usb_serial_port *porto) {
	unsigned int flags_controle; // variavel que armazena as flags de controle
	unsigned int dado_comunicacao, controle_de_fluxo[4]; /* controle_de_fluxo[0] = controlHandshake
											        controle_de_fluxo[1] = flowReplace
											        controle_de_fluxo[2] = X-on-Limit
											        controle_de_fluxo[3] = X-off-Limit
											        */
	int retorno; // variavel que armazena os valores de retorno de cada função

	// Faz uma copia dos valores das flags situadas no sistema.
	flags_controle  = tty->termios.c_cflag;
	// Elimina os dados antigos para a adicao de novos valores lidos do hardware: 
	flags_controle &= ~(CSIZE | // tamanho do char
		CSTOPB |                // bit de parada
		CRTSCTS                 // controle de fluxo de saida
		);

	// Busca informacoes sobre o baud rate
	printk(KERN_INFO "|%s - Recebe baud rate.\n", __func__);
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_BAUDRATE, 0, 4, &dado_comunicacao);
	// verifica se foi bem sucedido
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro no get baud rate.\n", __func__);
	else 
		printk(KERN_INFO "|%s - - Baud rate solicitado com sucesso (baud rate=%d).\n", __func__, dado_comunicacao);

	// Lido o baud rate do hardware, salva a informacao no sistema kernel sobre a comunicacao
	tty_encode_baud_rate(tty, dado_comunicacao, dado_comunicacao);

	
	// Realiza a leitura de todos os dados relacionado as flags de controle
	//  Após lido, eles serao verificados para que estejam de acordo com a capacidae de funcionamento
	//  Por exemplo, no sistema nao compreende 1,5 bit de parada. Assim, caso este sejam o modo definido
	//  em hardware, será sobrescrito definindo com outro valor.
	printk(KERN_INFO "|%s - Recebe CTL Line.\n", __func__);
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_LINE_CTL, 0, 2, &dado_comunicacao);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro no get line ctl.\n", __func__);

	else {
		// Caso a leitura tenha ocorrido com sucesso,  verifica os valores.
		printk(KERN_INFO "|%s - - Line CTL solicitado com sucesso.\n", __func__);

		// Verificacao de bit de parada
		//  Se o bit de para dor:
		//   1:   ele ja foi definindo ao resetar os valors do bit de stop no inicio do procedimento
		//   1,5: valor nao suportado. Sera novamente definido para 1
		//   2:   define 2 bits de parada no sistema, tal como e' o hardware
		//   se desconhecido, define 1.
		switch (dado_comunicacao & BITS_STOP_MASK) {
			case BITS_STOP_1:
				printk(KERN_INFO "|%s - - - (parada=1).\n", __func__);
				// padrao
				break;
			case BITS_STOP_1_5:
				printk(KERN_INFO "|%s - - - (parada=1.5).\n", __func__);
				dado_comunicacao &= ~BITS_STOP_MASK;
				dado_comunicacao |= BITS_STOP_1;
				// padrao, tal como o 1.
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

		// Verificacao de bit de paridade
		// Se o valor da paridade for:
		//   nenhum:  nenhum bit de paridade   
		//   impar:   paridade para valores impares
		//   par:     '' pares
		//   mascara: utilizando mascara
		//   espaco:  utilizando espaco
		//   define para 'nenhum' 
		switch (dado_comunicacao & BITS_PARITY_MASK) {
			// Defininicao das constantes
				// PARENB - paridade habilitada
				// CMSPAR - Marcacao ou paridade
				// PARODD - marcacao ou espaco $$$ impar ou par
					//referencia: http://lxr.free-electrons.com/source/include/uapi/asm-generic/termbits.h
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

		// Verificacao dos bits de tamanho de char
		// Definindo quantidade de bits do char
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


	// Independente de ter realiza alguma alteracao ou nao, realiza a gravacao dos dados novamente no hardware
	printk(KERN_INFO "|%s - Define novos valores de CTL Line caso aconteca alguma alteracao na inicializacao.\n", __func__);
	// Algum valor for invalido, será enviado um comando definido o padrao correto.
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_LINE_CTL, dado_comunicacao, 0, NULL);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro na definicao de novos valores de CTL Line.\n", __func__);
	else
		printk(KERN_INFO "|%s - - Valores de CTL Line redefinidos com sucesso.\n", __func__);


	// Requisita as informacoes de fluxo do hardware
	printk(KERN_INFO "|%s - Requisita informacoes de controle de fluxo.\n", __func__);
	// Algum valor for invalido, será enviado um comando definido o padrao correto.
	retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_FLOW, 0, 16, controle_de_fluxo);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro na requisicao informacoes de controle de fluxo.\n", __func__);
	else {
		// Caso sucesso, 
		printk(KERN_INFO "|%s - - Valores de controle de fluxo coletados com sucesso.\n", __func__);

		// verifica o tipo de controle de fluxo
		if (controle_de_fluxo[0] & 0x0008) {
			printk(KERN_INFO "|%s - - controle de fluxo=CRTSCTS.\n", __func__);
			flags_controle |= CRTSCTS;
		} else {
			printk(KERN_INFO "|%s - - controle de fluxo=NONE.\n", __func__);
		}
	}

	// Ao final de todo processamento das flags, salva os novos valores na variavel de comunicacao do sistema
	printk(KERN_INFO "|%s - Flags salvas non TTY com sucesso (c_cflag).\n", __func__);
	tty->termios.c_cflag = flags_controle;
}



// Procedimento responsavel por alterar o baud rate do hardware
// Parametros:
// tty:         estrutura de dados com valores do tty
// porto:       estrutura de transmissao de dados
// old_termios: estrutura de dados com valores do kernel
// baud_rate:   novo baud rate
static void altera_baud_rate(struct tty_struct *tty, struct usb_serial_port *porto, struct ktermios *old_termios) {
	unsigned int baud_rate;

	int retorno;

	// Recebe o valor de baud rate da comunicação tty atual
	baud_rate = tty->termios.c_ospeed;

	// Normaliza o baud_rate para que o dispositivo reconheca o valor enviado.
	baud_rate = normaliza_baud_rate(baud_rate);

	// Define baud rate no hardware
	printk(KERN_INFO "|%s - Define novo baud rate.\n", __func__);
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_BAUDRATE, 0, 4, &baud_rate);
	if (retorno < 0) {
		// caso erro, define um baud rate antigo ou o padrao.
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
	printk(KERN_INFO "|%s - - Baud rate definido com sucesso com sucesso (baud rate=%d).\n", __func__, baud_rate);
	
	// Termina o processo informando para o TTY qual é o baud rate
	tty_encode_baud_rate(tty, baud_rate, baud_rate);
}





/*This routine is called when a particular tty device is opened.
 * 	This routine is mandatory; if this routine is not filled in,
 * 	the attempted open will fail with ENODEV.
 *
 *	Required method.
 */
// Procedimento de inicializacao chamado quando um dispositivo tty e' aberto com a funcao open no 
//   no espaco de usuario.
static int abre_driver(struct tty_struct *tty, struct usb_serial_port *porto)
{
	int retorno;

	printk(KERN_INFO "|%s - INICIANDO ABERTURA DO DRIVER OPEN()\n", __func__);

	// Realiza procedimento de habilitacao de uso do dispositivo
	printk(KERN_INFO "|%s - Habilitacao do dispositivo.\n", __func__);
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, IFC_ENABLE, 1, 0, NULL);
	if (retorno < 0) {
		printk(KERN_ERR "|%s - - Erro na habilitacao do dispositivo.\n", __func__);
		return retorno;
	}
	printk(KERN_INFO "|%s - - Habilitacao do dispositivo concluido com sucesso.\n", __func__);


	// Realiza solicitacao dos dados atuais do dispositivo para que possa ser salvo no sistema.
	recebe_configuracao_atual_termios(tty, porto);

	// Verifca se o baud rate do dispositivo e' compativel e salva dados de baud rate no sistema
	altera_baud_rate(tty, porto, NULL);

	// Realizado todos as inicializacoes, inicia a comunicacao
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
// Procedimento de finalizacao chamado quando um dispositivo tty e' fechado com a funcao close no 
//   no espaco de usuario.
static void fecha_driver(struct usb_serial_port *porto)
{
	// desabilita dispositivo
	if (define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, IFC_ENABLE, 0, 0, NULL)) {
		printk(KERN_ERR "|%s - Erro na desabilitacao do dispositivo.\n", __func__);
	}
	else {
		printk(KERN_INFO "|%s - Desabilitacao do dispositivo concluido com sucesso.\n", __func__);	
	}

	// Ficha sua comunicacao
	usb_serial_generic_close(porto);
	printk(KERN_INFO "|%s - Serial Generic fechado com sucesso\n", __func__);
	printk(KERN_ERR "|%s - TERMINO DO FECHAMENTO DO DRIVER CLOSE()\n", __func__);
}




/*
 * 	This routine allows the tty driver to be notified when
 * 	device's termios settings have changed.
 *
 *	Optional: Called under the termios lock
*/
// Procedimento responsavel por definir novas configuracoes no dispositivo.
// tty:         estrutura de dados com valores do tty
// porto:       estrutura de transmissao de dados
// old_termios: estrutura de dados com valores do kernel
static void define_nova_configuracao_termios(struct tty_struct *tty, struct usb_serial_port *porto, struct ktermios *old_termios) {
	int retorno;
	unsigned int flags_controle, old_flags_controle; // variavel de flags nova e antiga
	unsigned int dado_comunicacao, controle_de_fluxo[4]; /* controle_de_fluxo[0] = controlHandshake
											controle_de_fluxo[1] = flowReplace
											controle_de_fluxo[2] = X-on-Limit
											controle_de_fluxo[3] = X-off-Limit */

	printk(KERN_INFO "|%s - INICIANDO NOVA CONFIGURACAO NO DEVICE\n", __func__);

	// Cada variavel recebera sua respectiva flag para inicio de processamento
	//   A existência de verificacao das duas flags de da pelo motivo de haver incosistencia 
	//   de valores entre os componentes do sistema tty e kernel
	flags_controle     = tty->termios.c_cflag;
	old_flags_controle = old_termios->c_cflag;


	// Verifica se existe incosistencia entre os valores do sistema
	if (flags_controle != old_flags_controle) {
		// Se sim, recebe o valor mais antigo definido pelo sistema e o define novamente a todos

		// Primeiro, redefine o baud rate.
		altera_baud_rate(tty, porto, old_termios);


		// Depois recebe os valores de controle de comunicacao
		//  e verifica se algum dos dados dele esta diferente com o do sistema.
		//  Se algum estiver algum dado inconsistente, então define o valor antigo.
		printk(KERN_INFO "|%s - Recebe CTL Line.\n", __func__);
		retorno = recebe_configuracao_atual(porto, REQTYPE_INTERFACE_TO_HOST, GET_LINE_CTL, 0, 2, &dado_comunicacao);
		if (retorno < 0) 
			printk(KERN_ERR "|%s - - Erro no get line ctl.\n", __func__);
		else {
			printk(KERN_INFO "|%s - - Line CTL solicitado com sucesso.\n", __func__);

			// Verifica se o bit de stop esta consistente
			if ((flags_controle & CSTOPB) != (old_flags_controle & CSTOPB)) {
				// se inconsistentes, redefine-os com os valores antigos
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

			// Verifica se os bits de paridade estao consistentes
			if ((flags_controle & (PARENB|PARODD|CMSPAR)) != (old_flags_controle & (PARENB|PARODD|CMSPAR))) {
				// se inconsistentes, redefine-os com os valores antigos
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


			// Verifica se os a quntidade de char estao consistentes
			if ((flags_controle & CSIZE) != (old_flags_controle & CSIZE)) {
				// se inconsistentes, redefine-os com os valores antigos
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

			// Redefine os valores no hardware
			printk(KERN_INFO "|%s - Define novos valores de CTL Line caso aconteca alguma alteracao na inicializacao.\n", __func__);
			// Algum valor for invalido, será enviado um comando definido o padrao correto.
			retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_LINE_CTL, dado_comunicacao, 0, NULL);
			if (retorno < 0) 
				printk(KERN_ERR "|%s - - Erro na definicao de novos valores de CTL Line.\n", __func__);
			else 
				printk(KERN_INFO "|%s - - Valores de CTL Line redefinidos com sucesso.\n", __func__);
		}


		// Verifica se as flags de controle de fluxo estao inconsistentes
		if ((flags_controle & CRTSCTS) != (old_flags_controle)) {
			// Se sim redefine
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

				// Define os novos valores.
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


// Controla a transmissao de um sinal de break.
//  Quando o valor e' diferente de zero, o sinal de break e' transmitido.
//  quando o valor retorna a zero, o comando break e' finalizado.
static void impede_controle(struct tty_struct *tty, int novo_estado) {

	// Recebe o porto de comunicacao serial
	struct usb_serial_port *porto = tty->driver_data;
	unsigned int estado_dado_comunicacao; // buffer para o valor do estado para envio
	int retorno;

	// Informacoes para o usuario
	printk(KERN_INFO "|%s - INICIANDO BLOQUEIO-LIBERACAO DE CONTROLES\n", __func__);

	// Define o valor da mensagem a ser enviada ao device
	if (novo_estado == 0)
		// sem break
		estado_dado_comunicacao = 0x00;
	else
		// com break
		estado_dado_comunicacao = 0x01;


	printk(KERN_INFO "|%s - Define a paralizacao dos controles (paralizacao=%d.\n", __func__, estado_dado_comunicacao);

	// Define a nova configuracao
	retorno = define_nova_configuracao(porto, REQTYPE_HOST_TO_INTERFACE, SET_BREAK, estado_dado_comunicacao, 0, NULL);
	if (retorno < 0) 
		printk(KERN_ERR "|%s - - Erro na definicao de paralizacao dos controles.\n", __func__);
	else 
		printk(KERN_INFO "|%s - - Valores de paralizacao dos controles redefinidos com sucesso.\n", __func__);
}

// Estrutura de drivers seriais para a utilizacao do USB serial
static struct usb_serial_driver * const serial_drivers[] = {&crypto_device, NULL};

//Registra os drivers desenvolvido
module_usb_serial_driver(serial_drivers, tabela_de_identificadores);

MODULE_AUTHOR("rodolfolabiapari at gmail dot com");
MODULE_DESCRIPTION("Driver para comunicacao com hardware criptografico reconfiguravel");
MODULE_VERSION("1.0");
MODULE_LICENSE("GPL");
