Could not get XIM

=================================================================
Got a SIGSEGV while executing native code. This usually indicates
a fatal error in the mono runtime or one of the native libraries 
used by your application.
=================================================================

Stacktrace:

in (wrapper managed-to-native) System.Windows.Forms.X11Keyboard:XCreateIC (intptr,string,System.Windows.Forms.XIMProperties,string,intptr,string,intptr,intptr) <0x4>
in (wrapper managed-to-native) System.Windows.Forms.X11Keyboard:XCreateIC (intptr,string,System.Windows.Forms.XIMProperties,string,intptr,string,intptr,intptr) <0xffffffd2>
in System.Windows.Forms.X11Keyboard:CreateXic (intptr) <0x32>
in System.Windows.Forms.X11Keyboard:.ctor (intptr,intptr) <0x185>
in System.Windows.Forms.XplatUIX11:SetDisplay (intptr) <0x3e9>
in System.Windows.Forms.XplatUIX11:.ctor () <0x8b>
in System.Windows.Forms.XplatUIX11:GetInstance () <0x40>
in System.Windows.Forms.XplatUI:.cctor () <0x61>
in (wrapper runtime-invoke) System.Object:runtime_invoke_void (object,intptr,intptr,intptr) <0xc7782857>
in System.Windows.Forms.Form:get_CreateParams () <0xffffffff>
in System.Windows.Forms.Form:get_CreateParams () <0x64>
in System.Windows.Forms.Control:.ctor () <0x273>
in System.Windows.Forms.ScrollableControl:.ctor () <0x11>
in System.Windows.Forms.ContainerControl:.ctor () <0x10>
in System.Windows.Forms.Form:.ctor () <0x19>
in (wrapper remoting-invoke-with-check) System.Windows.Forms.Form:.ctor () <0xfffffefe>
in TwoForms:Main () <0x1e>
in (wrapper runtime-invoke) System.Object:runtime_invoke_void (object,intptr,intptr,intptr) <0xc77838d7>

Native stacktrace:

	mono(mono_handle_native_sigsegv+0xbb) [0x815385b]
	mono [0x813e1bf]
	[0xffffe440]
	[0x4120afb2]
	[0x4120af23]
	[0x4120886e]
	[0x41205d6a]
	[0x41201014]
	[0x41200f01]
	[0x40da0ff2]
	[0x409bb83e]
	mono [0x813e070]
	mono(mono_runtime_invoke+0x27) [0x80d7847]
	mono(mono_runtime_class_init+0x12b) [0x80d5c4b]
	mono [0x813d8c4]
	mono [0x813dc12]
	mono [0x813ddaa]
	mono(mono_compile_method+0x3a) [0x80d604a]
	mono(mono_magic_trampoline+0x1a) [0x8154cea]
	[0x40251032]
	[0x40da0324]
	[0x40d9fe9a]
	[0x40d9fdb9]
	[0x40d9fab2]
	[0x409bb7ea]
	[0x409bb6c7]
	[0x409ba7be]
	mono [0x813e070]
	mono(mono_runtime_invoke+0x27) [0x80d7847]
	mono(mono_runtime_exec_main+0x5c) [0x80d897c]
	mono(mono_runtime_run_main+0x171) [0x80d85a1]
	mono(strftime+0x1bae) [0x805c632]
	mono(mono_main+0x841) [0x805d001]
	mono(__fxstat64+0x137) [0x805b9eb]
	/lib/tls/libc.so.6(__libc_start_main+0xe0) [0x40116250]
	mono(sinh+0x4d) [0x805b941]
