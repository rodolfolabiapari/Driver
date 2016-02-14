obj-m	:= usbSerial.o
module-objs := usbSerial.o funcoes.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order     # Removendo os arquivos antigos

	#sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	
	$(MAKE) -C $(KERNELDIR) M=$(PWD)     #Compilando os arquivos atraves do kernel

	sudo insmod /lib/modules/$(shell uname -r)/kernel/drivers/usb/serial/usbserial.ko

	sudo cp usbSerial.ko /tmp/        #Copiando para a pasta temporaria
	
	#sudo rmmod usbSerial              # Removendo o driver antigo
	
	sudo insmod /tmp/usbSerial.ko     # Adicionando o novo driver

	#sudo chmod 666 /dev/y*

