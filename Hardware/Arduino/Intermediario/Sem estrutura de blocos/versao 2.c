
const int BLOCOS = 1;
char buffer, buffer1, bufferMenuPrincipal, verificacao[100], text[100];
bool menuPrincipal = true;
bool executouMaquina = false;
char result[100],  keyHEX[100];

/*
	depis que o hardware recebe a chave, ele não envia a resposta 'k' corretamente
3031323334353637
133457799BBCDFF1
*/

int estado = 15, i, j;

void asciiToHex(int TAM, char* frase) {
	char atual;

	for (i = 0; i < TAM; i++) {
		atual = frase[i];

		Serial.print(atual & 0x0f);
		Serial.print((atual >> 4) & 0x0f);
	}
}

void setup() {
	Serial.begin(9600);
	Serial1.begin(4800);
	
	/*for (i = 0; i < 8; i++) {
		for (j = 0; j < 6; j++)
			keyHEX[i * j] = 0;

		for (j = 0; j < BLOCOS; j++)
			text[i * BLOCOS] = result[i * BLOCOS] = verificacao[i * BLOCOS] = 0;
	}
	keyHEX[48] = text[BLOCOS * 8] = result[BLOCOS * 8] = verificacao[BLOCOS * 8] = 0;*/

	for (i = 0; i < 100; i++) {
		verificacao[i] = text[i] = result[i] = keyHEX[i] = 0;
	}

	Serial.print("\n\nIniciando Hardware...");
	Serial1.print("s");
	//while (Serial1.available() == 0) ;

	//if (Serial1.read() == 's') 
		Serial.print("Hardware Iniciado...");
}



void loop() {

	switch (estado) {
		// Menu principal
		case 15:
			if (!executouMaquina) {
				executouMaquina = true;
				Serial.print("\n\n Menu Principal");
				Serial.print("\n----- ----------");
				Serial.print("\n\t[i] Reset\t[k] Chave\t[t] Texto\t[s] Start\t[r] Resultado\t[o] Operacoes\n");

				while (Serial.available() == 0) ;

				bufferMenuPrincipal = Serial.read();
				buffer = 0;
				menuPrincipal = false;
			}

			switch (bufferMenuPrincipal) {
				case 'i': 
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
					buffer = 0;
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

			buffer = 0;
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
				buffer = Serial.read();
				Serial.print(buffer);
			}

			switch (buffer) {
				case '0':
					executouMaquina = false;
					estado = 15; 
					Serial1.print("f");
					break;

				case '1': 
					Serial1.print("a");

					for (i = 0; i < 48; i++) {
						while (Serial1.available() != 0) {
							Serial1.read();
						}

						Serial.print("\n\tkeyHEX[");
						Serial.print(i);
						Serial.print("]: ");

						while (Serial.available() == 0) ;

						keyHEX[i] = Serial.read();

						switch (keyHEX[i]) {
							case 'a': keyHEX[i] = 'A'; break;
							case 'b': keyHEX[i] = 'B'; break;
							case 'c': keyHEX[i] = 'C'; break;
							case 'd': keyHEX[i] = 'D'; break;
							case 'e': keyHEX[i] = 'E'; break;
							case 'f': keyHEX[i] = 'F'; break;
						}

						Serial.print(keyHEX[i]);

						Serial1.print(keyHEX[i]);

						
						Serial.print("\t\t K1:");
						for (j = 0; j <= i && j < 16; j++)
							Serial.print(keyHEX[j]);

						if (i >= 16) {
							Serial.print(" K2:");
							for (j = 16; j <= i && j < 32; j++)
								Serial.print(keyHEX[j]);
						}
						if (i >= 32) {
							Serial.print(" K3:");
							for (j = 32; j <= i && j < 48; j++)
								Serial.print(keyHEX[j]);
						}
					}
					keyHEX[i] = 0;

					Serial.print("\n\nEsperando Resposta de envio da KEY...");
					delay(1000);

					if (Serial1.available() != 0) {
						//buffer = Serial1.read();

						Serial.print("Resposta do Hardware: ");
						buffer1 = Serial1.read();
						Serial.print(buffer1);

						if (buffer1 != 'k') {
							Serial.print("\n\nErro no envio da KEY.");
							estado = 15;
							executouMaquina = false;
						}
						buffer1 = 0;
						buffer = '2';
					} else {
						Serial.print("\n\nErro na resposta do Hardware.");
						estado = 15;
						executouMaquina = false;
					}

					break;

				case '2': 
					Serial.print("\n\tChave HEX no driver  :");

					Serial.print("\n\t\tK1: ");
					for (j = 0; j < 16; j++)
						Serial.print(keyHEX[j]);

					Serial.print("\n\t\tK2: ");
					for (j = 16; j < 32; j++)
						Serial.print(keyHEX[j]);

					Serial.print("\n\t\tK3: ");
					for (j = 32; j < 48; j++)
						Serial.print(keyHEX[j]);
					


					Serial1.print("b");

					for (i = 0; i < 24; i++) {
						while (Serial1.available() == 0) ;

						verificacao[i] = Serial1.read();
					}

					Serial.print("\n\tChave ASCII no hardware:");
					Serial.print("\n\t\tK1: ");
					for (j = 0; j < 8; j++)
						Serial.print(verificacao[j]);

					Serial.print("\n\t\tK2: ");
					for (j = 8; j < 16; j++)
						Serial.print(verificacao[j]);

					Serial.print("\n\t\tK3: ");
					for (j = 16; j < 24; j++)
						Serial.print(verificacao[j]);

					executouMaquina = false;
					break;

				default: executouMaquina = false;
					buffer = 0;

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

				Serial.print("\n\t[0] Menu Principal\t[1] Define texto\t[2] Imprime texto");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				buffer = Serial.read();
				Serial.print(buffer);
			}

			switch (buffer) {
				case '0':
					Serial1.print("f");
					executouMaquina = false;
					estado = 15; 
					break;

				case '1': 
					Serial1.print("a");

					for (i = 0; i < BLOCOS * 8; i++) {
						Serial.print("\n\tText[");
						Serial.print(i);
						Serial.print("]: ");

						while (Serial.available() == 0) ;

						text[i] = Serial.read();
						Serial.print(text[i]);
						Serial1.print(text[i]);
					}


					Serial.print("\n\nEsperando Resposta de envio da TEXT...");
					delay(1000);
					if (Serial1.available() != 0) {
						//buffer = Serial1.read();

						Serial.print("Resposta do Hardware: ");
						buffer1 = Serial1.read();
						Serial.print(buffer1);

						if (buffer1 != 't') {
							Serial.print("\n\nErro no envio da TEXT.");
							estado = 15;
							executouMaquina = false;
						}
						buffer1 = 0;
						buffer = '2';
					} else {
						Serial.print("\n\nErro na resposta do Hardware.");
						estado = 15;
						executouMaquina = false;
					}
					break;

				case '2': 
					Serial.print("\n\tTexto atual ASC        : ");
					Serial.print(text);


					Serial1.print("b");

					for (i = 0; i < 8; i++) {
						while (Serial1.available() == 0) ;

						verificacao[i] = Serial1.read();
					}
					verificacao[i] = 0;

					Serial.print("\n\tTexto ASCII no hardware: ");
					for (j = 0; j < 8; j++)
						Serial.print(verificacao[j]);

					executouMaquina = false;
					break;

					default: executouMaquina = false;
					buffer = 0;
			}
			break;


		case 6:
			break;


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
				Serial.print("\nChave Atual HEX: \""); Serial.print(keyHEX); Serial.print("\"");
				Serial.print("\nTexto Atual ASC: \""); Serial.print(text);   Serial.print("\"");
				bufferMenuPrincipal = 0;

				Serial.print("\n\t[0] Menu Principal\t[1] Encripta\t[2] Decrifra");

				while (Serial.available() == 0) ;

				Serial.print("\n\tComando Lido: ");
				buffer = Serial.read();
				Serial.print(buffer);
			}

			switch (buffer) {
				case '0':
					Serial1.print("f");
					executouMaquina = false;
					estado = 15; 
					break;

				case '1': 
					Serial1.print("e"); // Encripta
					Serial.print("\n\nEncriptando...");
					buffer = '3';
					break;

				case '2': 
					executouMaquina = false;
					estado = 15; 
					break;

				case '3': //Rercebe resultado
					Serial.print("Esperando a resposta...\"");
					for (i = 0; i < 8; i++) {
						while (Serial1.available() == 0) ;
						result[i] = Serial1.read();
						Serial.print(result[i]);
					}
					result[i] = 0;
					Serial.print("\"Resposta obtida...");
					estado = 11;
					break;

					default: executouMaquina = false;
					buffer = 0;
			}
			break;


		case 11: //Imprime resultado
			Serial.print("\n\nRESULTADO OBTIDO: ");
			Serial.print(result);
			asciiToHex(8, result); 
			estado = 15; 
			executouMaquina = false;
			break;
		
		default: 
		executouMaquina = false;
		buffer = 0;
	}
/*
3031323334353637
133457799BBCDFF1
*/
}
