obj-m	:= memoryFile.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:

	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order

	sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	$(MAKE) -C $(KERNELDIR) M=$(PWD)

	cp memoryFile.ko ~/temporario/memoryFile


	sudo rmmod memoryFile
	sudo insmod ~/temporario/memoryFile/memoryFile.ko
