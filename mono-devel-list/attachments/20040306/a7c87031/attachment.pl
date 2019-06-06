I've got Mono JIT compiler version 0.30.99 from CVS.

"mint nonvirt.exe" no problems.
"mono nonvirt.exe" and it justs sits there eating 99.9% of processor.

"gdb --args mono -v nonvirt.exe" and "run"
Method TestObj:Main () emitted at 0x4075c4c8 to 0x4075c53a [nonvirt.exe]
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 32771 (LWP 9666)]
0x4075c4e7 in ?? ()
(gdb) disassemble 0x4075c4c8 0x4075c53a
Dump of assembler code from 0x4075c4c8 to 0x4075c53a:
0x4075c4c8:     push   %ebp
0x4075c4c9:     mov    %esp,%ebp
0x4075c4cb:     sub    $0x24,%esp
0x4075c4ce:     movl   $0x0,0xfffffffc(%ebp)
0x4075c4d5:     movl   $0x0,0xfffffff8(%ebp)
0x4075c4dc:     movl   $0x0,0xfffffffc(%ebp)
0x4075c4e3:     mov    0xfffffffc(%ebp),%eax
0x4075c4e6:     push   %eax
0x4075c4e7:     cmpl   $0x0,(%eax)  <--- EIP
0x4075c4ea:     call   0x814f068
0x4075c4ef:     add    $0x4,%esp
0x4075c4f2:     mov    %eax,0xfffffff0(%ebp)
0x4075c4f5:     jmp    0x4075c52e
0x4075c4f7:     movl   $0x0,0xfffffff8(%ebp)
0x4075c4fe:     call   0x48a5b60c <mono_thread_get_pending_exception>
0x4075c503:     mov    %eax,0xffffffec(%ebp)
0x4075c506:     test   %eax,%eax
0x4075c508:     je     0x4075c514
0x4075c50e:     push   %eax
0x4075c50f:     call   0x48b0b288 <start.4>
0x4075c514:     jmp    0x4075c535
0x4075c516:     call   0x48a5b60c <mono_thread_get_pending_exception>
0x4075c51b:     mov    %eax,0xffffffe8(%ebp)
0x4075c51e:     test   %eax,%eax
0x4075c520:     je     0x4075c52c
0x4075c526:     push   %eax
0x4075c527:     call   0x48b0b288 <start.4>
0x4075c52c:     jmp    0x4075c52e
0x4075c52e:     mov    $0x1,%eax
0x4075c533:     jmp    0x4075c538
0x4075c535:     mov    0xfffffff8(%ebp),%eax
0x4075c538:     leave
0x4075c539:     ret
End of assembler dump.

(gdb) stepi
0x4c2ad211 in __pthread_sighandler_rt () from /lib/libpthread.so.0

(gdb) continue
Continuing.
Program received signal SIGSEGV, Segmentation fault.
0x4c2ad23c in __pthread_sighandler_rt () from /lib/libpthread.so.0

It appears to jump back to 0x4c2ad23c a little futher in
0x4c2ad2d8 <__pthread_sighandler_rt+200>:       or     $0x1fffff,%edx
0x4c2ad2de <__pthread_sighandler_rt+206>:       lea    0xfffffbe1(%edx),%esi
0x4c2ad2e4 <__pthread_sighandler_rt+212>:       jmp    0x4c2ad23c <__pthread_sighandler_rt+44>

Once back at 0x4c2ad23c, it segfaults and starts __pthread_sighandler_rt again, resulting in my endless loop.

Okay, my debugging ability stops about here.

I'm not sure where to go. It seems to be segfaulting in the segfault handler.
I think this handler is based on pthreads (/lib/libpthread.so.0)
I think this is a glibc provided library.

I'm REALLY new to this, and guessing my way thru half of this.
Anybody have ideas on how to further track this down?

Regards,
Ivan

