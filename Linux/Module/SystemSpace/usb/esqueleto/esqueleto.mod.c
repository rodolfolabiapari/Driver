#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0xca05c877, __VMLINUX_SYMBOL_STR(module_layout) },
	{ 0x33e7e3bc, __VMLINUX_SYMBOL_STR(usb_deregister) },
	{ 0xd37bada7, __VMLINUX_SYMBOL_STR(usb_register_driver) },
	{ 0xa799c6b4, __VMLINUX_SYMBOL_STR(usb_control_msg) },
	{ 0xac93a94, __VMLINUX_SYMBOL_STR(usb_register_dev) },
	{ 0x3e62dcee, __VMLINUX_SYMBOL_STR(usb_get_dev) },
	{ 0x25563496, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0x2f7c36b3, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xd40211b1, __VMLINUX_SYMBOL_STR(usb_submit_urb) },
	{ 0xda3e43d1, __VMLINUX_SYMBOL_STR(_raw_spin_unlock) },
	{ 0xd52bf1ce, __VMLINUX_SYMBOL_STR(_raw_spin_lock) },
	{ 0x4f6b400b, __VMLINUX_SYMBOL_STR(_copy_from_user) },
	{ 0x61dc5785, __VMLINUX_SYMBOL_STR(usb_alloc_urb) },
	{ 0x71e3cecb, __VMLINUX_SYMBOL_STR(up) },
	{ 0xf22449ae, __VMLINUX_SYMBOL_STR(down_interruptible) },
	{ 0x7768e72, __VMLINUX_SYMBOL_STR(usb_free_urb) },
	{ 0xd2b09ce5, __VMLINUX_SYMBOL_STR(__kmalloc) },
	{ 0x1fdc14ac, __VMLINUX_SYMBOL_STR(usb_deregister_dev) },
	{ 0x1c8c9783, __VMLINUX_SYMBOL_STR(dev_set_drvdata) },
	{ 0x68aca4ad, __VMLINUX_SYMBOL_STR(down) },
	{ 0x5907da33, __VMLINUX_SYMBOL_STR(dev_get_drvdata) },
	{ 0x4cb61051, __VMLINUX_SYMBOL_STR(usb_find_interface) },
	{ 0x4f8b5ddb, __VMLINUX_SYMBOL_STR(_copy_to_user) },
	{ 0xd8db6059, __VMLINUX_SYMBOL_STR(usb_bulk_msg) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("usb:v067Bp2303d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v09FBp6001d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v2341p0042d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v10C4pEA60d*dc*dsc*dp*ic*isc*ip*in*");

MODULE_INFO(srcversion, "349F451BA4FACB11463728F");
