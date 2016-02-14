
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h> // tipos internos
#include <sys/stat.h>  // chmod, mknod, mkdir...
#include <fcntl.h>     // change file descriptor, open, close...
#include <unistd.h>
#include <termios.h>

#define BUFFER_SIZE 256

static int arquivo_driver = -1;

void inicializa_comunicacao(char * dir) {
	struct termios estrutura_termios_buffer;
    
	printf("\n\nInicializando os parametros de comunicacao.");
			
	// Abre a comunicação com o driver
	printf("\n| - Abrindo comunicacao com o driver \"%s\".", dir);
	arquivo_driver = open(dir,  O_RDWR | O_NOCTTY);
	if (arquivo_driver < 0) {
		printf("\n| - - Erro! Arquivo \"%s\" nao foi encontrado ou pode ser aberto.", dir);
		return;
	} else {
		printf("\n| - - Arquivo \"%s\" encontrado com sucesso.", dir);
	}
	
	// Recebe os dados atuais
	printf("\n| - Recebendo configuracao atual do \"%s\".", dir);
	if (tcgetattr(arquivo_driver, &estrutura_termios_buffer) != 0) {
		printf("\n| - - Erro! Não foi possivel receber os atributos da comunicacao.");
		return;
	} else {
		printf("\n| - - Dados recebidos com sucesso.");
	}
	
	// Define os novos valores
	printf("\n| - Definindo novos paramentros.");
	estrutura_termios_buffer.c_iflag &= -(   // RETIRANDO: 
			BRKINT |                  // interrupcao
			IGNPAR | PARMRK | INPCK | //paridade, marcacao de paridade e flags, checagem de erros de paridade
			IXON                      // char de parada
			);
	estrutura_termios_buffer.c_iflag |= IGNBRK | IXOFF; // ingora envio de controles XON e XOFF

	
	estrutura_termios_buffer.c_oflag &= -(OPOST); // Eliminando flags de output
	
	estrutura_termios_buffer.c_lflag &= -(         // Sem flags locais. RETIRANDO:
			ECHO | ECHOE | ECHOK | ECHONL | // echo particular
			ICANON |                        // processamento de entrada de echo canonico 
			ISIG |                          // Sinais
			NOFLSH|                         // filas flush
			TOSTOP                          // controle de job
			);
	
	estrutura_termios_buffer.c_cflag &= (
			CSIZE |  // Tamanho de caractere
			CSTOPB | // Dois bits de stop
			HUPCL |  // Pendura no ultimo fechar
			PARENB   // Paridade habilitada
			);
	estrutura_termios_buffer.c_cflag |= 
			CLOCAL | // nao ao modem
			CREAD |  // permite recebimento
			CS8      // dados de 8bit
			;


    // Inicializanco os caracteres de controle.
    //   Valores default podem ser encontrados em /usr/include/termios.h
    estrutura_termios_buffer.c_cc[VINTR]    = 0;     /* Ctrl-c */ 
    estrutura_termios_buffer.c_cc[VQUIT]    = 0;     /* Ctrl-\ */
    estrutura_termios_buffer.c_cc[VERASE]   = 0;     /* del */
    estrutura_termios_buffer.c_cc[VKILL]    = 0;     /* @ */
    estrutura_termios_buffer.c_cc[VEOF]     = 4;     /* Ctrl-d */
    estrutura_termios_buffer.c_cc[VTIME]    = 0;     /* inter-character timer unused */
    estrutura_termios_buffer.c_cc[VMIN]     = 1;     /* blocking read until 1 character arrives */
    estrutura_termios_buffer.c_cc[VSWTC]    = 0;     /* '\0' */
    estrutura_termios_buffer.c_cc[VSTART]   = 0;     /* Ctrl-q */ 
    estrutura_termios_buffer.c_cc[VSTOP]    = 0;     /* Ctrl-s */
    estrutura_termios_buffer.c_cc[VSUSP]    = 0;     /* Ctrl-z */
    estrutura_termios_buffer.c_cc[VEOL]     = 0;     /* '\0' */
    estrutura_termios_buffer.c_cc[VREPRINT] = 0;     /* Ctrl-r */
    estrutura_termios_buffer.c_cc[VDISCARD] = 0;     /* Ctrl-u */
    estrutura_termios_buffer.c_cc[VWERASE]  = 0;     /* Ctrl-w */
    estrutura_termios_buffer.c_cc[VLNEXT]   = 0;     /* Ctrl-v */
    estrutura_termios_buffer.c_cc[VEOL2]    = 0;     /* '\0' */

	
	// Define baud rate de entrada e saida do termios
	printf("\n| - Definindo novos baud rate para entrada e saida.");
	if (cfsetispeed(&estrutura_termios_buffer, B9600) == -1) {
		printf("\n| - - Erro! Não foi possivel definir baud rate de entrada.");
		return;
	} else {
		printf("\n| - - Baud Rate de ENTRADA definido com sucesso para cod %d.", B9600);
	}

	if (cfsetospeed(&estrutura_termios_buffer, B9600) == -1) {
		printf("\n| - - Erro! Não foi possivel definir baud rate de saida.");
		return;
	} else {
		printf("\n| - - Baud Rate de SAIDA definido com sucesso para cod %d.", B9600);
	}

	
	// Elimina qualquer dado no buffer de entrada gerado por ruidos
	printf("\n| - Eliminando buffer de entrada gerado por ruidos.");
	if (tcflush(arquivo_driver, TCIFLUSH) == -1) {
		printf("\n| - - Erro! Não foi possivel eliminar buffer de entrada gerado por ruidos.");
		return;
	} else {
		printf("\n| - - Buffer eliminado com sucesso.");
	}
	

	printf("\n| - Definindo os novos atributos na comunicacao atual.");
	// Define os atributos para para a porta do terminal
		// http://www.delorie.com/gnu/docs/glibc/libc_360.html
	if (tcsetattr(arquivo_driver, TCSANOW, &estrutura_termios_buffer) == -1) {
		printf("\n| - - Erro! Não foi possivel eliminar buffer de entrada gerado por ruidos.");
	}
	
	fflush(stdout);
}

// Procedimento que recebe dados e imprime na tela
void recebe (void) {
	char buffer_entrada[BUFFER_SIZE];
	int contado;
	
	while (1) {
		contador = read(arquivo_driver, &buffer_entrada, BUFFER_SIZE);
		if (contador < 0){
			printf("\n| - - Erro! Não foi possivel receber dados do arquivo neste momento.");
		} 
		else {
			printf("%s\n", buffer_entrada);
		}
		
		fflush(stdout);
	}
}

// Procedimento que envia dados para o dispositivo
void envia (void) {
	char buffer_saida[BUFFER_SIZE];
	int contado;

	while(1) {
		if (fgets(buffer_saida, sizeof(buffer_saida), stdin)) {
			contador = write(arquivo_driver, &buffer_saida, sizeof(buffer_saida));
			if (contador < 0) {
				printf("\n| - - Erro! Não foi escrever neste momento.");
				return -1; 
			}
		}

	}	
}

// Procedimento principal. Não possui fim.
int main(int argc, char** argv) {
    char buffer_saida[BUFFER_SIZE];
    int contador;
	
	// Inicializa o driver e define novos parametros
	inicializa_comunicacao(fgets(buffer_saida, sizeof(buffer_saida), stdin));	
	
	// realiza uma comunicação simples entre o computador e o dispositivo
	if (fork() == 0)
		recebe();

	envia();
    
    return (EXIT_SUCCESS);
}
