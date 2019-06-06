make[7]: Entering directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs/mcs'
MONO_PATH="../class/lib/basic:$MONO_PATH" /home/antoine/Projects/mono/mono-1.2.3.1-gc/runtime/mono-wrapper  ../class/lib/basic/mcs.exe /codepage:65001   -d:NET_1_1 -d:ONLY_1_1 -debug -target:exe -out:mcs.exe cs-parser.cs  @mcs.exe.sources
constant.cs(469,10): warning CS0652: A comparison between a constant and a variable is useless. The constant is out of the range of the variable type `char'
constant.cs(476,10): warning CS0652: A comparison between a constant and a variable is useless. The constant is out of the range of the variable type `char'
constant.cs(680,35): warning CS0652: A comparison between a constant and a variable is useless. The constant is out of the range of the variable type `short'
expression.cs(3715,18): warning CS0219: The variable `host' is assigned but its value is never used
cs-parser.jay(46,14): warning CS0169: The private field `Mono.CSharp.CSharpParser.current_delegate' is never used
iterators.cs(140,12): warning CS0169: The private field `Mono.CSharp.IteratorHost.generic_enumerable_type' is never used
Compilation succeeded - 6 warning(s)
Stacktrace:


Native stacktrace:

        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x817edb6]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x8161bb4]
        [0xffffe440]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x80c6c04]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x80c7546]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x80c8d4b]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono(mono_gc_collect+0x36) [0x80c926a]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono(mono_domain_finalize+0x52) [0x80cb693]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x81631ba]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono(mono_main+0x166a) [0x805a2c7]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x8057b96]
        /lib/libc.so.6(__libc_start_main+0xd8) [0x40134838]
        /home/antoine/Projects/mono/mono-1.2.3.1-gc/mono/mini/mono [0x8057af1]

Debug info from gdb:

Using host libthread_db library "/lib/libthread_db.so.1".
[Thread debugging using libthread_db enabled]
[New Thread 1076132560 (LWP 4927)]
[New Thread 1086983056 (LWP 4990)]
[New Thread 1073970064 (LWP 4989)]
0xffffe410 in __kernel_vsyscall ()
  3 Thread 1073970064 (LWP 4989)  0xffffe410 in __kernel_vsyscall ()
  2 Thread 1086983056 (LWP 4990)  0xffffe410 in __kernel_vsyscall ()
  1 Thread 1076132560 (LWP 4927)  0xffffe410 in __kernel_vsyscall ()

Thread 3 (Thread 1073970064 (LWP 4989)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0x400efb46 in ?? () from /lib/libpthread.so.0
#2  0x081172eb in collection_thread (unused=0x0) at collection.c:34
#3  0x400e84bb in start_thread () from /lib/libpthread.so.0
#4  0x401dc3be in clone () from /lib/libc.so.6

Thread 2 (Thread 1086983056 (LWP 4990)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0x40147b67 in sigsuspend () from /lib/libc.so.6
#2  0x080c552b in suspend_handler (sig=30) at sgen-gc.c:3562
#3  <signal handler called>
#4  0xffffe410 in __kernel_vsyscall ()
#5  0x400ec8e6 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
#6  0x0811c4f3 in timedwait_signal_poll_cond (cond=0x405801dc, 
    mutex=0x405801c4, timeout=0x0, alertable=0) at handles.c:1413
#7  0x0811c84b in _wapi_handle_timedwait_signal_handle (handle=0x404, 
    timeout=0x0, alertable=0) at handles.c:1493
#8  0x0811c634 in _wapi_handle_wait_signal_handle (handle=0x404, alertable=0)
    at handles.c:1453
#9  0x0812df92 in WaitForSingleObjectEx (handle=0x404, timeout=4294967295, 
    alertable=0) at wait.c:200
#10 0x080ca904 in finalizer_thread (unused=0x0) at gc.c:819
#11 0x080e5933 in start_wrapper (data=0x8244050) at threads.c:308
#12 0x0812c359 in thread_start_routine (args=0x405d23c0) at threads.c:253
#13 0x080c9c8f in gc_start_thread (arg=0x8244098) at sgen-gc.c:3875
#14 0x400e84bb in start_thread () from /lib/libpthread.so.0
#15 0x401dc3be in clone () from /lib/libc.so.6

Thread 1 (Thread 1076132560 (LWP 4927)):
#0  0xffffe410 in __kernel_vsyscall ()
#1  0x401a9b6b in fork () from /lib/libc.so.6
#2  0x400f1a24 in fork () from /lib/libpthread.so.0
#3  0x400a1679 in ?? () from /home/antoine/local/lib/libglib-2.0.so.0
#4  0x08457e98 in ?? ()
#5  0x08457e98 in ?? ()
#6  0xbff4d5c8 in ?? ()
#7  0x4018530a in ?? () from /lib/libc.so.6
#8  0x40244120 in ?? () from /lib/libc.so.6
#9  0x40184121 in ?? () from /lib/libc.so.6
#10 0x00000028 in ?? ()
#11 0x40244134 in ?? () from /lib/libc.so.6
#12 0x00000002 in ?? ()
#13 0xe96258b8 in ?? ()
#14 0x401837d4 in ?? () from /lib/libc.so.6
#15 0x401850d1 in ?? () from /lib/libc.so.6
#16 0x40242ff4 in ?? () from /lib/libc.so.6
#17 0x40244120 in ?? () from /lib/libc.so.6
#18 0x00000004 in ?? ()
#19 0xbff4d5d8 in ?? ()
#20 0xbff4d644 in ?? ()
#21 0x40244120 in ?? () from /lib/libc.so.6
#22 0xbff4d63c in ?? ()
#23 0x40242ff4 in ?? () from /lib/libc.so.6
#24 0xbff4d634 in ?? ()
#25 0x088a3fe8 in ?? ()
#26 0xbff4d62c in ?? ()
#27 0x40242ff4 in ?? () from /lib/libc.so.6
#28 0x088a3ff0 in ?? ()
#29 0x40244120 in ?? () from /lib/libc.so.6
#30 0x0883cf10 in ?? ()
#31 0x00000000 in ?? ()
#0  0xffffe410 in __kernel_vsyscall ()


=================================================================
Got a SIGSEGV while executing native code. This usually indicates
a fatal error in the mono runtime or one of the native libraries 
used by your application.
=================================================================

make[7]: *** [../class/lib/net_1_1_bootstrap/mcs.exe] Aborted
make[7]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs/mcs'
make[6]: *** [do-all] Error 2
make[6]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs/mcs'
make[5]: *** [all-recursive] Error 1
make[5]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs'
make[4]: *** [profile-do--net_1_1_bootstrap--all] Error 2
make[4]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs'
make[3]: *** [profiles-do--all] Error 2
make[3]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/mcs'
make[2]: *** [all-local] Error 2
make[2]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc/runtime'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/antoine/Projects/mono/mono-1.2.3.1-gc'
make: *** [all] Error 2
