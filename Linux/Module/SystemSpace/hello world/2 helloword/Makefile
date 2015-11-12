ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
	obj-m  := testePrint.o

else
# normal makefile
    KDIR ?= /lib/modules/`uname -r`/build

default:
$(MAKE) -C $(KDIR) M=$$PWD

endif
