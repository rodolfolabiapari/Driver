#include <SoftwareSerial.h>

//Porta USB --- TX = 18, RX = 19
SoftwareSerial porto1(18, 19);

char buffer, bufferMenuPrincipal = 0, key[15], text[63];
bool menuPrincipal = true;

int estado = 0, i;

void requisitaMenuPrincipal() {
  menuPrincipal = true;
  bufferMenuPrincipal = 0;
}


void setup() {
  Serial.begin(9600);
}



void loop() {

  if (menuPrincipal) {
    Serial.print("\n\n Menu Principal");
    Serial.print("\n----- ----------");
    Serial.print("\n\n[r] Reset    [k] Chave    [t] Texto    [s] Start    [o] Resultado");

    while (Serial.available() == 0) ;

    Serial.print("\n\nLendo Informacao");
    bufferMenuPrincipal = Serial.read();
    menuPrincipal = false;
  }

  Serial.print("\nEscolha realizada: ");


  switch (bufferMenuPrincipal) {
    case 'r':
      Serial.print("Reset");

      for (i = 0; i < 16; i++) {
        key[i] = text[i] = '0';
      }

      buffer = 0;
      bufferMenuPrincipal = 0;
      menuPrincipal = true;

      Serial.print("\n\nDados excluidos com sucesso\n");

      break;

    //case 'b':
    case 'k':
      Serial.print("Chave");
      bufferMenuPrincipal = 0;

      Serial.print("\n\t[1] Define Chave    [2] Imprime Chave\n");
      Serial.print("\n\tComando Lido: ");

      while (Serial.available() == 0) ;

      buffer = Serial.read();
      Serial.print(buffer);


      switch (buffer) {
        case '1': 

          i = 0;
          Serial.print("\n\tKey[");
          Serial.print(i);
          Serial.print("] lida: ");
          while (i < 16) {
            if (Serial.available() > 0) {
              key[i] = Serial.read();
              Serial.print(key[i++]);
              if (i < 16) {
                Serial.print("\n\tKey[");
                Serial.print(i);
                Serial.print("] lida: ");
              }
            }
          }

          Serial.print("\n\tChave lida: \"");
          Serial.print(key);

          buffer = 0;

          break;

        case '2':

          buffer = 0; 

          Serial.print("\n\tChave atual: \"");
          Serial.print(key);
          break;
      }


      Serial.print("\"\n\tDeseja voltar no menu Chave? (s, n)");

      while (Serial.available() == 0) ;

      buffer = Serial.read();
      Serial.print("\n\tComando Lido: ");
      Serial.print(buffer);
        

      if (buffer == 's' || buffer == 'S') {
        menuPrincipal = false;
        bufferMenuPrincipal = 'k';

      } else {
        Serial.print("Voltando para o Menu Principal\n");
        requisitaMenuPrincipal();
      }

      break;

    case 't':
      break;

    default:
      Serial.print("Operacao Finalizada ");
      break;
  }
}

