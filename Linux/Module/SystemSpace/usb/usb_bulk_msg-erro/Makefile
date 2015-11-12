obj-m	:= NoUrb.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:

	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order

	#sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	$(MAKE) -C $(KERNELDIR) M=$(PWD)

	cp NoUrb.ko ~/temporario/NoUrb


	sudo rmmod NoUrb
	sudo insmod ~/temporario/NoUrb/NoUrb.ko
	sudo chmod 666 /dev/y*
	dmesg | tail