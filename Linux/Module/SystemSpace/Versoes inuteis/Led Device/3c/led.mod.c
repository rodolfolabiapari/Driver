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
	{ 0x448eac3e, __VMLINUX_SYMBOL_STR(kmemdup) },
	{ 0x7091ac0, __VMLINUX_SYMBOL_STR(device_create_file) },
	{ 0x3e62dcee, __VMLINUX_SYMBOL_STR(usb_get_dev) },
	{ 0x309c0e1b, __VMLINUX_SYMBOL_STR(_dev_info) },
	{ 0x7486f88d, __VMLINUX_SYMBOL_STR(usb_put_dev) },
	{ 0x1c8c9783, __VMLINUX_SYMBOL_STR(dev_set_drvdata) },
	{ 0xd03a6fb4, __VMLINUX_SYMBOL_STR(device_remove_file) },
	{ 0x91715312, __VMLINUX_SYMBOL_STR(sprintf) },
	{ 0x20000329, __VMLINUX_SYMBOL_STR(simple_strtoul) },
	{ 0x5907da33, __VMLINUX_SYMBOL_STR(dev_get_drvdata) },
	{ 0x37a0cba, __VMLINUX_SYMBOL_STR(kfree) },
	{ 0x509f70c7, __VMLINUX_SYMBOL_STR(dev_err) },
	{ 0xf15ca0ca, __VMLINUX_SYMBOL_STR(__dynamic_dev_dbg) },
	{ 0xa799c6b4, __VMLINUX_SYMBOL_STR(usb_control_msg) },
	{ 0x25563496, __VMLINUX_SYMBOL_STR(kmem_cache_alloc_trace) },
	{ 0x2f7c36b3, __VMLINUX_SYMBOL_STR(kmalloc_caches) },
	{ 0xbdfb6dbb, __VMLINUX_SYMBOL_STR(__fentry__) },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("usb:v0FC5p1223d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v1D34p0004d*dc*dsc*dp*ic*isc*ip*in*");
MODULE_ALIAS("usb:v1D34p000Ad*dc*dsc*dp*ic*isc*ip*in*");

MODULE_INFO(srcversion, "E74A2B718D5814E2EF97641");
