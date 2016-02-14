/*
 * Distribuição do fonte:
 * <memory.c> =
 * 
 * <keiv initial>
 * <memory initial>
 * <keiv init module>
 * <keiv exit module> 
 * <memory open>
 * <memory release>
 * <memory read>
 * <memory write>

 * Utilização:
 * 1 - Inserir o arquivo no diretório /dev
 *        mknod /dev/nameFile c Major Minor
 *        chmod 666 /dev/nameFile
 * 2 - Carregar o módulo
 *        insmod nomeModulo.ko
 * 3 - Inserir dados
 *        echo -n abcdef > /dev/nameFile
 * 4 - Ler dados
 *        cat /dev/nameFile

 Para trabalhar com arquivos de mais caracteres: 
 https://appusajeev.wordpress.com/2011/06/18/writing-a-linux-character-device-driver/
 */




// <keiv initial> =
/* Necessary includes for device drivers */
#include <linux/init.h>
//#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h> /* printk() */
#include <linux/slab.h> /* kmalloc() */
#include <linux/fs.h> /* everything... */
#include <linux/errno.h> /* error codes */
#include <linux/types.h> /* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h> /* O_ACCMODE */
//#include <asm/system.h> /* cli(), *_flags */
#include <asm/uaccess.h> /* copy_from/to_user */

 MODULE_LICENSE("GPL");
MODULE_AUTHOR("Rodolfo Labiapari Mansur Guimaraes <rodolfolabiapari@gmail.com>");
MODULE_DESCRIPTION("USB Driver");

void kiev_exit(void);
int kiev_init(void);
static int times = 0;


/* Declaration of the init and exit functions */
module_init(kiev_init);
module_exit(kiev_exit);

/* Global variables of the driver */
/* Major number */
int kiev_major = 666;
/* Buffer to store data */
char *memory_buffer;





// <memory initial> =
/* Declaration of memory.c functions */
int memory_open(struct inode *inode, struct file *filp);
int memory_release(struct inode *inode, struct file *filp);
ssize_t memory_read(struct file *filp, char *buf, size_t count, loff_t *f_pos);
ssize_t memory_write(struct file *filp, char *buf, size_t count, loff_t *f_pos);

/* Structure that declares the usual file */
/* access functions */
struct file_operations memory_fops = {
	read: memory_read,
	write: memory_write,
	open: memory_open,
	release: memory_release
};





// <keiv init module> =
int kiev_init(void) {
	int result;

	printk("<Alerta>    Iniciando insercao do modulo.\n"); 
	/* Registering device */
	result = register_chrdev(kiev_major, "memory", &memory_fops);
	if (result < 0) {
		printk(
			"<Alerta>    |----Memoria: Nao foi possivel obter o Major Number %d.\n", kiev_major);

		return result;
	}

	/* Allocating memory for the buffer */
	memory_buffer = kmalloc(1, GFP_KERNEL); 
	if (!memory_buffer) { 
		result = -ENOMEM;
		printk(
			"<Alerta>    |----Memoria: Nao foi possivel alocar memoria.\n");
		kiev_exit(); 
		return result;
	} 
	memset(memory_buffer, 0, 1);
	printk(
		"<Alerta>    |----Memoria: Alocada com sucesso.\n");

	printk("<Alerta>    Modulo Inserido com sucesso.\n\n"); 
	return 0;
}





// <keiv exit module> =
void kiev_exit(void) {

	printk("<Alerta>    Iniciando remocao do modulo.\n"); 
	/* Freeing the major number */
	unregister_chrdev(kiev_major, "memory");

	/* Freeing buffer memory */
	if (memory_buffer) {
		kfree(memory_buffer);
	}

	printk("<Alerta>    Modulo removido com sucesso.\n\n");
}





// <memory open> =
int memory_open(struct inode *inode, struct file *filp) {
	times++;
	printk("<Alerta>    |----Arquivo Aberto pela %d vez.\n", times);
	/* Success */
	return 0;
}





// <memory release> =
int memory_release(struct inode *inode, struct file *filp) {
 
	printk("<Alerta>    |----Arquivo Fechado.\n\n");
	/* Success */
	return 0;
}





// <memory read> =
ssize_t memory_read(struct file *filp, char *buf, 
				            size_t count, loff_t *f_pos) { 
 
	
	printk("<Alerta>    |--------Lendo o arquivo (Kernel -> Usuario).\n");
	/* Transfering data to user space */ 
	copy_to_user(buf,memory_buffer,1);

	/* Changing reading position as best suits */ 
	if (*f_pos == 0) { 
		*f_pos+=1; 
		return 1; 
	} else { 
		return 0; 
	}
}





// <memory write> =
ssize_t memory_write( struct file *filp, char *buf,
	                    size_t count, loff_t *f_pos) {

	char *tmp;
	printk("<Alerta>    |--------Escrevendo o arquivo (Usuario -> Kernel).\n");

	tmp=buf+count-1;
	copy_from_user(memory_buffer,tmp,1);
	return 1;
}
