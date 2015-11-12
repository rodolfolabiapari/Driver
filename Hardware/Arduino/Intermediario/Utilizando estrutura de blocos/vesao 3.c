
// EXISTEM TODOS



byte respostaHardware, bufferMenuPrincipal, bufferSubMenu;//, verificacao[100], text[100];
bool menuPrincipal = true;
bool executouMaquina = false;
byte keyHEX[100];//, result[100];

struct tNodeBloco {
		byte bloco[8];
		struct tNodeBloco * next;
	};

struct tNodeBloco * listaBlocoOriginalRoot;
struct tNodeBloco * listaBlocoOriginalCorrente;

struct tNodeBloco * listaBlocoOperadoRoot;
struct tNodeBloco * listaBlocoOperadoCorrente;
int blocos = 0, estado = 15, i, j;

bool criaLista (struct tNodeBloco * estrutura) {
	estrutura = (struct tNodeBloco *) malloc( sizeof(struct tNodeBloco) );
	blocos = 1;
	if (estrutura != NULL)
		return 0;
	else 
		return -1;
}

void destroiLista (struct tNodeBloco * estrutura) {
	struct tNodeBloco * atual;
	while (estrutura != NULL) {
		atual = estrutura;
		estrutura = estrutura->next; 
		free(atual);
	}
	blocos = 0;
}

struct tNodeBloco * incrementaLista (struct tNodeBloco * estrutura) {
	estrutura->next = (struct tNodeBloco *) malloc( sizeof(struct tNodeBloco) );
	estrutura->next->next = NULL;
	blocos++;
	return (struct tNodeBloco *) estrutura->next;
}

void imprimeChaveHEX (char * chave) {
	Serial.print("K1:");
	int j;
	for (j = 0; j < 8; j++)
		Serial.print(chave[j], HEX);

	Serial.print(" K2:");
	for (j = 8; j < 16; j++)
		Serial.print(chave[j], HEX);

	Serial.print(" K3:");
	for (j = 16; j <= i && j < 24; j++)
		Serial.print(chave[j], HEX);
}

void imprimeChaveACII (char * chave) {
	int j;
	Serial.print("K1:");
	for (j = 0; j < 8; j++)
		Serial.print( (char) chave[j]);

	Serial.print(" K2:");
	for (j = 8; j < 16; j++)
		Serial.print( (char) chave[j]);

	Serial.print(" K3:");
	for (j = 16; j <= i && j < 24; j++)
		Serial.print( (char) chave[j]);
}

void imprimeTexto(struct tNodeBloco * texto) {
	struct tNodeBloco * corrente = texto;
	while (corrente != NULL) {
		for (int i = 0; i < 7; i++)
			Serial.print(corrente->bloco[i]);
		corrente = corrente->next;
	}
}

void realizaOperacao(struct tNodeBloco * texto, char op, struct tNodeBloco * resultado) {
	bool first = true;

	struct tNodeBloco * textoTemp = texto;
	while (textoTemp != NULL) {
		// Altera o texto atual
		Serial1.print("ta");

		for (i = 0; i < 8; i++) {
			Serial1.print(textoTemp->bloco[i]);
		}

		while (Serial1.available() == 0) ;

		if (Serial1.read() == 't') {
			// TODO Verificar se ambas são as mesmas
			if (resultadoVerificacao) {

				// Realiza a op
				Serial1.print("foe");

				// Recebe o texto
				if (first) {
					criaLista(resultado);
					first = false;
				} else 
					resultado = (struct tNodeBloco *) incrementaLista(resultado);

				for (i = 0; i < 8; i++) {
					while (Serial1.available() == 0) ;
					resultado->bloco[i] = Serial1.read();
				}

				textoTemp = textoTemp->next;
			} else {
				Serial.print("Tentando enviar bloco novamente.")
				i--;
			}


		} else {
			Serial1.print('fx');

		}
	}
}

/*
3031323334353637
133457799BBCDFF1	
*/

void setup() {
	Serial.begin(9600);
	Serial1.begin(4800);

	for (i = 0; i < 100; i++) {
		verificacao[i] = text[i] = result[i] = keyHEX[i] = 0;
	}

	/*Serial.print("\n\nIniciando Hardware...");
	Serial1.print("xs");
	//while (Serial1.available() == 0) ;

	//if (Serial1.read() == 's') 
		Serial.print("Hardware Iniciado...");*/
}



void loop() {

	switch (estado) {
		// Menu principal
		case 15:
			if (!executouMaquina) {
				executouMaquina = true;
				Serial.print("\n\n Menu Principal");
				Serial.print("\n----- ----------");
				Serial.print("\n\t[x] Reset\t[k] Chave\t[t] Texto\t[s] Start\t[r] Resultado\t[o] Operacoes\n");

				while (Serial.available() == 0) ;

				bufferMenuPrincipal = Serial.read();
				bufferSubMenu = 0;
				menuPrincipal = false;
			}

			switch (bufferMenuPrincipal) {
				case 'x': 
					estado = 0; 
					executouMaquina = false;
					break;

				case 'k': 
					estado = 4; 
					executouMaquina = false;
					Serial1.print("k");
					break;

				case 'o': 
					estado = 10; 
					executouMaquina = false;
					break;

				case 's': 
					executouMaquina = false;
					Serial1.print("s");
					break;

				case 't': 
					executouMaquina = false;
					estado = 5; 
					Serial1.print("t");
					break;

				case 'r': 
					estado = 7; 
					executouMaquina = false;
					break;

					default: executouMaquina = false;
					bufferSubMenu = 0;
			}
			break;


		// Reset
		case 0:
			Serial.print(" Reset");
			Serial.print("-------");

			for (i = 0; i < 8; i++) {
				text[i] = verificacao[i] =
				keyHEX[i] = keyHEX[i + 8] = keyHEX[i + 16] = keyHEX[i + 24] = keyHEX[i + 32] = keyHEX[i + 40] = 0;
			}

			Serial1.print("x");

			bufferSubMenu = 0;
			bufferMenuPrincipal = 0;
			menuPrincipal = true;

			Serial.print("\n\nDados excluidos com sucesso\n");

			executouMaquina = false;
			estado = 15; 
			bufferMenuPrincipal = 0;
			break;


		case 2:
			break;


		case 3:
			break;


			// Menu Chave
		case 4:
			if (!executouMaquina) {
				executouMaquina = true;
				Serial.print("\n\n Chave");
				Serial.print("\n-------");
				bufferMenuPrincipal = 0;

				Serial.print("\n\t[0] Menu Principal\t[1] Define Chave\t[2] Imprime Chave");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				bufferSubMenu = Serial.read();
				Serial.print((char) bufferSubMenu);
			}

			switch (bufferSubMenu) {
				case '0':
					executouMaquina = false;
					estado = 15; 
					Serial1.print("f");
					break;

				case '1': 
					Serial1.print("a");
					char bufferTemp , byteFinal;

					for (i = 0; i < 24; i++) {
						while (Serial1.available() != 0) {
							Serial1.read();
						}

						Serial.print("\n\tkeyHEX[");
						Serial.print(i*2);
						Serial.print("]: ");

						while (Serial.available() == 0) ;

						bufferTemp  = Serial.read();

						switch (bufferTemp ) {
							case 'a': bufferTemp  = 'A'; break;
							case 'b': bufferTemp  = 'B'; break;
							case 'c': bufferTemp  = 'C'; break;
							case 'd': bufferTemp  = 'D'; break;
							case 'e': bufferTemp  = 'E'; break;
							case 'f': bufferTemp  = 'F'; break;
							default : bufferTemp  = bufferTemp ;
						}

						Serial.print(bufferTemp );

						if (bufferTemp  >= '0' && bufferTemp  <= '9') 
							byteFinal = ((unsigned byte) bufferTemp  - '0') << 4;
						else
							byteFinal = ((unsigned byte) bufferTemp  - 'A' + 0xA) << 4; 


						Serial.print("\tkeyHEX[");
						Serial.print(i*2 + 1);
						Serial.print("]: ");

						while (Serial.available() == 0) ;

						bufferTemp  = Serial.read();

						switch (bufferTemp ) {
							case 'a': bufferTemp  = 'A'; break;
							case 'b': bufferTemp  = 'B'; break;
							case 'c': bufferTemp  = 'C'; break;
							case 'd': bufferTemp  = 'D'; break;
							case 'e': bufferTemp  = 'E'; break;
							case 'f': bufferTemp  = 'F'; break;
							default : bufferTemp  = bufferTemp ;
						}
						
						Serial.print(bufferTemp);

						if (bufferTemp  >= '0' && bufferTemp  <= '9') 
							byteFinal += ((unsigned byte) bufferTemp  - '0');
						else
							byteFinal += ((unsigned byte) bufferTemp  - 'A' + 0xA); 

						keyHEX[i] = byteFinal;

						Serial.print("\t(Caractere ASCII referente: \'");
						Serial.print((char) keyHEX[i]);
						Serial.print("\')");


						Serial1.print((char) keyHEX[i]);

						
						Serial.print("\n\t\t K1:");
						for (j = 0; j <= i && j < 8; j++)
							Serial.print(keyHEX[j], HEX);

						if (i >= 8) {
							Serial.print(" K2:");
							for (j = 8; j <= i && j < 16; j++)
								Serial.print(keyHEX[j], HEX);
						}
						if (i >= 16) {
							Serial.print(" K3:");
							for (j = 16; j <= i && j < 24; j++)
								Serial.print(keyHEX[j], HEX);
						}
						Serial.print('\n');
					}

					Serial.print("\n\nEsperando Resposta de envio da KEY...");
					delay(1000);

					if (Serial1.available() != 0) {
						//respostaHardware = Serial1.read();

						Serial.print("Resposta do Hardware: ");
						respostaHardware = Serial1.read();
						Serial.print(respostaHardware);

						if (respostaHardware != 'k') {
							Serial.print("\n\nErro no envio da KEY.");
							estado = 15;
							executouMaquina = false;
						}
						respostaHardware = 0;
						bufferSubMenu = '2';
					} else {
						Serial.print("\n\nErro na resposta do Hardware. Nao obteve nenhuma resposta.");
						estado = 15;
						executouMaquina = false;
					}

					break;

				case '2': 
					Serial.print("\n\tChave HEX no driver  :\n\t\t");

					imprimeChaveHEX(keyHEX);
					/*Serial.print("\n\t\tK1: ");
					for (j = 0; j < 8; j++)
						Serial.print(keyHEX[j], HEX);

					Serial.print("\n\t\tK2: ");
					for (j = 8; j < 16; j++)
						Serial.print(keyHEX[j], HEX);

					Serial.print("\n\t\tK3: ");
					for (j = 16; j < 24; j++)
						Serial.print(keyHEX[j], HEX);*/
					

					Serial1.print("b");

					for (i = 0; i < 24; i++) {
						while (Serial1.available() == 0) ;

						verificacao[i] = (unsigned byte) Serial1.read();
					}
					
					Serial.print("\n\n\tChave HEX no hardware:\n\t\t");
					imprimeChaveHEX(verificacao);
					/*Serial.print("\n\t\tK1: ");
					for (j = 0; j < 8; j++)
						Serial.print(verificacao[j], HEX);

					Serial.print("\n\t\tK2: ");
					for (j = 8; j < 16; j++)
						Serial.print(verificacao[j], HEX);

					Serial.print("\n\t\tK3: ");
					for (j = 16; j < 24; j++)
						Serial.print(verificacao[j], HEX);
						*/

					Serial.print("\n\tChave ASCII no hardware:\n\t\t");
					imprimeChaveACII(verificacao);
					/*Serial.print("\n\t\tK1: ");
					for (j = 0; j < 8; j++)
						Serial.print((char) verificacao[j]);

					Serial.print("\n\t\tK2: ");
					for (j = 8; j < 16; j++)
						Serial.print((char) verificacao[j]);

					Serial.print("\n\t\tK3: ");
					for (j = 16; j < 24; j++)
						Serial.print((char) verificacao[j]);*/

					executouMaquina = false;
					break;


				case 'x':
					Serial1.print("x");
					executouMaquina = false;
					estado = 15; 
					break;

				default: executouMaquina = false;
					bufferSubMenu = 0;

			}
			break;
		
			// Texto
		case 5:
			if (!executouMaquina) {
				while (Serial1.available() != 0) {
					Serial1.read();
				}
				
				executouMaquina = true;
				Serial.print("\n\n Texto");
				Serial.print("\n-------");
				bufferMenuPrincipal = 0;

				Serial.print("\n\t[0] Menu Principal\t[1] Menu Texto Simples\t[2] Menu Texto Extenso");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				bufferSubMenu = Serial.read();
				Serial.print((char) bufferSubMenu);
			}

			switch (bufferSubMenu) {
				case '0':
					Serial1.print("f");
					executouMaquina = false;
					estado = 15; 
					break;

				case '1': 
					Serial.print("\n\tDigite o texto que será operado:\n");
					char bufferTemp;
					i = 0;

					criaLista(listaBlocoOriginalRoot);

					while (Serial.available() == 0) ;
					bufferTemp = Serial.read();

					while(bufferTemp != EOF) {
						if (i == 8) {
							listaBlocoOriginalCorrente = (struct tNodeBloco *) incrementaLista(listaBlocoOriginalCorrente);
							i = 0;
						}

						listaBlocoOriginalCorrente->bloco[i++] = bufferTemp;
						Serial.print(bufferTemp);

						while (Serial.available() == 0) ;
						bufferTemp = Serial.read();
					};
					for (; i < 8; i++)
						listaBlocoOriginalCorrente->bloco[i++] = 0;

					bufferSubMenu = '2';

					/*
					listaBlocoOriginalCorrente = listaBlocoOriginalRoot;
					while (listaBlocoOriginalCorrente != NULL) {
						for (i = 0; i < 7; i++)
							Serial.print(listaBlocoOriginalCorrente->bloco[i]);
						listaBlocoOriginalCorrente = listaBlocoOriginalCorrente->next;
					}*/


					/*
					Serial.print("\n\nEsperando Resposta de envio da TEXT...");
					delay(1000);
					if (Serial1.available() != 0) {
						//respostaHardware = Serial1.read();

						Serial.print("Resposta do Hardware: ");
						respostaHardware = Serial1.read();
						Serial.print((char) respostaHardware);

						if (respostaHardware != 't') {
							Serial.print("\n\nErro no envio da TEXT.");
							estado = 15;
							executouMaquina = false;
						}
						respostaHardware = 0;
						bufferSubMenu = '2';
					} else {
						Serial.print("\n\nErro na resposta do Hardware. Nao obteve nenhuma resposta.");
						estado = 15;
						executouMaquina = false;
					}*/
					break;

				case '2': 
					Serial.print("\n\tTexto ASCII:\n");
					imprimeTexto(listaBlocoOriginalRoot);
					/*listaBlocoOriginalCorrente = listaBlocoOriginalRoot;
					while (listaBlocoOriginalCorrente != NULL) {
						for (i = 0; i < 7; i++)
							Serial.print(listaBlocoOriginalCorrente->bloco[i]);
						listaBlocoOriginalCorrente = listaBlocoOriginalCorrente->next;
					}*/


					executouMaquina = false;
					break;

				case 'x':
					Serial1.print("x");
					executouMaquina = false;
					estado = 15; 
					break;

				default: executouMaquina = false;
					bufferSubMenu = 0;
			}
			break;

		/*
		// Texto Simples
		case 6:
			if (!executouMaquina) {
				while (Serial1.available() != 0) {
					Serial1.read();
				}
				
				executouMaquina = true;
				Serial.print("\n\n Texto Simples");
				Serial.print("\n---------------");
				bufferMenuPrincipal = 0;

				Serial.print("\n\t[0] Menu Principal\t[1] Define Texto Simples\t[2] Exibe Texto Extenso");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				bufferSubMenu = Serial.read();
				Serial.print((char) bufferSubMenu);
			}

			switch (bufferSubMenu) {
				case '1': 
					Serial1.print("a");

					for (i = 0; i < 8; i++) {
						Serial.print("\n\tText[");
						Serial.print(i);
						Serial.print("]: ");

						while (Serial.available() == 0) ;

						text[i] = Serial.read();
						Serial.print((char) text[i]);
						Serial1.print((char) text[i]);
					}


					Serial.print("\n\nEsperando Resposta de envio da TEXT...");
					delay(1000);
					if (Serial1.available() != 0) {
						//respostaHardware = Serial1.read();

						Serial.print("Resposta do Hardware: ");
						respostaHardware = Serial1.read();
						Serial.print((char) respostaHardware);

						if (respostaHardware != 't') {
							Serial.print("\n\nErro no envio da TEXT.");
							estado = 15;
							executouMaquina = false;
						}
						respostaHardware = 0;
						bufferSubMenu = '2';
					} else {
						Serial.print("\n\nErro na resposta do Hardware. Nao obteve nenhuma resposta.");
						estado = 15;
						executouMaquina = false;
					}
					break;

				case '2': 
					Serial.print("\n\tTexto ASCII no modulo  : ");
					for (i = 0; i < 8; i++) 
						Serial.print((char) text[i]);
					Serial.print("\n\tTexto HEX no modulo    : ");
					for (i = 0; i < 8; i++) 
						Serial.print(text[i], HEX);


					Serial1.print("b");

					for (i = 0; i < 8; i++) {
						while (Serial1.available() == 0) ;

						verificacao[i] = Serial1.read();
					}
					verificacao[i] = 0;

					Serial.print("\n\tTexto HEX no hardware  : ");
					for (j = 0; j < 8; j++)
						Serial.print(verificacao[j], HEX);
					Serial.print("\n\tTexto ASCII no hardware: ");
					for (j = 0; j < 8; j++)
						Serial.print((char) verificacao[j]);

					executouMaquina = false;
					break;
			break;
*/
		// Texto longo
		case 7:
			break;


		case 8:
			break;


		case 9:
			break;


			// Operacoes
		case 10:
			if (!executouMaquina) {
				executouMaquina = true;
				Serial1.print("o");
				Serial.print("\n\n Operacoes");
				Serial.print("\n-----------");
				Serial.print("\nChave Atual HEX: \""); 
				imprimeChaveHEX(keyHEX);
				/*for (j = 0; j < 8; j++)
					Serial.print(keyHEX[j], HEX);

				Serial.print(":");
				for (j = 8; j < 16; j++)
					Serial.print(keyHEX[j], HEX);

				Serial.print(":");
				for (j = 16; j < 24; j++)
					Serial.print(keyHEX[j], HEX);*/
				Serial.print("\"");

				Serial.print("\nTexto Atual ASC: \n\""); 
				imprimeTextoEmBlocos(listaBlocoOriginalRoot);
				Serial.print("\"");

				bufferMenuPrincipal = 0;

				Serial.print("\n\t[0] Menu Principal\t[1] Encripta\t[2] Decrifra");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				bufferSubMenu = Serial.read();
				Serial.print(bufferSubMenu);
			}

			switch (bufferSubMenu) {
				case '0':
					Serial1.print("f");
					executouMaquina = false;
					estado = 15; 
					break;

				case '1': 
					Serial.print("\n\nEncriptando...");
					Serial1.print("e"); // Encripta

					bufferSubMenu = '3';
					break;

				case '2': 
					executouMaquina = false;
					estado = 15; 
					break;

				case '3': //Rercebe resultado
					Serial.print("Esperando a resposta... \"");
					for (i = 0; i < 8; i++) {
						while (Serial1.available() == 0) ;
						result[i] = Serial1.read();
					}

					Serial.print("\"Resposta obtida com sucesso...");
					estado = 11;
					break;

					default: executouMaquina = false;
					bufferSubMenu = 0;
			}
			break;


		case 11: //Imprime resultado
			Serial.print("\n\n RESULTADO OBTIDO ");
			Serial.print("\n------------------ ");

			Serial.print("\n\t\tResultado em HEXADECIMAL: ");
			for (i = 0; i < 8; i++) {
				Serial.print(result[i], HEX);
			}

			Serial.print("\n\n\t\tResultado em ASCII      : ");
			for (i = 0; i < 8; i++) 
				Serial.print((char) result[i]);

			estado = 15; 
			executouMaquina = false;
			break;
		
		default: 
		executouMaquina = false;
		bufferSubMenu = 0;
	}
/*
3031323334353637
133457799BBCDFF1
*/
}
