#include <linux/kernel.h>
//#include <linux/init.h>
//#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/tty.h>
//#include <linux/tty_flip.h>
#include <linux/module.h>
//#include <linux/moduleparam.h>
#include <linux/usb.h>
#include <linux/usb/serial.h>
#include <linux/uaccess.h>
//#include <linux/mutex.h>


/* Part number definitions */
#define CP2101_PARTNUM		0x01
#define CP2102_PARTNUM		0x02
#define CP2103_PARTNUM		0x03
#define CP2104_PARTNUM		0x04
#define CP2105_PARTNUM		0x05
#define CP2108_PARTNUM		0x08

/* IOCTLs */
#define IOCTL_GPIOGET		0x8000
#define IOCTL_GPIOSET		0x8001

/* Config request types */
#define REQTYPE_HOST_TO_INTERFACE	0x41
#define REQTYPE_INTERFACE_TO_HOST	0xc1
#define REQTYPE_HOST_TO_DEVICE	0x40
#define REQTYPE_DEVICE_TO_HOST	0xc0

/* Config request codes */
#define CP210X_IFC_ENABLE	0x00
#define CP210X_SET_BAUDDIV	0x01
#define CP210X_GET_BAUDDIV	0x02
#define CP210X_SET_LINE_CTL	0x03
#define CP210X_GET_LINE_CTL	0x04
#define CP210X_SET_BREAK	0x05
#define CP210X_IMM_CHAR		0x06
#define CP210X_SET_MHS		0x07
#define CP210X_GET_MDMSTS	0x08
#define CP210X_SET_XON		0x09
#define CP210X_SET_XOFF		0x0A
#define CP210X_SET_EVENTMASK	0x0B
#define CP210X_GET_EVENTMASK	0x0C
#define CP210X_SET_CHAR		0x0D
#define CP210X_GET_CHARS	0x0E
#define CP210X_GET_PROPS	0x0F
#define CP210X_GET_COMM_STATUS	0x10
#define CP210X_RESET		0x11
#define CP210X_PURGE		0x12
#define CP210X_SET_FLOW		0x13
#define CP210X_GET_FLOW		0x14
#define CP210X_EMBED_EVENTS	0x15
#define CP210X_GET_EVENTSTATE	0x16
#define CP210X_SET_CHARS	0x19
#define CP210X_GET_BAUDRATE	0x1D
#define CP210X_SET_BAUDRATE	0x1E
#define CP210X_VENDOR_SPECIFIC	0xFF

/* CP210X_IFC_ENABLE */
#define UART_ENABLE		0x0001
#define UART_DISABLE		0x0000

/* CP210X_VENDOR_SPECIFIC */
#define CP210X_WRITE_LATCH	0x37E1
#define CP210X_READ_LATCH	0x00C2
#define CP210X_GET_PARTNUM	0x370B

/* CP210X_(SET|GET)_BAUDDIV */
#define BAUD_RATE_GEN_FREQ	0x384000

/* CP210X_(SET|GET)_LINE_CTL */
#define BITS_DATA_MASK		0X0f00
#define BITS_DATA_5		0X0500
#define BITS_DATA_6		0X0600
#define BITS_DATA_7		0X0700
#define BITS_DATA_8		0X0800
#define BITS_DATA_9		0X0900

#define BITS_PARITY_MASK	0x00f0
#define BITS_PARITY_NONE	0x0000
#define BITS_PARITY_ODD		0x0010
#define BITS_PARITY_EVEN	0x0020
#define BITS_PARITY_MARK	0x0030
#define BITS_PARITY_SPACE	0x0040

#define BITS_STOP_MASK		0x000f
#define BITS_STOP_1		0x0000
#define BITS_STOP_1_5		0x0001
#define BITS_STOP_2		0x0002