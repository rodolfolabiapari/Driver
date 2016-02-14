# Nome do arquivo.c do driver a ser compilado
obj-m	:= driverAlgorithmCrypto.o

# Informações de diretório do sistema de compilação 
KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:
	# Remove arquivos antigos caso existam
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order     # Removendo os arquivos antigos

	# Atualiza o horário do sistema
	sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	# Compila o driver
	$(MAKE) -C $(KERNELDIR) M=$(PWD)     #Compilando os arquivos atraves do kernel

	# Carrega a biblioteca USB serial
	#    Este deve ser descomentado apenas na primeira compilacao
	#    Após carregado, não necessita de recarregar ao recompilar 
	#sudo insmod /lib/modules/$(shell uname -r)/kernel/drivers/usb/serial/usbserial.ko

	# copia para um diretório temporário
	sudo cp *.ko /tmp/        #Copiando para a pasta temporaria
	
	#Retirar o comentário somente quando for retirar o driver já inserido para 
	#  a adição de um novo, atualizando-o
	#sudo rmmod driverAlgorithmCrypto              # Removendo o driver antigo
	
	# Insere do diretório temporário
	sudo insmod /tmp/*.ko     # Adicionando o novo driver
