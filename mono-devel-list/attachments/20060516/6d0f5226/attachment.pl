
Hi all,

I am getting a segfault with the mono runtime, and since I couldn't find it in bugzilla,
thought I would check with the list if it has been fixed.

Unfortunately, the program is proprietary, so I cannot hand out the source. If more details
are required however, I can try and isolate it more ... Other important details are that I
compile the program using the Microsoft compiler ... I have not tested it with the mono
compiler.

The program loads some config, connects to a network socket via an asynchronous tcp
connection, does a bunch of things, and then exits. It segfaults if I call
Environment.Exit(1), rather than exiting cleanly. I "think" it does not segfault
when I explicitly Disconnect the socket before exiting. Yeah, ugly code not to disconnect,
but it shouldn't crash the runtime ... 

This is what the backtrace looks like:

#0  0x006becae in __pthread_mutex_lock (mutex=0x74c008) at pthread_mutex_lock.c:76
#1  0x08108242 in mono_once ()
#2  0x080da7bf in mono_jit_info_table_find ()
#3  0x0813ba64 in mono_codegen ()
#4  <signal handler called>
#5  0x080a5222 in mono_thread_pool_remove_socket ()
#6  0x080a42e3 in mono_debug_address_from_il_offset ()
#7  0x08099ff2 in mono_thread_get_tls_offset ()
#8  0x080f5227 in mono_environment_exitcode_set ()
#9  0x08113945 in GC_end_blocking ()
#10 0x006bd341 in start_thread (arg=0x1963bb0) at pthread_create.c:261
#11 0x004176fe in ?? () from /lib/tls/libc.so.6

Ah, actually, after I change the code to explicitly call Disconnect on the sockets before
calling Environment.Exit(1), I am now getting a different segfault ...

#0  0x003367a2 in ?? () at rtld.c:576 from /lib/ld-linux.so.2
576     relocate_doit (void *a)
(gdb) where
#0  0x003367a2 in ?? () at rtld.c:576 from /lib/ld-linux.so.2
#1  0x003777d5 in *__GI_raise (sig=6) at ../nptl/sysdeps/unix/sysv/linux/raise.c:67
#2  0x00379149 in *__GI_abort () at ../sysdeps/generic/abort.c:88
#3  0x0814f73b in mono_handle_native_sigsegv ()
#4  0x0813ba8f in mono_codegen ()
#5  <signal handler called>
#6  0x0813bad4 in mono_codegen ()
#7  <signal handler called>
#8  0x003367a2 in ?? () at rtld.c:576 from /lib/ld-linux.so.2
#9  0x006c213e in ?? () at
../nptl/sysdeps/unix/sysv/linux/i386/i686/../i486/lowlevellock.S:57 from
/lib/tls/libpthread.so.0
#10 0x081bf1c8 in stderr ()
#11 0x006c6ff4 in ?? () from /lib/tls/libpthread.so.0
#12 0x01275bb0 in ?? ()
#13 0x006beda7 in ?? () from /lib/tls/libpthread.so.0
#14 0x01275318 in ?? ()
#15 0x081beb10 in ?? ()
#16 0x08216300 in ?? ()
#17 0xb7e01b90 in ?? ()
#18 0x01275328 in ?? ()
#19 0x08108242 in mono_once ()
#20 0x08108242 in mono_once ()
#21 0x08099e18 in mono_thread_get_tls_offset ()
#22 0x08099ea7 in mono_thread_get_tls_offset ()
#23 0x0809a00f in mono_thread_get_tls_offset ()
#24 0x080f5227 in mono_environment_exitcode_set ()
#25 0x08113945 in GC_end_blocking ()
#26 0x006bd341 in start_thread (arg=0x1275bb0) at pthread_create.c:261
#27 0x004176fe in ?? () from /lib/tls/libc.so.6


mono --version
Mono JIT compiler version 1.1.13.6, (C) 2002-2005 Novell, Inc and Contributors. 
www.mono-project.com
        TLS:           normal
        GC:            Included Boehm (with typed GC)
        SIGSEGV      : normal

uname -a:
 Linux 2.6.10-1.741_FC3smp #1 SMP Thu Jan 13 16:53:16 EST 2005 i686 i686 i386 GNU/Linux

The machine has 4 intel xeon cpus.

Cheers, 
Andrew 

