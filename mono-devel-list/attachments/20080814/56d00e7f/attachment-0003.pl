==5807== Memcheck, a memory error detector.
==5807== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==5807== Using LibVEX rev 1804, a library for dynamic binary translation.
==5807== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==5807== Using valgrind-3.3.0-Debian, a dynamic binary instrumentation framework.
==5807== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==5807== 
==5807== My PID = 5807, parent PID = 15842.  Prog and args are:
==5807==    mono
==5807==    --optimize=-linears
==5807==    ./MonoDevelop.exe
==5807== 
--5807-- 
--5807-- Command line
--5807--    mono
--5807--    --optimize=-linears
--5807--    ./MonoDevelop.exe
--5807-- Startup, with flags:
--5807--    --suppressions=/usr/lib/valgrind/debian-libc6-dbg.supp
--5807--    --tool=memcheck
--5807--    -v
--5807--    --leak-check=full
--5807--    --log-file=/home/NANOFLUIDICS/cmarshall/md.valgrind3.log
--5807--    --smc-check=all
--5807--    --show-reachable=yes
--5807-- Contents of /proc/version:
--5807--   Linux version 2.6.24-19-server (buildd@king) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Fri Jul 11 21:50:43 UTC 2008
--5807-- Arch and hwcaps: AMD64, amd64-sse2
--5807-- Page sizes: currently 4096, max supported 4096
--5807-- Valgrind library directory: /usr/lib/valgrind
--5807-- Reading syms from /usr/mono-2.0/bin/mono (0x400000)
--5807-- Reading syms from /lib/ld-2.7.so (0x4000000)
--5807-- Reading debug info from /lib/ld-2.7.so...
--5807-- ... CRC mismatch (computed c9862f74 wanted 7aafc83d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/valgrind/amd64-linux/memcheck (0x38000000)
--5807--    object doesn't have a dynamic symbol table
--5807-- Reading suppressions file: /usr/lib/valgrind/debian-libc6-dbg.supp
--5807-- Reading suppressions file: /usr/lib/valgrind/default.supp
--5807-- Reading syms from /usr/lib/valgrind/amd64-linux/vgpreload_core.so (0x4A1F000)
--5807-- Reading syms from /usr/lib/valgrind/amd64-linux/vgpreload_memcheck.so (0x4C20000)
--5807-- Reading syms from /usr/lib/libgthread-2.0.so.0.1600.4 (0x4E27000)
--5807-- Reading debug info from /usr/lib/libgthread-2.0.so.0.1600.4...
--5807-- ... CRC mismatch (computed 539763b2 wanted b1c6fbda)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libglib-2.0.so.0.1600.4 (0x502B000)
--5807-- Reading debug info from /usr/lib/libglib-2.0.so.0.1600.4...
--5807-- ... CRC mismatch (computed 1b9d4ee0 wanted f0fc4328)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/librt-2.7.so (0x52EB000)
--5807-- Reading debug info from /lib/librt-2.7.so...
--5807-- ... CRC mismatch (computed c0424b42 wanted 293359f6)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libdl-2.7.so (0x54F4000)
--5807-- Reading debug info from /lib/libdl-2.7.so...
--5807-- ... CRC mismatch (computed 13394ae2 wanted 5c0f7518)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libpthread-2.7.so (0x56F8000)
--5807-- Reading debug info from /lib/libpthread-2.7.so...
--5807-- ... CRC mismatch (computed b064431f wanted 03c6976c)
--5807-- Reading syms from /lib/libm-2.7.so (0x5914000)
--5807-- Reading debug info from /lib/libm-2.7.so...
--5807-- ... CRC mismatch (computed e491af1c wanted a4e95324)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libc-2.7.so (0x5B95000)
--5807-- Reading debug info from /lib/libc-2.7.so...
--5807-- ... CRC mismatch (computed cb7b9635 wanted 11d14124)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libselinux.so.1 (0x5EF7000)
--5807-- Reading debug info from /lib/libselinux.so.1...
--5807-- ... CRC mismatch (computed 6e2a0151 wanted 90cef010)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpcre.so.3.12.1 (0x6113000)
--5807-- Reading debug info from /usr/lib/libpcre.so.3.12.1...
--5807-- ... CRC mismatch (computed 9f1d15e2 wanted 3588444b)
--5807--    object doesn't have a symbol table
--5807-- REDIR: 0x5c112d0 (memset) redirected to 0x4c24200 (memset)
--5807-- REDIR: 0x5c10460 (rindex) redirected to 0x4c23cb0 (rindex)
--5807-- REDIR: 0x5c0b2d0 (malloc) redirected to 0x4c22f40 (malloc)
--5807-- REDIR: 0x5c0cb90 (free) redirected to 0x4c22ac0 (free)
--5807-- REDIR: 0x5c12a60 (strchrnul) redirected to 0x4c242b0 (strchrnul)
--5807-- REDIR: 0x5c10050 (strlen) redirected to 0x4c23f50 (strlen)
--5807-- REDIR: 0x5c11cf0 (memcpy) redirected to 0x4c25020 (memcpy)
--5807-- REDIR: 0x5c113e0 (mempcpy) redirected to 0x4c24a20 (mempcpy)
--5807-- REDIR: 0x5c0cd70 (realloc) redirected to 0x4c23000 (realloc)
--5807-- REDIR: 0x5c10b70 (memchr) redirected to 0x4c240e0 (memchr)
--5807-- REDIR: 0x5c0f930 (index) redirected to 0x4c23da0 (index)
--5807-- REDIR: 0x5c0fae0 (strcmp) redirected to 0x4c24020 (strcmp)
--5807-- REDIR: 0x5c102d0 (strncmp) redirected to 0x4c23fb0 (strncmp)
--5807-- REDIR: 0x5c10140 (strnlen) redirected to 0x4c23f20 (strnlen)
--5807-- REDIR: 0x5c119f0 (stpcpy) redirected to 0x4c24cb0 (stpcpy)
--5807-- REDIR: 0x5c0fb20 (strcpy) redirected to 0x4c25280 (strcpy)
--5807-- REDIR: 0x5c12990 (rawmemchr) redirected to 0x4c242e0 (rawmemchr)
--5807-- REDIR: 0x5c0af70 (calloc) redirected to 0x4c22050 (calloc)
--5807-- REDIR: 0xffffffffff600000 (???) redirected to 0x38029a63 (vgPlain_amd64_linux_REDIR_FOR_vgettimeofday)
--5807-- REDIR: 0x5c0b680 (posix_memalign) redirected to 0x4c22000 (posix_memalign)
--5807-- REDIR: 0x5c11130 (memmove) redirected to 0x4c24250 (memmove)
--5807-- REDIR: 0x5c103b0 (strncpy) redirected to 0x4c25170 (strncpy)
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807==    by 0x526C34: mini_init (mini.c:13969)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807==    by 0x526C34: mini_init (mini.c:13969)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C9F5: GC_number_stack_black_listed (blacklst.c:279)
==5807==    by 0x51CA75: total_stack_black_listed (blacklst.c:296)
==5807==    by 0x51C5DA: GC_promote_black_lists (blacklst.c:140)
==5807==    by 0x51A533: GC_try_to_collect_inner (alloc.c:362)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==  Address 0x63705e0 is 72 bytes inside a block of size 74 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
--5807-- Reading syms from /lib/libnss_compat-2.7.so (0x69AB000)
--5807-- Reading debug info from /lib/libnss_compat-2.7.so...
--5807-- ... CRC mismatch (computed 3eb3176a wanted 1291e35a)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==  Address 0x63798f0 is 16 bytes inside a block of size 17 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4008B75: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
--5807-- Reading syms from /lib/libnsl-2.7.so (0x6BB4000)
--5807-- Reading debug info from /lib/libnsl-2.7.so...
--5807-- ... CRC mismatch (computed b0b57441 wanted c8167f5e)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libnss_nis-2.7.so (0x6DCD000)
--5807-- Reading debug info from /lib/libnss_nis-2.7.so...
--5807-- ... CRC mismatch (computed 1fc35041 wanted 0430800a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libnss_files-2.7.so (0x6FD8000)
--5807-- Reading debug info from /lib/libnss_files-2.7.so...
--5807-- ... CRC mismatch (computed e55e1683 wanted 9a5435f4)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5807==  Address 0x637b4a8 is 24 bytes inside a block of size 25 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4008B75: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5807==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
--5807-- Reading syms from /lib/libnss_winbind.so.2 (0x71E4000)
--5807-- Reading debug info from /lib/libnss_winbind.so.2...
--5807-- ... CRC mismatch (computed b69200e3 wanted c124aade)
--5807--    object doesn't have a symbol table
--5807-- REDIR: 0x5c10230 (strncat) redirected to 0x4c23e30 (strncat)
--5807-- REDIR: 0xffffffffff600400 (???) redirected to 0x38029a6d (vgPlain_amd64_linux_REDIR_FOR_vtime)
--5807-- REDIR: 0x5bc99c0 (unsetenv) redirected to 0x4c24390 (unsetenv)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==  Address 0x644ef90 is 80 bytes inside a block of size 84 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==  Address 0x64a40e0 is 120 bytes inside a block of size 123 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x52236D: GC_base (misc.c:398)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x522399: GC_base (misc.c:398)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x5223BA: GC_base (misc.c:399)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x522452: GC_base (misc.c:416)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224AB: GC_base (misc.c:422)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224CB: GC_base (misc.c:426)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E7F0: GC_mark_and_push_stack (mark.c:1369)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D826: GC_mark_from (mark.c:759)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D86B: GC_mark_from (mark.c:766)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D878: GC_mark_from (mark.c:769)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D8BD: GC_mark_from (mark.c:776)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DC40: GC_mark_from (mark.c:780)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D8CF: GC_mark_from (mark.c:784)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DFCD: GC_mark_from (mark.c:634)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DB89: GC_mark_from (mark.c:791)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DF14: GC_mark_from (mark.c:801)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524992: GC_finalize (finalize.c:583)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524AAC: GC_finalize (finalize.c:600)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517BC5: GC_block_empty (reclaim.c:109)
==5807==    by 0x5190B9: GC_reclaim_block (reclaim.c:784)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517ED2: GC_reclaim_clear (reclaim.c:329)
==5807==    by 0x518E4E: GC_reclaim_generic (reclaim.c:689)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517FC8: GC_reclaim_clear2 (reclaim.c:393)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517FFE: GC_reclaim_clear2 (reclaim.c:394)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517F9A: GC_reclaim_clear2 (reclaim.c:392)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518034: GC_reclaim_clear2 (reclaim.c:395)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D77D: GC_mark_from (mark.c:711)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x41AC23B: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D3A6: GC_mark_from (mark.c:684)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x41AC23B: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51904A: GC_reclaim_block (reclaim.c:769)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D645: GC_mark_from (mark.c:688)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5807==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x4C989E: mono_string_new_utf16 (object.c:3804)
==5807==    by 0x4C9DB7: mono_string_new (object.c:3891)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518BBF: GC_reclaim_uninit4 (reclaim.c:604)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518BF2: GC_reclaim_uninit4 (reclaim.c:605)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518C25: GC_reclaim_uninit4 (reclaim.c:606)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BA5253: ???
==5807==    by 0x8BA51EB: ???
==5807==    by 0x8BF0F47: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BA5253: ???
==5807==    by 0x8BA51EB: ???
==5807==    by 0x8BF0F47: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5807==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517DA4: GC_block_nearly_full (reclaim.c:261)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5180D4: GC_reclaim_clear4 (reclaim.c:434)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518120: GC_reclaim_clear4 (reclaim.c:435)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518176: GC_reclaim_clear4 (reclaim.c:436)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5181CC: GC_reclaim_clear4 (reclaim.c:437)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518222: GC_reclaim_clear4 (reclaim.c:438)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51827E: GC_reclaim_clear4 (reclaim.c:439)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== More than 100 errors detected.  Subsequent errors
==5807== will still be recorded, but in less detail than before.
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5182DF: GC_reclaim_clear4 (reclaim.c:440)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51840C: GC_reclaim_clear4 (reclaim.c:444)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518472: GC_reclaim_clear4 (reclaim.c:445)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518870: GC_reclaim_uninit2 (reclaim.c:550)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51896E: GC_reclaim_uninit4 (reclaim.c:590)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51898D: GC_reclaim_uninit4 (reclaim.c:591)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5189B6: GC_reclaim_uninit4 (reclaim.c:592)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5189DF: GC_reclaim_uninit4 (reclaim.c:593)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B8C: GC_reclaim_uninit4 (reclaim.c:603)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517DF8: GC_block_nearly_full (reclaim.c:267)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518340: GC_reclaim_clear4 (reclaim.c:441)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5183A6: GC_reclaim_clear4 (reclaim.c:443)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5184D8: GC_reclaim_clear4 (reclaim.c:446)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51853E: GC_reclaim_clear4 (reclaim.c:447)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5185A4: GC_reclaim_clear4 (reclaim.c:448)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51860A: GC_reclaim_clear4 (reclaim.c:449)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518670: GC_reclaim_clear4 (reclaim.c:450)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A5F: GC_reclaim_uninit4 (reclaim.c:596)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A8D: GC_reclaim_uninit4 (reclaim.c:597)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518AC0: GC_reclaim_uninit4 (reclaim.c:599)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518AF3: GC_reclaim_uninit4 (reclaim.c:600)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B26: GC_reclaim_uninit4 (reclaim.c:601)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B59: GC_reclaim_uninit4 (reclaim.c:602)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A08: GC_reclaim_uninit4 (reclaim.c:594)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5248AD: GC_finalize (finalize.c:560)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CF4: GC_block_nearly_full3 (reclaim.c:205)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==  Address 0x82378f8 is 96 bytes inside a block of size 98 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A31: GC_reclaim_uninit4 (reclaim.c:595)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8C463EB: ???
==5807==    by 0x8C4576F: ???
==5807==    by 0x8C447AB: ???
==5807==    by 0x8C44647: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517E46: GC_block_nearly_full (reclaim.c:273)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8D5C29A: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8D5B80F: ???
==5807==    by 0x8D5B4C3: ???
==5807==    by 0x8D5B0FF: ???
==5807==  Address 0x7feffe010 is not stack'd, malloc'd or (recently) free'd
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400A4CF: (within /lib/ld-2.7.so)
==5807==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5807==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5807==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5807==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807==    by 0x41AB377: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x40165A5: (within /lib/ld-2.7.so)
==5807==    by 0x400A50E: (within /lib/ld-2.7.so)
==5807==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5807==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5807==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5807==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807==    by 0x41AB377: ???
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400A99D: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==  Address 0x8914b90 is 16 bytes inside a block of size 20 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x481F94: mono_lookup_pinvoke_call (loader.c:1121)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
--5807-- Reading syms from /usr/lib/libgtk-x11-2.0.so.0.1200.9 (0x9006000)
--5807-- Reading debug info from /usr/lib/libgtk-x11-2.0.so.0.1200.9...
--5807-- ... CRC mismatch (computed 51be4d1d wanted 8f74fe6b)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9 (0x95D5000)
--5807-- Reading debug info from /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9...
--5807-- ... CRC mismatch (computed a7f83542 wanted 7f618f25)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgdk-x11-2.0.so.0.1200.9 (0x97EF000)
--5807-- Reading debug info from /usr/lib/libgdk-x11-2.0.so.0.1200.9...
--5807-- ... CRC mismatch (computed b484e102 wanted f32ddc33)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpangocairo-1.0.so.0.2002.3 (0x9A89000)
--5807-- Reading debug info from /usr/lib/libpangocairo-1.0.so.0.2002.3...
--5807-- ... CRC mismatch (computed 697619f4 wanted a0e936cc)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpango-1.0.so.0.2002.3 (0x9C94000)
--5807-- Reading debug info from /usr/lib/libpango-1.0.so.0.2002.3...
--5807-- ... CRC mismatch (computed 96c3c3bb wanted 59545878)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libX11.so.6.2.0 (0x9ED8000)
--5807-- Reading debug info from /usr/lib/libX11.so.6.2.0...
--5807-- ... CRC mismatch (computed afa3731b wanted 001ef74a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXcomposite.so.1.0.0 (0xA1DB000)
--5807-- Reading debug info from /usr/lib/libXcomposite.so.1.0.0...
--5807-- ... CRC mismatch (computed db431175 wanted 662a8e0b)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXdamage.so.1.1.0 (0xA3DD000)
--5807-- Reading debug info from /usr/lib/libXdamage.so.1.1.0...
--5807-- ... CRC mismatch (computed 85b00c5b wanted f78ddc18)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXfixes.so.3.1.0 (0xA5DF000)
--5807-- Reading debug info from /usr/lib/libXfixes.so.3.1.0...
--5807-- ... CRC mismatch (computed 87062290 wanted c65e5c9f)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libatk-1.0.so.0.2209.1 (0xA7E4000)
--5807-- Reading debug info from /usr/lib/libatk-1.0.so.0.2209.1...
--5807-- ... CRC mismatch (computed 4e6feb2a wanted f73af7a7)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgobject-2.0.so.0.1600.4 (0xAA04000)
--5807-- Reading debug info from /usr/lib/libgobject-2.0.so.0.1600.4...
--5807-- ... CRC mismatch (computed ae81bf07 wanted a3249db9)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgmodule-2.0.so.0.1600.4 (0xAC49000)
--5807-- Reading debug info from /usr/lib/libgmodule-2.0.so.0.1600.4...
--5807-- ... CRC mismatch (computed e37361d7 wanted 29f7385d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libcairo.so.2.17.3 (0xAE4C000)
--5807-- Reading debug info from /usr/lib/libcairo.so.2.17.3...
--5807-- ... CRC mismatch (computed 3ec5255e wanted 2cc7fcff)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libfontconfig.so.1.3.0 (0xB0B7000)
--5807-- Reading debug info from /usr/lib/libfontconfig.so.1.3.0...
--5807-- ... CRC mismatch (computed 187912bc wanted 9ec04f9a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXext.so.6.4.0 (0xB2E8000)
--5807-- Reading debug info from /usr/lib/libXext.so.6.4.0...
--5807-- ... CRC mismatch (computed 749303dd wanted 14c9f19c)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXrender.so.1.3.0 (0xB4F9000)
--5807-- Reading debug info from /usr/lib/libXrender.so.1.3.0...
--5807-- ... CRC mismatch (computed 7abe549a wanted 38591836)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXinerama.so.1.0.0 (0xB702000)
--5807-- Reading debug info from /usr/lib/libXinerama.so.1.0.0...
--5807-- ... CRC mismatch (computed 79f8be73 wanted 9f1e67e8)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXi.so.6.0.0 (0xB904000)
--5807-- Reading debug info from /usr/lib/libXi.so.6.0.0...
--5807-- ... CRC mismatch (computed fcc610ab wanted 44c4dbbe)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXrandr.so.2.1.0 (0xBB0D000)
--5807-- Reading debug info from /usr/lib/libXrandr.so.2.1.0...
--5807-- ... CRC mismatch (computed a13002cc wanted 197a14e7)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXcursor.so.1.0.2 (0xBD14000)
--5807-- Reading debug info from /usr/lib/libXcursor.so.1.0.2...
--5807-- ... CRC mismatch (computed 15cdd867 wanted a60dd5d5)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400522C: (within /lib/ld-2.7.so)
==5807==    by 0x40079E5: (within /lib/ld-2.7.so)
==5807==    by 0x40089D7: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==  Address 0x89d78a8 is 8 bytes inside a block of size 9 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4007823: (within /lib/ld-2.7.so)
==5807==    by 0x4007979: (within /lib/ld-2.7.so)
==5807==    by 0x40089D7: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
--5807-- Reading syms from /usr/lib/libpangoft2-1.0.so.0.2002.3 (0xBF1E000)
--5807-- Reading debug info from /usr/lib/libpangoft2-1.0.so.0.2002.3...
--5807-- ... CRC mismatch (computed 02937f20 wanted 44877eac)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libfreetype.so.6.3.16 (0xC14A000)
--5807-- Reading debug info from /usr/lib/libfreetype.so.6.3.16...
--5807-- ... CRC mismatch (computed 72ba4f5a wanted ddfa7f8d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libz.so.1.2.3.3 (0xC3C9000)
--5807-- Reading debug info from /usr/lib/libz.so.1.2.3.3...
--5807-- ... CRC mismatch (computed 38d836d6 wanted 4bea647b)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libxcb-xlib.so.0.0.0 (0xC5E0000)
--5807-- Reading debug info from /usr/lib/libxcb-xlib.so.0.0.0...
--5807-- ... CRC mismatch (computed 6702c4d9 wanted a09203a4)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libxcb.so.1.0.0 (0xC7E1000)
--5807-- Reading debug info from /usr/lib/libxcb.so.1.0.0...
--5807-- ... CRC mismatch (computed 2c58fe5c wanted 8ea17cc5)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpng12.so.0.15.0 (0xC9FC000)
--5807-- Reading debug info from /usr/lib/libpng12.so.0.15.0...
--5807-- ... CRC mismatch (computed 7be56180 wanted 58c9dcae)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpixman-1.so.0.10.0 (0xCC21000)
--5807-- Reading debug info from /usr/lib/libpixman-1.so.0.10.0...
--5807-- ... CRC mismatch (computed 413771fd wanted aa908744)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libstdc++.so.6.0.9 (0xCE4F000)
--5807-- Reading debug info from /usr/lib/libstdc++.so.6.0.9...
--5807-- ... CRC mismatch (computed cffb6542 wanted 4e57faa1)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libgcc_s.so.1 (0xD15A000)
--5807-- Reading debug info from /lib/libgcc_s.so.1...
--5807-- ... CRC mismatch (computed 068ceb1e wanted 5861faf2)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libexpat.so.1.5.2 (0xD368000)
--5807-- Reading debug info from /usr/lib/libexpat.so.1.5.2...
--5807-- ... CRC mismatch (computed 3a1561fe wanted 4895301c)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXau.so.6.0.0 (0xD58C000)
--5807-- Reading debug info from /usr/lib/libXau.so.6.0.0...
--5807-- ... CRC mismatch (computed f6128d91 wanted 5bb2fa57)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libXdmcp.so.6.0.0 (0xD78E000)
--5807-- Reading debug info from /usr/lib/libXdmcp.so.6.0.0...
--5807-- ... CRC mismatch (computed 2acd0e34 wanted 8c2b8da1)
--5807--    object doesn't have a symbol table
--5807-- REDIR: 0x5c0f770 (strcat) redirected to 0x4c24750 (strcat)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==  Address 0x84235c0 is 32 bytes inside a block of size 39 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4005F47: (within /lib/ld-2.7.so)
==5807==    by 0x400885F: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
--5807-- Reading syms from /usr/mono-2.0/lib/libgtksharpglue-2.so (0xD993000)
--5807-- Reading syms from /usr/mono-2.0/lib/libglibsharpglue-2.so (0xDF9C000)
--5807-- Reading syms from /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so (0xE19E000)
--5807-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so...
--5807-- ... CRC mismatch (computed dc8d9df5 wanted ab0ea5b0)
--5807--    object doesn't have a symbol table
--5807-- memcheck GC: 1024 nodes, 1024 survivors (100.0%)
--5807-- memcheck GC: increase table size to 2048
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
--5807-- Reading syms from /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so (0xE3C1000)
--5807-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so...
--5807-- ... CRC mismatch (computed cd0cbca9 wanted d1eabfa8)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400A99D: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==  Address 0x843f130 is 40 bytes inside a block of size 47 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAC4A932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0xAA31A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x9CA71C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CA7288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CA7306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAA459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAA6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==  Address 0x7f5cb68 is 40 bytes inside a block of size 47 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4007823: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
--5807-- Reading syms from /usr/lib/pango/1.6.0/modules/pango-basic-fc.so (0xE6C1000)
--5807-- Reading debug info from /usr/lib/pango/1.6.0/modules/pango-basic-fc.so...
--5807-- ... CRC mismatch (computed 5eb59628 wanted c750bc89)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnomevfs-2.so.0.2200.0 (0xED48000)
--5807-- Reading debug info from /usr/lib/libgnomevfs-2.so.0.2200.0...
--5807-- ... CRC mismatch (computed 4a5d84bf wanted 4d1d25ef)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgconf-2.so.4.1.5 (0xEFB2000)
--5807-- Reading debug info from /usr/lib/libgconf-2.so.4.1.5...
--5807-- ... CRC mismatch (computed 5d970145 wanted 6d094911)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libxml2.so.2.6.31 (0xF1ED000)
--5807-- Reading debug info from /usr/lib/libxml2.so.2.6.31...
--5807-- ... CRC mismatch (computed 6346bb6f wanted 2436dc76)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libdbus-glib-1.so.2.1.0 (0xF534000)
--5807-- Reading debug info from /usr/lib/libdbus-glib-1.so.2.1.0...
--5807-- ... CRC mismatch (computed 4828c83c wanted 876558b5)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libdbus-1.so.3.4.0 (0xF754000)
--5807-- Reading debug info from /usr/lib/libdbus-1.so.3.4.0...
--5807-- ... CRC mismatch (computed 77b8b9a2 wanted 4349cae2)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnutls.so.13.9.1 (0xF991000)
--5807-- Reading debug info from /usr/lib/libgnutls.so.13.9.1...
--5807-- ... CRC mismatch (computed 9473aef1 wanted 873a588c)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libavahi-glib.so.1.0.1 (0xFC15000)
--5807-- Reading debug info from /usr/lib/libavahi-glib.so.1.0.1...
--5807-- ... CRC mismatch (computed 27dec6ce wanted 16cd9dc6)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libavahi-common.so.3.5.0 (0xFE18000)
--5807-- Reading debug info from /usr/lib/libavahi-common.so.3.5.0...
--5807-- ... CRC mismatch (computed bdde8cfd wanted 031b8c55)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libavahi-client.so.3.2.4 (0x10024000)
--5807-- Reading debug info from /usr/lib/libavahi-client.so.3.2.4...
--5807-- ... CRC mismatch (computed df243a51 wanted cdc4b724)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libresolv-2.7.so (0x10234000)
--5807-- Reading debug info from /lib/libresolv-2.7.so...
--5807-- ... CRC mismatch (computed b7d418c3 wanted 3b9cb093)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libutil-2.7.so (0x1044A000)
--5807-- Reading debug info from /lib/libutil-2.7.so...
--5807-- ... CRC mismatch (computed dad2b7f7 wanted 39db7729)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libORBit-2.so.0.1.0 (0x1064D000)
--5807-- Reading debug info from /usr/lib/libORBit-2.so.0.1.0...
--5807-- ... CRC mismatch (computed 6e54e8cd wanted da5cabd7)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libtasn1.so.3.0.12 (0x108BA000)
--5807-- Reading debug info from /usr/lib/libtasn1.so.3.0.12...
--5807-- ... CRC mismatch (computed fb8d9aa5 wanted de19d909)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libgcrypt.so.11.2.3 (0x10ACA000)
--5807-- Reading debug info from /lib/libgcrypt.so.11.2.3...
--5807-- ... CRC mismatch (computed 42972b2c wanted 76cb42fc)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libgpg-error.so.0.3.0 (0x10D18000)
--5807-- Reading debug info from /lib/libgpg-error.so.0.3.0...
--5807-- ... CRC mismatch (computed e92bcaa6 wanted daec7936)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnomeui-2.so.0.2201.0 (0x10F1B000)
--5807-- Reading debug info from /usr/lib/libgnomeui-2.so.0.2201.0...
--5807-- ... CRC mismatch (computed 662c2b8d wanted e7b9cc9c)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libbonoboui-2.so.0.0.0 (0x111B6000)
--5807-- Reading debug info from /usr/lib/libbonoboui-2.so.0.0.0...
--5807-- ... CRC mismatch (computed 74934e7a wanted 6041bfaa)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnomecanvas-2.so.0.2001.0 (0x11427000)
--5807-- Reading debug info from /usr/lib/libgnomecanvas-2.so.0.2001.0...
--5807-- ... CRC mismatch (computed 77d065a8 wanted 292a6821)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnome-2.so.0.2200.0 (0x1165D000)
--5807-- Reading debug info from /usr/lib/libgnome-2.so.0.2200.0...
--5807-- ... CRC mismatch (computed bc4d548f wanted 9fd73b4b)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libart_lgpl_2.so.2.3.20 (0x11875000)
--5807-- Reading debug info from /usr/lib/libart_lgpl_2.so.2.3.20...
--5807-- ... CRC mismatch (computed bbdf4f4a wanted cf96cddf)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgio-2.0.so.0.0.0 (0x11A8D000)
--5807-- Reading debug info from /usr/lib/libgio-2.0.so.0.0.0...
--5807-- ... CRC mismatch (computed a432a97e wanted c71d38fa)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgnome-keyring.so.0.1.1 (0x11CFE000)
--5807-- Reading debug info from /usr/lib/libgnome-keyring.so.0.1.1...
--5807-- ... CRC mismatch (computed 91a0ff30 wanted 19928d5a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libSM.so.6.0.0 (0x11F11000)
--5807-- Reading debug info from /usr/lib/libSM.so.6.0.0...
--5807-- ... CRC mismatch (computed fe5d1672 wanted f24edc81)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libICE.so.6.3.0 (0x12119000)
--5807-- Reading debug info from /usr/lib/libICE.so.6.3.0...
--5807-- ... CRC mismatch (computed d9288efe wanted a63cf42f)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libbonobo-2.so.0.0.0 (0x12334000)
--5807-- Reading debug info from /usr/lib/libbonobo-2.so.0.0.0...
--5807-- ... CRC mismatch (computed f42e5a54 wanted a968d763)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libbonobo-activation.so.4.0.0 (0x125A8000)
--5807-- Reading debug info from /usr/lib/libbonobo-activation.so.4.0.0...
--5807-- ... CRC mismatch (computed 4a966f65 wanted 333e4502)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libpopt.so.0.0.0 (0x127C2000)
--5807-- Reading debug info from /lib/libpopt.so.0.0.0...
--5807-- ... CRC mismatch (computed b5f9fd69 wanted e8a1a0d1)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgailutil.so.18.0.1 (0x129CA000)
--5807-- Reading debug info from /usr/lib/libgailutil.so.18.0.1...
--5807-- ... CRC mismatch (computed eadec55f wanted 9553b74d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libesd.so.0.2.38 (0x12BD2000)
--5807-- Reading debug info from /usr/lib/libesd.so.0.2.38...
--5807-- ... CRC mismatch (computed a9be2d4f wanted 1c32e6ce)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libaudiofile.so.0.0.2 (0x12DDC000)
--5807-- Reading debug info from /usr/lib/libaudiofile.so.0.0.2...
--5807-- ... CRC mismatch (computed f6dd7442 wanted 15481a97)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libORBitCosNaming-2.so.0.1.0 (0x13004000)
--5807-- Reading debug info from /usr/lib/libORBitCosNaming-2.so.0.1.0...
--5807-- ... CRC mismatch (computed 0e204ab3 wanted 5ed9cb7e)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libasound.so.2.0.0 (0x1320B000)
--5807-- Reading debug info from /usr/lib/libasound.so.2.0.0...
--5807-- ... CRC mismatch (computed bb0f1cda wanted 9669d2a2)
--5807--    object doesn't have a symbol table
--5812-- Discarding syms at 0x69AB000-0x6BB4000 in /lib/libnss_compat-2.7.so due to munmap()
--5812-- Discarding syms at 0x6DCD000-0x6FD8000 in /lib/libnss_nis-2.7.so due to munmap()
--5812-- Discarding syms at 0x71E4000-0x73EF000 in /lib/libnss_winbind.so.2 due to munmap()
--5812-- Discarding syms at 0x6FD8000-0x71E4000 in /lib/libnss_files-2.7.so due to munmap()
==5812== 
==5812== ERROR SUMMARY: 62985 errors from 151 contexts (suppressed: 132 from 1)
==5812== 
==5812== 1 errors in context 1 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x400AB93: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==  Address 0x7f5cb68 is 40 bytes inside a block of size 47 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4007823: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 1 errors in context 2 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x400A99D: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==  Address 0x843f130 is 40 bytes inside a block of size 47 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xAC4A932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0xAA31A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x9CA71C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CA7288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CA7306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CAA459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CAA6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 1 errors in context 3 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5812==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812== 
==5812== 1 errors in context 4 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518870: GC_reclaim_uninit2 (reclaim.c:550)
==5812==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5812==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5812==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5812==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5812==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5812== 
==5812== 1 errors in context 5 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518034: GC_reclaim_clear2 (reclaim.c:395)
==5812==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5812==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 1 errors in context 6 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 1 errors in context 7 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 2 errors in context 8 of 151:
==5812== Invalid read of size 8
==5812==    at 0x40165A5: (within /lib/ld-2.7.so)
==5812==    by 0x400A50E: (within /lib/ld-2.7.so)
==5812==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5812==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5812==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5812==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8E3715B: ???
==5812==    by 0x41AB377: ???
==5812== 
==5812== 2 errors in context 9 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x400A4CF: (within /lib/ld-2.7.so)
==5812==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5812==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5812==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5812==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8E3715B: ???
==5812==    by 0x41AB377: ???
==5812== 
==5812== 2 errors in context 10 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x40087D1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8E3715B: ???
==5812== 
==5812== 2 errors in context 11 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D33: (within /lib/ld-2.7.so)
==5812==    by 0x40085B1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8E3715B: ???
==5812== 
==5812== 2 errors in context 12 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 2 errors in context 13 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 2 errors in context 14 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518A31: GC_reclaim_uninit4 (reclaim.c:595)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8C463EB: ???
==5812==    by 0x8C4576F: ???
==5812==    by 0x8C447AB: ???
==5812==    by 0x8C44647: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 2 errors in context 15 of 151:
==5812== Invalid read of size 8
==5812==    at 0x415C0C2: ???
==5812==    by 0x8C4DA90: ???
==5812==    by 0x8C4DA90: ???
==5812==    by 0x8C4DA90: ???
==5812==    by 0x8D5C29A: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8D5B80F: ???
==5812==    by 0x8D5B4C3: ???
==5812==    by 0x8D5B0FF: ???
==5812==  Address 0x7feffe010 is not stack'd, malloc'd or (recently) free'd
==5812== 
==5812== 2 errors in context 16 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5812==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5812==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x4C989E: mono_string_new_utf16 (object.c:3804)
==5812==    by 0x4C9DB7: mono_string_new (object.c:3891)
==5812== 
==5812== 2 errors in context 17 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517F9A: GC_reclaim_clear2 (reclaim.c:392)
==5812==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5812==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 2 errors in context 18 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517FFE: GC_reclaim_clear2 (reclaim.c:394)
==5812==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5812==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 2 errors in context 19 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517FC8: GC_reclaim_clear2 (reclaim.c:393)
==5812==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5812==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 3 errors in context 20 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5812==    by 0x400AB93: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==  Address 0x84235c0 is 32 bytes inside a block of size 39 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4005F47: (within /lib/ld-2.7.so)
==5812==    by 0x400885F: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812== 
==5812== 3 errors in context 21 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5812==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5812==    by 0x8C404F3: ???
==5812==    by 0x8C3F21B: ???
==5812== 
==5812== 3 errors in context 22 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5812==    by 0x4007817: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5812==    by 0x8C404F3: ???
==5812==    by 0x8C3F21B: ???
==5812== 
==5812== 3 errors in context 23 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5812==    by 0x400780A: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5812==    by 0x8C404F3: ???
==5812==    by 0x8C3F21B: ???
==5812== 
==5812== 3 errors in context 24 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5812==    by 0x4011F31: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5812==    by 0x8C404F3: ???
==5812==    by 0x8C3F21B: ???
==5812== 
==5812== 3 errors in context 25 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5812==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812== 
==5812== 3 errors in context 26 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5248AD: GC_finalize (finalize.c:560)
==5812==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 3 errors in context 27 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517CF4: GC_block_nearly_full3 (reclaim.c:205)
==5812==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812== 
==5812== 3 errors in context 28 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5812==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5812==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5812==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BA5253: ???
==5812==    by 0x8BA51EB: ???
==5812==    by 0x8BF0F47: ???
==5812== 
==5812== 3 errors in context 29 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5812==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5812==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5812==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BA5253: ???
==5812==    by 0x8BA51EB: ???
==5812==    by 0x8BF0F47: ???
==5812== 
==5812== 4 errors in context 30 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5812==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5812==  Address 0x82378f8 is 96 bytes inside a block of size 98 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400DF00: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812== 
==5812== 4 errors in context 31 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518A5F: GC_reclaim_uninit4 (reclaim.c:596)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 4 errors in context 32 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5812==    by 0x517E46: GC_block_nearly_full (reclaim.c:273)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812== 
==5812== 4 errors in context 33 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5812==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812==    by 0x41B4243: ???
==5812== 
==5812== 5 errors in context 34 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812== 
==5812== 5 errors in context 35 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812== 
==5812== 6 errors in context 36 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x400522C: (within /lib/ld-2.7.so)
==5812==    by 0x40079E5: (within /lib/ld-2.7.so)
==5812==    by 0x40089D7: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==  Address 0x89d78a8 is 8 bytes inside a block of size 9 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4007823: (within /lib/ld-2.7.so)
==5812==    by 0x4007979: (within /lib/ld-2.7.so)
==5812==    by 0x40089D7: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812== 
==5812== 6 errors in context 37 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x4007817: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812== 
==5812== 6 errors in context 38 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D33: (within /lib/ld-2.7.so)
==5812==    by 0x400780A: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812== 
==5812== 6 errors in context 39 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5812==    by 0x40087D1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812== 
==5812== 6 errors in context 40 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5812==    by 0x40085B1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812== 
==5812== 6 errors in context 41 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518C25: GC_reclaim_uninit4 (reclaim.c:606)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x879A50F: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 6 errors in context 42 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518BF2: GC_reclaim_uninit4 (reclaim.c:605)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x879A50F: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 6 errors in context 43 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518B59: GC_reclaim_uninit4 (reclaim.c:602)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 6 errors in context 44 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518AC0: GC_reclaim_uninit4 (reclaim.c:599)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 6 errors in context 45 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5812==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5812== 
==5812== 6 errors in context 46 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5812==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5812==    by 0x41ABA67: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 6 errors in context 47 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5812==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812==    by 0x41B4243: ???
==5812== 
==5812== 6 errors in context 48 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5812==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5812==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5812==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BD3E43: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 7 errors in context 49 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x400A99D: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==  Address 0x8914b90 is 16 bytes inside a block of size 20 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x481F94: mono_lookup_pinvoke_call (loader.c:1121)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812== 
==5812== 7 errors in context 50 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==  Address 0x63705e0 is 72 bytes inside a block of size 74 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400DF00: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812== 
==5812== 7 errors in context 51 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518A08: GC_reclaim_uninit4 (reclaim.c:594)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 8 errors in context 52 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5812==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5812==    by 0x41ABA67: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 8 errors in context 53 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5812==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5812==    by 0x41ABA67: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 8 errors in context 54 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5183A6: GC_reclaim_clear4 (reclaim.c:443)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 8 errors in context 55 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518340: GC_reclaim_clear4 (reclaim.c:441)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 8 errors in context 56 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5812==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5812== 
==5812== 8 errors in context 57 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518BBF: GC_reclaim_uninit4 (reclaim.c:604)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x879A50F: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 8 errors in context 58 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518AF3: GC_reclaim_uninit4 (reclaim.c:600)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 8 errors in context 59 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518A8D: GC_reclaim_uninit4 (reclaim.c:597)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 8 errors in context 60 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5189DF: GC_reclaim_uninit4 (reclaim.c:593)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8BF6F23: ???
==5812==    by 0x8BF74BB: ???
==5812==    by 0x8BF622F: ???
==5812==    by 0x8BEDDCF: ???
==5812== 
==5812== 9 errors in context 61 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5812==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812== 
==5812== 9 errors in context 62 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D33: (within /lib/ld-2.7.so)
==5812==    by 0x4011F31: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812== 
==5812== 10 errors in context 63 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518B8C: GC_reclaim_uninit4 (reclaim.c:603)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8BF6F23: ???
==5812==    by 0x8BF74BB: ???
==5812==    by 0x8BF622F: ???
==5812==    by 0x8BEDDCF: ???
==5812== 
==5812== 10 errors in context 64 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5812==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5812==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5812==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BD3E43: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 11 errors in context 65 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518670: GC_reclaim_clear4 (reclaim.c:450)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 11 errors in context 66 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5185A4: GC_reclaim_clear4 (reclaim.c:448)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 11 errors in context 67 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518120: GC_reclaim_clear4 (reclaim.c:435)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 11 errors in context 68 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5180D4: GC_reclaim_clear4 (reclaim.c:434)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 11 errors in context 69 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5812==    by 0x517DF8: GC_block_nearly_full (reclaim.c:267)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5812== 
==5812== 11 errors in context 70 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518B26: GC_reclaim_uninit4 (reclaim.c:601)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 11 errors in context 71 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51898D: GC_reclaim_uninit4 (reclaim.c:591)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8BF6F23: ???
==5812==    by 0x8BF74BB: ???
==5812==    by 0x8BF622F: ???
==5812==    by 0x8BEDDCF: ???
==5812== 
==5812== 11 errors in context 72 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 11 errors in context 73 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 12 errors in context 74 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5184D8: GC_reclaim_clear4 (reclaim.c:446)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 12 errors in context 75 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5181CC: GC_reclaim_clear4 (reclaim.c:437)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 12 errors in context 76 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518176: GC_reclaim_clear4 (reclaim.c:436)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 12 errors in context 77 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51896E: GC_reclaim_uninit4 (reclaim.c:590)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8BF6F23: ???
==5812==    by 0x8BF74BB: ???
==5812==    by 0x8BF622F: ???
==5812==    by 0x8BEDDCF: ???
==5812== 
==5812== 13 errors in context 78 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51860A: GC_reclaim_clear4 (reclaim.c:449)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 13 errors in context 79 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51853E: GC_reclaim_clear4 (reclaim.c:447)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8C3E6B7: ???
==5812==    by 0x8BF6453: ???
==5812==    by 0x8BEDDCF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 13 errors in context 80 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518472: GC_reclaim_clear4 (reclaim.c:445)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 13 errors in context 81 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5182DF: GC_reclaim_clear4 (reclaim.c:440)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 13 errors in context 82 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51827E: GC_reclaim_clear4 (reclaim.c:439)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 13 errors in context 83 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x518222: GC_reclaim_clear4 (reclaim.c:438)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 13 errors in context 84 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5189B6: GC_reclaim_uninit4 (reclaim.c:592)
==5812==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5812==    by 0x41AD737: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x8BF6F23: ???
==5812==    by 0x8BF74BB: ???
==5812==    by 0x8BF622F: ???
==5812==    by 0x8BEDDCF: ???
==5812== 
==5812== 13 errors in context 85 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812== 
==5812== 13 errors in context 86 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812== 
==5812== 13 errors in context 87 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5812==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5812==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5812== 
==5812== 13 errors in context 88 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5812==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5812==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5812==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5812==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5812==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5812== 
==5812== 14 errors in context 89 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812== 
==5812== 16 errors in context 90 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51840C: GC_reclaim_clear4 (reclaim.c:444)
==5812==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812== 
==5812== 17 errors in context 91 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x4007817: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x417944: mono_main (driver.c:1480)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 17 errors in context 92 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5812==    by 0x400780A: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x417944: mono_main (driver.c:1480)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 20 errors in context 93 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5812==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5812==  Address 0x64a40e0 is 120 bytes inside a block of size 123 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400DF00: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812== 
==5812== 21 errors in context 94 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51904A: GC_reclaim_block (reclaim.c:769)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812== 
==5812== 24 errors in context 95 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x524AAC: GC_finalize (finalize.c:600)
==5812==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812==    by 0x41B4243: ???
==5812== 
==5812== 24 errors in context 96 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x524992: GC_finalize (finalize.c:583)
==5812==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812==    by 0x41B4243: ???
==5812== 
==5812== 25 errors in context 97 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812== 
==5812== 25 errors in context 98 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812== 
==5812== 25 errors in context 99 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812== 
==5812== 26 errors in context 100 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x400AB93: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==  Address 0x63798f0 is 16 bytes inside a block of size 17 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4008B75: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812== 
==5812== 35 errors in context 101 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5812==    by 0x400AB93: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5812==  Address 0x637b4a8 is 24 bytes inside a block of size 25 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4008B75: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5812==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==5812==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812== 
==5812== 40 errors in context 102 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5812==    by 0x517DA4: GC_block_nearly_full (reclaim.c:261)
==5812==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5812==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5812== 
==5812== 57 errors in context 103 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x40087D1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 57 errors in context 104 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5812==    by 0x40085B1: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5812==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5812==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x559E0C: inline_method (mini.c:4018)
==5812==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812== 
==5812== 58 errors in context 105 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5812==    by 0x4007817: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5812==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5812==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5812== 
==5812== 58 errors in context 106 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5812==    by 0x400780A: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5812==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5812==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5812== 
==5812== 64 errors in context 107 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5812==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5812==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5812==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5812== 
==5812== 64 errors in context 108 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5812==    by 0x4011F31: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5812==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5812==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5812== 
==5812== 66 errors in context 109 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x417944: mono_main (driver.c:1480)
==5812==  Address 0x644ef90 is 80 bytes inside a block of size 84 alloc'd
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400DF00: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812== 
==5812== 70 errors in context 110 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5812==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5812==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x417944: mono_main (driver.c:1480)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 77 errors in context 111 of 151:
==5812== Invalid read of size 8
==5812==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5812==    by 0x4011F31: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x417944: mono_main (driver.c:1480)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 103 errors in context 112 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517BC5: GC_block_empty (reclaim.c:109)
==5812==    by 0x5190B9: GC_reclaim_block (reclaim.c:784)
==5812==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5812==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5812==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5812==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812== 
==5812== 148 errors in context 113 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812==    by 0x526C34: mini_init (mini.c:13969)
==5812== 
==5812== 176 errors in context 114 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51D77D: GC_mark_from (mark.c:711)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x41AC23B: ???
==5812== 
==5812== 289 errors in context 115 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812==    by 0x526C34: mini_init (mini.c:13969)
==5812== 
==5812== 325 errors in context 116 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E7F0: GC_mark_and_push_stack (mark.c:1369)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812== 
==5812== 325 errors in context 117 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5224CB: GC_base (misc.c:426)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 325 errors in context 118 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x522452: GC_base (misc.c:416)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 326 errors in context 119 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x5224AB: GC_base (misc.c:422)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 326 errors in context 120 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x5223BA: GC_base (misc.c:399)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 326 errors in context 121 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x522399: GC_base (misc.c:398)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 326 errors in context 122 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x52236D: GC_base (misc.c:398)
==5812==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812== 
==5812== 378 errors in context 123 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x517ED2: GC_reclaim_clear (reclaim.c:329)
==5812==    by 0x518E4E: GC_reclaim_generic (reclaim.c:689)
==5812==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5812==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5812==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812==    by 0x41B4243: ???
==5812== 
==5812== 498 errors in context 124 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51DF14: GC_mark_from (mark.c:801)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 604 errors in context 125 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812== 
==5812== 604 errors in context 126 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812== 
==5812== 634 errors in context 127 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51D8BD: GC_mark_from (mark.c:776)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 645 errors in context 128 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51DFCD: GC_mark_from (mark.c:634)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 690 errors in context 129 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51D878: GC_mark_from (mark.c:769)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 693 errors in context 130 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51D86B: GC_mark_from (mark.c:766)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 732 errors in context 131 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51D826: GC_mark_from (mark.c:759)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 744 errors in context 132 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51D3A6: GC_mark_from (mark.c:684)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x41AC23B: ???
==5812== 
==5812== 757 errors in context 133 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5812==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5812==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5812==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BF0F47: ???
==5812==    by 0x8BF0963: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 888 errors in context 134 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51C9F5: GC_number_stack_black_listed (blacklst.c:279)
==5812==    by 0x51CA75: total_stack_black_listed (blacklst.c:296)
==5812==    by 0x51C5DA: GC_promote_black_lists (blacklst.c:140)
==5812==    by 0x51A533: GC_try_to_collect_inner (alloc.c:362)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5812==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5812==    by 0x51F976: GC_malloc (malloc.c:297)
==5812==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5812==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5812== 
==5812== 1432 errors in context 135 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51D645: GC_mark_from (mark.c:688)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5812==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5812==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5812==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5812==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5812==    by 0x41AC42B: ???
==5812==    by 0x8BD3E43: ???
==5812== 
==5812== 1719 errors in context 136 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51D8CF: GC_mark_from (mark.c:784)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 1728 errors in context 137 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 1728 errors in context 138 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 1742 errors in context 139 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x516F1F: GC_find_header (headers.c:41)
==5812==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 1742 errors in context 140 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x516EF4: GC_find_header (headers.c:41)
==5812==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 1742 errors in context 141 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x516EC8: GC_find_header (headers.c:41)
==5812==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5812==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5812==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5812==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5812==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812== 
==5812== 1814 errors in context 142 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51DC40: GC_mark_from (mark.c:780)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 2020 errors in context 143 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812== 
==5812== 2022 errors in context 144 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 2306 errors in context 145 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51DB89: GC_mark_from (mark.c:791)
==5812==    by 0x51CF45: GC_mark_some (mark.c:361)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5812==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5812==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5812==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5812==    by 0x41ABBC7: ???
==5812==    by 0x879C147: ???
==5812== 
==5812== 2776 errors in context 146 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5812==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5812== 
==5812== 3751 errors in context 147 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 3751 errors in context 148 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 3751 errors in context 149 of 151:
==5812== Use of uninitialised value of size 8
==5812==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5812==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812== 
==5812== 5200 errors in context 150 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5812== 
==5812== 11413 errors in context 151 of 151:
==5812== Conditional jump or move depends on uninitialised value(s)
==5812==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5812==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5812==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5812==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5812==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5812==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5812==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5812==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5812==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5812==    by 0x522951: GC_init_inner (misc.c:782)
==5812==    by 0x522567: GC_init (misc.c:492)
==5812==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
--5812-- 
--5812-- supp:    132 dl-hack3-1
==5812== 
==5812== IN SUMMARY: 62985 errors from 151 contexts (suppressed: 132 from 1)
==5812== 
==5812== malloc/free: in use at exit: 7,792,249 bytes in 21,606 blocks.
==5812== malloc/free: 194,766 allocs, 173,160 frees, 190,316,038 bytes allocated.
==5812== 
==5812== searching for pointers to 21,606 not-freed blocks.
==5812== checked 16,022,688 bytes.
==5812== 
==5812== 
==5812== 1 bytes in 1 blocks are still reachable in loss record 1 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F33726: _XlcDefaultMapModifiers (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F33794: XSetLocaleModifiers (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C743: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812== 
==5812== 
==5812== 6 bytes in 1 blocks are still reachable in loss record 2 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xBD1870C: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 6 bytes in 1 blocks are still reachable in loss record 3 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xBD186EF: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 6 bytes in 1 blocks are still reachable in loss record 4 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2D07F: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 8 bytes in 1 blocks are still reachable in loss record 5 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB908354: _XiGetExtensionVersion (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0xB90A6D2: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0xB908FDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 8 bytes in 1 blocks are still reachable in loss record 6 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1CEDE: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 9 bytes in 1 blocks are still reachable in loss record 7 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5F0866F: (within /lib/libselinux.so.1)
==5812==    by 0x5F0A021: (within /lib/libselinux.so.1)
==5812==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==5812==    by 0x7FEFFFFD7: ???
==5812==    by 0x400E165: (within /lib/ld-2.7.so)
==5812==    by 0x400E28D: (within /lib/ld-2.7.so)
==5812==    by 0x4000A99: (within /lib/ld-2.7.so)
==5812==    by 0x2: ???
==5812==    by 0x7FF000216: ???
==5812==    by 0x7FF00021B: ???
==5812==    by 0x7FF00022F: ???
==5812== 
==5812== 
==5812== 12 bytes in 1 blocks are still reachable in loss record 8 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2CC32: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 16 bytes in 1 blocks are still reachable in loss record 9 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F1F1F2: _XCBInitDisplayLock (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F08AB4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 16 bytes in 1 blocks are still reachable in loss record 10 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xC7EC4AD: (within /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EBA0C: (within /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EA65E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812== 
==5812== 
==5812== 16 bytes in 1 blocks are still reachable in loss record 11 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2D43C: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1C9CF: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 16 bytes in 1 blocks are still reachable in loss record 12 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F31EFD: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F275EE: _XlcOpenConverter (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2D460: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1C9CF: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 16 bytes in 1 blocks are still reachable in loss record 13 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0BD62C: FcBlanksCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D3115: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 20 bytes in 1 blocks are still reachable in loss record 14 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE5C4BA: cairo_font_options_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8D884: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF27A5E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 21 bytes in 1 blocks are still reachable in loss record 15 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F08C95: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 16 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F19503: XAddConnectionWatch (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C487: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 17 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB2F5B8D: XextCreateExtension (in /usr/lib/libXext.so.6.4.0)
==5812==    by 0xB90A735: XInput_find_display (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0xB908FBA: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 18 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F29FB3: _XlcResolveLocaleName (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF40: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 19 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1CF24: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 20 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2C446: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 21 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F330D5: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812== 
==5812== 
==5812== 24 bytes in 1 blocks are still reachable in loss record 22 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE99AA6: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 29 bytes in 3 blocks are still reachable in loss record 23 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26C0C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 24 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xA5E2A97: XFixesFindDisplay (in /usr/lib/libXfixes.so.3.1.0)
==5812==    by 0xA5E2CE8: XFixesQueryExtension (in /usr/lib/libXfixes.so.3.1.0)
==5812==    by 0x982C5EE: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 25 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xA3DDC77: XDamageFindDisplay (in /usr/lib/libXdamage.so.1.1.0)
==5812==    by 0xA3DE2F8: XDamageQueryExtension (in /usr/lib/libXdamage.so.1.1.0)
==5812==    by 0x982C632: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 26 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xA1DBE2C: XCompositeFindDisplay (in /usr/lib/libXcomposite.so.1.0.0)
==5812==    by 0xA1DC878: XCompositeQueryExtension (in /usr/lib/libXcomposite.so.1.0.0)
==5812==    by 0x982C610: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 27 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1C99A: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 28 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CDFCD: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CB0B5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 29 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB4FFACE: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==5812==    by 0xB500A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==5812==    by 0xBD18666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 32 bytes in 4 blocks are still reachable in loss record 30 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2B743: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 31 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xC7EB72C: (within /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EA44E: (within /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EBE59: xcb_wait_for_reply (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EC25B: xcb_get_extension_data (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EAB8E: xcb_prefetch_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7EAC0B: xcb_get_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0x9F08FE3: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 32 bytes in 1 blocks are still reachable in loss record 32 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x54F554A: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5812==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5812==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5812==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812==    by 0x527394: mini_init (mini.c:14018)
==5812== 
==5812== 
==5812== 40 bytes in 1 blocks are still reachable in loss record 33 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1841D: _XPollfdCacheInit (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F08AC4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 40 bytes in 1 blocks are still reachable in loss record 34 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE5A78F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6827D: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9C137: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DFA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 40 bytes in 1 blocks are still reachable in loss record 35 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F28256: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 41 bytes in 1 blocks are still reachable in loss record 36 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xD58CE06: XauFileName (in /usr/lib/libXau.so.6.0.0)
==5812==    by 0xD58D042: XauGetBestAuthByAddr (in /usr/lib/libXau.so.6.0.0)
==5812==    by 0xC7ECE93: (within /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7ECAD1: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812== 
==5812== 
==5812== 48 bytes in 2 blocks are still reachable in loss record 37 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xF779752: (within /usr/lib/libdbus-1.so.3.4.0)
==5812==    by 0xF773B3A: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5812==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5812==    by 0xE3B7C17: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0xE3B7ABB: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5812== 
==5812== 
==5812== 48 bytes in 1 blocks are still reachable in loss record 38 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F1D1CE: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 48 bytes in 3 blocks are still reachable in loss record 39 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CC1E5: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CD2A3: FcPatternGetString (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF263AA: pango_fc_font_description_from_pattern (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF25CBE: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xAA160DB: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA16F65: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x9A90B4A: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF27C3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 48 bytes in 3 blocks are still reachable in loss record 40 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0C7B9C: FcFontSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1432: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 48 bytes in 2 blocks are still reachable in loss record 41 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x50965D: mono_code_manager_new (mono-codeman.c:94)
==5812==    by 0x527444: mini_init (mini.c:13954)
==5812==    by 0x41779D: mono_main (driver.c:1425)
==5812==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5812== 
==5812== 
==5812== 52 bytes in 1 blocks are still reachable in loss record 42 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1F42D: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 52 bytes in 1 blocks are still reachable in loss record 43 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C0FDD1: strdup (in /lib/libc-2.7.so)
==5812==    by 0xAE99CEE: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99F99: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 292 (52 direct, 240 indirect) bytes in 1 blocks are definitely lost in loss record 44 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C7D240: (within /lib/libc-2.7.so)
==5812==    by 0x5C7DAFE: __nss_database_lookup (in /lib/libc-2.7.so)
==5812==    by 0x69AD42F: ???
==5812==    by 0x69AE968: ???
==5812==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5812==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5812==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812== 
==5812== 
==5812== 56 bytes in 1 blocks are still reachable in loss record 45 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F2A9A9: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2B23B: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 64 bytes in 2 blocks are still reachable in loss record 46 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB9094CA: XOpenDevice (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0x98522BC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 64 bytes in 2 blocks are still reachable in loss record 47 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xC1569DD: FT_New_Memory (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC156CE0: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xAE99ACB: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 64 bytes in 1 blocks are still reachable in loss record 48 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x401346B: (within /lib/ld-2.7.so)
==5812==    by 0x4013D7B: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA3164: __libc_dlclose (in /lib/libc-2.7.so)
==5812==    by 0x5CA4B57: (within /lib/libc-2.7.so)
==5812==    by 0x5CA4878: __libc_freeres (in /lib/libc-2.7.so)
==5812==    by 0x4A1F31C: _vgnU_freeres (vg_preloaded.c:60)
==5812==    by 0x509511D: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5095828: g_spawn_async_with_pipes (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x509590C: g_spawn_async (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xEFC4190: gconf_activate_server (in /usr/lib/libgconf-2.so.4.1.5)
==5812== 
==5812== 
==5812== 64 bytes in 1 blocks are still reachable in loss record 49 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1FEDF: _XReply (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F0E755: XQueryPointer (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x984E1CE: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980CC9E: gdk_display_get_pointer (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9265E4A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x9266545: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x926D69F: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA24BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 64 bytes in 1 blocks are still reachable in loss record 50 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F0DD79: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26E08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26A4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 72 bytes in 1 blocks are still reachable in loss record 51 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F08B66: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 72 bytes in 3 blocks are still reachable in loss record 52 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D102A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15B6: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 72 bytes in 3 blocks are still reachable in loss record 53 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D108A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15D2: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 80 bytes in 3 blocks are still reachable in loss record 54 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F2B676: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 80 bytes in 5 blocks are indirectly lost in loss record 55 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C7CE7F: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x69AD44A: ???
==5812==    by 0x69AE968: ???
==5812==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5812==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5812==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5812== 
==5812== 
==5812== 85 bytes in 10 blocks are still reachable in loss record 56 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F03323: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F6BA56: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 96 bytes in 1 blocks are still reachable in loss record 57 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9850AF3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 96 bytes in 3 blocks are still reachable in loss record 58 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CB679: FcMatrixCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D10AF: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15D2: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812== 
==5812== 
==5812== 96 bytes in 6 blocks are still reachable in loss record 59 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x40079C3: (within /lib/ld-2.7.so)
==5812==    by 0x40089D7: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812== 
==5812== 
==5812== 102 bytes in 15 blocks are still reachable in loss record 60 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x98507E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 104 bytes in 1 blocks are still reachable in loss record 61 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE9A481: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A608: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 104 bytes in 3 blocks are still reachable in loss record 62 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F27CDE: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 112 bytes in 1 blocks are still reachable in loss record 63 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F08E7D: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 112 bytes in 1 blocks are still reachable in loss record 64 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F1F3C6: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 120 bytes in 1 blocks are still reachable in loss record 65 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xF773AEC: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5812==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5812==    by 0xE3B7C17: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0xE3B7ABB: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5812==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5812== 
==5812== 
==5812== 120 bytes in 3 blocks are still reachable in loss record 66 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE5F09A: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE679B1: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE67E3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DFA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 120 bytes in 3 blocks are still reachable in loss record 67 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE97AD8: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95A7F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6D1B5: cairo_surface_finish (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6D234: cairo_surface_destroy (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE94BA0: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6CAD4: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EC21: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EFFF: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6BB5D: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE5D5DB: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE56CBF: cairo_fill_preserve (in /usr/lib/libcairo.so.2.17.3)
==5812== 
==5812== 
==5812== 128 bytes in 1 blocks are still reachable in loss record 68 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F08D92: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 128 bytes in 1 blocks are still reachable in loss record 69 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE97BAB: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9872C: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9504F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 128 bytes in 4 blocks are still reachable in loss record 70 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE97FCB: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95086: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 136 bytes in 1 blocks are still reachable in loss record 71 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0C1621: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7E9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 144 bytes in 6 blocks are still reachable in loss record 72 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CF40C: FcStrSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1644: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7E9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 144 bytes in 9 blocks are still reachable in loss record 73 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5133F3: mono_dl_open (mono-dl.c:298)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5812==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5812==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5812==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8E3715B: ???
==5812==    by 0x41AB377: ???
==5812== 
==5812== 
==5812== 152 bytes in 3 blocks are still reachable in loss record 74 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4007823: (within /lib/ld-2.7.so)
==5812==    by 0x40085CE: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 152 bytes in 1 blocks are still reachable in loss record 75 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F6BB7F: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 152 bytes in 1 blocks are still reachable in loss record 76 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE72711: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE5E91D: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE57EEE: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x980C197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 160 bytes in 5 blocks are still reachable in loss record 77 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB2F5BDB: XextAddDisplay (in /usr/lib/libXext.so.6.4.0)
==5812==    by 0xB2F0AC8: XShapeQueryExtension (in /usr/lib/libXext.so.6.4.0)
==5812==    by 0x982C65C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812== 
==5812== 
==5812== 160 bytes in 5 blocks are indirectly lost in loss record 78 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C6B0D9: tsearch (in /lib/libc-2.7.so)
==5812==    by 0x5C7CE29: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x69AD44A: ???
==5812==    by 0x69AE968: ???
==5812==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5812==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5812==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5812==    by 0x4E91F1: load_in_path (assembly.c:399)
==5812==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5812== 
==5812== 
==5812== 168 bytes in 1 blocks are still reachable in loss record 79 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F08D07: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 168 bytes in 1 blocks are still reachable in loss record 80 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE98796: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9504F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5812==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 168 bytes in 7 blocks are still reachable in loss record 81 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0F19: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15F1: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1A31: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D29AC: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 168 bytes in 1 blocks are still reachable in loss record 82 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2C495: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 168 bytes in 7 blocks are still reachable in loss record 83 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0EC4: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15E1: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1A31: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D29AC: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 176 bytes in 1 blocks are still reachable in loss record 84 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2C472: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 176 bytes in 2 blocks are still reachable in loss record 85 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1CD19: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 182 bytes in 3 blocks are still reachable in loss record 86 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x9F27D15: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 200 bytes in 1 blocks are still reachable in loss record 87 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB90A6B4: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0xB908FDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5812==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 208 bytes in 13 blocks are still reachable in loss record 88 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1CC80: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 256 bytes in 2 blocks are still reachable in loss record 89 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F03245: XAddExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18620: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 256 bytes in 1 blocks are still reachable in loss record 90 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xB0BD5B5: FcBlanksAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D3092: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 256 bytes in 1 blocks are still reachable in loss record 91 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0C7B7F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D28C6: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 288 (256 direct, 32 indirect) bytes in 1 blocks are definitely lost in loss record 92 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CD81B: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE105: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE219: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2C08: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 264 bytes in 1 blocks are still reachable in loss record 93 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE99F7E: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 322 bytes in 6 blocks are still reachable in loss record 94 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x5BE3097: asprintf (in /lib/libc-2.7.so)
==5812==    by 0x5F08633: (within /lib/libselinux.so.1)
==5812==    by 0x5F0A021: (within /lib/libselinux.so.1)
==5812==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==5812==    by 0x7FEFFFFD7: ???
==5812==    by 0x400E165: (within /lib/ld-2.7.so)
==5812==    by 0x400E28D: (within /lib/ld-2.7.so)
==5812==    by 0x4000A99: (within /lib/ld-2.7.so)
==5812==    by 0x2: ???
==5812==    by 0x7FF000216: ???
==5812== 
==5812== 
==5812== 336 bytes in 14 blocks are still reachable in loss record 95 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D10FA: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D15A8: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1800: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2A94: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 346 bytes in 12 blocks are still reachable in loss record 96 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4005F47: (within /lib/ld-2.7.so)
==5812==    by 0x400885F: (within /lib/ld-2.7.so)
==5812==    by 0x4012048: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812== 
==5812== 
==5812== 362 bytes in 38 blocks are still reachable in loss record 97 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F27DE8: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 400 bytes in 1 blocks are still reachable in loss record 98 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xBF3F887: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF3FE88: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF3FFCD: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xE6C2392: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5812==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB081E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB2966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB31B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0xBF250EE: pango_fc_font_create_metrics_for_context (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9A8E18F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 408 bytes in 1 blocks are still reachable in loss record 99 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4011CF4: (within /lib/ld-2.7.so)
==5812==    by 0x400C9BD: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x5C7D114: (within /lib/libc-2.7.so)
==5812==    by 0x5C83A1A: gethostbyname2_r (in /lib/libc-2.7.so)
==5812== 
==5812== 
==5812== 408 bytes in 51 blocks are still reachable in loss record 100 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1D0AF: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 416 bytes in 13 blocks are still reachable in loss record 101 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x509701: new_codechunk (mono-codeman.c:293)
==5812==    by 0x509891: mono_code_manager_reserve_align (mono-codeman.c:371)
==5812==    by 0x52A857: mono_codegen (mini.c:11879)
==5812==    by 0x558643: mini_method_compile (mini.c:12532)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x87A1C8F: ???
==5812==    by 0x87A195B: ???
==5812==    by 0x87A18E7: ???
==5812==    by 0x87A1730: ???
==5812== 
==5812== 
==5812== 424 bytes in 1 blocks are still reachable in loss record 102 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE9C037: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DFA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 432 bytes in 27 blocks are still reachable in loss record 103 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9850EA7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x985068F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 456 bytes in 3 blocks are still reachable in loss record 104 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE71104: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6ADC3: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6C216: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6D3C2: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE707CA: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE716A5: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95C80: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6B987: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EE21: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6E195: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EB1D: (within /usr/lib/libcairo.so.2.17.3)
==5812== 
==5812== 
==5812== 456 bytes in 1 blocks are still reachable in loss record 105 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xBD18601: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 464 bytes in 27 blocks are still reachable in loss record 106 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x985072F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 492 bytes in 41 blocks are still reachable in loss record 107 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F289D1: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 512 bytes in 1 blocks are still reachable in loss record 108 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F03684: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F03C42: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x98425FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9843BE5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C4D0: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 560 bytes in 7 blocks are still reachable in loss record 109 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2A967: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2B23B: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 584 bytes in 1 blocks are still reachable in loss record 110 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0xAE5EC6B: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE5EEAE: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE5A697: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE68548: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE68DE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8E978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF2AB64: pango_ot_buffer_output (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xE6C24A5: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5812==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB081E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB2966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 584 bytes in 4 blocks are still reachable in loss record 111 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CFD0E: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D025D: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2DD2: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 606 bytes in 41 blocks are still reachable in loss record 112 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F28BD9: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 608 bytes in 38 blocks are still reachable in loss record 113 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F27E33: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 620 bytes in 1 blocks are still reachable in loss record 114 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xC7EA7C8: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 672 bytes in 42 blocks are still reachable in loss record 115 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CBEB6: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CBF62: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CC1D6: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE3A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE4F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF280EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 677 bytes in 51 blocks are still reachable in loss record 116 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26F7B: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 688 bytes in 2 blocks are still reachable in loss record 117 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0xAE5F0C1: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99ABA: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 816 bytes in 34 blocks are still reachable in loss record 118 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0E79: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1601: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1800: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2A94: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 832 bytes in 52 blocks are still reachable in loss record 119 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26E5E: _XlcAddCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26C92: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 840 bytes in 15 blocks are still reachable in loss record 120 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xF77B9EA: (within /usr/lib/libdbus-1.so.3.4.0)
==5812==    by 0xF773B0C: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5812==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5812==    by 0xE3B7C17: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0xE3B7ABB: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5812== 
==5812== 
==5812== 848 bytes in 1 blocks are still reachable in loss record 121 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4011E14: (within /lib/ld-2.7.so)
==5812==    by 0x4012335: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5812== 
==5812== 
==5812== 864 bytes in 27 blocks are still reachable in loss record 122 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x985070B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 920 bytes in 16 blocks are still reachable in loss record 123 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0BE53C: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0BEB32: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0BEC48: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0BE8BD: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0BE999: FcDirCacheLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C4AC2: FcDirCacheRead (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C11E8: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 952 bytes in 2 blocks are still reachable in loss record 124 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F08EF1: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 1,008 bytes in 1 blocks are still reachable in loss record 125 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F281F5: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,029 bytes in 30 blocks are still reachable in loss record 126 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F03713: _XUpdateAtomCache (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F03CF8: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x98425FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9847BC3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x9847E26: gdk_window_set_decorations (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x926E6DA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x925F956: gtk_widget_realize (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,056 bytes in 44 blocks are still reachable in loss record 127 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CD13C: FcPatternCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CAF1D: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 1,068 bytes in 52 blocks are still reachable in loss record 128 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26F1C: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,092 bytes in 35 blocks are still reachable in loss record 129 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CFE6F: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D00F5: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D0248: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1161: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1201: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 1,280 bytes in 10 blocks are still reachable in loss record 130 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F032FB: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F6BA56: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812== 
==5812== 
==5812== 1,344 bytes in 1 blocks are still reachable in loss record 131 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CBDCA: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CC207: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE3A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE4F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF280EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 1,373 bytes in 55 blocks are still reachable in loss record 132 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4008B75: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812== 
==5812== 
==5812== 1,376 bytes in 43 blocks are indirectly lost in loss record 133 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0C8CFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C8DFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CDF09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE01C: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 1,416 bytes in 3 blocks are still reachable in loss record 134 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE95065: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95780: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6D2C1: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6D395: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE707CA: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE716A5: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE95C80: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6B987: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EE21: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6E195: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE6EB1D: (within /usr/lib/libcairo.so.2.17.3)
==5812== 
==5812== 
==5812== 1,416 bytes in 1 blocks are still reachable in loss record 135 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB500210: XRenderQueryFormats (in /usr/lib/libXrender.so.1.3.0)
==5812==    by 0xB5009CC: XRenderQueryVersion (in /usr/lib/libXrender.so.1.3.0)
==5812==    by 0xBD189E1: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 1,464 bytes in 40 blocks are still reachable in loss record 136 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5812==    by 0x5BE3097: asprintf (in /lib/libc-2.7.so)
==5812==    by 0x5F085DD: (within /lib/libselinux.so.1)
==5812==    by 0x5F0A021: (within /lib/libselinux.so.1)
==5812==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==5812==    by 0x7FEFFFFD7: ???
==5812==    by 0x400E165: (within /lib/ld-2.7.so)
==5812==    by 0x400E28D: (within /lib/ld-2.7.so)
==5812==    by 0x4000A99: (within /lib/ld-2.7.so)
==5812==    by 0x2: ???
==5812==    by 0x7FF000216: ???
==5812== 
==5812== 
==5812== 1,584 bytes in 66 blocks are still reachable in loss record 137 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1D023: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 1,600 bytes in 20 blocks are possibly lost in loss record 138 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xAA289EF: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA28B3E: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2C705: g_type_register_fundamental (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1455F: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2B7D4: g_type_init_with_debug_flags (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x980BBBE: gdk_pre_parse_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,630 bytes in 96 blocks are definitely lost in loss record 139 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x497C2C: mono_metadata_type_dup (metadata.c:4142)
==5812==    by 0x4A7440: inflate_generic_type (class.c:512)
==5812==    by 0x4A8D5D: mono_class_inflate_generic_type_with_mempool (class.c:606)
==5812==    by 0x4EE5BD: inflate_other_info (generic-sharing.c:532)
==5812==    by 0x4EF227: fill_runtime_generic_context (generic-sharing.c:733)
==5812==    by 0x4EF497: mono_class_fill_runtime_generic_context (generic-sharing.c:1116)
==5812==    by 0x415B996: ???
==5812==    by 0x8C41E33: ???
==5812==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5812==    by 0x55918B: mono_jit_compile_method (mini.c:13021)
==5812== 
==5812== 
==5812== 1,640 bytes in 41 blocks are still reachable in loss record 140 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F2897C: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,728 bytes in 27 blocks are still reachable in loss record 141 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F274F0: _XlcSetConverter (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F31120: _XlcAddUtf8LocaleConverters (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C84B: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 1,780 bytes in 89 blocks are still reachable in loss record 142 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE5C47C: cairo_font_options_copy (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DE4C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A90C2C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF27C3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 1,871 bytes in 70 blocks are still reachable in loss record 143 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400AC49: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812== 
==5812== 
==5812== 2,032 bytes in 1 blocks are definitely lost in loss record 144 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x507DB94: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x507F22D: g_slist_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4CD17A: mono_thread_push_appdomain_ref (threads.c:2967)
==5812==    by 0x4CEB47: start_wrapper (threads.c:569)
==5812==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5812==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5812==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5812==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5812== 
==5812== 
==5812== 2,048 bytes in 1 blocks are still reachable in loss record 145 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F27F9C: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 2,048 bytes in 1 blocks are still reachable in loss record 146 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xB0C7B2F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C119A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1201: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 2,064 bytes in 1 blocks are still reachable in loss record 147 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE67996: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE67E3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DFA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 2,240 bytes in 32 blocks are still reachable in loss record 148 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4012436: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5812==    by 0x95DD151: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812==    by 0x95DEE01: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 2,520 bytes in 21 blocks are still reachable in loss record 149 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xAE684E9: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE68DE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8E978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0xBF2AB64: pango_ot_buffer_output (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xE6C24A5: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5812==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB081E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB2966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB31B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0xBF250EE: pango_fc_font_create_metrics_for_context (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 2,525 bytes in 48 blocks are still reachable in loss record 150 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26A7D: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 2,616 bytes in 1 blocks are still reachable in loss record 151 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F08790: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 2,784 bytes in 4 blocks are still reachable in loss record 152 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xC15BD5B: ft_mem_qrealloc (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15BDFA: ft_mem_realloc (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15C781: FT_CMap_New (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC18E125: (within /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC18E3E8: (within /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC16B08E: (within /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15CA56: (within /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15E3D5: FT_Open_Face (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15EFD1: FT_New_Face (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xAE9A75F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9C01F: (within /usr/lib/libcairo.so.2.17.3)
==5812== 
==5812== 
==5812== 3,744 bytes in 52 blocks are still reachable in loss record 153 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F26EC6: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 4,096 bytes in 1 blocks are still reachable in loss record 154 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F0DB90: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26E08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26A4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5812== 
==5812== 
==5812== 4,200 bytes in 175 blocks are still reachable in loss record 155 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0BF66A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1E6D: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 4,628 bytes in 194 blocks are still reachable in loss record 156 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F1D0FF: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 4,720 bytes in 12 blocks are still reachable in loss record 157 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400C679: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5812== 
==5812== 
==5812== 5,304 bytes in 221 blocks are still reachable in loss record 158 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0DE9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1FBE: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2EDE: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 5,440 bytes in 34 blocks are still reachable in loss record 159 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9EF6161: XCreateGC (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x983A36A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x911011B: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x504766F: g_cache_insert (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x9110534: gtk_gc_get (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7F17: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA26642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x91BFFD7: gtk_style_attach (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 5,888 bytes in 184 blocks are indirectly lost in loss record 160 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0C05A9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0C09D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CB02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 6,016 bytes in 188 blocks are still reachable in loss record 161 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0BA9: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1DF3: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 6,048 bytes in 60 blocks are still reachable in loss record 162 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x400C582: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5812==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5812==    by 0x5C7D114: (within /lib/libc-2.7.so)
==5812==    by 0x5C31ABC: getpwnam_r (in /lib/libc-2.7.so)
==5812==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 6,381 bytes in 1 blocks are still reachable in loss record 163 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F09346: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 6,528 bytes in 204 blocks are still reachable in loss record 164 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D0F8D: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D1E50: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 6,628 bytes in 308 blocks are still reachable in loss record 165 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xAA10118: g_closure_set_meta_marshal (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1050D: g_signal_type_cclosure_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA21A20: g_signal_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x91C027F: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA2FC50: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA16B11: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x9258714: gtk_widget_get_default_style (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 8,528 bytes in 41 blocks are still reachable in loss record 166 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F18D75: _XEnq (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1FCED: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1FFA4: _XReply (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F03C9D: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x98425FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x984C322: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x984EDDB: gdk_window_new (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x982C59C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 8,589 bytes in 596 blocks are still reachable in loss record 167 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CFDC3: FcStrCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D117F: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2C59: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 8,680 bytes in 1 blocks are still reachable in loss record 168 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0xC7EA57E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5812==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812== 
==5812== 
==5812== 9,096 bytes in 70 blocks are still reachable in loss record 169 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x400F8F4: (within /lib/ld-2.7.so)
==5812==    by 0x4012328: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5812==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5812==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5812==    by 0x481CB0: cached_module_load (loader.c:1048)
==5812==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5812== 
==5812== 
==5812== 12,624 bytes in 307 blocks are still reachable in loss record 170 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CD211: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE089: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 13,080 bytes in 545 blocks are still reachable in loss record 171 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0D115A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2C59: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5812==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0D2E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==5812== 
==5812== 
==5812== 16,352 bytes in 2 blocks are still reachable in loss record 172 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x9F0D964: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F0DE6E: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1D6BF: (within /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5812==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812== 
==5812== 
==5812== 16,384 bytes in 1 blocks are still reachable in loss record 173 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x9F08B15: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5812==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0x8E3C527: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== 
==5812== 36,608 bytes in 1,144 blocks are indirectly lost in loss record 174 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xB0CDFCD: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 67,072 bytes in 215 blocks are still reachable in loss record 175 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xAA1FCCF: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA21059: g_signal_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA21786: g_signal_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA21902: g_signal_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x92628B5: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA2FC50: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2FE9C: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2FE9C: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2FE9C: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA2FE9C: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 67,648 (23,808 direct, 43,840 indirect) bytes in 43 blocks are definitely lost in loss record 176 of 184
==5812==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5812==    by 0xB0CD792: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CE105: (within /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5812==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812== 
==5812== 
==5812== 73,648 bytes in 37 blocks are possibly lost in loss record 177 of 184
==5812==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==5812==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==5812==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x507E0C2: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x507E1E5: g_slice_alloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0xAA302BE: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5812==    by 0x913B521: gtk_label_new_with_mnemonic (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5812==    by 0xE3B5787: ???
==5812== 
==5812== 
==5812== 81,358 bytes in 70 blocks are still reachable in loss record 178 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x400A9D4: (within /lib/ld-2.7.so)
==5812==    by 0x40061E4: (within /lib/ld-2.7.so)
==5812==    by 0x4008677: (within /lib/ld-2.7.so)
==5812==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5812==    by 0x40120A8: (within /lib/ld-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812==    by 0x401191A: (within /lib/ld-2.7.so)
==5812==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5812==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5812== 
==5812== 
==5812== 84,921 bytes in 108 blocks are still reachable in loss record 179 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xC15A30F: ft_mem_qalloc (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15BC52: ft_mem_alloc (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC15DBB4: FT_Add_Module (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC156C9E: FT_Add_Default_Modules (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xC156D24: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==5812==    by 0xAE99ACB: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5812==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5812==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5812==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 379,200 bytes in 1 blocks are still reachable in loss record 180 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x95D9E94: gdk_pixbuf_new (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812==    by 0xE3C3F57: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5812==    by 0xCA189F2: (within /usr/lib/libpng12.so.0.15.0)
==5812==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5812==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5812==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5812==    by 0xE3B3DAF: ???
==5812==    by 0xE3B2B6B: ???
==5812==    by 0x8FF9AFF: ???
==5812==    by 0x41AB3AF: ???
==5812== 
==5812== 
==5812== 906,576 bytes in 1,723 blocks are still reachable in loss record 181 of 184
==5812==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==5812==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==5812==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x506035D: g_list_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x52AF25: mono_allocate_stack_slots_full (mini.c:9812)
==5812==    by 0x432320: mono_arch_allocate_vars (mini-amd64.c:1137)
==5812==    by 0x558127: mini_method_compile (mini.c:12525)
==5812==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5812==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5812==    by 0x415B164: ???
==5812==    by 0x8BA4AAB: ???
==5812== 
==5812== 
==5812== 1,012,800 bytes in 6,575 blocks are still reachable in loss record 182 of 184
==5812==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5812==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x4A8E25: mono_generic_class_get_class (class.c:4308)
==5812==    by 0x4A5926: mono_bounded_array_class_get (class.c:4820)
==5812==    by 0x4E0F7E: ves_icall_System_Array_CreateInstanceImpl (icall.c:516)
==5812==    by 0x8795863: ???
==5812==    by 0x8E3283F: ???
==5812==    by 0x8E31D6F: ???
==5812==    by 0x8E31963: ???
==5812==    by 0x8E2EA0B: ???
==5812==    by 0x8C415BB: ???
==5812==    by 0x8E2CDB7: ???
==5812== 
==5812== 
==5812== 1,890,094 bytes in 2,630 blocks are still reachable in loss record 183 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0xBF2E201: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF30194: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF3E81D: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2B604: pango_ot_info_get_gsub (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2B654: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2BEDB: pango_ot_info_find_script (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2C9B9: pango_ot_ruleset_new_for (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2CA75: pango_ot_ruleset_new_from_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xBF2CBBE: pango_ot_ruleset_get_for_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5812==    by 0xE6C2479: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5812==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5812== 
==5812== 
==5812== 2,999,781 bytes in 4,252 blocks are still reachable in loss record 184 of 184
==5812==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5812==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5812==    by 0x49850E: mono_metadata_get_generic_inst (metadata.c:2374)
==5812==    by 0x4B2E18: mono_class_bind_generic_parameters (reflection.c:9314)
==5812==    by 0x4A5926: mono_bounded_array_class_get (class.c:4820)
==5812==    by 0x4E0F7E: ves_icall_System_Array_CreateInstanceImpl (icall.c:516)
==5812==    by 0x8795863: ???
==5812==    by 0x41AB3AF: ???
==5812==    by 0x41AB265: ???
==5812==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5812==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5812==    by 0x417A5F: mono_main (driver.c:942)
==5812== 
==5812== LEAK SUMMARY:
==5812==    definitely lost: 27,778 bytes in 142 blocks.
==5812==    indirectly lost: 44,112 bytes in 1,381 blocks.
==5812==      possibly lost: 75,248 bytes in 57 blocks.
==5812==    still reachable: 7,645,111 bytes in 20,026 blocks.
==5812==         suppressed: 0 bytes in 0 blocks.
--5812--  memcheck: sanity checks: 1730 cheap, 41 expensive
--5812--  memcheck: auxmaps: 0 auxmap entries (0k, 0M) in use
--5812--  memcheck: auxmaps_L1: 0 searches, 0 cmps, ratio 0:10
--5812--  memcheck: auxmaps_L2: 0 searches, 0 nodes
--5812--  memcheck: SMs: n_issued      = 520 (8320k, 8M)
--5812--  memcheck: SMs: n_deissued    = 9 (144k, 0M)
--5812--  memcheck: SMs: max_noaccess  = 524287 (8388592k, 8191M)
--5812--  memcheck: SMs: max_undefined = 5 (80k, 0M)
--5812--  memcheck: SMs: max_defined   = 3267 (52272k, 51M)
--5812--  memcheck: SMs: max_non_DSM   = 511 (8176k, 7M)
--5812--  memcheck: max sec V bit nodes:    1408 (121k, 0M)
--5812--  memcheck: set_sec_vbits8 calls: 73668 (new: 1408, updates: 72260)
--5812--  memcheck: max shadow mem size:   12441k, 12M
--5812-- translate:            fast SP updates identified: 57,622 ( 85.9%)
--5812-- translate:   generic_known SP updates identified: 8,404 ( 12.5%)
--5812-- translate: generic_unknown SP updates identified: 1,035 (  1.5%)
--5812--     tt/tc: 7,488,294 tt lookups requiring 14,538,710 probes
--5812--     tt/tc: 7,488,294 fast-cache updates, 3,832 flushes
--5812--  transtab: new        88,248 (1,773,667 -> 33,651,715; ratio 189:10) [88,248 scs]
--5812--  transtab: dumped     0 (0 -> ??)
--5812--  transtab: discarded  4,333 (138,924 -> ??)
--5812-- scheduler: 172,767,160 jumps (bb entries).
--5812-- scheduler: 1,730/7,727,969 major/minor sched events.
--5812--    sanity: 1731 cheap, 41 expensive checks.
--5812--    exectx: 98,317 lists, 97,578 contexts (avg 0 per list)
--5812--    exectx: 430,628 searches, 412,121 full compares (957 per 1000)
--5812--    exectx: 2,018,078 cmp2, 54,788 cmp4, 0 cmpAll
--5812--  errormgr: 357 supplist searches, 24,881 comparisons during search
--5812--  errormgr: 63,117 errlist searches, 559,396 comparisons during search
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524A14: GC_finalize (finalize.c:586)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524BF9: GC_finalize (finalize.c:637)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
--5807-- Reading syms from /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so (0x13818000)
--5807-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so...
--5807-- ... CRC mismatch (computed a1d4d3de wanted e712bd61)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/librsvg-2.so.2.22.2 (0x13A30000)
--5807-- Reading debug info from /usr/lib/librsvg-2.so.2.22.2...
--5807-- ... CRC mismatch (computed 5d8a19ba wanted 1379147e)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgsf-1.so.114.0.7 (0x13C66000)
--5807-- Reading debug info from /usr/lib/libgsf-1.so.114.0.7...
--5807-- ... CRC mismatch (computed 255ecc8f wanted fedaae2a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libcroco-0.6.so.3.0.1 (0x13EA1000)
--5807-- Reading debug info from /usr/lib/libcroco-0.6.so.3.0.1...
--5807-- ... CRC mismatch (computed 2f118585 wanted 34b37c38)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libbz2.so.1.0.4 (0x140DC000)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CF4: GC_block_nearly_full3 (reclaim.c:205)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5188DD: GC_reclaim_uninit2 (reclaim.c:553)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51888F: GC_reclaim_uninit2 (reclaim.c:551)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5188B6: GC_reclaim_uninit2 (reclaim.c:552)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x14BF3433: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x14BF3117: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0xE3B6303: ???
==5807==  Address 0x7feffe050 is not stack'd, malloc'd or (recently) free'd
--5807-- Reading syms from /usr/mono-2.0/lib/libMonoPosixHelper.so (0x14BFE000)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517D84: GC_block_nearly_full (reclaim.c:259)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
--5807-- memcheck GC: 2048 nodes, 2048 survivors (100.0%)
--5807-- memcheck GC: increase table size to 4096
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DF14: GC_mark_from (mark.c:801)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x161712DB: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DB89: GC_mark_from (mark.c:791)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x161712DB: ???
--5807-- Reading syms from /usr/mono-2.0/lib/libgdksharpglue-2.so (0x1687D000)
--5807-- memcheck GC: 4096 nodes, 3751 survivors ( 91.5%)
--5807-- memcheck GC: increase table size to 8192
--5807-- Reading syms from /usr/lib/gnome-vfs-2.0/modules/libfile.so (0x16CE7000)
--5807-- Reading debug info from /usr/lib/gnome-vfs-2.0/modules/libfile.so...
--5807-- ... CRC mismatch (computed e965ce71 wanted 9d6f55f7)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libacl.so.1.1.0 (0x16F0C000)
--5807-- Reading debug info from /lib/libacl.so.1.1.0...
--5807-- ... CRC mismatch (computed e1c130eb wanted e10d0368)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libfam.so.0.0.0 (0x17113000)
--5807-- Reading debug info from /usr/lib/libfam.so.0.0.0...
--5807-- ... CRC mismatch (computed 14aafade wanted 6780a44b)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libattr.so.1.1.0 (0x1731B000)
--5807-- Reading debug info from /lib/libattr.so.1.1.0...
--5807-- ... CRC mismatch (computed 270e5d3e wanted e021b06d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/mono-2.0/lib/libp4api.so (0x17654000)
--5807-- REDIR: 0xcf135d0 (operator new(unsigned long)) redirected to 0x4c237a0 (operator new(unsigned long))
--5807-- REDIR: 0xcf13700 (operator new[](unsigned long)) redirected to 0x4c23420 (operator new[](unsigned long))
--5807-- REDIR: 0xcf11f50 (operator delete[](void*)) redirected to 0x4c22330 (operator delete[](void*))
--5807-- Reading syms from /lib/libnss_mdns4_minimal.so.2 (0x1791D000)
--5807-- Reading debug info from /lib/libnss_mdns4_minimal.so.2...
--5807-- ... CRC mismatch (computed bdc1e1df wanted 44ddd8a1)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libnss_dns-2.7.so (0x17B1F000)
--5807-- Reading debug info from /lib/libnss_dns-2.7.so...
--5807-- ... CRC mismatch (computed 89e8c2cc wanted 4c55bb8e)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D645: GC_mark_from (mark.c:688)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x182307BF: ???
==5807==    by 0x1823045F: ???
--5807-- REDIR: 0xcf11f10 (operator delete(void*)) redirected to 0x4c22750 (operator delete(void*))
==5807== 
==5807== Thread 6:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1852D680: ???
==5807==    by 0x1823D4BB: ???
==5807==    by 0x1823B717: ???
==5807==    by 0x1790FAEB: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x17e24520 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--5807-- Reading syms from /usr/lib/libgdiplus.so.0.0.0 (0x18552000)
--5807-- Reading debug info from /usr/lib/libgdiplus.so.0.0.0...
--5807-- ... CRC mismatch (computed f5f0cde3 wanted ffb12385)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libtiff.so.4.2.1 (0x187B6000)
--5807-- Reading debug info from /usr/lib/libtiff.so.4.2.1...
--5807-- ... CRC mismatch (computed 77d37870 wanted c23ecbe9)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libjpeg.so.62.0.0 (0x18A0F000)
--5807-- Reading debug info from /usr/lib/libjpeg.so.62.0.0...
--5807-- ... CRC mismatch (computed 6be639f1 wanted d31f1928)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgif.so.4.1.6 (0x18C32000)
--5807-- Reading debug info from /usr/lib/libgif.so.4.1.6...
--5807-- ... CRC mismatch (computed 0ce81d21 wanted 8531d7d5)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libexif.so.12.2.0 (0x18E3A000)
--5807-- Reading debug info from /usr/lib/libexif.so.12.2.0...
--5807-- ... CRC mismatch (computed f5a7a222 wanted eccf6753)
--5807--    object doesn't have a symbol table
==5807== 
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0368: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D037A: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D038C: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03B7: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03C8: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03F0: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0400: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0210: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D02B6: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D0318: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0322: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0356: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0413: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D041F: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D047F: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0544: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0186: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0696: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D06A7: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D1DCB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D38B0: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D06EB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CBEBA: crc32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA01AAC: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA09394: png_write_chunk_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA09F96: png_write_chunk (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0AEA4: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0AFBE: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x95DD909: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DEDEA: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x17910B03: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CBEC4: crc32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA01AAC: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA17F77: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D54E4: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D4C71: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D4CB4: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4BB5: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4BC3: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D546A: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D5484: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D542F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D543F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D5459: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D54A5: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D52AA: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB282: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB294: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB29F: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB366: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB51B: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB54D: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB5A1: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB600: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB60C: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB615: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB637: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D531F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D3FE9: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D3FFB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x4C2502A: memcpy (mc_replace_strmem.c:402)
==5807==    by 0xC3D40BD: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D40CC: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4697: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D46E9: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xCA17E48: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
--5807-- memcheck GC: 8192 nodes, 7528 survivors ( 91.8%)
--5807-- memcheck GC: increase table size to 16384
==5807== 
==5807== Thread 7:
==5807== Use of uninitialised value of size 8
==5807==    at 0x52236D: GC_base (misc.c:398)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x522399: GC_base (misc.c:398)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x5223BA: GC_base (misc.c:399)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224AB: GC_base (misc.c:422)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224CB: GC_base (misc.c:426)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== Thread 8:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x199697CB: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e310 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x19969807: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e1d0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e550 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Thread 11:
==5807== Invalid read of size 8
==5807==    at 0x51E97C: GC_push_all_eager (mark.c:1468)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==  Address 0x7feffe030 is on thread 1's stack
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517E63: GC_block_nearly_full (reclaim.c:275)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x19A8758B: ???
==5807==    by 0x19A83543: ???
==5807==    by 0x19A8325B: ???
==5807==    by 0x4C7B6E: mono_runtime_invoke_array (object.c:3228)
==5807==    by 0x4CA31A: mono_message_invoke (object.c:4743)
==5807==    by 0x4ECC14: mono_async_invoke (threadpool.c:938)
==5807==    by 0x4EDE39: async_invoke_io_thread (threadpool.c:260)
==5807==    by 0x4CEBFC: start_wrapper (threads.c:621)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==  Address 0x19c8a630 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Thread 8:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928ea70 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Thread 1:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1ACAC44F: ???
==5807==    by 0x1ACAAF33: ???
==5807==    by 0x1ACA9B03: ???
==5807==    by 0x1ACA9A6F: ???
==5807==    by 0x1ACA8147: ???
==5807==    by 0x1ACA7F97: ???
==5807==    by 0x1ACA7B2B: ???
==5807==    by 0x1AC906A3: ???
==5807==    by 0x1AC9006D: ???
==5807==    by 0x1AC90007: ???
==5807==    by 0x14AF578E: ???
==5807==  Address 0x7feffb670 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Thread 11:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1B1ED24B: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928ec20 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== Thread 1:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1B7E0EDF: ???
==5807==    by 0x1B7E0A9F: ???
==5807==    by 0x1B7E08D3: ???
==5807==    by 0x1B7DE757: ???
==5807==    by 0x1B7DC5EB: ???
==5807==    by 0x1B7DC0EB: ???
==5807==    by 0x1AC90007: ???
==5807==    by 0x14AF578E: ???
==5807==    by 0x7FFFFFF: ???
==5807==  Address 0x7feffbc30 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--5807-- Reading syms from /usr/lib/libsvn_client-1.so.1.0.0 (0x1B807000)
--5807-- Reading debug info from /usr/lib/libsvn_client-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 286a212e wanted 56867854)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_wc-1.so.1.0.0 (0x1BA31000)
--5807-- Reading debug info from /usr/lib/libsvn_wc-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 8e2098a5 wanted 295fe310)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_ra-1.so.1.0.0 (0x1BC63000)
--5807-- Reading debug info from /usr/lib/libsvn_ra-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 2ec6f7e2 wanted 06e773ae)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_delta-1.so.1.0.0 (0x1BE67000)
--5807-- Reading debug info from /usr/lib/libsvn_delta-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 481e4984 wanted 8b8b0f0d)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_diff-1.so.1.0.0 (0x1C071000)
--5807-- Reading debug info from /usr/lib/libsvn_diff-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 7dbaa55d wanted 52dce1ca)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_subr-1.so.1.0.0 (0x1C278000)
--5807-- Reading debug info from /usr/lib/libsvn_subr-1.so.1.0.0...
--5807-- ... CRC mismatch (computed cc615e4e wanted fdded8af)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libapr-1.so.0.2.11 (0x1C4AC000)
--5807-- Reading debug info from /usr/lib/libapr-1.so.0.2.11...
--5807-- ... CRC mismatch (computed fa350136 wanted 68786032)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libaprutil-1.so.0.2.11 (0x1C6D5000)
--5807-- Reading debug info from /usr/lib/libaprutil-1.so.0.2.11...
--5807-- ... CRC mismatch (computed be9576e4 wanted 8c18d0b5)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_ra_local-1.so.1.0.0 (0x1C8F3000)
--5807-- Reading debug info from /usr/lib/libsvn_ra_local-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 2a039916 wanted 08106e1e)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_repos-1.so.1.0.0 (0x1CAFA000)
--5807-- Reading debug info from /usr/lib/libsvn_repos-1.so.1.0.0...
--5807-- ... CRC mismatch (computed ef6870c3 wanted 9f6c2377)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_fs-1.so.1.0.0 (0x1CD1B000)
--5807-- Reading debug info from /usr/lib/libsvn_fs-1.so.1.0.0...
--5807-- ... CRC mismatch (computed da9455ed wanted 9a3a4fa9)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_ra_svn-1.so.1.0.0 (0x1CF21000)
--5807-- Reading debug info from /usr/lib/libsvn_ra_svn-1.so.1.0.0...
--5807-- ... CRC mismatch (computed db3a7eb4 wanted 96b02517)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_ra_dav-1.so.1.0.0 (0x1D135000)
--5807-- Reading debug info from /usr/lib/libsvn_ra_dav-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 60cea68f wanted 0b17ba8f)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libuuid.so.1.2 (0x1D352000)
--5807-- Reading debug info from /lib/libuuid.so.1.2...
--5807-- ... CRC mismatch (computed f1e7d171 wanted 5326e314)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libcrypt-2.7.so (0x1D556000)
--5807-- Reading debug info from /lib/libcrypt-2.7.so...
--5807-- ... CRC mismatch (computed f17bd312 wanted 8ca73583)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libldap_r-2.4.so.2.0.5 (0x1D78E000)
--5807-- Reading debug info from /usr/lib/libldap_r-2.4.so.2.0.5...
--5807-- ... CRC mismatch (computed 8243c472 wanted c4d6223f)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/liblber-2.4.so.2.0.5 (0x1D9D3000)
--5807-- Reading debug info from /usr/lib/liblber-2.4.so.2.0.5...
--5807-- ... CRC mismatch (computed 2e940a69 wanted 3fead3f6)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libdb-4.6.so (0x1DBE1000)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libpq.so.5.1 (0x1DF16000)
--5807-- Reading debug info from /usr/lib/libpq.so.5.1...
--5807-- ... CRC mismatch (computed 8691a2e9 wanted dbdba3f3)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsqlite3.so.0.8.6 (0x1E13A000)
--5807-- Reading debug info from /usr/lib/libsqlite3.so.0.8.6...
--5807-- ... CRC mismatch (computed a5e5a180 wanted bcc09067)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_fs_fs-1.so.1.0.0 (0x1E3A6000)
--5807-- Reading debug info from /usr/lib/libsvn_fs_fs-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 59a609fe wanted 3753cc06)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsvn_fs_base-1.so.1.0.0 (0x1E5C2000)
--5807-- Reading debug info from /usr/lib/libsvn_fs_base-1.so.1.0.0...
--5807-- ... CRC mismatch (computed 2ecb58f6 wanted 91439102)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libneon.so.27.0.2 (0x1E7EB000)
--5807-- Reading debug info from /usr/lib/libneon.so.27.0.2...
--5807-- ... CRC mismatch (computed 83da46b9 wanted 867962d8)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libsasl2.so.2.0.22 (0x1EA0F000)
--5807-- Reading debug info from /usr/lib/libsasl2.so.2.0.22...
--5807-- ... CRC mismatch (computed 702055a8 wanted 33f05302)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libssl.so.0.9.8 (0x1EC28000)
--5807-- Reading debug info from /usr/lib/libssl.so.0.9.8...
--5807-- ... CRC mismatch (computed 81d12423 wanted 9e65664a)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libcrypto.so.0.9.8 (0x1EE72000)
--5807-- Reading debug info from /usr/lib/libcrypto.so.0.9.8...
--5807-- ... CRC mismatch (computed 4c77ca08 wanted 62b6fe3f)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libkrb5.so.3.3 (0x1F1F2000)
--5807-- Reading debug info from /usr/lib/libkrb5.so.3.3...
--5807-- ... CRC mismatch (computed 5984bc14 wanted f7b21757)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libcom_err.so.2.1 (0x1F489000)
--5807-- Reading debug info from /lib/libcom_err.so.2.1...
--5807-- ... CRC mismatch (computed 8d112d17 wanted 0e952244)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libgssapi_krb5.so.2.2 (0x1F68B000)
--5807-- Reading debug info from /usr/lib/libgssapi_krb5.so.2.2...
--5807-- ... CRC mismatch (computed 422a65aa wanted f12854ac)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libk5crypto.so.3.1 (0x1F8B6000)
--5807-- Reading debug info from /usr/lib/libk5crypto.so.3.1...
--5807-- ... CRC mismatch (computed e14f5de9 wanted 1e868fae)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /usr/lib/libkrb5support.so.0.1 (0x1FADA000)
--5807-- Reading debug info from /usr/lib/libkrb5support.so.0.1...
--5807-- ... CRC mismatch (computed fe0592a5 wanted ef85f36e)
--5807--    object doesn't have a symbol table
--5807-- Reading syms from /lib/libkeyutils-1.2.so (0x1FCE1000)
--5807-- Reading debug info from /lib/libkeyutils-1.2.so...
--5807-- ... CRC mismatch (computed 775fbe7d wanted d95e5972)
--5807--    object doesn't have a symbol table
--5807-- memcheck GC: 16384 nodes, 15777 survivors ( 96.2%)
--5807-- memcheck GC: increase table size to 32768
--5807-- memcheck GC: 32768 nodes, 30017 survivors ( 91.6%)
--5807-- memcheck GC: increase table size to 65536
--5807-- memcheck GC: 65536 nodes, 57838 survivors ( 88.2%)
--5807-- memcheck GC: increase table size to 131072
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x16853A9B: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x16853A9B: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
--5807-- memcheck GC: 131072 nodes, 117150 survivors ( 89.3%)
--5807-- memcheck GC: increase table size to 262144
==5807== 
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x15402067: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
--5807-- memcheck GC: 262144 nodes, 228400 survivors ( 87.1%)
--5807-- memcheck GC: increase table size to 524288
==5807== 
==5807== More than 10000000 total errors detected.  I'm not reporting any more.
==5807== Final error counts will be inaccurate.  Go fix your program!
==5807== Rerun with --error-limit=no to disable this cutoff.  Note
==5807== that errors may occur in your program without prior warning from
==5807== Valgrind, because errors are no longer being displayed.
==5807== 
--5807-- memcheck GC: 524288 nodes, 464688 survivors ( 88.6%)
--5807-- memcheck GC: increase table size to 1048576
--5807-- Discarding syms at 0x69AB000-0x6BB4000 in /lib/libnss_compat-2.7.so due to munmap()
--5807-- Discarding syms at 0x6DCD000-0x6FD8000 in /lib/libnss_nis-2.7.so due to munmap()
--5807-- Discarding syms at 0x71E4000-0x73EF000 in /lib/libnss_winbind.so.2 due to munmap()
--5807-- Discarding syms at 0x6FD8000-0x71E4000 in /lib/libnss_files-2.7.so due to munmap()
--5807-- Discarding syms at 0x1791D000-0x17B1F000 in /lib/libnss_mdns4_minimal.so.2 due to munmap()
--5807-- Discarding syms at 0x17B1F000-0x17D25000 in /lib/libnss_dns-2.7.so due to munmap()
==5807== 
==5807== ERROR SUMMARY: 10000000 errors from 241 contexts (suppressed: 789 from 1)
==5807== 
==5807== 1 errors in context 1 of 241:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1B7E0EDF: ???
==5807==    by 0x1B7E0A9F: ???
==5807==    by 0x1B7E08D3: ???
==5807==    by 0x1B7DE757: ???
==5807==    by 0x1B7DC5EB: ???
==5807==    by 0x1B7DC0EB: ???
==5807==    by 0x1AC90007: ???
==5807==    by 0x14AF578E: ???
==5807==    by 0x7FFFFFF: ???
==5807==  Address 0x7feffbc30 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 1 errors in context 2 of 241:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1ACAC44F: ???
==5807==    by 0x1ACAAF33: ???
==5807==    by 0x1ACA9B03: ???
==5807==    by 0x1ACA9A6F: ???
==5807==    by 0x1ACA8147: ???
==5807==    by 0x1ACA7F97: ???
==5807==    by 0x1ACA7B2B: ???
==5807==    by 0x1AC906A3: ???
==5807==    by 0x1AC9006D: ???
==5807==    by 0x1AC90007: ???
==5807==    by 0x14AF578E: ???
==5807==  Address 0x7feffb670 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 1 errors in context 3 of 241:
==5807== Thread 11:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x19A8758B: ???
==5807==    by 0x19A83543: ???
==5807==    by 0x19A8325B: ???
==5807==    by 0x4C7B6E: mono_runtime_invoke_array (object.c:3228)
==5807==    by 0x4CA31A: mono_message_invoke (object.c:4743)
==5807==    by 0x4ECC14: mono_async_invoke (threadpool.c:938)
==5807==    by 0x4EDE39: async_invoke_io_thread (threadpool.c:260)
==5807==    by 0x4CEBFC: start_wrapper (threads.c:621)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==  Address 0x19c8a630 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 1 errors in context 4 of 241:
==5807== Thread 8:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x19969807: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e1d0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 1 errors in context 5 of 241:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x199697CB: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e310 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 1 errors in context 6 of 241:
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xCA17E48: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807== 
==5807== 1 errors in context 7 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D46E9: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 8 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4697: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 9 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D40CC: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 10 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x4C2502A: memcpy (mc_replace_strmem.c:402)
==5807==    by 0xC3D40BD: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807== 
==5807== 1 errors in context 11 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D3FFB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 12 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D3FE9: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D465D: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 13 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D531F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 14 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB637: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 15 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB615: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 16 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB60C: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 17 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB366: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 18 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB29F: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 19 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB294: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 20 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB282: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 1 errors in context 21 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D52AA: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 22 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D54A5: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 23 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D5459: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 24 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D542F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 25 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D5484: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 26 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D546A: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 27 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4BC3: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 28 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D4BB5: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 29 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D4CB4: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 30 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D4C71: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 31 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CBEC4: crc32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA01AAC: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA17F77: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 32 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CBEBA: crc32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA01AAC: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA09394: png_write_chunk_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA09F96: png_write_chunk (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0AEA4: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0AFBE: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807== 
==5807== 1 errors in context 33 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0322: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 34 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D0318: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 35 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D02B6: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 1 errors in context 36 of 241:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x14BF3433: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x14BF3117: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0xE3B6303: ???
==5807==  Address 0x7feffe050 is not stack'd, malloc'd or (recently) free'd
==5807== 
==5807== 1 errors in context 37 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518034: GC_reclaim_clear2 (reclaim.c:395)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 1 errors in context 38 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 1 errors in context 39 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 2 errors in context 40 of 241:
==5807== Thread 11:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1B1ED24B: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928ec20 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 2 errors in context 41 of 241:
==5807== Thread 8:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1996908B: ???
==5807==    by 0x1929F7FE: ???
==5807==    by 0x1929AE7B: ???
==5807==    by 0x19298F3F: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928e550 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 2 errors in context 42 of 241:
==5807== Thread 1:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D54E4: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 43 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x95DD909: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DEDEA: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x17910B03: ???
==5807== 
==5807== 2 errors in context 44 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D1DCB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D38B0: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D06EB: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807== 
==5807== 2 errors in context 45 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D06A7: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 46 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0696: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 47 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0186: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 48 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3D047F: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 49 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0413: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 50 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0210: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 51 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D038C: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 52 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0400: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 2 errors in context 53 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DB89: GC_mark_from (mark.c:791)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x161712DB: ???
==5807== 
==5807== 2 errors in context 54 of 241:
==5807== Invalid read of size 8
==5807==    at 0x40165A5: (within /lib/ld-2.7.so)
==5807==    by 0x400A50E: (within /lib/ld-2.7.so)
==5807==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5807==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5807==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5807==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807==    by 0x41AB377: ???
==5807== 
==5807== 2 errors in context 55 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400A4CF: (within /lib/ld-2.7.so)
==5807==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==5807==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==5807==    by 0x51327B: mono_dl_symbol (mono-dl.c:357)
==5807==    by 0x4822CF: mono_lookup_pinvoke_call (loader.c:1297)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==  Address 0x66894b0 is 8 bytes inside a block of size 14 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4823FC: mono_lookup_pinvoke_call (loader.c:1270)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807==    by 0x41AB377: ???
==5807== 
==5807== 2 errors in context 56 of 241:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8C4DA90: ???
==5807==    by 0x8D5C29A: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8D5B80F: ???
==5807==    by 0x8D5B4C3: ???
==5807==    by 0x8D5B0FF: ???
==5807==  Address 0x7feffe010 is not stack'd, malloc'd or (recently) free'd
==5807== 
==5807== 2 errors in context 57 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5807==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x4C989E: mono_string_new_utf16 (object.c:3804)
==5807==    by 0x4C9DB7: mono_string_new (object.c:3891)
==5807== 
==5807== 2 errors in context 58 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517F9A: GC_reclaim_clear2 (reclaim.c:392)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 2 errors in context 59 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517FFE: GC_reclaim_clear2 (reclaim.c:394)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 2 errors in context 60 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517FC8: GC_reclaim_clear2 (reclaim.c:393)
==5807==    by 0x518E0C: GC_reclaim_generic (reclaim.c:682)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4C6E95: mono_class_vtable (object.c:1422)
==5807==    by 0x5391E3: mono_method_to_ir (mini.c:7688)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 3 errors in context 61 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x15402067: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 3 errors in context 62 of 241:
==5807== Thread 8:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x1928ea70 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 3 errors in context 63 of 241:
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D041F: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 3 errors in context 64 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03F0: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 3 errors in context 65 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03C8: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 3 errors in context 66 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D03B7: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 3 errors in context 67 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0356: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 3 errors in context 68 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==  Address 0x7f5cb68 is 40 bytes inside a block of size 47 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4007823: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 3 errors in context 69 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BA5253: ???
==5807==    by 0x8BA51EB: ???
==5807==    by 0x8BF0F47: ???
==5807== 
==5807== 3 errors in context 70 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BA5253: ???
==5807==    by 0x8BA51EB: ???
==5807==    by 0x8BF0F47: ???
==5807== 
==5807== 4 errors in context 71 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x16853A9B: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 4 errors in context 72 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FC90: GC_allochblk_nth (allchblk.c:628)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x16853A9B: ???
==5807==    by 0x19C915BF: ???
==5807==    by 0x14AF5A4E: ???
==5807==    by 0x52DFFFF: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 4 errors in context 73 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3CB600: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 4 errors in context 74 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB5A1: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 4 errors in context 75 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB54D: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 4 errors in context 76 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0xC3CB51B: adler32 (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3D59A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807== 
==5807== 4 errors in context 77 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D037A: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 4 errors in context 78 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0368: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 4 errors in context 79 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==  Address 0x84235c0 is 32 bytes inside a block of size 39 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4005F47: (within /lib/ld-2.7.so)
==5807==    by 0x400885F: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807== 
==5807== 4 errors in context 80 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== 5 errors in context 81 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400A99D: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==  Address 0x843f130 is 40 bytes inside a block of size 47 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAC4A932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0xAA31A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x9CA71C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CA7288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CA7306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAA459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAA6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 5 errors in context 82 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== 5 errors in context 83 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== 6 errors in context 84 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== 7 errors in context 85 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400522C: (within /lib/ld-2.7.so)
==5807==    by 0x40079E5: (within /lib/ld-2.7.so)
==5807==    by 0x40089D7: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==  Address 0x89d78a8 is 8 bytes inside a block of size 9 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4007823: (within /lib/ld-2.7.so)
==5807==    by 0x4007979: (within /lib/ld-2.7.so)
==5807==    by 0x40089D7: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807== 
==5807== 9 errors in context 86 of 241:
==5807== Thread 11:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517E63: GC_block_nearly_full (reclaim.c:275)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== 10 errors in context 87 of 241:
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== 10 errors in context 88 of 241:
==5807== Thread 7:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 89 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 90 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x51E77A: GC_mark_and_push_stack (mark.c:1357)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 91 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224CB: GC_base (misc.c:426)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 92 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224AB: GC_base (misc.c:422)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 93 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== 10 errors in context 94 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== 10 errors in context 95 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x5223F2: GC_base (misc.c:406)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807== 
==5807== 10 errors in context 96 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x5223BA: GC_base (misc.c:399)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 97 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x522399: GC_base (misc.c:398)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 98 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x52236D: GC_base (misc.c:398)
==5807==    by 0x51E76D: GC_mark_and_push_stack (mark.c:1356)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 10 errors in context 99 of 241:
==5807== Thread 1:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400A99D: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==  Address 0x8914b90 is 16 bytes inside a block of size 20 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x481F94: mono_lookup_pinvoke_call (loader.c:1121)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807== 
==5807== 10 errors in context 100 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 11 errors in context 101 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 11 errors in context 102 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 12 errors in context 103 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5188B6: GC_reclaim_uninit2 (reclaim.c:552)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== 12 errors in context 104 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DF14: GC_mark_from (mark.c:801)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x161712DB: ???
==5807== 
==5807== 13 errors in context 105 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C7A4: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 13 errors in context 106 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C793: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 13 errors in context 107 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518870: GC_reclaim_uninit2 (reclaim.c:550)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== 13 errors in context 108 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== 13 errors in context 109 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807== 
==5807== 13 errors in context 110 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5807== 
==5807== 13 errors in context 111 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x5236EB: GC_new_hblk (new_hblk.c:253)
==5807==    by 0x51B7CB: GC_allocobj (alloc.c:1116)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807==    by 0x4E528F: mono_init_internal (domain.c:1240)
==5807== 
==5807== 14 errors in context 112 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 15 errors in context 113 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51888F: GC_reclaim_uninit2 (reclaim.c:551)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== 15 errors in context 114 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5188DD: GC_reclaim_uninit2 (reclaim.c:553)
==5807==    by 0x518EA8: GC_reclaim_generic (reclaim.c:700)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807==    by 0x5144A3: GC_local_malloc_atomic (pthread_support.c:389)
==5807==    by 0x4C50E4: mono_object_new_ptrfree (object.c:3372)
==5807==    by 0x4C51F4: mono_object_new_alloc_specific (object.c:3345)
==5807==    by 0x4C5357: mono_object_new_specific (object.c:3336)
==5807== 
==5807== 15 errors in context 115 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==  Address 0x82378f8 is 96 bytes inside a block of size 98 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== 16 errors in context 116 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== 16 errors in context 117 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EB0: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== 16 errors in context 118 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== 16 errors in context 119 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015CF0: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x8843338 is 64 bytes inside a block of size 67 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x49C2B2: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==5807==    by 0x8C404F3: ???
==5807==    by 0x8C3F21B: ???
==5807== 
==5807== 21 errors in context 120 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807== 
==5807== 21 errors in context 121 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x6444250 is 8 bytes inside a block of size 13 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8E3715B: ???
==5807== 
==5807== 24 errors in context 122 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== 24 errors in context 123 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== 25 errors in context 124 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 25 errors in context 125 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 25 errors in context 126 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 33 errors in context 127 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517D84: GC_block_nearly_full (reclaim.c:259)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807== 
==5807== 35 errors in context 128 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D543F: inflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA17DCD: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA1808A: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0x18533633: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 36 errors in context 129 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0xC3D0544: (within /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xC3CF37C: deflate (in /usr/lib/libz.so.1.2.3.3)
==5807==    by 0xCA0AF3C: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B20B: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0B548: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA0F130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0x18592B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18536527: ???
==5807==    by 0x18535FFB: ???
==5807==    by 0x1853445B: ???
==5807==    by 0x185300F3: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 40 errors in context 130 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==  Address 0x63705e0 is 72 bytes inside a block of size 74 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== 40 errors in context 131 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807== 
==5807== 40 errors in context 132 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x814b088 is 24 bytes inside a block of size 26 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807== 
==5807== 46 errors in context 133 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==  Address 0x63798f0 is 16 bytes inside a block of size 17 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4008B75: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807== 
==5807== 47 errors in context 134 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CF4: GC_block_nearly_full3 (reclaim.c:205)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== 47 errors in context 135 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D645: GC_mark_from (mark.c:688)
==5807==    by 0x524C49: GC_finalize (finalize.c:639)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x182307BF: ???
==5807==    by 0x1823045F: ???
==5807== 
==5807== 47 errors in context 136 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015ECA: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== 48 errors in context 137 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CF4: GC_block_nearly_full3 (reclaim.c:205)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== 48 errors in context 138 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D33: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x6370470 is 40 bytes inside a block of size 43 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== 53 errors in context 139 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51896E: GC_reclaim_uninit4 (reclaim.c:590)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== 60 errors in context 140 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x400AB93: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5807==  Address 0x637b4a8 is 24 bytes inside a block of size 25 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4008B75: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==5807==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 65 errors in context 141 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51898D: GC_reclaim_uninit4 (reclaim.c:591)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== 67 errors in context 142 of 241:
==5807== Thread 11:
==5807== Invalid read of size 8
==5807==    at 0x51E97C: GC_push_all_eager (mark.c:1468)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==  Address 0x7feffe030 is on thread 1's stack
==5807== 
==5807== 70 errors in context 143 of 241:
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A08: GC_reclaim_uninit4 (reclaim.c:594)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 70 errors in context 144 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5189DF: GC_reclaim_uninit4 (reclaim.c:593)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== 71 errors in context 145 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5189B6: GC_reclaim_uninit4 (reclaim.c:592)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== 74 errors in context 146 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A31: GC_reclaim_uninit4 (reclaim.c:595)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8C463EB: ???
==5807==    by 0x8C4576F: ???
==5807==    by 0x8C447AB: ???
==5807==    by 0x8C44647: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 75 errors in context 147 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518AC0: GC_reclaim_uninit4 (reclaim.c:599)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 76 errors in context 148 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5807==    by 0x517E29: GC_block_nearly_full (reclaim.c:269)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== 76 errors in context 149 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A5F: GC_reclaim_uninit4 (reclaim.c:596)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 79 errors in context 150 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518A8D: GC_reclaim_uninit4 (reclaim.c:597)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 79 errors in context 151 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==  Address 0x64a40e0 is 120 bytes inside a block of size 123 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== 82 errors in context 152 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518AF3: GC_reclaim_uninit4 (reclaim.c:600)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 82 errors in context 153 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 82 errors in context 154 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 91 errors in context 155 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B59: GC_reclaim_uninit4 (reclaim.c:602)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 92 errors in context 156 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517E46: GC_block_nearly_full (reclaim.c:273)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== 93 errors in context 157 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518BBF: GC_reclaim_uninit4 (reclaim.c:604)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 95 errors in context 158 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B8C: GC_reclaim_uninit4 (reclaim.c:603)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8BF6F23: ???
==5807==    by 0x8BF74BB: ???
==5807==    by 0x8BF622F: ???
==5807==    by 0x8BEDDCF: ???
==5807== 
==5807== 96 errors in context 159 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518BF2: GC_reclaim_uninit4 (reclaim.c:605)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 99 errors in context 160 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518B26: GC_reclaim_uninit4 (reclaim.c:601)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 116 errors in context 161 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518C25: GC_reclaim_uninit4 (reclaim.c:606)
==5807==    by 0x518EC4: GC_reclaim_generic (reclaim.c:703)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4C9812: mono_string_new_size (object.c:3269)
==5807==    by 0x41AD737: ???
==5807==    by 0x879A50F: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 133 errors in context 162 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51904A: GC_reclaim_block (reclaim.c:769)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807== 
==5807== 193 errors in context 163 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5180D4: GC_reclaim_clear4 (reclaim.c:434)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 220 errors in context 164 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524BF9: GC_finalize (finalize.c:637)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807== 
==5807== 220 errors in context 165 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524A14: GC_finalize (finalize.c:586)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807== 
==5807== 240 errors in context 166 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518176: GC_reclaim_clear4 (reclaim.c:436)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 241 errors in context 167 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518120: GC_reclaim_clear4 (reclaim.c:435)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 245 errors in context 168 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517DF8: GC_block_nearly_full (reclaim.c:267)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== 288 errors in context 169 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51827E: GC_reclaim_clear4 (reclaim.c:439)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 309 errors in context 170 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51860A: GC_reclaim_clear4 (reclaim.c:449)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 310 errors in context 171 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5183A6: GC_reclaim_clear4 (reclaim.c:443)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 316 errors in context 172 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5181CC: GC_reclaim_clear4 (reclaim.c:437)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 324 errors in context 173 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518340: GC_reclaim_clear4 (reclaim.c:441)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 326 errors in context 174 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518222: GC_reclaim_clear4 (reclaim.c:438)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 348 errors in context 175 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5182DF: GC_reclaim_clear4 (reclaim.c:440)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 352 errors in context 176 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51853E: GC_reclaim_clear4 (reclaim.c:447)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 354 errors in context 177 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5185A4: GC_reclaim_clear4 (reclaim.c:448)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 356 errors in context 178 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518472: GC_reclaim_clear4 (reclaim.c:445)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 361 errors in context 179 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C1E: GC_block_nearly_full1 (reclaim.c:175)
==5807==    by 0x517DA4: GC_block_nearly_full (reclaim.c:261)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807== 
==5807== 363 errors in context 180 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51840C: GC_reclaim_clear4 (reclaim.c:444)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 368 errors in context 181 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5184D8: GC_reclaim_clear4 (reclaim.c:446)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 373 errors in context 182 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x518670: GC_reclaim_clear4 (reclaim.c:450)
==5807==    by 0x518E2B: GC_reclaim_generic (reclaim.c:685)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x51439C: GC_local_malloc (pthread_support.c:366)
==5807==    by 0x4CA206: mono_array_new_specific (object.c:3252)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x8C3E6B7: ???
==5807==    by 0x8BF6453: ???
==5807==    by 0x8BEDDCF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 513 errors in context 183 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x4007817: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== 513 errors in context 184 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x400780A: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== 525 errors in context 185 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x40087D1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 525 errors in context 186 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x40085B1: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==  Address 0x8914bd8 is 16 bytes inside a block of size 23 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x513216: mono_dl_build_path (mono-dl.c:426)
==5807==    by 0x48213A: mono_lookup_pinvoke_call (loader.c:1156)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x54448B: mono_method_to_ir (mini.c:6074)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807== 
==5807== 553 errors in context 187 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EFE: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== 553 errors in context 188 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015DA1: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x64a3f58 is 88 bytes inside a block of size 92 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807==    by 0x4EA8EE: mono_assembly_load_reference (assembly.c:848)
==5807== 
==5807== 594 errors in context 189 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x4011C2B: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==  Address 0x644ef90 is 80 bytes inside a block of size 84 alloc'd
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400DF00: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807== 
==5807== 600 errors in context 190 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517C8C: GC_block_nearly_full3 (reclaim.c:199)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F883: GC_malloc_atomic (malloc.c:262)
==5807== 
==5807== 600 errors in context 191 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015EE4: (within /lib/ld-2.7.so)
==5807==    by 0x400DEE6: (within /lib/ld-2.7.so)
==5807==    by 0x4008DA5: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 612 errors in context 192 of 241:
==5807== Invalid read of size 8
==5807==    at 0x4015D6E: (within /lib/ld-2.7.so)
==5807==    by 0x4011F31: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==  Address 0x644ee30 is 48 bytes inside a block of size 53 alloc'd
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x423338: load_aot_module (aot-runtime.c:571)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x417944: mono_main (driver.c:1480)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 660 errors in context 193 of 241:
==5807== Thread 6:
==5807== Invalid read of size 8
==5807==    at 0x415C0C2: ???
==5807==    by 0x1852D680: ???
==5807==    by 0x1823D4BB: ???
==5807==    by 0x1823B717: ???
==5807==    by 0x1790FAEB: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x4CEC54: start_wrapper (threads.c:627)
==5807==    by 0x4F7BB2: thread_start_routine (threads.c:279)
==5807==    by 0x515540: GC_start_routine (pthread_support.c:1382)
==5807==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==5807==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==5807==  Address 0x17e24520 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==5807== 
==5807== 696 errors in context 194 of 241:
==5807== Thread 1:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517CC0: GC_block_nearly_full3 (reclaim.c:202)
==5807==    by 0x517DD8: GC_block_nearly_full (reclaim.c:263)
==5807==    by 0x5190F8: GC_reclaim_block (reclaim.c:793)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807== 
==5807== 1564 errors in context 195 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524AAC: GC_finalize (finalize.c:600)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== 1564 errors in context 196 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x524992: GC_finalize (finalize.c:583)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== 2919 errors in context 197 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8DC: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x51F2E9: GC_alloc_large (malloc.c:53)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 5242 errors in context 198 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807==    by 0x526C34: mini_init (mini.c:13969)
==5807== 
==5807== 7091 errors in context 199 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517BC5: GC_block_empty (reclaim.c:109)
==5807==    by 0x5190B9: GC_reclaim_block (reclaim.c:784)
==5807==    by 0x51772A: GC_apply_to_all_blocks (headers.c:274)
==5807==    by 0x519435: GC_start_reclaim (reclaim.c:969)
==5807==    by 0x51AE36: GC_finish_collection (alloc.c:741)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807== 
==5807== 8732 errors in context 200 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x522452: GC_base (misc.c:416)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 8751 errors in context 201 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E7F0: GC_mark_and_push_stack (mark.c:1369)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== 8751 errors in context 202 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224CB: GC_base (misc.c:426)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 8761 errors in context 203 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5224AB: GC_base (misc.c:422)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 8763 errors in context 204 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x5223BA: GC_base (misc.c:399)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 8763 errors in context 205 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x522399: GC_base (misc.c:398)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 8763 errors in context 206 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x52236D: GC_base (misc.c:398)
==5807==    by 0x51E7D6: GC_mark_and_push_stack (mark.c:1367)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807== 
==5807== 9911 errors in context 207 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807==    by 0x526C34: mini_init (mini.c:13969)
==5807== 
==5807== 10550 errors in context 208 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D77D: GC_mark_from (mark.c:711)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x41AC23B: ???
==5807== 
==5807== 13230 errors in context 209 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C951: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 13573 errors in context 210 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C924: GC_is_black_listed (blacklst.c:254)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 13701 errors in context 211 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C8BA: GC_is_black_listed (blacklst.c:249)
==5807==    by 0x57FD42: GC_allochblk_nth (allchblk.c:645)
==5807==    by 0x57FA27: GC_allochblk (allchblk.c:561)
==5807==    by 0x521A7A: GC_generic_malloc_many (mallocx.c:483)
==5807==    by 0x514629: GC_local_gcj_malloc (pthread_support.c:446)
==5807==    by 0x41ABA67: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 17354 errors in context 212 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x5248AD: GC_finalize (finalize.c:560)
==5807==    by 0x51ADB4: GC_finish_collection (alloc.c:696)
==5807==    by 0x51A5AB: GC_try_to_collect_inner (alloc.c:393)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x521AFA: GC_generic_malloc_many (mallocx.c:513)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807== 
==5807== 18961 errors in context 213 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51873B: GC_reclaim_uninit (reclaim.c:480)
==5807==    by 0x518EE4: GC_reclaim_generic (reclaim.c:707)
==5807==    by 0x521968: GC_generic_malloc_many (mallocx.c:416)
==5807==    by 0x5144D0: GC_local_malloc_atomic (pthread_support.c:391)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BF0F47: ???
==5807==    by 0x8BF0963: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 25930 errors in context 214 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E8AC: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== 25930 errors in context 215 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E898: GC_mark_and_push_stack (mark.c:1391)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== 26622 errors in context 216 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x517ED2: GC_reclaim_clear (reclaim.c:329)
==5807==    by 0x518E4E: GC_reclaim_generic (reclaim.c:689)
==5807==    by 0x518FE5: GC_reclaim_small_nonempty_block (reclaim.c:737)
==5807==    by 0x5194AD: GC_continue_reclaim (reclaim.c:1002)
==5807==    by 0x51B7A9: GC_allocobj (alloc.c:1113)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807==    by 0x41B4243: ???
==5807== 
==5807== 44730 errors in context 217 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DF14: GC_mark_from (mark.c:801)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 61212 errors in context 218 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D3A6: GC_mark_from (mark.c:684)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x41AC23B: ???
==5807== 
==5807== 69409 errors in context 219 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E84F: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== 69422 errors in context 220 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E7B2: GC_mark_and_push_stack (mark.c:1364)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 97187 errors in context 221 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DFCD: GC_mark_from (mark.c:634)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 112396 errors in context 222 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D645: GC_mark_from (mark.c:688)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51F33B: GC_alloc_large (malloc.c:60)
==5807==    by 0x51F708: GC_generic_malloc (malloc.c:204)
==5807==    by 0x51F8D8: GC_malloc_atomic (malloc.c:270)
==5807==    by 0x5143F7: GC_local_malloc_atomic (pthread_support.c:376)
==5807==    by 0x4CA1CA: mono_array_new_specific (object.c:3269)
==5807==    by 0x41AC42B: ???
==5807==    by 0x8BD3E43: ???
==5807== 
==5807== 114069 errors in context 223 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E862: GC_mark_and_push_stack (mark.c:1390)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807== 
==5807== 173686 errors in context 224 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7EE: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 173686 errors in context 225 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51C7DA: GC_add_to_black_list_stack (blacklst.c:221)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 173711 errors in context 226 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516F1F: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 173750 errors in context 227 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x516EF4: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 173750 errors in context 228 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x516EC8: GC_find_header (headers.c:41)
==5807==    by 0x51C773: GC_add_to_black_list_stack (blacklst.c:211)
==5807==    by 0x51E83D: GC_mark_and_push_stack (mark.c:1386)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51C266: GC_push_current_stack (mark_rts.c:491)
==5807==    by 0x58130F: GC_with_callee_saves_pushed (mach_dep.c:476)
==5807==    by 0x581349: GC_generic_push_regs (mach_dep.c:487)
==5807==    by 0x51C367: GC_push_roots (mark_rts.c:631)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807== 
==5807== 219826 errors in context 229 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51C9F5: GC_number_stack_black_listed (blacklst.c:279)
==5807==    by 0x51CA75: total_stack_black_listed (blacklst.c:296)
==5807==    by 0x51C5DA: GC_promote_black_lists (blacklst.c:140)
==5807==    by 0x51A533: GC_try_to_collect_inner (alloc.c:362)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x51F516: GC_generic_malloc_inner (malloc.c:125)
==5807==    by 0x51F692: GC_generic_malloc (malloc.c:192)
==5807==    by 0x51F976: GC_malloc (malloc.c:297)
==5807==    by 0x51436F: GC_local_malloc (pthread_support.c:364)
==5807==    by 0x4E4D9B: mono_domain_create (domain.c:1140)
==5807== 
==5807== 243150 errors in context 230 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E747: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 243189 errors in context 231 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E71C: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 243189 errors in context 232 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51E6F0: GC_mark_and_push_stack (mark.c:1353)
==5807==    by 0x51E99F: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807== 
==5807== 414268 errors in context 233 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E995: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 458149 errors in context 234 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D8BD: GC_mark_from (mark.c:776)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 464277 errors in context 235 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D878: GC_mark_from (mark.c:769)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 468001 errors in context 236 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51D86B: GC_mark_from (mark.c:766)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 479209 errors in context 237 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D826: GC_mark_from (mark.c:759)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 1124107 errors in context 238 of 241:
==5807== Use of uninitialised value of size 8
==5807==    at 0x51D8CF: GC_mark_from (mark.c:784)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 1141442 errors in context 239 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DC40: GC_mark_from (mark.c:780)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
==5807== 
==5807== 1287972 errors in context 240 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51E98B: GC_push_all_eager (mark.c:1469)
==5807==    by 0x51E9ED: GC_push_all_stack (mark.c:1521)
==5807==    by 0x519839: pthread_push_all_stacks (pthread_stop_world.c:278)
==5807==    by 0x5198B3: GC_push_all_stacks (pthread_stop_world.c:309)
==5807==    by 0x580ED5: GC_default_push_other_roots (os_dep.c:2078)
==5807==    by 0x51C37C: GC_push_roots (mark_rts.c:646)
==5807==    by 0x51CEDC: GC_mark_some (mark.c:326)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x522951: GC_init_inner (misc.c:782)
==5807==    by 0x522567: GC_init (misc.c:492)
==5807==    by 0x480643: mono_gc_base_init (boehm-gc.c:94)
==5807== 
==5807== 1504500 errors in context 241 of 241:
==5807== Conditional jump or move depends on uninitialised value(s)
==5807==    at 0x51DB89: GC_mark_from (mark.c:791)
==5807==    by 0x51CF45: GC_mark_some (mark.c:361)
==5807==    by 0x51A9A5: GC_stopped_mark (alloc.c:543)
==5807==    by 0x51A582: GC_try_to_collect_inner (alloc.c:382)
==5807==    by 0x51B5A4: GC_collect_or_expand (alloc.c:1045)
==5807==    by 0x51B822: GC_allocobj (alloc.c:1125)
==5807==    by 0x51F54A: GC_generic_malloc_inner (malloc.c:136)
==5807==    by 0x523D67: GC_general_register_disappearing_link (finalize.c:203)
==5807==    by 0x4ABEFC: mono_monitor_try_enter_internal (monitor.c:383)
==5807==    by 0x4AC01F: mono_monitor_enter (monitor.c:600)
==5807==    by 0x41ABBC7: ???
==5807==    by 0x879C147: ???
--5807-- 
--5807-- supp:    789 dl-hack3-1
==5807== 
==5807== IN SUMMARY: 10000000 errors from 241 contexts (suppressed: 789 from 1)
==5807== 
==5807== malloc/free: in use at exit: 822,147,758 bytes in 1,660,022 blocks.
==5807== malloc/free: 66,383,044 allocs, 64,723,022 frees, 3,963,070,472 bytes allocated.
==5807== 
==5807== searching for pointers to 1,660,022 not-freed blocks.
==5807== checked 639,630,888 bytes.
==5807== 
==5807== 
==5807== 1 bytes in 1 blocks are still reachable in loss record 1 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F33726: _XlcDefaultMapModifiers (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F33794: XSetLocaleModifiers (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C743: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807== 
==5807== 
==5807== 4 bytes in 1 blocks are still reachable in loss record 2 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xCC2F194: pixman_image_create_bits (in /usr/lib/libpixman-1.so.0.10.0)
==5807==    by 0xAE605A7: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D2C1: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D395: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE707CA: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE716A5: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE60C38: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B987: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EE21: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6E195: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EB1D: (within /usr/lib/libcairo.so.2.17.3)
==5807== 
==5807== 
==5807== 6 bytes in 1 blocks are still reachable in loss record 3 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xBD1870C: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 6 bytes in 1 blocks are still reachable in loss record 4 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xBD186EF: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 6 bytes in 1 blocks are still reachable in loss record 5 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2D07F: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 8 bytes in 1 blocks are still reachable in loss record 6 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB908354: _XiGetExtensionVersion (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0xB90A6D2: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0xB908FDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 8 bytes in 1 blocks are still reachable in loss record 7 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1CEDE: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 8 bytes in 1 blocks are indirectly lost in loss record 8 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE588A5: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE58906: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE589B4: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE58B3B: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9833738: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982386B: gdk_window_begin_paint_region (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914BD12: gtk_main_do_event (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9823CAA: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98242C6: gdk_window_process_all_updates (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x90C1DA0: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x980B89D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 12 bytes in 1 blocks are still reachable in loss record 9 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2CC32: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 10 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F1F1F2: _XCBInitDisplayLock (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F08AB4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 11 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xC7EC4AD: (within /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EBA0C: (within /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EA65E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 12 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xED8AABD: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED882B4: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x10F7C30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==5807==    by 0x16CDC4D7: ???
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 13 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xED8A9FD: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED882A8: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x10F7C30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==5807==    by 0x16CDC4D7: ???
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 14 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xED8829C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x10F7C30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==5807==    by 0x16CDC4D7: ???
==5807==    by 0x16CD27E2: ???
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 15 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2D43C: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1C9CF: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 16 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F31EFD: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F275EE: _XlcOpenConverter (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2D460: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1C9CF: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 16 bytes in 1 blocks are still reachable in loss record 17 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0BD62C: FcBlanksCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D3115: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 21 bytes in 1 blocks are still reachable in loss record 18 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F08C95: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 19 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xED89D29: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8898E: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED87F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED882C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 20 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F19503: XAddConnectionWatch (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C487: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 21 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB2F5B8D: XextCreateExtension (in /usr/lib/libXext.so.6.4.0)
==5807==    by 0xB90A735: XInput_find_display (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0xB908FBA: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 22 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xED88290: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x10F7C30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==5807==    by 0x16CDC4D7: ???
==5807==    by 0x16CD27E2: ???
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 23 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F29FB3: _XlcResolveLocaleName (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF40: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 24 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1CF24: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 25 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2C446: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 26 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F330D5: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807== 
==5807== 
==5807== 24 bytes in 1 blocks are still reachable in loss record 27 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE99AA6: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 28 bytes in 1 blocks are still reachable in loss record 28 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xED88936: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED87F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED882C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x10F7C30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==5807== 
==5807== 
==5807== 29 bytes in 3 blocks are still reachable in loss record 29 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26C0C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 30 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xA5E2A97: XFixesFindDisplay (in /usr/lib/libXfixes.so.3.1.0)
==5807==    by 0xA5E2CE8: XFixesQueryExtension (in /usr/lib/libXfixes.so.3.1.0)
==5807==    by 0x982C5EE: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 31 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xA3DDC77: XDamageFindDisplay (in /usr/lib/libXdamage.so.1.1.0)
==5807==    by 0xA3DE2F8: XDamageQueryExtension (in /usr/lib/libXdamage.so.1.1.0)
==5807==    by 0x982C632: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 32 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xA1DBE2C: XCompositeFindDisplay (in /usr/lib/libXcomposite.so.1.0.0)
==5807==    by 0xA1DC878: XCompositeQueryExtension (in /usr/lib/libXcomposite.so.1.0.0)
==5807==    by 0x982C610: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 33 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1C99A: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E18D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 34 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xED87C02: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8899B: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED87F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED882C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED8866C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED74FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED7507C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xED75862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0x16CEE3FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0x16CEEA03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==5807==    by 0xED790DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 35 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB4FFACE: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==5807==    by 0xB500A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==5807==    by 0xBD18666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 32 bytes in 4 blocks are still reachable in loss record 36 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2B743: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 32 bytes in 1 blocks are still reachable in loss record 37 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xC7EB72C: (within /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EA44E: (within /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EBE59: xcb_wait_for_reply (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EC25B: xcb_get_extension_data (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EAB8E: xcb_prefetch_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7EAC0B: xcb_get_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0x9F08FE3: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 34 bytes in 2 blocks are still reachable in loss record 38 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18565E92: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1859320B: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x17910B03: ???
==5807== 
==5807== 
==5807== 40 bytes in 1 blocks are still reachable in loss record 39 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1841D: _XPollfdCacheInit (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F08AC4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 40 bytes in 1 blocks are still reachable in loss record 40 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F28256: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 41 bytes in 1 blocks are still reachable in loss record 41 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xD58CE06: XauFileName (in /usr/lib/libXau.so.6.0.0)
==5807==    by 0xD58D042: XauGetBestAuthByAddr (in /usr/lib/libXau.so.6.0.0)
==5807==    by 0xC7ECE93: (within /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7ECAD1: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807== 
==5807== 
==5807== 48 bytes in 2 blocks are still reachable in loss record 42 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF779752: (within /usr/lib/libdbus-1.so.3.4.0)
==5807==    by 0xF773B3A: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5807==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xE3B7C17: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0xE3B7ABB: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5807== 
==5807== 
==5807== 48 bytes in 1 blocks are still reachable in loss record 43 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F1D1CE: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 48 bytes in 1 blocks are still reachable in loss record 44 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F67729: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50656E4: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5065BCA: g_main_context_iteration (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914BD5C: gtk_main_iteration_do (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 48 bytes in 2 blocks are still reachable in loss record 45 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18565E27: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1859320B: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x17910B03: ???
==5807== 
==5807== 
==5807== 48 bytes in 3 blocks are still reachable in loss record 46 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CC1E5: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CD2A3: FcPatternGetString (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF263AA: pango_fc_font_description_from_pattern (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF25CBE: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xAA160DB: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA16F65: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x9A90B4A: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF27C3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 48 bytes in 3 blocks are still reachable in loss record 47 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C7B9C: FcFontSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1432: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 52 bytes in 1 blocks are still reachable in loss record 48 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1F42D: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 96 bytes in 3 blocks are still reachable in loss record 49 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x54F554A: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x42334C: load_aot_module (aot-runtime.c:573)
==5807==    by 0x4E711E: mono_assembly_invoke_load_hook (assembly.c:923)
==5807==    by 0x4E8D26: mono_assembly_load_from_full (assembly.c:1482)
==5807==    by 0x4E90F0: mono_assembly_open_full (assembly.c:1298)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807==    by 0x527394: mini_init (mini.c:14018)
==5807== 
==5807== 
==5807== 292 (52 direct, 240 indirect) bytes in 1 blocks are definitely lost in loss record 50 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C7D240: (within /lib/libc-2.7.so)
==5807==    by 0x5C7DAFE: __nss_database_lookup (in /lib/libc-2.7.so)
==5807==    by 0x69AD42F: ???
==5807==    by 0x69AE968: ???
==5807==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5807==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807== 
==5807== 
==5807== 56 bytes in 2 blocks are still reachable in loss record 51 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x1023D199: (within /lib/libresolv-2.7.so)
==5807==    by 0x1023BAB7: __libc_res_nquery (in /lib/libresolv-2.7.so)
==5807==    by 0x1023BD66: (within /lib/libresolv-2.7.so)
==5807==    by 0x1023C005: __libc_res_nsearch (in /lib/libresolv-2.7.so)
==5807==    by 0x17B21980: ???
==5807==    by 0x17B21B90: ???
==5807==    by 0x5C83C22: gethostbyname_r (in /lib/libc-2.7.so)
==5807==    by 0x5C83453: gethostbyname (in /lib/libc-2.7.so)
==5807==    by 0x1769D724: NetTcpAddr(char*, AddrType, sockaddr_in*, Error*) (in /usr/mono-2.0/lib/libp4api.so)
==5807==    by 0x1769E174: NetTcpEndPoint::Connect(Error*) (in /usr/mono-2.0/lib/libp4api.so)
==5807==    by 0x1769A542: Rpc::Connect(Error*) (in /usr/mono-2.0/lib/libp4api.so)
==5807== 
==5807== 
==5807== 56 bytes in 1 blocks are still reachable in loss record 52 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F2A9A9: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2B23B: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 62 bytes in 8 blocks are still reachable in loss record 53 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF28E20F: xmlStrndup (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21E626: xmlNewCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21E7B0: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21EC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF247EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF226194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0x13A55C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==5807==    by 0x13818D7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3DAF: ???
==5807== 
==5807== 
==5807== 64 bytes in 1 blocks are still reachable in loss record 54 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1FEDF: _XReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F148A9: XSync (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9835B8D: gdk_flush (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914BF18: gtk_main (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x19C94663: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 
==5807== 64 bytes in 2 blocks are still reachable in loss record 55 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB9094CA: XOpenDevice (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0x98522BC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 64 bytes in 2 blocks are still reachable in loss record 56 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xC1569DD: FT_New_Memory (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC156CE0: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xAE99ACB: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 64 bytes in 1 blocks are still reachable in loss record 57 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F754C1: XkbAllocServerMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F6661A: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 64 bytes in 2 blocks are still reachable in loss record 58 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18565216: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x185659DE: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18593018: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807== 
==5807== 
==5807== 64 bytes in 1 blocks are still reachable in loss record 59 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F0DD79: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26E08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26A4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 64 bytes in 2 blocks are still reachable in loss record 60 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C8CFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C8DFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CDF09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE01C: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 72 bytes in 1 blocks are still reachable in loss record 61 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F08B66: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 72 bytes in 1 blocks are still reachable in loss record 62 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F6770E: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50656E4: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5065BCA: g_main_context_iteration (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914BD5C: gtk_main_iteration_do (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 72 bytes in 3 blocks are still reachable in loss record 63 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D102A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15B6: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 72 bytes in 3 blocks are still reachable in loss record 64 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D108A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15D2: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 80 bytes in 3 blocks are still reachable in loss record 65 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F2B676: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 80 bytes in 5 blocks are indirectly lost in loss record 66 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C7CE7F: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x69AD44A: ???
==5807==    by 0x69AE968: ???
==5807==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5807==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807==    by 0x4E52FE: mono_init_internal (domain.c:1277)
==5807== 
==5807== 
==5807== 85 bytes in 10 blocks are still reachable in loss record 67 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F03323: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F6BA56: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 96 bytes in 1 blocks are still reachable in loss record 68 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9850AF3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 96 bytes in 3 blocks are still reachable in loss record 69 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CB679: FcMatrixCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D10AF: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15D2: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1C48: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807== 
==5807== 
==5807== 102 bytes in 15 blocks are still reachable in loss record 70 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x98507E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 104 bytes in 1 blocks are still reachable in loss record 71 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF28B4EC: xmlNewRMutex (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF2D91C4: (within /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF2D93E1: xmlDictCreate (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF22220B: xmlInitParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF22227D: xmlNewParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF2261A5: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0x13A55C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==5807==    by 0x13818D7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3DAF: ???
==5807== 
==5807== 
==5807== 104 bytes in 3 blocks are still reachable in loss record 72 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F66665: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 104 bytes in 3 blocks are still reachable in loss record 73 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F27CDE: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 104 bytes in 21 blocks are indirectly lost in loss record 74 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x921D4E9: gtk_tree_path_append_index (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x921D74A: gtk_tree_path_new_from_string (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x16CD60D7: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x16CC9CB7: ???
==5807==    by 0x16CC8C83: ???
==5807== 
==5807== 
==5807== 112 bytes in 1 blocks are still reachable in loss record 75 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F08E7D: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 112 bytes in 1 blocks are still reachable in loss record 76 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F1F3C6: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 112 bytes in 2 blocks are still reachable in loss record 77 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18564C8A: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x185659CB: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18593018: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807== 
==5807== 
==5807== 112 bytes in 7 blocks are still reachable in loss record 78 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x40079C3: (within /lib/ld-2.7.so)
==5807==    by 0x40089D7: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807== 
==5807== 
==5807== 120 bytes in 1 blocks are still reachable in loss record 79 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF773AEC: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5807==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xE3B7C17: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0xE3B7ABB: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 
==5807== 128 bytes in 2 blocks are still reachable in loss record 80 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x401346B: (within /lib/ld-2.7.so)
==5807==    by 0x4013D7B: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA3164: __libc_dlclose (in /lib/libc-2.7.so)
==5807==    by 0x5CA4B57: (within /lib/libc-2.7.so)
==5807==    by 0x5CA4878: __libc_freeres (in /lib/libc-2.7.so)
==5807==    by 0x4A1F31C: _vgnU_freeres (vg_preloaded.c:60)
==5807== 
==5807== 
==5807== 128 bytes in 1 blocks are still reachable in loss record 81 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F08D92: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 128 bytes in 1 blocks are still reachable in loss record 82 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE97BAB: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9872C: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9504F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 128 bytes in 4 blocks are possibly lost in loss record 83 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CDFCD: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 136 bytes in 1 blocks are still reachable in loss record 84 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C1621: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7E9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 144 bytes in 6 blocks are still reachable in loss record 85 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CF40C: FcStrSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1644: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7E9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 152 bytes in 1 blocks are still reachable in loss record 86 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F6BB7F: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 152 bytes in 1 blocks are indirectly lost in loss record 87 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE72711: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5E91D: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE57EEE: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x980C197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 160 bytes in 5 blocks are still reachable in loss record 88 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB2F5BDB: XextAddDisplay (in /usr/lib/libXext.so.6.4.0)
==5807==    by 0xB2F0AC8: XShapeQueryExtension (in /usr/lib/libXext.so.6.4.0)
==5807==    by 0x982C65C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 160 bytes in 5 blocks are indirectly lost in loss record 89 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C6B0D9: tsearch (in /lib/libc-2.7.so)
==5807==    by 0x5C7CE29: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x69AD44A: ???
==5807==    by 0x69AE968: ???
==5807==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x4EB99D: mono_config_for_assembly (mono-config.c:461)
==5807==    by 0x4E9134: mono_assembly_open_full (assembly.c:1304)
==5807==    by 0x4E91F1: load_in_path (assembly.c:399)
==5807==    by 0x4E92DB: mono_assembly_load_corlib (assembly.c:2195)
==5807== 
==5807== 
==5807== 168 bytes in 1 blocks are still reachable in loss record 90 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F08D07: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 168 bytes in 1 blocks are still reachable in loss record 91 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE98796: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9504F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9182C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 168 bytes in 7 blocks are still reachable in loss record 92 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0F19: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15F1: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1A31: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D29AC: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 168 bytes in 1 blocks are still reachable in loss record 93 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2C495: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 168 bytes in 7 blocks are still reachable in loss record 94 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0EC4: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15E1: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1A31: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D29AC: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 176 bytes in 2 blocks are still reachable in loss record 95 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x1856510B: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x185659F4: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18593018: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807== 
==5807== 
==5807== 176 bytes in 1 blocks are still reachable in loss record 96 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2C472: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 176 bytes in 2 blocks are still reachable in loss record 97 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1CD19: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 182 bytes in 3 blocks are still reachable in loss record 98 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x9F27D15: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 192 bytes in 1 blocks are still reachable in loss record 99 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x1C4C2B21: apr_allocator_create (in /usr/lib/libapr-1.so.0.2.11)
==5807==    by 0x1C4C329E: apr_pool_initialize (in /usr/lib/libapr-1.so.0.2.11)
==5807==    by 0x1C4C40E4: apr_initialize (in /usr/lib/libapr-1.so.0.2.11)
==5807==    by 0x1B7E1903: ???
==5807==    by 0x1B7E0F6B: ???
==5807==    by 0x1B7E0A9F: ???
==5807==    by 0x1B7E08D3: ???
==5807==    by 0x1B7DE757: ???
==5807==    by 0x1B7DC5EB: ???
==5807==    by 0x1B7DC0EB: ???
==5807==    by 0x1AC90007: ???
==5807== 
==5807== 
==5807== 192 bytes in 6 blocks are still reachable in loss record 100 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C05A9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C09D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CB02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x14BFC3D7: ???
==5807== 
==5807== 
==5807== 200 bytes in 1 blocks are still reachable in loss record 101 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB90A6B4: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0xB908FDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==5807==    by 0x9851F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 208 bytes in 1 blocks are still reachable in loss record 102 of 238
==5807==    at 0x4C23809: operator new(unsigned long) (vg_replace_malloc.c:230)
==5807==    by 0x1768CFE7: CSharp_new_ClientUser (p4api_wrap.cc:2451)
==5807==    by 0x16CE166B: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x1AC84CFF: ???
==5807==    by 0x18233827: ???
==5807==    by 0x182332E3: ???
==5807==    by 0x1B7E204B: ???
==5807==    by 0x1B7E0A5D: ???
==5807== 
==5807== 
==5807== 208 bytes in 13 blocks are still reachable in loss record 103 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1CC80: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 208 bytes in 1 blocks are definitely lost in loss record 104 of 238
==5807==    at 0x4C23809: operator new(unsigned long) (vg_replace_malloc.c:230)
==5807==    by 0x1768CFE7: CSharp_new_ClientUser (p4api_wrap.cc:2451)
==5807==    by 0x16CE166B: ???
==5807==    by 0xE3B835B: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x16CDFB27: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807== 
==5807== 
==5807== 240 bytes in 5 blocks are still reachable in loss record 105 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4007823: (within /lib/ld-2.7.so)
==5807==    by 0x40085CE: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0xAC4A975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==5807==    by 0x9CA70DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 240 bytes in 4 blocks are indirectly lost in loss record 106 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x47F644: mono_mb_new_base (method-builder.c:61)
==5807==    by 0x47FA27: mono_mb_new (method-builder.c:85)
==5807==    by 0x479977: mono_marshal_get_managed_wrapper (marshal.c:8970)
==5807==    by 0x479DA2: mono_delegate_to_ftnptr (marshal.c:688)
==5807==    by 0x8E3C0B7: ???
==5807==    by 0x14BFD433: ???
==5807==    by 0x14BFD307: ???
==5807==    by 0x8BCB292: ???
==5807==    by 0x47D5A3: run_finalize (gc.c:149)
==5807==    by 0x52507B: GC_invoke_finalizers (finalize.c:787)
==5807== 
==5807== 
==5807== 256 bytes in 1 blocks are still reachable in loss record 107 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F75877: XkbAllocClientMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66BAB: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 256 bytes in 2 blocks are still reachable in loss record 108 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F03245: XAddExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18620: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 256 bytes in 1 blocks are still reachable in loss record 109 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xB0BD5B5: FcBlanksAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D3092: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 256 bytes in 1 blocks are still reachable in loss record 110 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C7B7F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D28C6: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 288 (256 direct, 32 indirect) bytes in 1 blocks are definitely lost in loss record 111 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CD81B: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE105: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE219: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2C08: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 304 bytes in 19 blocks are still reachable in loss record 112 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5133F3: mono_dl_open (mono-dl.c:298)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807==    by 0x54D3EF: mono_method_to_ir (mini.c:5741)
==5807==    by 0x559E0C: inline_method (mini.c:4018)
==5807==    by 0x554BEA: mono_method_to_ir (mini.c:7109)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807== 
==5807== 
==5807== 320 bytes in 8 blocks are still reachable in loss record 113 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF21E640: xmlNewCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21E754: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21EC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF247EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF226194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0x13A55C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==5807==    by 0x13818D7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3DAF: ???
==5807==    by 0xE3B9F43: ???
==5807== 
==5807== 
==5807== 336 bytes in 14 blocks are still reachable in loss record 114 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D10FA: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D15A8: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1800: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2A94: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 350 bytes in 6 blocks are still reachable in loss record 115 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C0FDD1: strdup (in /lib/libc-2.7.so)
==5807==    by 0xAE99CEE: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE99F99: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 362 bytes in 38 blocks are still reachable in loss record 116 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F27DE8: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 391 bytes in 16 blocks are indirectly lost in loss record 117 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x47F8B1: mono_mb_create_method (method-builder.c:195)
==5807==    by 0x479AAC: mono_marshal_get_managed_wrapper (marshal.c:9026)
==5807==    by 0x479DA2: mono_delegate_to_ftnptr (marshal.c:688)
==5807==    by 0x8E3C0B7: ???
==5807==    by 0x16CE647B: ???
==5807==    by 0x16CDE07D: ???
==5807==    by 0x16CC9CB7: ???
==5807==    by 0x16CC8C83: ???
==5807==    by 0x16852247: ???
==5807==    by 0x7FEFFA7FF: ???
==5807== 
==5807== 
==5807== 400 bytes in 1 blocks are still reachable in loss record 118 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF21E70A: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF21EC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF247EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0xF226194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==5807==    by 0x13A55C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==5807==    by 0x13818D7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF8D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3DAF: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807== 
==5807== 
==5807== 408 bytes in 1 blocks are still reachable in loss record 119 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4011CF4: (within /lib/ld-2.7.so)
==5807==    by 0x400C9BD: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D114: (within /lib/libc-2.7.so)
==5807==    by 0x5C83A1A: gethostbyname2_r (in /lib/libc-2.7.so)
==5807== 
==5807== 
==5807== 408 bytes in 51 blocks are still reachable in loss record 120 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1D0AF: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 432 bytes in 27 blocks are still reachable in loss record 121 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9850EA7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x985068F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 456 bytes in 1 blocks are still reachable in loss record 122 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xBD18601: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 464 bytes in 27 blocks are still reachable in loss record 123 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x985072F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 472 bytes in 1 blocks are indirectly lost in loss record 124 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE95065: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982386B: gdk_window_begin_paint_region (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914BD12: gtk_main_do_event (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9823CAA: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98242C6: gdk_window_process_all_updates (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x90C1DA0: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x980B89D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50656E4: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 480 bytes in 12 blocks are still reachable in loss record 125 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE97AD8: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95BA4: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D1B5: cairo_surface_finish (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D234: cairo_surface_destroy (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE7090A: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE716A5: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE60C38: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B987: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EE21: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6E195: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EB1D: (within /usr/lib/libcairo.so.2.17.3)
==5807== 
==5807== 
==5807== 481 bytes in 16 blocks are still reachable in loss record 126 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4005F47: (within /lib/ld-2.7.so)
==5807==    by 0x400885F: (within /lib/ld-2.7.so)
==5807==    by 0x4012048: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807== 
==5807== 
==5807== 492 bytes in 41 blocks are still reachable in loss record 127 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F289D1: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 496 bytes in 1 blocks are still reachable in loss record 128 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F69CD3: XkbGetNames (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F3B2: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50656E4: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x5065BCA: g_main_context_iteration (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914BD5C: gtk_main_iteration_do (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 497 bytes in 1 blocks are still reachable in loss record 129 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9EFECF4: XGetWindowProperty (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x98356EB: gdk_x11_screen_supports_net_wm_hint (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x984BC9A: gdk_window_focus (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x16CB67AB: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==5807== 
==5807== 
==5807== 512 bytes in 1 blocks are possibly lost in loss record 130 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xB0CD792: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE105: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x14BFC3D7: ???
==5807== 
==5807== 
==5807== 512 bytes in 1 blocks are still reachable in loss record 131 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F03684: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F03C42: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x98425FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9843BE5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C4D0: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 520 bytes in 1 blocks are still reachable in loss record 132 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18577E3F: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x185693DE: GdiplusStartup (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853168F: ???
==5807==    by 0x41AC06E: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x18530ECF: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 
==5807== 528 bytes in 63 blocks are indirectly lost in loss record 133 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x921D4E9: gtk_tree_path_append_index (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x922C0F8: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x1B7EE887: ???
==5807==    by 0x1B7EE637: ???
==5807==    by 0x20886259: ???
==5807==    by 0x208860FB: ???
==5807==    by 0x20885F47: ???
==5807==    by 0x1B7F79E2: ???
==5807==    by 0x1B7F5C67: ???
==5807==    by 0x1AC8FFD4: ???
==5807== 
==5807== 
==5807== 560 bytes in 7 blocks are still reachable in loss record 134 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2A967: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2B23B: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 560 bytes in 7 blocks are still reachable in loss record 135 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE9415F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B28B: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CF79: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9A8F907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB9311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB975A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9814F29: gdk_draw_layout_with_colors (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 584 bytes in 4 blocks are still reachable in loss record 136 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CFD0E: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D025D: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2DD2: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7EBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7F95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 600 bytes in 15 blocks are still reachable in loss record 137 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE5A78F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6827D: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C137: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5C879: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CED6: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9A8F907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 606 bytes in 41 blocks are still reachable in loss record 138 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F28BD9: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 608 bytes in 4 blocks are still reachable in loss record 139 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE71104: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6ADC3: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B20F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CF79: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9A8F907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB9311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB975A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 608 bytes in 38 blocks are still reachable in loss record 140 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F27E33: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28B7A: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 620 bytes in 1 blocks are still reachable in loss record 141 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xC7EA7C8: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 624 bytes in 6 blocks are still reachable in loss record 142 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE9A481: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A608: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 672 bytes in 42 blocks are still reachable in loss record 143 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CBEB6: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CBF62: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CC1D6: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE3A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE4F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF280EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 672 bytes in 3 blocks are still reachable in loss record 144 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xCC2EACF: (within /usr/lib/libpixman-1.so.0.10.0)
==5807==    by 0xCC2F08B: pixman_image_create_bits (in /usr/lib/libpixman-1.so.0.10.0)
==5807==    by 0xAE605A7: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x18593075: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807== 
==5807== 
==5807== 677 bytes in 51 blocks are still reachable in loss record 145 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26F7B: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 680 bytes in 17 blocks are still reachable in loss record 146 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE5F09A: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5A7A2: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6827D: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C137: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5C879: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CED6: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 800 bytes in 25 blocks are still reachable in loss record 147 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CDFCD: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x14BFC3D7: ???
==5807==    by 0x14BFACAA: ???
==5807== 
==5807== 
==5807== 816 bytes in 6 blocks are still reachable in loss record 148 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F01EB5: XCreateImage (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983D0E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98134F7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98137AD: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9833E51: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98258AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x14BFB8D7: ???
==5807==    by 0x14BFB7FF: ???
==5807==    by 0x14BFAE7B: ???
==5807==    by 0x14BFACAA: ???
==5807==    by 0x8FFF1DF: ???
==5807== 
==5807== 
==5807== 816 bytes in 34 blocks are still reachable in loss record 149 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0E79: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1601: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D16D9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1800: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2A94: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 832 bytes in 1 blocks are still reachable in loss record 150 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18577E21: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x185693DE: GdiplusStartup (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853168F: ???
==5807==    by 0x41AC06E: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x18530ECF: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807== 
==5807== 
==5807== 832 bytes in 52 blocks are still reachable in loss record 151 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26E5E: _XlcAddCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26C92: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 840 bytes in 15 blocks are still reachable in loss record 152 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xF77B9EA: (within /usr/lib/libdbus-1.so.3.4.0)
==5807==    by 0xF773B0C: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==5807==    by 0xED6DE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==5807==    by 0xE3B7C17: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x55933A: mono_jit_compile_method (mini.c:12980)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0xE3B7ABB: ???
==5807==    by 0x4C8DC9: mono_runtime_class_init_full (object.c:336)
==5807==    by 0x559B1C: mono_jit_runtime_invoke (mini.c:13170)
==5807== 
==5807== 
==5807== 864 bytes in 27 blocks are still reachable in loss record 153 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x985070B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9850C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x982C506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 864 bytes in 27 blocks are still reachable in loss record 154 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE97FCB: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95086: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x983371A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980C18C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0xE1A4BA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x918467D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9184BB3: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x915187E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 888 bytes in 3 blocks are still reachable in loss record 155 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE602D2: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE605B9: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x18593075: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807== 
==5807== 
==5807== 920 bytes in 16 blocks are still reachable in loss record 156 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0BE53C: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0BEB32: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0BEC48: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0BE8BD: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0BE999: FcDirCacheLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C4AC2: FcDirCacheRead (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C11E8: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 952 bytes in 2 blocks are still reachable in loss record 157 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F08EF1: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 1,000 bytes in 1 blocks are still reachable in loss record 158 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F757A9: XkbAllocClientMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F665D1: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,008 bytes in 1 blocks are still reachable in loss record 159 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F281F5: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,068 bytes in 52 blocks are still reachable in loss record 160 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26F1C: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,092 bytes in 35 blocks are still reachable in loss record 161 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CFE6F: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D00F5: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D0248: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1161: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1201: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 1,216 bytes in 38 blocks are indirectly lost in loss record 162 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C03CB: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C05D4: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C09D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CB02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 1,280 bytes in 10 blocks are still reachable in loss record 163 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F032FB: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F6BA56: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F090DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807== 
==5807== 
==5807== 1,308 bytes in 24 blocks are still reachable in loss record 164 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F665F5: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 1,344 bytes in 1 blocks are still reachable in loss record 165 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CBDCA: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CC207: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CC24D: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE3A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE4F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF280EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 1,416 bytes in 1 blocks are still reachable in loss record 166 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB500210: XRenderQueryFormats (in /usr/lib/libXrender.so.1.3.0)
==5807==    by 0xB5009CC: XRenderQueryVersion (in /usr/lib/libXrender.so.1.3.0)
==5807==    by 0xBD189E1: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 1,536 bytes in 45 blocks are still reachable in loss record 167 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F03713: _XUpdateAtomCache (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F03CF8: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x98425FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9835724: gdk_x11_screen_supports_net_wm_hint (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x984BC9A: gdk_window_focus (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x16CB67AB: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 1,584 bytes in 6 blocks are still reachable in loss record 168 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE99F7E: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 1,584 bytes in 66 blocks are still reachable in loss record 169 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1D023: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 1,624 bytes in 7 blocks are definitely lost in loss record 170 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE71485: cairo_pattern_create_linear (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x207FABA3: ???
==5807==    by 0x185426FD: ???
==5807==    by 0x18544477: ???
==5807==    by 0x14BFACAA: ???
==5807==    by 0x8FFF1DF: ???
==5807==    by 0x863FFFF: ???
==5807== 
==5807== 
==5807== 1,640 (984 direct, 656 indirect) bytes in 1 blocks are definitely lost in loss record 171 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE57EB4: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x980C197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0xE1A3285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0xE1A34F7: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x907D40E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x915187E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA24BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA25F7E: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x9258E54: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,640 bytes in 41 blocks are still reachable in loss record 172 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F2897C: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28D2E: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F28432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,652 bytes in 43 blocks are still reachable in loss record 173 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==5807==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x49509B: mono_guid_to_string (metadata.c:4993)
==5807==    by 0x4D3975: do_mono_image_load (image.c:394)
==5807==    by 0x4D3F28: do_mono_image_open (image.c:944)
==5807==    by 0x4D40D4: mono_image_open_full (image.c:1200)
==5807==    by 0x4E908F: mono_assembly_open_full (assembly.c:1279)
==5807==    by 0x4EA6BE: mono_assembly_load_full_nosearch (assembly.c:2157)
==5807==    by 0x4EA787: mono_assembly_load_full (assembly.c:2295)
==5807== 
==5807== 
==5807== 1,720 bytes in 5 blocks are still reachable in loss record 174 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xAE5F0C1: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE99ABA: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE99F1F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9A5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DF87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,728 bytes in 27 blocks are still reachable in loss record 175 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F274F0: _XlcSetConverter (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F31120: _XlcAddUtf8LocaleConverters (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C84B: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,952 bytes in 29 blocks are possibly lost in loss record 176 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAA289EF: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA28B3E: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA2C705: g_type_register_fundamental (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1455F: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA2B7D4: g_type_init_with_debug_flags (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x980BBBE: gdk_pre_parse_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x914C30E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 2,048 bytes in 1 blocks are still reachable in loss record 177 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F66977: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 2,048 bytes in 1 blocks are still reachable in loss record 178 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F27F9C: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CF88: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 2,048 bytes in 2 blocks are still reachable in loss record 179 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x18592FE1: (within /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x18578895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==5807==    by 0x1853222B: ???
==5807==    by 0x18530FB3: ???
==5807==    by 0x185309DB: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x17910B03: ???
==5807==    by 0x17910D13: ???
==5807== 
==5807== 
==5807== 2,048 bytes in 1 blocks are still reachable in loss record 180 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xB0C7B2F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C119A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1201: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C1455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C7FAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C806C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0x9A9111F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF28188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 2,064 bytes in 1 blocks are still reachable in loss record 181 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE67996: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE67E3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DFA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A8E157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB00AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 2,208 bytes in 1 blocks are still reachable in loss record 182 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4011E14: (within /lib/ld-2.7.so)
==5807==    by 0x4012335: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5807== 
==5807== 
==5807== 2,440 bytes in 98 blocks are still reachable in loss record 183 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4008B75: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807== 
==5807== 
==5807== 2,525 bytes in 48 blocks are still reachable in loss record 184 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26A7D: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98412E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 2,544 bytes in 8 blocks are possibly lost in loss record 185 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x401132B: _dl_allocate_tls (in /lib/ld-2.7.so)
==5807==    by 0x56FEB87: pthread_create@@GLIBC_2.2.5 (in /lib/libpthread-2.7.so)
==5807==    by 0x4F55CD: _wapi_collection_init (collection.c:73)
==5807==    by 0x4F8E9A: shared_init (handles.c:241)
==5807==    by 0x4F7CA4: mono_once (mono-mutex.c:80)
==5807==    by 0x4F8C03: _wapi_handle_new (handles.c:413)
==5807==    by 0x4F4F64: sem_create (semaphores.c:181)
==5807==    by 0x4F52FC: CreateSemaphore (semaphores.c:353)
==5807==    by 0x4EDAFA: mono_thread_pool_init (threadpool.c:989)
==5807==    by 0x49E044: mono_runtime_init (appdomain.c:142)
==5807==    by 0x5272B2: mini_init (mini.c:14224)
==5807== 
==5807== 
==5807== 2,616 bytes in 1 blocks are still reachable in loss record 186 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F08790: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 3,072 bytes in 1 blocks are still reachable in loss record 187 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F66BFB: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F66C60: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F67764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983F404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983FE49: gdk_keymap_translate_keyboard_state (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983618B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98376CF: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9838141: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983855D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 3,160 bytes in 158 blocks are still reachable in loss record 188 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE5C4BA: cairo_font_options_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8D884: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF27A5E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 3,161 bytes in 119 blocks are still reachable in loss record 189 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400AC49: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807== 
==5807== 
==5807== 3,744 bytes in 52 blocks are still reachable in loss record 190 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F26EC6: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26C7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983C6A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 4,096 bytes in 1 blocks are still reachable in loss record 191 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F0DB90: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26E08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26A4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F26CEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CE26: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2AFB7: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F2CBE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F4C80F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F330C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F331B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F335A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==5807== 
==5807== 
==5807== 4,200 bytes in 175 blocks are still reachable in loss record 192 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0BF66A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1E6D: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 4,628 bytes in 194 blocks are still reachable in loss record 193 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F1D0FF: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1DD58: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA30723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 4,672 bytes in 46 blocks are still reachable in loss record 194 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4012436: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4820F2: mono_lookup_pinvoke_call (loader.c:1159)
==5807==    by 0x47AA39: mono_marshal_get_native_wrapper (marshal.c:8571)
==5807== 
==5807== 
==5807== 5,304 bytes in 221 blocks are still reachable in loss record 195 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0DE9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1FBE: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2EDE: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 5,736 bytes in 239 blocks are still reachable in loss record 196 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CD13C: FcPatternCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAF1D: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 6,016 bytes in 188 blocks are still reachable in loss record 197 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0BA9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1DF3: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 6,360 bytes in 15 blocks are still reachable in loss record 198 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE9C037: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5C879: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CED6: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9A8F907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB9311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 6,381 bytes in 1 blocks are still reachable in loss record 199 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F09346: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 6,528 bytes in 204 blocks are still reachable in loss record 200 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D0F8D: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D1E50: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 7,080 bytes in 15 blocks are still reachable in loss record 201 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE95065: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95780: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D2C1: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6D395: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE707CA: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE716A5: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE95C80: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B987: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EE21: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6E195: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6EB1D: (within /usr/lib/libcairo.so.2.17.3)
==5807== 
==5807== 
==5807== 7,552 bytes in 236 blocks are indirectly lost in loss record 202 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C8CFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C8DFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CDF09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE01C: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 8,589 bytes in 596 blocks are still reachable in loss record 203 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CFDC3: FcStrCopy (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D117F: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2C59: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 8,680 bytes in 1 blocks are still reachable in loss record 204 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xC7EA57E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0xC7ECADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==5807==    by 0x9F1F529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F087C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807== 
==5807== 
==5807== 9,224 bytes in 95 blocks are still reachable in loss record 205 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400C582: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==5807==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==5807==    by 0x5C7D114: (within /lib/libc-2.7.so)
==5807==    by 0x5C31ABC: getpwnam_r (in /lib/libc-2.7.so)
==5807==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 9,600 bytes in 60 blocks are still reachable in loss record 206 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9EF6161: XCreateGC (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x983A36A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x20375627: ???
==5807==    by 0x207F8895: ???
==5807==    by 0x1852ECC3: ???
==5807==    by 0x924A3CA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x924B1F7: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9247949: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x915187E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1EF56: g_signal_chain_from_overridden (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 9,712 bytes in 26 blocks are still reachable in loss record 207 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x400C679: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5807== 
==5807== 
==5807== 12,800 bytes in 640 blocks are still reachable in loss record 208 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE5C47C: cairo_font_options_copy (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8DE4C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9A90C2C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF27C3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 13,080 bytes in 545 blocks are still reachable in loss record 209 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0D115A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2C59: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xD3720E0: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD372EE3: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD373C6C: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD374FEA: (within /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xD36C000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==5807==    by 0xB0D22B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2623: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0D2E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==5807== 
==5807== 
==5807== 16,224 bytes in 12 blocks are still reachable in loss record 210 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0xAE5EC6B: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5EEAE: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5A697: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE68548: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE93841: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE6B28B: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE5CF79: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE565EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A909C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0x9CB8DBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9A8F907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 16,272 bytes in 119 blocks are still reachable in loss record 211 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x400F8F4: (within /lib/ld-2.7.so)
==5807==    by 0x4012328: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==5807==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==5807==    by 0x51341B: mono_dl_open (mono-dl.c:305)
==5807==    by 0x481CB0: cached_module_load (loader.c:1048)
==5807==    by 0x4821F8: mono_lookup_pinvoke_call (loader.c:1193)
==5807== 
==5807== 
==5807== 16,352 bytes in 2 blocks are still reachable in loss record 212 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F0D964: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F0DE6E: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1D6BF: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1E1B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFCEDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0xBD18ADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0xBD18B48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==5807==    by 0x982AF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x91ADE9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91AE395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x91C7288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 16,384 bytes in 2 blocks are still reachable in loss record 213 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x1C4C3147: apr_pool_create_ex (in /usr/lib/libapr-1.so.0.2.11)
==5807==    by 0x1C4C40FA: apr_initialize (in /usr/lib/libapr-1.so.0.2.11)
==5807==    by 0x1B7E1903: ???
==5807==    by 0x1B7E0F6B: ???
==5807==    by 0x1B7E0A9F: ???
==5807==    by 0x1B7E08D3: ???
==5807==    by 0x1B7DE757: ???
==5807==    by 0x1B7DC5EB: ???
==5807==    by 0x1B7DC0EB: ???
==5807==    by 0x1AC90007: ???
==5807==    by 0x14AF578E: ???
==5807== 
==5807== 
==5807== 16,384 bytes in 1 blocks are still reachable in loss record 214 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x9F08B15: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x982C448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x980BAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x914C398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x8E3C527: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807==    by 0x417A5F: mono_main (driver.c:942)
==5807== 
==5807== 
==5807== 17,371 bytes in 396 blocks are still reachable in loss record 215 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CD211: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CE089: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF28514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CB008A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB0586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB41B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 18,583 (17,952 direct, 631 indirect) bytes in 450 blocks are definitely lost in loss record 216 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x9118DDD: gtk_icon_source_new (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xE3BA82B: ???
==5807==    by 0xE3BBAF3: ???
==5807==    by 0xE3B850C: ???
==5807==    by 0xE3B835B: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 22,440 bytes in 3 blocks are still reachable in loss record 217 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xBF3F887: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3FEBA: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3FFCD: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xE6C2392: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5807==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB081E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB31B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 22,784 bytes in 5 blocks are still reachable in loss record 218 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069D45: g_try_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x13A5AED0: rsvg_handle_get_pixbuf_sub (in /usr/lib/librsvg-2.so.2.22.2)
==5807==    by 0x13818E4C: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==5807==    by 0x95DF309: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807==    by 0xE3B850C: ???
==5807==    by 0xE3B835B: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807== 
==5807== 
==5807== 29,063 bytes in 23 blocks are still reachable in loss record 219 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xC15BD5B: ft_mem_qrealloc (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15BDFA: ft_mem_realloc (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15C781: FT_CMap_New (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC18E125: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC18E3E8: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC16B08E: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15CA56: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15E3D5: FT_Open_Face (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15EFD1: FT_New_Face (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xAE9A75F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C01F: (within /usr/lib/libcairo.so.2.17.3)
==5807== 
==5807== 
==5807== 39,936 bytes in 1,248 blocks are indirectly lost in loss record 220 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0C05A9: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C09D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CB02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x14BFC3D7: ???
==5807== 
==5807== 
==5807== 42,496 bytes in 1 blocks are still reachable in loss record 221 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F181CF: _XAllocScratch (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F0D138: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F0D4F0: XPutImage (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9834489: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x983426C: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98258AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x14BFB8D7: ???
==5807==    by 0x14BFB7FF: ???
==5807==    by 0x19C93267: ???
==5807==    by 0x14BFACAA: ???
==5807==    by 0x8FFF1DF: ???
==5807== 
==5807== 
==5807== 49,750 (49,142 direct, 608 indirect) bytes in 1,602 blocks are definitely lost in loss record 222 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x497C2C: mono_metadata_type_dup (metadata.c:4142)
==5807==    by 0x4EE5BD: inflate_other_info (generic-sharing.c:532)
==5807==    by 0x4EF62E: mono_method_lookup_or_register_other_info (generic-sharing.c:908)
==5807==    by 0x52F4C2: get_runtime_generic_context_ptr (mini.c:4575)
==5807==    by 0x541E85: mono_method_to_ir (mini.c:7651)
==5807==    by 0x5577F3: mini_method_compile (mini.c:12292)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x14BF361F: ???
==5807== 
==5807== 
==5807== 64,920 bytes in 541 blocks are still reachable in loss record 223 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xAE684E9: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE68DE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==5807==    by 0x9A8E978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==5807==    by 0xBF2AB64: pango_ot_buffer_output (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xE6C24A5: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==5807==    by 0x9CBC679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB081E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB31B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x909B207: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 79,424 bytes in 43 blocks are still reachable in loss record 224 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x95D9FAC: gdk_pixbuf_copy (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95E1C0B: gdk_pixbuf_add_alpha (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE1A30C6: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==5807==    by 0x91BDEE9: gtk_style_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x911AE31: gtk_icon_set_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x925EF99: gtk_widget_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x912E790: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x912E848: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 85,072 bytes in 409 blocks are still reachable in loss record 225 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x9F18D75: _XEnq (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1FCED: (within /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9F1FFA4: _XReply (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFF4D4: _XGetWindowAttributes (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9EFF647: XGetWindowAttributes (in /usr/lib/libX11.so.6.2.0)
==5807==    by 0x9847156: gdk_window_get_events (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x925B5B7: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x925F973: gtk_widget_realize (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x925FBD7: gtk_widget_map (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x90C4138: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9214910: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 138,282 bytes in 119 blocks are still reachable in loss record 226 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x400A9D4: (within /lib/ld-2.7.so)
==5807==    by 0x40061E4: (within /lib/ld-2.7.so)
==5807==    by 0x4008677: (within /lib/ld-2.7.so)
==5807==    by 0x400BE0C: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x400C4D0: (within /lib/ld-2.7.so)
==5807==    by 0x40120A8: (within /lib/ld-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807==    by 0x401191A: (within /lib/ld-2.7.so)
==5807==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==5807==    by 0x400DDF5: (within /lib/ld-2.7.so)
==5807== 
==5807== 
==5807== 143,908 bytes in 4,178 blocks are still reachable in loss record 227 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAA131FB: g_object_add_toggle_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xE3B135B: ???
==5807==    by 0x8FFA637: ???
==5807==    by 0xE3BC417: ???
==5807==    by 0xE3BBAF3: ???
==5807==    by 0xE3B850C: ???
==5807==    by 0xE3B835B: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807== 
==5807== 
==5807== 196,928 bytes in 6,154 blocks are indirectly lost in loss record 228 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xB0CDFCD: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CAFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x913E375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xAA10C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA244CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA26254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807== 
==5807== 
==5807== 394,336 (148,736 direct, 245,600 indirect) bytes in 237 blocks are definitely lost in loss record 229 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0xB0CD792: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0BF9DC: (within /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0C0C35: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xB0CB02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==5807==    by 0xBF28283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0x9CAA9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CAAD3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB2E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB4FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807==    by 0x9CB505D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 175,661 bytes in 272 blocks are still reachable in loss record 230 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xC15A30F: ft_mem_qalloc (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15BC52: ft_mem_alloc (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC18EC7C: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC16B041: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15CA56: (within /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15E3D5: FT_Open_Face (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xC15EFD1: FT_New_Face (in /usr/lib/libfreetype.so.6.3.16)
==5807==    by 0xAE9A75F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C01F: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE9C506: (within /usr/lib/libcairo.so.2.17.3)
==5807==    by 0xAE67ED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==5807== 
==5807== 
==5807== 393,216 bytes in 6 blocks are still reachable in loss record 231 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x983D0FB: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98134F7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98137AD: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x9833E51: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x98258AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x14BFB8D7: ???
==5807==    by 0x14BFB7FF: ???
==5807==    by 0x14BFAE7B: ???
==5807==    by 0x14BFACAA: ???
==5807==    by 0x8FFF1DF: ???
==5807==    by 0x640FFFF: ???
==5807== 
==5807== 
==5807== 528,496 bytes in 4,861 blocks are still reachable in loss record 232 of 238
==5807==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==5807==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAA20220: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA224E3: g_signal_connect_data (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x92395A7: gtk_tree_view_set_model (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x16CCDCE7: ???
==5807==    by 0x4C78EC: mono_runtime_invoke_array (object.c:3214)
==5807==    by 0x4DA29F: ves_icall_InternalInvoke (icall.c:3016)
==5807==    by 0x8BCB227: ???
==5807==    by 0x8BCAC71: ???
==5807==    by 0x16CC9CB7: ???
==5807==    by 0x16CC8C83: ???
==5807== 
==5807== 
==5807== 816,592 bytes in 707 blocks are possibly lost in loss record 233 of 238
==5807==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==5807==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==5807==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x507E1E5: g_slice_alloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0xAA302BE: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA15F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA1654F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0xAA17190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==5807==    by 0x984E925: gdk_window_new (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==5807==    by 0x908DA3D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807== 
==5807== 
==5807== 1,620,928 bytes in 7,680 blocks are still reachable in loss record 234 of 238
==5807==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==5807==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x9117E0D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x911CF03: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9119154: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x911ADB2: gtk_icon_set_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xE3BE16F: ???
==5807==    by 0xE3BE03F: ???
==5807==    by 0xE3BC92F: ???
==5807==    by 0xE3BC817: ???
==5807==    by 0xE3BBAF3: ???
==5807==    by 0xE3B850C: ???
==5807== 
==5807== 
==5807== 5,475,052 bytes in 599 blocks are still reachable in loss record 235 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x95D9E94: gdk_pixbuf_new (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3C3F57: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0xCA189F2: (within /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xCA18FEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==5807==    by 0xE3C35FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==5807==    by 0x95DED68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0x95DF3EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==5807==    by 0xE3B3F1F: ???
==5807==    by 0xE3B9F43: ???
==5807==    by 0xE3B9707: ???
==5807==    by 0xE3B850C: ???
==5807== 
==5807== 
==5807== 6,019,478 bytes in 8,752 blocks are still reachable in loss record 236 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0xBF2E201: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3C046: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3CC2E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3E1A3: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF3E8A6: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2B604: pango_ot_info_get_gsub (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2B654: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2BEDB: pango_ot_info_find_script (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2C9B9: pango_ot_ruleset_new_for (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2CA75: pango_ot_ruleset_new_from_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807==    by 0xBF2CBBE: pango_ot_ruleset_get_for_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==5807== 
==5807== 
==5807== 10,901,070 bytes in 14,177 blocks are still reachable in loss record 237 of 238
==5807==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==5807==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x9118CBB: gtk_icon_source_copy (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0x9118E77: gtk_icon_set_add_source (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==5807==    by 0xE3BACC7: ???
==5807==    by 0xE3B850C: ???
==5807==    by 0xE3B835B: ???
==5807==    by 0x8E387D3: ???
==5807==    by 0x41AB3AF: ???
==5807==    by 0x41AB265: ???
==5807==    by 0x4C9F5F: mono_runtime_exec_main (object.c:3031)
==5807==    by 0x4CB342: mono_runtime_run_main (object.c:2825)
==5807== 
==5807== 
==5807== 794,797,632 bytes in 1,601,948 blocks are still reachable in loss record 238 of 238
==5807==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==5807==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==5807==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x506035D: g_list_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==5807==    by 0x52AF25: mono_allocate_stack_slots_full (mini.c:9812)
==5807==    by 0x432320: mono_arch_allocate_vars (mini-amd64.c:1137)
==5807==    by 0x558127: mini_method_compile (mini.c:12525)
==5807==    by 0x559419: mono_jit_compile_method (mini.c:12836)
==5807==    by 0x42C5E2: mono_magic_trampoline (mini-trampolines.c:249)
==5807==    by 0x415B164: ???
==5807==    by 0x8BA4AAB: ???
==5807== 
==5807== LEAK SUMMARY:
==5807==    definitely lost: 218,954 bytes in 2,300 blocks.
==5807==    indirectly lost: 247,767 bytes in 7,793 blocks.
==5807==      possibly lost: 821,728 bytes in 749 blocks.
==5807==    still reachable: 820,859,309 bytes in 1,649,180 blocks.
==5807==         suppressed: 0 bytes in 0 blocks.
--5807--  memcheck: sanity checks: 984797 cheap, 1382 expensive
--5807--  memcheck: auxmaps: 0 auxmap entries (0k, 0M) in use
--5807--  memcheck: auxmaps_L1: 0 searches, 0 cmps, ratio 0:10
--5807--  memcheck: auxmaps_L2: 0 searches, 0 nodes
--5807--  memcheck: SMs: n_issued      = 28702 (459232k, 448M)
--5807--  memcheck: SMs: n_deissued    = 203 (3248k, 3M)
--5807--  memcheck: SMs: max_noaccess  = 524287 (8388592k, 8191M)
--5807--  memcheck: SMs: max_undefined = 11 (176k, 0M)
--5807--  memcheck: SMs: max_defined   = 5642 (90272k, 88M)
--5807--  memcheck: SMs: max_non_DSM   = 28505 (456080k, 445M)
--5807--  memcheck: max sec V bit nodes:    667495 (57362k, 56M)
--5807--  memcheck: set_sec_vbits8 calls: 43040800 (new: 786826, updates: 42253974)
--5807--  memcheck: max shadow mem size:   517586k, 505M
--5807-- translate:            fast SP updates identified: 183,465 ( 83.8%)
--5807-- translate:   generic_known SP updates identified: 30,966 ( 14.1%)
--5807-- translate: generic_unknown SP updates identified: 4,367 (  1.9%)
--5807--     tt/tc: 1,311,497,973 tt lookups requiring 73,135,373,278 probes
--5807--     tt/tc: 1,311,497,973 fast-cache updates, 26,002 flushes
--5807--  transtab: new        256,118 (5,856,835 -> 102,293,817; ratio 174:10) [256,118 scs]
--5807--  transtab: dumped     0 (0 -> ??)
--5807--  transtab: discarded  123,631 (3,561,833 -> ??)
--5807-- scheduler: 90,703,058,736 jumps (bb entries).
--5807-- scheduler: 984,797/1,454,113,148 major/minor sched events.
--5807--    sanity: 984798 cheap, 1382 expensive checks.
--5807--    exectx: 786,433 lists, 538,481 contexts (avg 0 per list)
--5807--    exectx: 140,670,115 searches, 140,568,110 full compares (999 per 1000)
--5807--    exectx: 362,092,844 cmp2, 54,788 cmp4, 0 cmpAll
--5807--  errormgr: 509 supplist searches, 35,545 comparisons during search
--5807--  errormgr: 10,000,789 errlist searches, 46,014,556 comparisons during search
