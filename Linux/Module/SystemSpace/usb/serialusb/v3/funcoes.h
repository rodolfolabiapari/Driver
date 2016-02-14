#include <linux/kernel.h>
//#include <linux/init.h>
#include <linux/errno.h>
#include <linux/slab.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/module.h>
//#include <linux/moduleparam.h>
#include <linux/usb.h>
#include <linux/uaccess.h>
#include <linux/usb/serial.h>
//#include <linux/mutex.h>
#include "constantes.h"

static int  recebe_configuracao_atual        (struct usb_serial_port *, u8, u8, int, int, unsigned int *);
static int  define_nova_configuracao         (struct usb_serial_port *, u8, u8, int, int, unsigned int *);
static int  abre_driver                      (struct tty_struct *, struct usb_serial_port *);
static void fecha_driver                     (struct usb_serial_port *);
static void define_nova_configuracao_termios (struct tty_struct *, struct usb_serial_port *, struct ktermios *);
static void impede_controle                  (struct tty_struct *, int);
//static int  inicia_conexao_device            (struct usb_serial *);
//static void finaliza_conexao_device          (struct usb_serial *);
static unsigned int normaliza_baud_rate      (unsigned int );
static void recebe_configuracao_atual_termios(struct tty_struct *, struct usb_serial_port *) ;
static void altera_baud_rate                 (struct tty_struct *, struct usb_serial_port *, struct ktermios *) ;