obj-m	:= gotemp.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:

	#rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order

	#sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	$(MAKE) -C $(KERNELDIR) M=$(PWD)

	cp gotemp.ko /home/rodolfo/temporario/probeAndDisconnect

	sudo rmmod gotemp
	sudo insmod /home/rodolfo/temporario/probeAndDisconnect/gotemp.ko
