obj-m	:= moduleFileUSB.o

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

all:

	rm -f *.o *~ core .depend .*.cmd *.ko *.mod.c *.symvers *.order

	#sudo /usr/sbin/ntpdate ntp.on.br time.nist.gov pool.ntp.org

	$(MAKE) -C $(KERNELDIR) M=$(PWD)

	cp moduleFileUSB.ko /home/rodolfo/temporario/device_file

	#$(sudo rmmod moduleFileUSB)
	#$(sudo insmod /home/rodolfo/temporario/probeAndDisconnect/moduleFileUSB.ko)
