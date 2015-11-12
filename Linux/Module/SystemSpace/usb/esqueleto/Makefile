obj-m	:= esqueleto.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:
	
	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order # Removendo os arquivos antigos

	#sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	
	$(MAKE) -C $(KERNELDIR) M=$(PWD) #Compilando os arquivos atraves do kernel

	
	sudo cp esqueleto.ko /tmp/ #Copiando para a pasta temporaria

	
	sudo rmmod esqueleto # Removendo o driver antigo

	
	sudo insmod /tmp/esqueleto.ko # Adicionando o novo driver

	#sudo chmod 666 /dev/y*

	#dmesg | tail
