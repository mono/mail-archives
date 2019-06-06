==7947== Memcheck, a memory error detector.
==7947== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==7947== Using LibVEX rev 1804, a library for dynamic binary translation.
==7947== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==7947== Using valgrind-3.3.0-Debian, a dynamic binary instrumentation framework.
==7947== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==7947== 
==7947== My PID = 7947, parent PID = 15842.  Prog and args are:
==7947==    mono
==7947==    --debug
==7947==    ./MonoDevelop.exe
==7947== 
--7947-- 
--7947-- Command line
--7947--    mono
--7947--    --debug
--7947--    ./MonoDevelop.exe
--7947-- Startup, with flags:
--7947--    --suppressions=/usr/lib/valgrind/debian-libc6-dbg.supp
--7947--    --tool=memcheck
--7947--    -v
--7947--    --leak-check=full
--7947--    --log-file=/home/NANOFLUIDICS/cmarshall/md.valgrind1.log
--7947--    --smc-check=all
--7947--    --show-reachable=yes
--7947--    --suppressions=/home/NANOFLUIDICS/cmarshall/Source/mono-2.0/mono/data/mono.supp
--7947-- Contents of /proc/version:
--7947--   Linux version 2.6.24-19-server (buildd@king) (gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #1 SMP Fri Jul 11 21:50:43 UTC 2008
--7947-- Arch and hwcaps: AMD64, amd64-sse2
--7947-- Page sizes: currently 4096, max supported 4096
--7947-- Valgrind library directory: /usr/lib/valgrind
--7947-- Reading syms from /usr/mono-2.0/bin/mono (0x400000)
--7947-- Reading syms from /lib/ld-2.7.so (0x4000000)
--7947-- Reading debug info from /lib/ld-2.7.so...
--7947-- ... CRC mismatch (computed c9862f74 wanted 7aafc83d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/valgrind/amd64-linux/memcheck (0x38000000)
--7947--    object doesn't have a dynamic symbol table
--7947-- Reading suppressions file: /usr/lib/valgrind/debian-libc6-dbg.supp
--7947-- Reading suppressions file: /home/NANOFLUIDICS/cmarshall/Source/mono-2.0/mono/data/mono.supp
--7947-- Reading suppressions file: /usr/lib/valgrind/default.supp
--7947-- Reading syms from /usr/lib/valgrind/amd64-linux/vgpreload_core.so (0x4A1F000)
--7947-- Reading syms from /usr/lib/valgrind/amd64-linux/vgpreload_memcheck.so (0x4C20000)
--7947-- Reading syms from /usr/lib/libgthread-2.0.so.0.1600.4 (0x4E27000)
--7947-- Reading debug info from /usr/lib/libgthread-2.0.so.0.1600.4...
--7947-- ... CRC mismatch (computed 539763b2 wanted b1c6fbda)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libglib-2.0.so.0.1600.4 (0x502B000)
--7947-- Reading debug info from /usr/lib/libglib-2.0.so.0.1600.4...
--7947-- ... CRC mismatch (computed 1b9d4ee0 wanted f0fc4328)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/librt-2.7.so (0x52EB000)
--7947-- Reading debug info from /lib/librt-2.7.so...
--7947-- ... CRC mismatch (computed c0424b42 wanted 293359f6)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libdl-2.7.so (0x54F4000)
--7947-- Reading debug info from /lib/libdl-2.7.so...
--7947-- ... CRC mismatch (computed 13394ae2 wanted 5c0f7518)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libpthread-2.7.so (0x56F8000)
--7947-- Reading debug info from /lib/libpthread-2.7.so...
--7947-- ... CRC mismatch (computed b064431f wanted 03c6976c)
--7947-- Reading syms from /lib/libm-2.7.so (0x5914000)
--7947-- Reading debug info from /lib/libm-2.7.so...
--7947-- ... CRC mismatch (computed e491af1c wanted a4e95324)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libc-2.7.so (0x5B95000)
--7947-- Reading debug info from /lib/libc-2.7.so...
--7947-- ... CRC mismatch (computed cb7b9635 wanted 11d14124)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libselinux.so.1 (0x5EF7000)
--7947-- Reading debug info from /lib/libselinux.so.1...
--7947-- ... CRC mismatch (computed 6e2a0151 wanted 90cef010)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpcre.so.3.12.1 (0x6113000)
--7947-- Reading debug info from /usr/lib/libpcre.so.3.12.1...
--7947-- ... CRC mismatch (computed 9f1d15e2 wanted 3588444b)
--7947--    object doesn't have a symbol table
--7947-- REDIR: 0x5c112d0 (memset) redirected to 0x4c24200 (memset)
--7947-- REDIR: 0x5c10460 (rindex) redirected to 0x4c23cb0 (rindex)
--7947-- REDIR: 0x5c0b2d0 (malloc) redirected to 0x4c22f40 (malloc)
--7947-- REDIR: 0x5c0cb90 (free) redirected to 0x4c22ac0 (free)
--7947-- REDIR: 0x5c12a60 (strchrnul) redirected to 0x4c242b0 (strchrnul)
--7947-- REDIR: 0x5c10050 (strlen) redirected to 0x4c23f50 (strlen)
--7947-- REDIR: 0x5c11cf0 (memcpy) redirected to 0x4c25020 (memcpy)
--7947-- REDIR: 0x5c113e0 (mempcpy) redirected to 0x4c24a20 (mempcpy)
--7947-- REDIR: 0x5c0cd70 (realloc) redirected to 0x4c23000 (realloc)
--7947-- REDIR: 0x5c10b70 (memchr) redirected to 0x4c240e0 (memchr)
--7947-- REDIR: 0x5c0f930 (index) redirected to 0x4c23da0 (index)
--7947-- REDIR: 0x5c0fae0 (strcmp) redirected to 0x4c24020 (strcmp)
--7947-- REDIR: 0x5c102d0 (strncmp) redirected to 0x4c23fb0 (strncmp)
--7947-- REDIR: 0x5c10140 (strnlen) redirected to 0x4c23f20 (strnlen)
--7947-- REDIR: 0x5c119f0 (stpcpy) redirected to 0x4c24cb0 (stpcpy)
--7947-- REDIR: 0x5c0fb20 (strcpy) redirected to 0x4c25280 (strcpy)
--7947-- REDIR: 0x5c12990 (rawmemchr) redirected to 0x4c242e0 (rawmemchr)
--7947-- REDIR: 0x5c0af70 (calloc) redirected to 0x4c22050 (calloc)
--7947-- REDIR: 0xffffffffff600000 (???) redirected to 0x38029a63 (vgPlain_amd64_linux_REDIR_FOR_vgettimeofday)
--7947-- REDIR: 0x5c0b680 (posix_memalign) redirected to 0x4c22000 (posix_memalign)
--7947-- REDIR: 0x5c11130 (memmove) redirected to 0x4c24250 (memmove)
--7947-- REDIR: 0x5c103b0 (strncpy) redirected to 0x4c25170 (strncpy)
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==  Address 0x63795a8 is 72 bytes inside a block of size 74 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
--7947-- Reading syms from /lib/libnss_compat-2.7.so (0x6ADC000)
--7947-- Reading debug info from /lib/libnss_compat-2.7.so...
--7947-- ... CRC mismatch (computed 3eb3176a wanted 1291e35a)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==  Address 0x6387e00 is 16 bytes inside a block of size 17 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4008B75: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
--7947-- Reading syms from /lib/libnsl-2.7.so (0x6CE5000)
--7947-- Reading debug info from /lib/libnsl-2.7.so...
--7947-- ... CRC mismatch (computed b0b57441 wanted c8167f5e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libnss_nis-2.7.so (0x6EFE000)
--7947-- Reading debug info from /lib/libnss_nis-2.7.so...
--7947-- ... CRC mismatch (computed 1fc35041 wanted 0430800a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libnss_files-2.7.so (0x7109000)
--7947-- Reading debug info from /lib/libnss_files-2.7.so...
--7947-- ... CRC mismatch (computed e55e1683 wanted 9a5435f4)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==7947==  Address 0x63899b8 is 24 bytes inside a block of size 25 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4008B75: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==7947==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
--7947-- Reading syms from /lib/libnss_winbind.so.2 (0x7315000)
--7947-- Reading debug info from /lib/libnss_winbind.so.2...
--7947-- ... CRC mismatch (computed b69200e3 wanted c124aade)
--7947--    object doesn't have a symbol table
--7947-- REDIR: 0x5c10230 (strncat) redirected to 0x4c23e30 (strncat)
--7947-- REDIR: 0xffffffffff600400 (???) redirected to 0x38029a6d (vgPlain_amd64_linux_REDIR_FOR_vtime)
--7947-- REDIR: 0x5bc99c0 (unsetenv) redirected to 0x4c24390 (unsetenv)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==  Address 0x646ec60 is 80 bytes inside a block of size 84 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==  Address 0x64d08b0 is 120 bytes inside a block of size 123 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015CF0: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015CF0: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==  Address 0x823d4e8 is 96 bytes inside a block of size 98 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x919680F: ???
==7947==    by 0x919680F: ???
==7947==    by 0x919680F: ???
==7947==    by 0x918C628: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x918BD2F: ???
==7947==    by 0x918BA1F: ???
==7947==    by 0x918B6DF: ???
==7947==  Address 0x7feffe9f0 is not stack'd, malloc'd or (recently) free'd
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400A4CF: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==7947==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947==    by 0x41AD343: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x40165A5: (within /lib/ld-2.7.so)
==7947==    by 0x400A50E: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==7947==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947==    by 0x41AD343: ???
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400A99D: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==  Address 0x92083b0 is 16 bytes inside a block of size 20 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481B94: mono_lookup_pinvoke_call (loader.c:1121)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
--7947-- Reading syms from /usr/lib/libgtk-x11-2.0.so.0.1200.9 (0x985A000)
--7947-- Reading debug info from /usr/lib/libgtk-x11-2.0.so.0.1200.9...
--7947-- ... CRC mismatch (computed 51be4d1d wanted 8f74fe6b)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9 (0x9E29000)
--7947-- Reading debug info from /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9...
--7947-- ... CRC mismatch (computed a7f83542 wanted 7f618f25)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgdk-x11-2.0.so.0.1200.9 (0xA043000)
--7947-- Reading debug info from /usr/lib/libgdk-x11-2.0.so.0.1200.9...
--7947-- ... CRC mismatch (computed b484e102 wanted f32ddc33)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpangocairo-1.0.so.0.2002.3 (0xA2DD000)
--7947-- Reading debug info from /usr/lib/libpangocairo-1.0.so.0.2002.3...
--7947-- ... CRC mismatch (computed 697619f4 wanted a0e936cc)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpango-1.0.so.0.2002.3 (0xA4E8000)
--7947-- Reading debug info from /usr/lib/libpango-1.0.so.0.2002.3...
--7947-- ... CRC mismatch (computed 96c3c3bb wanted 59545878)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libX11.so.6.2.0 (0xA72C000)
--7947-- Reading debug info from /usr/lib/libX11.so.6.2.0...
--7947-- ... CRC mismatch (computed afa3731b wanted 001ef74a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXcomposite.so.1.0.0 (0xAA2F000)
--7947-- Reading debug info from /usr/lib/libXcomposite.so.1.0.0...
--7947-- ... CRC mismatch (computed db431175 wanted 662a8e0b)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXdamage.so.1.1.0 (0xAC31000)
--7947-- Reading debug info from /usr/lib/libXdamage.so.1.1.0...
--7947-- ... CRC mismatch (computed 85b00c5b wanted f78ddc18)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXfixes.so.3.1.0 (0xAE33000)
--7947-- Reading debug info from /usr/lib/libXfixes.so.3.1.0...
--7947-- ... CRC mismatch (computed 87062290 wanted c65e5c9f)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libatk-1.0.so.0.2209.1 (0xB038000)
--7947-- Reading debug info from /usr/lib/libatk-1.0.so.0.2209.1...
--7947-- ... CRC mismatch (computed 4e6feb2a wanted f73af7a7)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgobject-2.0.so.0.1600.4 (0xB258000)
--7947-- Reading debug info from /usr/lib/libgobject-2.0.so.0.1600.4...
--7947-- ... CRC mismatch (computed ae81bf07 wanted a3249db9)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgmodule-2.0.so.0.1600.4 (0xB49D000)
--7947-- Reading debug info from /usr/lib/libgmodule-2.0.so.0.1600.4...
--7947-- ... CRC mismatch (computed e37361d7 wanted 29f7385d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libcairo.so.2.17.3 (0xB6A0000)
--7947-- Reading debug info from /usr/lib/libcairo.so.2.17.3...
--7947-- ... CRC mismatch (computed 3ec5255e wanted 2cc7fcff)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libfontconfig.so.1.3.0 (0xB90B000)
--7947-- Reading debug info from /usr/lib/libfontconfig.so.1.3.0...
--7947-- ... CRC mismatch (computed 187912bc wanted 9ec04f9a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXext.so.6.4.0 (0xBB3C000)
--7947-- Reading debug info from /usr/lib/libXext.so.6.4.0...
--7947-- ... CRC mismatch (computed 749303dd wanted 14c9f19c)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXrender.so.1.3.0 (0xBD4D000)
--7947-- Reading debug info from /usr/lib/libXrender.so.1.3.0...
--7947-- ... CRC mismatch (computed 7abe549a wanted 38591836)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXinerama.so.1.0.0 (0xBF56000)
--7947-- Reading debug info from /usr/lib/libXinerama.so.1.0.0...
--7947-- ... CRC mismatch (computed 79f8be73 wanted 9f1e67e8)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXi.so.6.0.0 (0xC158000)
--7947-- Reading debug info from /usr/lib/libXi.so.6.0.0...
--7947-- ... CRC mismatch (computed fcc610ab wanted 44c4dbbe)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXrandr.so.2.1.0 (0xC361000)
--7947-- Reading debug info from /usr/lib/libXrandr.so.2.1.0...
--7947-- ... CRC mismatch (computed a13002cc wanted 197a14e7)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXcursor.so.1.0.2 (0xC568000)
--7947-- Reading debug info from /usr/lib/libXcursor.so.1.0.2...
--7947-- ... CRC mismatch (computed 15cdd867 wanted a60dd5d5)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400522C: (within /lib/ld-2.7.so)
==7947==    by 0x40079E5: (within /lib/ld-2.7.so)
==7947==    by 0x40089D7: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==  Address 0x8f83150 is 8 bytes inside a block of size 9 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x4007979: (within /lib/ld-2.7.so)
==7947==    by 0x40089D7: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
--7947-- Reading syms from /usr/lib/libpangoft2-1.0.so.0.2002.3 (0xC772000)
--7947-- Reading debug info from /usr/lib/libpangoft2-1.0.so.0.2002.3...
--7947-- ... CRC mismatch (computed 02937f20 wanted 44877eac)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libfreetype.so.6.3.16 (0xC99E000)
--7947-- Reading debug info from /usr/lib/libfreetype.so.6.3.16...
--7947-- ... CRC mismatch (computed 72ba4f5a wanted ddfa7f8d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libz.so.1.2.3.3 (0xCC1D000)
--7947-- Reading debug info from /usr/lib/libz.so.1.2.3.3...
--7947-- ... CRC mismatch (computed 38d836d6 wanted 4bea647b)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libxcb-xlib.so.0.0.0 (0xCE34000)
--7947-- Reading debug info from /usr/lib/libxcb-xlib.so.0.0.0...
--7947-- ... CRC mismatch (computed 6702c4d9 wanted a09203a4)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libxcb.so.1.0.0 (0xD035000)
--7947-- Reading debug info from /usr/lib/libxcb.so.1.0.0...
--7947-- ... CRC mismatch (computed 2c58fe5c wanted 8ea17cc5)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpng12.so.0.15.0 (0xD250000)
--7947-- Reading debug info from /usr/lib/libpng12.so.0.15.0...
--7947-- ... CRC mismatch (computed 7be56180 wanted 58c9dcae)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpixman-1.so.0.10.0 (0xD475000)
--7947-- Reading debug info from /usr/lib/libpixman-1.so.0.10.0...
--7947-- ... CRC mismatch (computed 413771fd wanted aa908744)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libstdc++.so.6.0.9 (0xD6A3000)
--7947-- Reading debug info from /usr/lib/libstdc++.so.6.0.9...
--7947-- ... CRC mismatch (computed cffb6542 wanted 4e57faa1)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libgcc_s.so.1 (0xD9AE000)
--7947-- Reading debug info from /lib/libgcc_s.so.1...
--7947-- ... CRC mismatch (computed 068ceb1e wanted 5861faf2)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libexpat.so.1.5.2 (0xDBBC000)
--7947-- Reading debug info from /usr/lib/libexpat.so.1.5.2...
--7947-- ... CRC mismatch (computed 3a1561fe wanted 4895301c)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXau.so.6.0.0 (0xDDE0000)
--7947-- Reading debug info from /usr/lib/libXau.so.6.0.0...
--7947-- ... CRC mismatch (computed f6128d91 wanted 5bb2fa57)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libXdmcp.so.6.0.0 (0xDFE2000)
--7947-- Reading debug info from /usr/lib/libXdmcp.so.6.0.0...
--7947-- ... CRC mismatch (computed 2acd0e34 wanted 8c2b8da1)
--7947--    object doesn't have a symbol table
--7947-- REDIR: 0x5c0f770 (strcat) redirected to 0x4c24750 (strcat)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==  Address 0x640c8c0 is 32 bytes inside a block of size 39 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4005F47: (within /lib/ld-2.7.so)
==7947==    by 0x400885F: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
--7947-- Reading syms from /usr/mono-2.0/lib/libgtksharpglue-2.so (0xE269000)
--7947-- Reading syms from /usr/mono-2.0/lib/libglibsharpglue-2.so (0xE482000)
--7947-- Reading syms from /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so (0xE684000)
--7947-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so...
--7947-- ... CRC mismatch (computed dc8d9df5 wanted ab0ea5b0)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x400E093: (within /lib/ld-2.7.so)
==7947==    by 0x400A547: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xB49EC7E: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==  Address 0x925b958 is 48 bytes inside a block of size 50 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
--7947-- memcheck GC: 1024 nodes, 1024 survivors (100.0%)
--7947-- memcheck GC: increase table size to 2048
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
--7947-- Reading syms from /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so (0xE897000)
--7947-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so...
--7947-- ... CRC mismatch (computed cd0cbca9 wanted d1eabfa8)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400A99D: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==  Address 0x84306c0 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0xB49E932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xB285A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xA4FB1C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FB288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FB306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FE459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FE6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
--7947-- Reading syms from /usr/lib/pango/1.6.0/modules/pango-basic-fc.so (0xEBA1000)
--7947-- Reading debug info from /usr/lib/pango/1.6.0/modules/pango-basic-fc.so...
--7947-- ... CRC mismatch (computed 5eb59628 wanted c750bc89)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x400E093: (within /lib/ld-2.7.so)
==7947==    by 0x400A547: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xB49EBF1: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
--7947-- Reading syms from /usr/lib/libgnomevfs-2.so.0.2200.0 (0xF229000)
--7947-- Reading debug info from /usr/lib/libgnomevfs-2.so.0.2200.0...
--7947-- ... CRC mismatch (computed 4a5d84bf wanted 4d1d25ef)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgconf-2.so.4.1.5 (0xF493000)
--7947-- Reading debug info from /usr/lib/libgconf-2.so.4.1.5...
--7947-- ... CRC mismatch (computed 5d970145 wanted 6d094911)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libxml2.so.2.6.31 (0xF6CE000)
--7947-- Reading debug info from /usr/lib/libxml2.so.2.6.31...
--7947-- ... CRC mismatch (computed 6346bb6f wanted 2436dc76)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libdbus-glib-1.so.2.1.0 (0xFA15000)
--7947-- Reading debug info from /usr/lib/libdbus-glib-1.so.2.1.0...
--7947-- ... CRC mismatch (computed 4828c83c wanted 876558b5)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libdbus-1.so.3.4.0 (0xFC35000)
--7947-- Reading debug info from /usr/lib/libdbus-1.so.3.4.0...
--7947-- ... CRC mismatch (computed 77b8b9a2 wanted 4349cae2)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgnutls.so.13.9.1 (0xFE72000)
--7947-- Reading debug info from /usr/lib/libgnutls.so.13.9.1...
--7947-- ... CRC mismatch (computed 9473aef1 wanted 873a588c)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libavahi-glib.so.1.0.1 (0x100F6000)
--7947-- Reading debug info from /usr/lib/libavahi-glib.so.1.0.1...
--7947-- ... CRC mismatch (computed 27dec6ce wanted 16cd9dc6)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libavahi-common.so.3.5.0 (0x102F9000)
--7947-- Reading debug info from /usr/lib/libavahi-common.so.3.5.0...
--7947-- ... CRC mismatch (computed bdde8cfd wanted 031b8c55)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libavahi-client.so.3.2.4 (0x10505000)
--7947-- Reading debug info from /usr/lib/libavahi-client.so.3.2.4...
--7947-- ... CRC mismatch (computed df243a51 wanted cdc4b724)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libresolv-2.7.so (0x10715000)
--7947-- Reading debug info from /lib/libresolv-2.7.so...
--7947-- ... CRC mismatch (computed b7d418c3 wanted 3b9cb093)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libutil-2.7.so (0x1092B000)
--7947-- Reading debug info from /lib/libutil-2.7.so...
--7947-- ... CRC mismatch (computed dad2b7f7 wanted 39db7729)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libORBit-2.so.0.1.0 (0x10B2E000)
--7947-- Reading debug info from /usr/lib/libORBit-2.so.0.1.0...
--7947-- ... CRC mismatch (computed 6e54e8cd wanted da5cabd7)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libtasn1.so.3.0.12 (0x10D9B000)
--7947-- Reading debug info from /usr/lib/libtasn1.so.3.0.12...
--7947-- ... CRC mismatch (computed fb8d9aa5 wanted de19d909)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libgcrypt.so.11.2.3 (0x10FAB000)
--7947-- Reading debug info from /lib/libgcrypt.so.11.2.3...
--7947-- ... CRC mismatch (computed 42972b2c wanted 76cb42fc)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libgpg-error.so.0.3.0 (0x111F9000)
--7947-- Reading debug info from /lib/libgpg-error.so.0.3.0...
--7947-- ... CRC mismatch (computed e92bcaa6 wanted daec7936)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgnomeui-2.so.0.2201.0 (0x113FC000)
--7947-- Reading debug info from /usr/lib/libgnomeui-2.so.0.2201.0...
--7947-- ... CRC mismatch (computed 662c2b8d wanted e7b9cc9c)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libbonoboui-2.so.0.0.0 (0x11697000)
--7947-- Reading debug info from /usr/lib/libbonoboui-2.so.0.0.0...
--7947-- ... CRC mismatch (computed 74934e7a wanted 6041bfaa)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgnomecanvas-2.so.0.2001.0 (0x11908000)
--7947-- Reading debug info from /usr/lib/libgnomecanvas-2.so.0.2001.0...
--7947-- ... CRC mismatch (computed 77d065a8 wanted 292a6821)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgnome-2.so.0.2200.0 (0x11B3E000)
--7947-- Reading debug info from /usr/lib/libgnome-2.so.0.2200.0...
--7947-- ... CRC mismatch (computed bc4d548f wanted 9fd73b4b)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libart_lgpl_2.so.2.3.20 (0x11D56000)
--7947-- Reading debug info from /usr/lib/libart_lgpl_2.so.2.3.20...
--7947-- ... CRC mismatch (computed bbdf4f4a wanted cf96cddf)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgio-2.0.so.0.0.0 (0x11F6E000)
--7947-- Reading debug info from /usr/lib/libgio-2.0.so.0.0.0...
--7947-- ... CRC mismatch (computed a432a97e wanted c71d38fa)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgnome-keyring.so.0.1.1 (0x121DF000)
--7947-- Reading debug info from /usr/lib/libgnome-keyring.so.0.1.1...
--7947-- ... CRC mismatch (computed 91a0ff30 wanted 19928d5a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libSM.so.6.0.0 (0x123F2000)
--7947-- Reading debug info from /usr/lib/libSM.so.6.0.0...
--7947-- ... CRC mismatch (computed fe5d1672 wanted f24edc81)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libICE.so.6.3.0 (0x125FA000)
--7947-- Reading debug info from /usr/lib/libICE.so.6.3.0...
--7947-- ... CRC mismatch (computed d9288efe wanted a63cf42f)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libbonobo-2.so.0.0.0 (0x12815000)
--7947-- Reading debug info from /usr/lib/libbonobo-2.so.0.0.0...
--7947-- ... CRC mismatch (computed f42e5a54 wanted a968d763)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libbonobo-activation.so.4.0.0 (0x12A89000)
--7947-- Reading debug info from /usr/lib/libbonobo-activation.so.4.0.0...
--7947-- ... CRC mismatch (computed 4a966f65 wanted 333e4502)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libpopt.so.0.0.0 (0x12CA3000)
--7947-- Reading debug info from /lib/libpopt.so.0.0.0...
--7947-- ... CRC mismatch (computed b5f9fd69 wanted e8a1a0d1)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgailutil.so.18.0.1 (0x12EAB000)
--7947-- Reading debug info from /usr/lib/libgailutil.so.18.0.1...
--7947-- ... CRC mismatch (computed eadec55f wanted 9553b74d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libesd.so.0.2.38 (0x130B3000)
--7947-- Reading debug info from /usr/lib/libesd.so.0.2.38...
--7947-- ... CRC mismatch (computed a9be2d4f wanted 1c32e6ce)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libaudiofile.so.0.0.2 (0x132BD000)
--7947-- Reading debug info from /usr/lib/libaudiofile.so.0.0.2...
--7947-- ... CRC mismatch (computed f6dd7442 wanted 15481a97)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libORBitCosNaming-2.so.0.1.0 (0x134E5000)
--7947-- Reading debug info from /usr/lib/libORBitCosNaming-2.so.0.1.0...
--7947-- ... CRC mismatch (computed 0e204ab3 wanted 5ed9cb7e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libasound.so.2.0.0 (0x136EC000)
--7947-- Reading debug info from /usr/lib/libasound.so.2.0.0...
--7947-- ... CRC mismatch (computed bb0f1cda wanted 9669d2a2)
--7947--    object doesn't have a symbol table
--9106-- Discarding syms at 0x6ADC000-0x6CE5000 in /lib/libnss_compat-2.7.so due to munmap()
--9106-- Discarding syms at 0x6EFE000-0x7109000 in /lib/libnss_nis-2.7.so due to munmap()
--9106-- Discarding syms at 0x7315000-0x7520000 in /lib/libnss_winbind.so.2 due to munmap()
--9106-- Discarding syms at 0x7109000-0x7315000 in /lib/libnss_files-2.7.so due to munmap()
==9106== 
==9106== ERROR SUMMARY: 779 errors from 38 contexts (suppressed: 33833 from 3)
==9106== 
==9106== 1 errors in context 1 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400AB93: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4007823: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 1 errors in context 2 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400A99D: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==  Address 0x84306c0 is 40 bytes inside a block of size 47 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0xB49E932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xB285A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xA4FB1C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA4FB288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA4FB306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA4FE459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA4FE6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 2 errors in context 3 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x400E093: (within /lib/ld-2.7.so)
==9106==    by 0x400A547: (within /lib/ld-2.7.so)
==9106==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==9106==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==9106==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xB49EBF1: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4007823: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 2 errors in context 4 of 38:
==9106== Invalid read of size 8
==9106==    at 0x40165A5: (within /lib/ld-2.7.so)
==9106==    by 0x400A50E: (within /lib/ld-2.7.so)
==9106==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==9106==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==9106==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==9106==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x95F8E23: ???
==9106==    by 0x41AD343: ???
==9106== 
==9106== 2 errors in context 5 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400A4CF: (within /lib/ld-2.7.so)
==9106==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==9106==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==9106==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==9106==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x95F8E23: ???
==9106==    by 0x41AD343: ???
==9106== 
==9106== 2 errors in context 6 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x40087D1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x95F8E23: ???
==9106== 
==9106== 2 errors in context 7 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D33: (within /lib/ld-2.7.so)
==9106==    by 0x40085B1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x95F8E23: ???
==9106== 
==9106== 2 errors in context 8 of 38:
==9106== Invalid read of size 8
==9106==    at 0x415C0C2: ???
==9106==    by 0x919680F: ???
==9106==    by 0x919680F: ???
==9106==    by 0x919680F: ???
==9106==    by 0x918C628: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x918BD2F: ???
==9106==    by 0x918BA1F: ???
==9106==    by 0x918B6DF: ???
==9106==  Address 0x7feffe9f0 is not stack'd, malloc'd or (recently) free'd
==9106== 
==9106== 3 errors in context 9 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EB0: (within /lib/ld-2.7.so)
==9106==    by 0x400AB93: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==  Address 0x640c8c0 is 32 bytes inside a block of size 39 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4005F47: (within /lib/ld-2.7.so)
==9106==    by 0x400885F: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106== 
==9106== 3 errors in context 10 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x400E093: (within /lib/ld-2.7.so)
==9106==    by 0x400A547: (within /lib/ld-2.7.so)
==9106==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==9106==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==9106==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0xB49EC7E: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==  Address 0x925b958 is 48 bytes inside a block of size 50 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4007823: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 3 errors in context 11 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EB0: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==9106==    by 0x905C18F: ???
==9106==    by 0x905B10B: ???
==9106== 
==9106== 3 errors in context 12 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EB0: (within /lib/ld-2.7.so)
==9106==    by 0x4007817: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==9106==    by 0x905C18F: ???
==9106==    by 0x905B10B: ???
==9106== 
==9106== 3 errors in context 13 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015CF0: (within /lib/ld-2.7.so)
==9106==    by 0x400780A: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==9106==    by 0x905C18F: ???
==9106==    by 0x905B10B: ???
==9106== 
==9106== 3 errors in context 14 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015CF0: (within /lib/ld-2.7.so)
==9106==    by 0x4011F31: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==9106==    by 0x905C18F: ???
==9106==    by 0x905B10B: ???
==9106== 
==9106== 4 errors in context 15 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EB0: (within /lib/ld-2.7.so)
==9106==    by 0x4011C2B: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==9106==  Address 0x823d4e8 is 96 bytes inside a block of size 98 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400DF00: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106== 
==9106== 6 errors in context 16 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400522C: (within /lib/ld-2.7.so)
==9106==    by 0x40079E5: (within /lib/ld-2.7.so)
==9106==    by 0x40089D7: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==  Address 0x8f83150 is 8 bytes inside a block of size 9 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4007823: (within /lib/ld-2.7.so)
==9106==    by 0x4007979: (within /lib/ld-2.7.so)
==9106==    by 0x40089D7: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106== 
==9106== 6 errors in context 17 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x4007817: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106== 
==9106== 6 errors in context 18 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D33: (within /lib/ld-2.7.so)
==9106==    by 0x400780A: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106== 
==9106== 6 errors in context 19 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EFE: (within /lib/ld-2.7.so)
==9106==    by 0x40087D1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106== 
==9106== 6 errors in context 20 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015DA1: (within /lib/ld-2.7.so)
==9106==    by 0x40085B1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106== 
==9106== 7 errors in context 21 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x400A99D: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==  Address 0x92083b0 is 16 bytes inside a block of size 20 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x481B94: mono_lookup_pinvoke_call (loader.c:1121)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106== 
==9106== 7 errors in context 22 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x4011C2B: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==  Address 0x63795a8 is 72 bytes inside a block of size 74 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400DF00: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106== 
==9106== 7 errors in context 23 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015ECA: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106== 
==9106== 9 errors in context 24 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D33: (within /lib/ld-2.7.so)
==9106==    by 0x4011F31: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106== 
==9106== 17 errors in context 25 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x4007817: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x417914: mono_main (driver.c:1480)
==9106==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==9106== 
==9106== 17 errors in context 26 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D6E: (within /lib/ld-2.7.so)
==9106==    by 0x400780A: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x417914: mono_main (driver.c:1480)
==9106==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==9106== 
==9106== 20 errors in context 27 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EFE: (within /lib/ld-2.7.so)
==9106==    by 0x4011C2B: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==9106==  Address 0x64d08b0 is 120 bytes inside a block of size 123 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400DF00: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106== 
==9106== 26 errors in context 28 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x400AB93: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==  Address 0x6387e00 is 16 bytes inside a block of size 17 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4008B75: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106== 
==9106== 35 errors in context 29 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EFE: (within /lib/ld-2.7.so)
==9106==    by 0x400AB93: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==9106==  Address 0x63899b8 is 24 bytes inside a block of size 25 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4008B75: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==9106==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==9106==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106== 
==9106== 57 errors in context 30 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x40087D1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106== 
==9106== 57 errors in context 31 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D6E: (within /lib/ld-2.7.so)
==9106==    by 0x40085B1: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==9106==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106== 
==9106== 58 errors in context 32 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EFE: (within /lib/ld-2.7.so)
==9106==    by 0x4007817: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==9106==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==9106==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==9106== 
==9106== 58 errors in context 33 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015DA1: (within /lib/ld-2.7.so)
==9106==    by 0x400780A: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==9106==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==9106==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==9106== 
==9106== 64 errors in context 34 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EFE: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==9106==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==9106==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==9106== 
==9106== 64 errors in context 35 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015DA1: (within /lib/ld-2.7.so)
==9106==    by 0x4011F31: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==9106==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==9106==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==9106== 
==9106== 66 errors in context 36 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x4011C2B: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x417914: mono_main (driver.c:1480)
==9106==  Address 0x646ec60 is 80 bytes inside a block of size 84 alloc'd
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400DF00: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106== 
==9106== 67 errors in context 37 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015EE4: (within /lib/ld-2.7.so)
==9106==    by 0x400DEE6: (within /lib/ld-2.7.so)
==9106==    by 0x4008DA5: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x417914: mono_main (driver.c:1480)
==9106==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==9106== 
==9106== 77 errors in context 38 of 38:
==9106== Invalid read of size 8
==9106==    at 0x4015D6E: (within /lib/ld-2.7.so)
==9106==    by 0x4011F31: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x417914: mono_main (driver.c:1480)
==9106==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
--9106-- 
--9106-- supp:    132 dl-hack3-1
--9106-- supp:  20620 mono - Conditional jump or move depends on uninitialised value
--9106-- supp:  13081 mono - Use of uninitialized value of size 8
==9106== 
==9106== IN SUMMARY: 779 errors from 38 contexts (suppressed: 33833 from 3)
==9106== 
==9106== malloc/free: in use at exit: 9,481,567 bytes in 25,457 blocks.
==9106== malloc/free: 262,203 allocs, 236,746 frees, 218,529,466 bytes allocated.
==9106== 
==9106== searching for pointers to 25,457 not-freed blocks.
==9106== checked 17,529,616 bytes.
==9106== 
==9106== 
==9106== 1 bytes in 1 blocks are still reachable in loss record 1 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA787726: _XlcDefaultMapModifiers (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA787794: XSetLocaleModifiers (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA090743: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106== 
==9106== 
==9106== 6 bytes in 1 blocks are still reachable in loss record 2 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA78107F: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 6 bytes in 1 blocks are still reachable in loss record 3 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC56C6EF: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 6 bytes in 1 blocks are still reachable in loss record 4 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC56C70C: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 8 bytes in 1 blocks are still reachable in loss record 5 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA770EDE: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 8 bytes in 1 blocks are still reachable in loss record 6 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC15C354: _XiGetExtensionVersion (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xC15E6D2: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xC15CFDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 9 bytes in 1 blocks are still reachable in loss record 7 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5F0866F: (within /lib/libselinux.so.1)
==9106==    by 0x5F0A021: (within /lib/libselinux.so.1)
==9106==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==9106==    by 0x7FEFFFFE7: ???
==9106==    by 0x400E165: (within /lib/ld-2.7.so)
==9106==    by 0x400E28D: (within /lib/ld-2.7.so)
==9106==    by 0x4000A99: (within /lib/ld-2.7.so)
==9106==    by 0x2: ???
==9106==    by 0x7FF000222: ???
==9106==    by 0x7FF000227: ???
==9106==    by 0x7FF00022F: ???
==9106== 
==9106== 
==9106== 12 bytes in 1 blocks are still reachable in loss record 8 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA780C32: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 16 bytes in 1 blocks are still reachable in loss record 9 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA7731F2: _XCBInitDisplayLock (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75CAB4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 16 bytes in 1 blocks are still reachable in loss record 10 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xD0404AD: (within /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03FA0C: (within /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03E65E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106== 
==9106== 
==9106== 16 bytes in 1 blocks are still reachable in loss record 11 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91162C: FcBlanksCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB927115: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 16 bytes in 1 blocks are still reachable in loss record 12 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA785EFD: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77B5EE: _XlcOpenConverter (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA781460: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7709CF: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 16 bytes in 1 blocks are still reachable in loss record 13 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA78143C: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7709CF: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 20 bytes in 1 blocks are still reachable in loss record 14 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6B04BA: cairo_font_options_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1884: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77BA5E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 21 bytes in 1 blocks are still reachable in loss record 15 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75CC95: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 16 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA770F24: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 17 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xBB49B8D: XextCreateExtension (in /usr/lib/libXext.so.6.4.0)
==9106==    by 0xC15E735: XInput_find_display (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xC15CFBA: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 18 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EDAA6: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EDF1F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 19 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA76D503: XAddConnectionWatch (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080487: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 20 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA7870D5: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 21 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA77DFB3: _XlcResolveLocaleName (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F40: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 24 bytes in 1 blocks are still reachable in loss record 22 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA780446: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 29 bytes in 3 blocks are still reachable in loss record 23 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AC0C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 24 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xAE36A97: XFixesFindDisplay (in /usr/lib/libXfixes.so.3.1.0)
==9106==    by 0xAE36CE8: XFixesQueryExtension (in /usr/lib/libXfixes.so.3.1.0)
==9106==    by 0xA0805EE: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 25 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xD03F72C: (within /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03E44E: (within /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03FE59: xcb_wait_for_reply (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD04025B: xcb_get_extension_data (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03EB8E: xcb_prefetch_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD03EC0B: xcb_get_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xA75CFE3: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 26 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xAC31C77: XDamageFindDisplay (in /usr/lib/libXdamage.so.1.1.0)
==9106==    by 0xAC322F8: XDamageQueryExtension (in /usr/lib/libXdamage.so.1.1.0)
==9106==    by 0xA080632: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 27 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xAA2FE2C: XCompositeFindDisplay (in /usr/lib/libXcomposite.so.1.0.0)
==9106==    by 0xAA30878: XCompositeQueryExtension (in /usr/lib/libXcomposite.so.1.0.0)
==9106==    by 0xA080610: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 32 bytes in 4 blocks are still reachable in loss record 28 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77F743: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 29 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77099A: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 30 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xBD53ACE: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 31 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB921FCD: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 32 bytes in 1 blocks are still reachable in loss record 32 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x54F554A: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==9106==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==9106==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==9106==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106==    by 0x526D9D: mini_init (mini.c:13999)
==9106== 
==9106== 
==9106== 40 bytes in 1 blocks are still reachable in loss record 33 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6AE78F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BC27D: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6F0137: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6F0506: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BBED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 40 bytes in 1 blocks are still reachable in loss record 34 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA76C41D: _XPollfdCacheInit (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75CAC4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 40 bytes in 1 blocks are still reachable in loss record 35 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77C256: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 41 bytes in 1 blocks are still reachable in loss record 36 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xDDE0E06: XauFileName (in /usr/lib/libXau.so.6.0.0)
==9106==    by 0xDDE1042: XauGetBestAuthByAddr (in /usr/lib/libXau.so.6.0.0)
==9106==    by 0xD040E93: (within /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD040AD1: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106== 
==9106== 
==9106== 48 bytes in 1 blocks are still reachable in loss record 37 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA7711CE: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 48 bytes in 3 blocks are still reachable in loss record 38 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB9201E5: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9212A3: FcPatternGetString (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77A3AA: pango_fc_font_description_from_pattern (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC779CBE: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xB26A0DB: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26AF65: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xA2E4B4A: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77BC3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 48 bytes in 2 blocks are still reachable in loss record 39 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xFC5A752: (within /usr/lib/libdbus-1.so.3.4.0)
==9106==    by 0xFC54B3A: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==9106==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==9106==    by 0xE47C9D7: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0xE47C8AB: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==9106== 
==9106== 
==9106== 48 bytes in 3 blocks are still reachable in loss record 40 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91BB9C: FcFontSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB915432: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 48 bytes in 2 blocks are still reachable in loss record 41 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x50913D: mono_code_manager_new (mono-codeman.c:94)
==9106==    by 0x526E46: mini_init (mini.c:13935)
==9106==    by 0x41776D: mono_main (driver.c:1425)
==9106==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==9106== 
==9106== 
==9106== 52 bytes in 1 blocks are still reachable in loss record 42 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C0FDD1: strdup (in /lib/libc-2.7.so)
==9106==    by 0xB6EDCEE: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EDF99: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 52 bytes in 1 blocks are still reachable in loss record 43 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77342D: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 292 (52 direct, 240 indirect) bytes in 1 blocks are definitely lost in loss record 44 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C7D240: (within /lib/libc-2.7.so)
==9106==    by 0x5C7DAFE: __nss_database_lookup (in /lib/libc-2.7.so)
==9106==    by 0x6ADE42F: ???
==9106==    by 0x6ADF968: ???
==9106==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==9106==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==9106==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106== 
==9106== 
==9106== 56 bytes in 1 blocks are still reachable in loss record 45 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA77E9A9: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77F23B: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 64 bytes in 2 blocks are still reachable in loss record 46 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC9AA9DD: FT_New_Memory (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9AACE0: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xA2E5184: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xA2E2D8E: pango_cairo_font_map_get_default (in /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA0680A9: gdk_pango_context_get_for_screen (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9AB01ED: gtk_widget_create_pango_context (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 64 bytes in 1 blocks are still reachable in loss record 47 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA773EDF: _XReply (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA762755: XQueryPointer (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0A21CE: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA060C9E: gdk_display_get_pointer (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9AB9E4A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9ABA545: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9AC169F: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB278BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 64 bytes in 1 blocks are still reachable in loss record 48 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA761D79: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 64 bytes in 1 blocks are still reachable in loss record 49 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x401346B: (within /lib/ld-2.7.so)
==9106==    by 0x4013D7B: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA3164: __libc_dlclose (in /lib/libc-2.7.so)
==9106==    by 0x5CA4B57: (within /lib/libc-2.7.so)
==9106==    by 0x5CA4878: __libc_freeres (in /lib/libc-2.7.so)
==9106==    by 0x4A1F31C: _vgnU_freeres (vg_preloaded.c:60)
==9106==    by 0x509511D: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5095828: g_spawn_async_with_pipes (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x509590C: g_spawn_async (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0xF4A5190: gconf_activate_server (in /usr/lib/libgconf-2.so.4.1.5)
==9106== 
==9106== 
==9106== 64 bytes in 2 blocks are still reachable in loss record 50 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC15D4CA: XOpenDevice (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xA0A62BC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 72 bytes in 1 blocks are still reachable in loss record 51 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA75CB66: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 72 bytes in 3 blocks are still reachable in loss record 52 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92502A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255B6: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 72 bytes in 3 blocks are still reachable in loss record 53 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92508A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255D2: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 80 bytes in 3 blocks are still reachable in loss record 54 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA77F676: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 80 bytes in 5 blocks are indirectly lost in loss record 55 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C7CE7F: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x6ADE44A: ???
==9106==    by 0x6ADF968: ???
==9106==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==9106==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==9106==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==9106== 
==9106== 
==9106== 85 bytes in 10 blocks are still reachable in loss record 56 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA757323: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xBD53B81: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 96 bytes in 1 blocks are still reachable in loss record 57 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA0A4AF3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 96 bytes in 3 blocks are still reachable in loss record 58 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91F679: FcMatrixCopy (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9250AF: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255D2: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106== 
==9106== 
==9106== 96 bytes in 6 blocks are still reachable in loss record 59 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x40079C3: (within /lib/ld-2.7.so)
==9106==    by 0x40089D7: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106== 
==9106== 
==9106== 102 bytes in 15 blocks are still reachable in loss record 60 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA0A47E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106== 
==9106== 
==9106== 104 bytes in 1 blocks are still reachable in loss record 61 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EE481: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EE608: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 104 bytes in 3 blocks are still reachable in loss record 62 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA77BCDE: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 112 bytes in 1 blocks are still reachable in loss record 63 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75CE7D: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 112 bytes in 1 blocks are still reachable in loss record 64 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA7733C6: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 120 bytes in 3 blocks are still reachable in loss record 65 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6B309A: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BB9B1: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BBE3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 120 bytes in 1 blocks are still reachable in loss record 66 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xFC54AEC: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==9106==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==9106==    by 0xE47C9D7: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0xE47C8AB: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==9106==    by 0x4C745C: mono_runtime_invoke_array (object.c:3214)
==9106== 
==9106== 
==9106== 120 bytes in 3 blocks are still reachable in loss record 67 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EBAD8: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9A7F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C11B5: cairo_surface_finish (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C1234: cairo_surface_destroy (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C6C2C: cairo_pattern_destroy (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6B23B5: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6AB8AA: cairo_set_source (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6AB9AB: cairo_set_source_rgba (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xE68F884: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE69408C: ubuntulooks_draw_progressbar_trough (in /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68B82B: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106== 
==9106== 
==9106== 128 bytes in 1 blocks are still reachable in loss record 68 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EBBAB: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EC72C: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E904F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA08771A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA06018C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 128 bytes in 1 blocks are still reachable in loss record 69 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75CD92: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 128 bytes in 4 blocks are still reachable in loss record 70 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EBFCB: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9086: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9780: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C12C1: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C1395: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xE69398B: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE693F7D: ubuntulooks_draw_progressbar_trough (in /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68B82B: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 136 bytes in 1 blocks are still reachable in loss record 71 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB915621: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BE9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 144 bytes in 6 blocks are still reachable in loss record 72 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92340C: FcStrSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB915644: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BE9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 144 bytes in 9 blocks are still reachable in loss record 73 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x512ED3: mono_dl_open (mono-dl.c:298)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x559420: mono_jit_runtime_invoke (mini.c:13163)
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106== 
==9106== 
==9106== 152 bytes in 1 blocks are still reachable in loss record 74 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA7BFB7F: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75D0DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 152 bytes in 1 blocks are still reachable in loss record 75 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6C6711: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6B291D: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6ABEEE: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA060197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 152 bytes in 3 blocks are still reachable in loss record 76 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4007823: (within /lib/ld-2.7.so)
==9106==    by 0x40085CE: (within /lib/ld-2.7.so)
==9106==    by 0x4012048: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==9106==    by 0x9E31151: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 160 bytes in 5 blocks are still reachable in loss record 77 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xBB49BDB: XextAddDisplay (in /usr/lib/libXext.so.6.4.0)
==9106==    by 0xBB44AC8: XShapeQueryExtension (in /usr/lib/libXext.so.6.4.0)
==9106==    by 0xA08065C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106== 
==9106== 
==9106== 160 bytes in 5 blocks are indirectly lost in loss record 78 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C6B0D9: tsearch (in /lib/libc-2.7.so)
==9106==    by 0x5C7CE29: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x6ADE44A: ???
==9106==    by 0x6ADF968: ???
==9106==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==9106==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==9106==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==9106==    by 0x4E8D61: load_in_path (assembly.c:399)
==9106==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==9106== 
==9106== 
==9106== 168 bytes in 1 blocks are still reachable in loss record 79 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75CD07: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 168 bytes in 7 blocks are still reachable in loss record 80 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924F19: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255F1: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925A31: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9269AC: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 168 bytes in 1 blocks are still reachable in loss record 81 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA780495: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 168 bytes in 1 blocks are still reachable in loss record 82 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EC796: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E904F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA08771A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA06018C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 168 bytes in 7 blocks are still reachable in loss record 83 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924EC4: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255E1: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925A31: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9269AC: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 176 bytes in 2 blocks are still reachable in loss record 84 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA770D19: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 176 bytes in 1 blocks are still reachable in loss record 85 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA780472: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 182 bytes in 3 blocks are still reachable in loss record 86 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xA77BD15: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 200 bytes in 1 blocks are still reachable in loss record 87 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC15E6B4: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xC15CFDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==9106==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106== 
==9106== 
==9106== 208 bytes in 13 blocks are still reachable in loss record 88 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA770C80: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 256 bytes in 1 blocks are still reachable in loss record 89 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xB9115B5: FcBlanksAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB927092: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 256 bytes in 1 blocks are still reachable in loss record 90 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91BB7F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9268C6: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 256 bytes in 2 blocks are still reachable in loss record 91 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA757245: XAddExtension (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56C620: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 288 (256 direct, 32 indirect) bytes in 1 blocks are definitely lost in loss record 92 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92181B: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB922105: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB922219: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926C08: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 264 bytes in 1 blocks are still reachable in loss record 93 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6EDF7E: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 336 bytes in 14 blocks are still reachable in loss record 94 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB9250FA: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9255A8: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925800: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926A94: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 346 bytes in 12 blocks are still reachable in loss record 95 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4005F47: (within /lib/ld-2.7.so)
==9106==    by 0x400896C: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106== 
==9106== 
==9106== 352 bytes in 11 blocks are still reachable in loss record 96 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5091E1: new_codechunk (mono-codeman.c:293)
==9106==    by 0x509371: mono_code_manager_reserve_align (mono-codeman.c:371)
==9106==    by 0x52A227: mono_codegen (mini.c:11862)
==9106==    by 0x557F23: mini_method_compile (mini.c:12515)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x559420: mono_jit_runtime_invoke (mini.c:13163)
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x552B81: mono_method_to_ir (mini.c:7707)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106== 
==9106== 
==9106== 362 bytes in 38 blocks are still reachable in loss record 97 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77BDE8: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 400 bytes in 1 blocks are still reachable in loss record 98 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xC793887: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC793E88: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC793FCD: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xEBA2392: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==9106==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xC7790EE: pango_fc_font_create_metrics_for_context (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA2E218F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 408 bytes in 1 blocks are still reachable in loss record 99 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4011CF4: (within /lib/ld-2.7.so)
==9106==    by 0x400C9BD: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x5C7D114: (within /lib/libc-2.7.so)
==9106==    by 0x5C83A1A: gethostbyname2_r (in /lib/libc-2.7.so)
==9106== 
==9106== 
==9106== 408 bytes in 51 blocks are still reachable in loss record 100 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA7710AF: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 424 bytes in 1 blocks are still reachable in loss record 101 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6F0037: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6F0506: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BBED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 432 bytes in 27 blocks are still reachable in loss record 102 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA0A4EA7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A468F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 456 bytes in 1 blocks are still reachable in loss record 103 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC56C601: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 456 bytes in 3 blocks are still reachable in loss record 104 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6C5104: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BEDC3: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BFCC4: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6B16BC: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6AAD0F: cairo_stroke_preserve (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6AAD28: cairo_stroke (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xE69408C: ubuntulooks_draw_progressbar_trough (in /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0xE68B82B: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 464 bytes in 27 blocks are still reachable in loss record 105 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA0A472F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106== 
==9106== 
==9106== 492 bytes in 41 blocks are still reachable in loss record 106 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77C9D1: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 512 bytes in 1 blocks are still reachable in loss record 107 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA757684: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA757C42: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0965FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA097BE5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0804D0: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 560 bytes in 7 blocks are still reachable in loss record 108 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77E967: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77F23B: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 584 bytes in 1 blocks are still reachable in loss record 109 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xB6B2C6B: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6B2EAE: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6AE697: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BC548: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BCDE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E2978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77EB64: pango_ot_buffer_output (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xEBA24A5: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==9106==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 584 bytes in 4 blocks are still reachable in loss record 110 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB923D0E: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB923E1D: FcStrSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92619B: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106== 
==9106== 
==9106== 606 bytes in 41 blocks are still reachable in loss record 111 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77CBD9: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 608 bytes in 38 blocks are still reachable in loss record 112 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77BE33: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 620 bytes in 1 blocks are still reachable in loss record 113 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xD03E7C8: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 672 bytes in 42 blocks are still reachable in loss record 114 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91FEB6: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91FF62: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9201D6: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9223A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9224F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C0EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 677 bytes in 51 blocks are still reachable in loss record 115 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AF7B: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 688 bytes in 2 blocks are still reachable in loss record 116 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xB6B30C1: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BB9B1: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BBE3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 816 bytes in 34 blocks are still reachable in loss record 117 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924E79: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925601: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925800: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926A94: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 832 bytes in 52 blocks are still reachable in loss record 118 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AE5E: _XlcAddCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AC92: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 840 bytes in 15 blocks are still reachable in loss record 119 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xFC5C9EA: (within /usr/lib/libdbus-1.so.3.4.0)
==9106==    by 0xFC54B0C: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==9106==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==9106==    by 0xE47C9D7: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0xE47C8AB: ???
==9106==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==9106==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==9106== 
==9106== 
==9106== 848 bytes in 1 blocks are still reachable in loss record 120 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4011E14: (within /lib/ld-2.7.so)
==9106==    by 0x4012335: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==9106== 
==9106== 
==9106== 864 bytes in 27 blocks are still reachable in loss record 121 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA0A470B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106== 
==9106== 
==9106== 920 bytes in 16 blocks are still reachable in loss record 122 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91253C: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB912B32: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB912C48: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9128BD: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB912999: FcDirCacheLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB918AC2: FcDirCacheRead (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9151E8: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB915455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 952 bytes in 2 blocks are still reachable in loss record 123 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75CEF1: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 1,008 bytes in 1 blocks are still reachable in loss record 124 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77C1F5: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,029 bytes in 30 blocks are still reachable in loss record 125 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA757713: _XUpdateAtomCache (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA757CF8: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0965FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA09BBC3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA09BE26: gdk_window_set_decorations (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9AC26DA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0x9AB3956: gtk_widget_realize (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,056 bytes in 44 blocks are still reachable in loss record 126 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92113C: FcPatternCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EF1D: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 1,068 bytes in 52 blocks are still reachable in loss record 127 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AF1C: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,092 bytes in 35 blocks are still reachable in loss record 128 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB923E6F: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9240F5: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB924248: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926DD2: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 1,280 bytes in 10 blocks are still reachable in loss record 129 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA7572FB: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xBD53B81: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 1,344 bytes in 1 blocks are still reachable in loss record 130 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91FDCA: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB920207: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9223A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9224F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C0EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 1,373 bytes in 55 blocks are still reachable in loss record 131 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4008B75: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106== 
==9106== 
==9106== 1,376 bytes in 43 blocks are indirectly lost in loss record 132 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91CCFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91CDFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB921F09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92201C: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 1,416 bytes in 1 blocks are still reachable in loss record 133 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xBD54210: XRenderQueryFormats (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xBD549CC: XRenderQueryVersion (in /usr/lib/libXrender.so.1.3.0)
==9106==    by 0xC56C9E1: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 1,416 bytes in 3 blocks are still reachable in loss record 134 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6E9065: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9602: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C12C1: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C1395: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C47CA: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C56A5: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6E9C80: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BF987: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C2E21: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C2195: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6C2B1D: (within /usr/lib/libcairo.so.2.17.3)
==9106== 
==9106== 
==9106== 1,584 bytes in 66 blocks are still reachable in loss record 135 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA771023: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 1,600 bytes in 20 blocks are possibly lost in loss record 136 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0xB27C9EF: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27CB3E: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB280705: g_type_register_fundamental (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB289DCB: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27F7BB: g_type_init_with_debug_flags (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xA05FBBE: gdk_pre_parse_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,630 bytes in 96 blocks are definitely lost in loss record 137 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x95F8E23: ???
==9106==    by 0x41AD343: ???
==9106== 
==9106== 
==9106== 1,640 bytes in 41 blocks are still reachable in loss record 138 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77C97C: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,728 bytes in 27 blocks are still reachable in loss record 139 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77B4F0: _XlcSetConverter (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA785120: _XlcAddUtf8LocaleConverters (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A084B: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 1,780 bytes in 89 blocks are still reachable in loss record 140 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6B047C: cairo_font_options_copy (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1E4C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E4C2C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77BC3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 1,871 bytes in 70 blocks are still reachable in loss record 141 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400AC49: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106== 
==9106== 
==9106== 2,048 bytes in 1 blocks are still reachable in loss record 142 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77BF9C: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 2,048 bytes in 1 blocks are still reachable in loss record 143 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xB91BB2F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91519A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB915201: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB915455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 2,056 bytes in 2 blocks are definitely lost in loss record 144 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x507DB94: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x507F22D: g_slist_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4CCCEA: mono_thread_push_appdomain_ref (threads.c:2967)
==9106==    by 0x4CE6B7: start_wrapper (threads.c:569)
==9106==    by 0x4F7692: thread_start_routine (threads.c:279)
==9106==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==9106==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==9106==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==9106== 
==9106== 
==9106== 2,064 bytes in 1 blocks are still reachable in loss record 145 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6BB996: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BBE3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 2,240 bytes in 32 blocks are still reachable in loss record 146 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4012436: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==9106==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==9106== 
==9106== 
==9106== 2,520 bytes in 21 blocks are still reachable in loss record 147 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB6BC4E9: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BCDE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E2978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xC77EB64: pango_ot_buffer_output (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xEBA24A5: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==9106==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xC7790EE: pango_fc_font_create_metrics_for_context (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 2,525 bytes in 48 blocks are still reachable in loss record 148 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AA7D: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 2,616 bytes in 1 blocks are still reachable in loss record 149 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA75C790: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 2,784 bytes in 4 blocks are still reachable in loss record 150 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xC9AFD5B: ft_mem_qrealloc (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9AFDFA: ft_mem_realloc (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9B3110: FT_GlyphLoader_CheckPoints (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9BC585: (within /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9BCB12: (within /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9BDC6D: (within /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9B13B0: FT_Load_Glyph (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xB6EEB69: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BC531: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6BCDE2: cairo_scaled_font_glyph_extents (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E2978: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 3,744 bytes in 52 blocks are still reachable in loss record 151 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA77AEC6: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 4,096 bytes in 1 blocks are still reachable in loss record 152 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA761B90: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 4,200 bytes in 175 blocks are still reachable in loss record 153 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB91366A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB927179: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 4,628 bytes in 194 blocks are still reachable in loss record 154 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA7710FF: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==9106==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 4,720 bytes in 12 blocks are still reachable in loss record 155 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400C679: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==9106== 
==9106== 
==9106== 5,304 bytes in 221 blocks are still reachable in loss record 156 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924DE9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925D79: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 5,440 bytes in 34 blocks are still reachable in loss record 157 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA74A161: XCreateGC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA08E36A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x996411B: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x504766F: g_cache_insert (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x9964534: gtk_gc_get (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9A1BDFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0x9A13FD7: gtk_style_attach (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 5,888 bytes in 184 blocks are indirectly lost in loss record 158 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB9145A9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB9149D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91F02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 6,016 bytes in 188 blocks are still reachable in loss record 159 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924BA9: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925DF3: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 6,048 bytes in 60 blocks are still reachable in loss record 160 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x400C582: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==9106==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==9106==    by 0x5C7D114: (within /lib/libc-2.7.so)
==9106==    by 0x5C31ABC: getpwnam_r (in /lib/libc-2.7.so)
==9106==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 6,381 bytes in 1 blocks are still reachable in loss record 161 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA75D346: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 6,528 bytes in 204 blocks are still reachable in loss record 162 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB924F8D: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB925E50: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 6,628 bytes in 308 blocks are still reachable in loss record 163 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0xB28048B: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB281FFE: g_type_register_static (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2821C7: g_type_register_static_simple (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0x99F624C: gtk_scale_get_type (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xE68B39C: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==9106==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 8,528 bytes in 41 blocks are still reachable in loss record 164 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA76CD75: _XEnq (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA773CED: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA773FA4: _XReply (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA757C9D: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA0965FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A0322: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA0A2DDB: gdk_window_new (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA08059C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106== 
==9106== 
==9106== 8,589 bytes in 596 blocks are still reachable in loss record 165 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB923DC3: FcStrCopy (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB923E08: FcStrSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB92619B: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106== 
==9106== 
==9106== 8,680 bytes in 1 blocks are still reachable in loss record 166 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xD03E57E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==9106==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106== 
==9106== 
==9106== 9,096 bytes in 70 blocks are still reachable in loss record 167 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x400F8F4: (within /lib/ld-2.7.so)
==9106==    by 0x4012328: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==9106==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==9106==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==9106==    by 0x4818B0: cached_module_load (loader.c:1048)
==9106==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==9106== 
==9106== 
==9106== 11,521 bytes in 192 blocks are still reachable in loss record 168 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x5BE3097: asprintf (in /lib/libc-2.7.so)
==9106==    by 0x5F085DD: (within /lib/libselinux.so.1)
==9106==    by 0x5F0A021: (within /lib/libselinux.so.1)
==9106==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==9106==    by 0x7FEFFFFE7: ???
==9106==    by 0x400E165: (within /lib/ld-2.7.so)
==9106==    by 0x400E28D: (within /lib/ld-2.7.so)
==9106==    by 0x4000A99: (within /lib/ld-2.7.so)
==9106==    by 0x2: ???
==9106==    by 0x7FF000222: ???
==9106== 
==9106== 
==9106== 12,624 bytes in 307 blocks are still reachable in loss record 169 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB921211: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB922089: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 13,080 bytes in 545 blocks are still reachable in loss record 170 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB92515A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926C59: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==9106==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==9106== 
==9106== 
==9106== 16,352 bytes in 2 blocks are still reachable in loss record 171 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xA761964: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA761D39: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==9106== 
==9106== 
==9106== 16,384 bytes in 1 blocks are still reachable in loss record 172 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0xA75CB15: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==9106==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0x9844B6B: ???
==9106==    by 0x41AD377: ???
==9106==    by 0x41AD245: ???
==9106==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==9106==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==9106==    by 0x417A2F: mono_main (driver.c:942)
==9106== 
==9106== 
==9106== 19,645 bytes in 251 blocks are still reachable in loss record 173 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==9106==    by 0x5BE3097: asprintf (in /lib/libc-2.7.so)
==9106==    by 0x5F08633: (within /lib/libselinux.so.1)
==9106==    by 0x5F0A021: (within /lib/libselinux.so.1)
==9106==    by 0x5EFBBBA: (within /lib/libselinux.so.1)
==9106==    by 0x7FEFFFFE7: ???
==9106==    by 0x400E165: (within /lib/ld-2.7.so)
==9106==    by 0x400E28D: (within /lib/ld-2.7.so)
==9106==    by 0x4000A99: (within /lib/ld-2.7.so)
==9106==    by 0x2: ???
==9106==    by 0x7FF000222: ???
==9106== 
==9106== 
==9106== 36,608 bytes in 1,144 blocks are indirectly lost in loss record 174 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xB921FCD: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 67,648 (23,808 direct, 43,840 indirect) bytes in 43 blocks are definitely lost in loss record 175 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0xB921792: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB922105: (within /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==9106==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==9106==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106== 
==9106== 
==9106== 68,544 bytes in 36 blocks are possibly lost in loss record 176 of 184
==9106==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==9106==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==9106==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0xB276438: g_signal_connect_data (in /usr/lib/libgobject-2.0.so.0.1600.4)
==9106==    by 0xE477E5F: ???
==9106==    by 0x63686F7: ???
==9106==    by 0x935C02F: ???
==9106== 
==9106== 
==9106== 81,358 bytes in 70 blocks are still reachable in loss record 177 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x400A9D4: (within /lib/ld-2.7.so)
==9106==    by 0x40061E4: (within /lib/ld-2.7.so)
==9106==    by 0x4008677: (within /lib/ld-2.7.so)
==9106==    by 0x400BE0C: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x400C4D0: (within /lib/ld-2.7.so)
==9106==    by 0x40120A8: (within /lib/ld-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106==    by 0x401191A: (within /lib/ld-2.7.so)
==9106==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==9106==    by 0x400DDF5: (within /lib/ld-2.7.so)
==9106== 
==9106== 
==9106== 84,921 bytes in 108 blocks are still reachable in loss record 178 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC9AE30F: ft_mem_qalloc (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9AFC52: ft_mem_alloc (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9B062F: FT_New_Library (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xC9AACF3: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==9106==    by 0xB6EDACB: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EDF1F: (within /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==9106==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==9106==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==9106==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 246,528 bytes in 594 blocks are still reachable in loss record 179 of 184
==9106==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==9106==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5082243: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x508228D: g_string_append_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x5082397: g_string_append_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4AC914: dis_one (debug-helpers.c:409)
==9106==    by 0x4ACC75: mono_disasm_code (debug-helpers.c:552)
==9106==    by 0x49B445: mono_debug_add_method (mono-debug.c:649)
==9106==    by 0x419D31: mono_debug_close_method (debug-mini.c:284)
==9106==    by 0x557F23: mini_method_compile (mini.c:12515)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x558ADA: mono_jit_compile_method (mini.c:12810)
==9106== 
==9106== 
==9106== 379,200 bytes in 1 blocks are still reachable in loss record 180 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x9E2DE94: gdk_pixbuf_new (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==9106==    by 0xE899F57: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==9106==    by 0xD26C9F2: (within /usr/lib/libpng12.so.0.15.0)
==9106==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==9106==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==9106==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==9106==    by 0x9E338D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==9106==    by 0xE4794CB: ???
==9106==    by 0x63686F7: ???
==9106==    by 0x43: ???
==9106==    by 0x400007E: (within /lib/ld-2.7.so)
==9106== 
==9106== 
==9106== 1,153,808 bytes in 2,207 blocks are still reachable in loss record 181 of 184
==9106==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==9106==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==9106==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x506035D: g_list_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x432953: mono_arch_get_allocatable_int_vars (mini-amd64.c:910)
==9106==    by 0x5579A9: mini_method_compile (mini.c:12490)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106==    by 0x8FCA917: ???
==9106==    by 0x85E7E9F: ???
==9106== 
==9106== 
==9106== 1,890,094 bytes in 2,630 blocks are still reachable in loss record 182 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0xC782201: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC79016E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC790C2E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC7921A3: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC7928A6: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77F604: pango_ot_info_get_gsub (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77F654: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC77FEDB: pango_ot_info_find_script (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC7809B9: pango_ot_ruleset_new_for (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC780A75: pango_ot_ruleset_new_from_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106==    by 0xC780BBE: pango_ot_ruleset_get_for_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==9106== 
==9106== 
==9106== 2,249,470 bytes in 9,144 blocks are still reachable in loss record 183 of 184
==9106==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==9106==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x4E16CF: mono_debug_symfile_lookup_method (debug-mono-symfile.c:413)
==9106==    by 0x499F04: lookup_method_func (mono-debug.c:467)
==9106==    by 0x505577D: g_hash_table_foreach (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x499EAE: _mono_debug_lookup_method (mono-debug.c:481)
==9106==    by 0x49AFDA: mono_debug_add_method (mono-debug.c:568)
==9106==    by 0x419D31: mono_debug_close_method (debug-mini.c:284)
==9106==    by 0x557F23: mini_method_compile (mini.c:12515)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106== 
==9106== 
==9106== 3,001,505 bytes in 4,276 blocks are still reachable in loss record 184 of 184
==9106==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==9106==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==9106==    by 0x49779C: mono_metadata_type_dup (metadata.c:4142)
==9106==    by 0x480547: inflate_generic_signature (loader.c:613)
==9106==    by 0x480AF1: mono_method_signature (loader.c:1909)
==9106==    by 0x538F29: mono_method_to_ir (mini.c:5740)
==9106==    by 0x5596EC: inline_method (mini.c:4018)
==9106==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==9106==    by 0x5570D3: mini_method_compile (mini.c:12275)
==9106==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==9106==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==9106==    by 0x415B164: ???
==9106== 
==9106== LEAK SUMMARY:
==9106==    definitely lost: 27,802 bytes in 143 blocks.
==9106==    indirectly lost: 44,112 bytes in 1,381 blocks.
==9106==      possibly lost: 70,144 bytes in 56 blocks.
==9106==    still reachable: 9,339,509 bytes in 23,877 blocks.
==9106==         suppressed: 0 bytes in 0 blocks.
--9106--  memcheck: sanity checks: 2024 cheap, 46 expensive
--9106--  memcheck: auxmaps: 0 auxmap entries (0k, 0M) in use
--9106--  memcheck: auxmaps_L1: 0 searches, 0 cmps, ratio 0:10
--9106--  memcheck: auxmaps_L2: 0 searches, 0 nodes
--9106--  memcheck: SMs: n_issued      = 571 (9136k, 8M)
--9106--  memcheck: SMs: n_deissued    = 11 (176k, 0M)
--9106--  memcheck: SMs: max_noaccess  = 524287 (8388592k, 8191M)
--9106--  memcheck: SMs: max_undefined = 4 (64k, 0M)
--9106--  memcheck: SMs: max_defined   = 3333 (53328k, 52M)
--9106--  memcheck: SMs: max_non_DSM   = 561 (8976k, 8M)
--9106--  memcheck: max sec V bit nodes:    1426 (122k, 0M)
--9106--  memcheck: set_sec_vbits8 calls: 46309 (new: 1426, updates: 44883)
--9106--  memcheck: max shadow mem size:   13242k, 12M
--9106-- translate:            fast SP updates identified: 60,206 ( 86.2%)
--9106-- translate:   generic_known SP updates identified: 8,328 ( 11.9%)
--9106-- translate: generic_unknown SP updates identified: 1,278 (  1.8%)
--9106--     tt/tc: 4,167,006 tt lookups requiring 9,480,995 probes
--9106--     tt/tc: 4,167,006 fast-cache updates, 2,390 flushes
--9106--  transtab: new        89,779 (1,708,287 -> 33,771,965; ratio 197:10) [89,779 scs]
--9106--  transtab: dumped     0 (0 -> ??)
--9106--  transtab: discarded  2,905 (74,101 -> ??)
--9106-- scheduler: 201,757,247 jumps (bb entries).
--9106-- scheduler: 2,024/4,520,255 major/minor sched events.
--9106--    sanity: 2025 cheap, 46 expensive checks.
--9106--    exectx: 196,613 lists, 155,389 contexts (avg 0 per list)
--9106--    exectx: 532,897 searches, 495,820 full compares (930 per 1000)
--9106--    exectx: 2,103,362 cmp2, 167,916 cmp4, 0 cmpAll
--9106--  errormgr: 373 supplist searches, 17,938 comparisons during search
--9106--  errormgr: 34,612 errlist searches, 311,735 comparisons during search
--7947-- Reading syms from /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so (0x1418B000)
--7947-- Reading debug info from /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so...
--7947-- ... CRC mismatch (computed a1d4d3de wanted e712bd61)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/librsvg-2.so.2.22.2 (0x143A3000)
--7947-- Reading debug info from /usr/lib/librsvg-2.so.2.22.2...
--7947-- ... CRC mismatch (computed 5d8a19ba wanted 1379147e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgsf-1.so.114.0.7 (0x145D9000)
--7947-- Reading debug info from /usr/lib/libgsf-1.so.114.0.7...
--7947-- ... CRC mismatch (computed 255ecc8f wanted fedaae2a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libcroco-0.6.so.3.0.1 (0x14814000)
--7947-- Reading debug info from /usr/lib/libcroco-0.6.so.3.0.1...
--7947-- ... CRC mismatch (computed 2f118585 wanted 34b37c38)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libbz2.so.1.0.4 (0x14A4F000)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1526680F: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x152665D7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0xE47B3BB: ???
==7947==  Address 0x7feffe7b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--7947-- Reading syms from /usr/mono-2.0/lib/libMonoPosixHelper.so (0x158C9000)
--7947-- memcheck GC: 2048 nodes, 2048 survivors (100.0%)
--7947-- memcheck GC: increase table size to 4096
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x51E420: GC_push_all_eager (mark.c:1468)
==7947==    by 0x51E491: GC_push_all_stack (mark.c:1521)
==7947==    by 0x5192DD: pthread_push_all_stacks (pthread_stop_world.c:278)
==7947==    by 0x519357: GC_push_all_stacks (pthread_stop_world.c:309)
==7947==    by 0x5807A5: GC_default_push_other_roots (os_dep.c:2078)
==7947==    by 0x51BE20: GC_push_roots (mark_rts.c:646)
==7947==    by 0x51C980: GC_mark_some (mark.c:326)
==7947==    by 0x51A449: GC_stopped_mark (alloc.c:543)
==7947==    by 0x51A026: GC_try_to_collect_inner (alloc.c:382)
==7947==    by 0x51B048: GC_collect_or_expand (alloc.c:1045)
==7947==    by 0x51B2C6: GC_allocobj (alloc.c:1125)
==7947==    by 0x51EFEE: GC_generic_malloc_inner (malloc.c:136)
==7947==  Address 0x16f58e00 is on thread 5's stack
--7947-- memcheck GC: 4096 nodes, 3668 survivors ( 89.5%)
--7947-- memcheck GC: increase table size to 8192
--7947-- Reading syms from /usr/mono-2.0/lib/libgdksharpglue-2.so (0x17565000)
--7947-- Reading syms from /usr/lib/gnome-vfs-2.0/modules/libfile.so (0x1779B000)
--7947-- Reading debug info from /usr/lib/gnome-vfs-2.0/modules/libfile.so...
--7947-- ... CRC mismatch (computed e965ce71 wanted 9d6f55f7)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libacl.so.1.1.0 (0x179C0000)
--7947-- Reading debug info from /lib/libacl.so.1.1.0...
--7947-- ... CRC mismatch (computed e1c130eb wanted e10d0368)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libfam.so.0.0.0 (0x17BC7000)
--7947-- Reading debug info from /usr/lib/libfam.so.0.0.0...
--7947-- ... CRC mismatch (computed 14aafade wanted 6780a44b)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libattr.so.1.1.0 (0x17DCF000)
--7947-- Reading debug info from /lib/libattr.so.1.1.0...
--7947-- ... CRC mismatch (computed 270e5d3e wanted e021b06d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/mono-2.0/lib/libp4api.so (0x18353000)
--7947-- REDIR: 0xd7675d0 (operator new(unsigned long)) redirected to 0x4c237a0 (operator new(unsigned long))
--7947-- REDIR: 0xd767700 (operator new[](unsigned long)) redirected to 0x4c23420 (operator new[](unsigned long))
--7947-- REDIR: 0xd765f50 (operator delete[](void*)) redirected to 0x4c22330 (operator delete[](void*))
--7947-- Reading syms from /lib/libnss_mdns4_minimal.so.2 (0x1861C000)
--7947-- Reading debug info from /lib/libnss_mdns4_minimal.so.2...
--7947-- ... CRC mismatch (computed bdc1e1df wanted 44ddd8a1)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libnss_dns-2.7.so (0x1881E000)
--7947-- Reading debug info from /lib/libnss_dns-2.7.so...
--7947-- ... CRC mismatch (computed 89e8c2cc wanted 4c55bb8e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgdiplus.so.0.0.0 (0x19475000)
--7947-- Reading debug info from /usr/lib/libgdiplus.so.0.0.0...
--7947-- ... CRC mismatch (computed f5f0cde3 wanted ffb12385)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libtiff.so.4.2.1 (0x196D9000)
--7947-- Reading debug info from /usr/lib/libtiff.so.4.2.1...
--7947-- ... CRC mismatch (computed 77d37870 wanted c23ecbe9)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libjpeg.so.62.0.0 (0x19932000)
--7947-- Reading debug info from /usr/lib/libjpeg.so.62.0.0...
--7947-- ... CRC mismatch (computed 6be639f1 wanted d31f1928)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgif.so.4.1.6 (0x19B55000)
--7947-- Reading debug info from /usr/lib/libgif.so.4.1.6...
--7947-- ... CRC mismatch (computed 0ce81d21 wanted 8531d7d5)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libexif.so.12.2.0 (0x19D5D000)
--7947-- Reading debug info from /usr/lib/libexif.so.12.2.0...
--7947-- ... CRC mismatch (computed f5a7a222 wanted eccf6753)
--7947--    object doesn't have a symbol table
==7947== 
==7947== Thread 6:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1708F0FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0BDF: ???
==7947==    by 0xA: ???
==7947==    by 0x1708F0FF: ???
==7947==    by 0x170A0BDF: ???
==7947==    by 0xFFFFFFFEFFFFFFFF: ???
==7947==    by 0x16FA7D1F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1902F27C: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x16FC6C7F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0B8F: ???
==7947==    by 0xA: ???
==7947==    by 0x16FC6C7F: ???
==7947==    by 0x170A0B8F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803AC7F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0A4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803AC7F: ???
==7947==    by 0x170A0A4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A77F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A09FF: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A77F: ???
==7947==    by 0x170A09FF: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A3FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A07CF: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A3FF: ???
==7947==    by 0x170A07CF: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A37F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x16FE7F4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A37F: ???
==7947==    by 0x16FE7F4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A2FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1808DF9F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A2FF: ???
==7947==    by 0x1808DF9F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 1:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24368: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2437A: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2438C: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243B7: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243C8: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243F0: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24400: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24210: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC242B6: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC24318: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24322: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24356: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24413: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2441F: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC2447F: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24544: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24186: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24696: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC246A7: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC25DCB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC278B0: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC246EB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947== 
==7947== Thread 6:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A27F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1808DF4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A27F: ???
==7947==    by 0x1808DF4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 1:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1FEBA: crc32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD255AAC: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25D394: png_write_chunk_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25DF96: png_write_chunk (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25EEA4: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25EFBE: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0x9E31909: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E32DEA: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947==    by 0x1806D6DF: ???
==7947==    by 0x17FEF31F: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1FEC4: crc32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD255AAC: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26BF77: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC294E4: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC28C71: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC28CB4: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28BB5: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28BC3: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2946A: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC29484: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC2942F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2943F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC29459: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC294A5: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC292AA: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F282: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F294: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F29F: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F366: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F51B: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F54D: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F5A1: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F600: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F60C: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F615: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F637: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2931F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC27FE9: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC27FFB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0x4C2502A: memcpy (mc_replace_strmem.c:402)
==7947==    by 0xCC280BD: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC280CC: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28697: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== More than 100 errors detected.  Subsequent errors
==7947== will still be recorded, but in less detail than before.
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC286E9: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xD26BE48: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947==    by 0x1806D6DF: ???
--7947-- REDIR: 0xd765f10 (operator delete(void*)) redirected to 0x4c22750 (operator delete(void*))
--7947-- memcheck GC: 8192 nodes, 7540 survivors ( 92.0%)
--7947-- memcheck GC: increase table size to 16384
==7947== 
==7947== Thread 8:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5AE593: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af6a0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5AE5AF: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af540 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af860 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 11:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1ACAB7B7: ???
==7947==    by 0x1ACA69F5: ???
==7947==    by 0x1ACA66BB: ???
==7947==    by 0x4C76DE: mono_runtime_invoke_array (object.c:3228)
==7947==    by 0x4C9E8A: mono_message_invoke (object.c:4743)
==7947==    by 0x4EC784: mono_async_invoke (threadpool.c:938)
==7947==    by 0x4ED9A9: async_invoke_io_thread (threadpool.c:260)
==7947==    by 0x4CE76C: start_wrapper (threads.c:621)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==  Address 0x1b0b5800 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 8:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7afbc0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--7947-- memcheck GC: 16384 nodes, 15770 survivors ( 96.2%)
--7947-- memcheck GC: increase table size to 32768
==7947== 
==7947== Thread 1:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1CA58F8F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x1ABC277F: ???
==7947==    by 0x1B54065F: ???
==7947==    by 0x1CA58ED7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1CA58D4B: ???
==7947==  Address 0x7feffc5a0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 13:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1CA691DF: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1ce78c40 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== Thread 1:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1D97C41F: ???
==7947==    by 0x1D97BFC1: ???
==7947==    by 0x1D97BE07: ???
==7947==    by 0x170C8DC7: ???
==7947==  Address 0x7feffc770 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--7947-- Reading syms from /usr/lib/libsvn_client-1.so.1.0.0 (0x1D995000)
--7947-- Reading debug info from /usr/lib/libsvn_client-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 286a212e wanted 56867854)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_wc-1.so.1.0.0 (0x1DBBF000)
--7947-- Reading debug info from /usr/lib/libsvn_wc-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 8e2098a5 wanted 295fe310)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_ra-1.so.1.0.0 (0x1DDF1000)
--7947-- Reading debug info from /usr/lib/libsvn_ra-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 2ec6f7e2 wanted 06e773ae)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_delta-1.so.1.0.0 (0x1DFF5000)
--7947-- Reading debug info from /usr/lib/libsvn_delta-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 481e4984 wanted 8b8b0f0d)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_diff-1.so.1.0.0 (0x1E1FF000)
--7947-- Reading debug info from /usr/lib/libsvn_diff-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 7dbaa55d wanted 52dce1ca)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_subr-1.so.1.0.0 (0x1E406000)
--7947-- Reading debug info from /usr/lib/libsvn_subr-1.so.1.0.0...
--7947-- ... CRC mismatch (computed cc615e4e wanted fdded8af)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libapr-1.so.0.2.11 (0x1E63A000)
--7947-- Reading debug info from /usr/lib/libapr-1.so.0.2.11...
--7947-- ... CRC mismatch (computed fa350136 wanted 68786032)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libaprutil-1.so.0.2.11 (0x1E863000)
--7947-- Reading debug info from /usr/lib/libaprutil-1.so.0.2.11...
--7947-- ... CRC mismatch (computed be9576e4 wanted 8c18d0b5)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_ra_local-1.so.1.0.0 (0x1EA81000)
--7947-- Reading debug info from /usr/lib/libsvn_ra_local-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 2a039916 wanted 08106e1e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_repos-1.so.1.0.0 (0x1EC88000)
--7947-- Reading debug info from /usr/lib/libsvn_repos-1.so.1.0.0...
--7947-- ... CRC mismatch (computed ef6870c3 wanted 9f6c2377)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_fs-1.so.1.0.0 (0x1EEA9000)
--7947-- Reading debug info from /usr/lib/libsvn_fs-1.so.1.0.0...
--7947-- ... CRC mismatch (computed da9455ed wanted 9a3a4fa9)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_ra_svn-1.so.1.0.0 (0x1F0AF000)
--7947-- Reading debug info from /usr/lib/libsvn_ra_svn-1.so.1.0.0...
--7947-- ... CRC mismatch (computed db3a7eb4 wanted 96b02517)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_ra_dav-1.so.1.0.0 (0x1F2C3000)
--7947-- Reading debug info from /usr/lib/libsvn_ra_dav-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 60cea68f wanted 0b17ba8f)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libuuid.so.1.2 (0x1F4E0000)
--7947-- Reading debug info from /lib/libuuid.so.1.2...
--7947-- ... CRC mismatch (computed f1e7d171 wanted 5326e314)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libcrypt-2.7.so (0x1F6E4000)
--7947-- Reading debug info from /lib/libcrypt-2.7.so...
--7947-- ... CRC mismatch (computed f17bd312 wanted 8ca73583)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libldap_r-2.4.so.2.0.5 (0x1F91C000)
--7947-- Reading debug info from /usr/lib/libldap_r-2.4.so.2.0.5...
--7947-- ... CRC mismatch (computed 8243c472 wanted c4d6223f)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/liblber-2.4.so.2.0.5 (0x1FB61000)
--7947-- Reading debug info from /usr/lib/liblber-2.4.so.2.0.5...
--7947-- ... CRC mismatch (computed 2e940a69 wanted 3fead3f6)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libdb-4.6.so (0x1FD6F000)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libpq.so.5.1 (0x200A4000)
--7947-- Reading debug info from /usr/lib/libpq.so.5.1...
--7947-- ... CRC mismatch (computed 8691a2e9 wanted dbdba3f3)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsqlite3.so.0.8.6 (0x202C8000)
--7947-- Reading debug info from /usr/lib/libsqlite3.so.0.8.6...
--7947-- ... CRC mismatch (computed a5e5a180 wanted bcc09067)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_fs_fs-1.so.1.0.0 (0x20534000)
--7947-- Reading debug info from /usr/lib/libsvn_fs_fs-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 59a609fe wanted 3753cc06)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsvn_fs_base-1.so.1.0.0 (0x20750000)
--7947-- Reading debug info from /usr/lib/libsvn_fs_base-1.so.1.0.0...
--7947-- ... CRC mismatch (computed 2ecb58f6 wanted 91439102)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libneon.so.27.0.2 (0x20979000)
--7947-- Reading debug info from /usr/lib/libneon.so.27.0.2...
--7947-- ... CRC mismatch (computed 83da46b9 wanted 867962d8)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libsasl2.so.2.0.22 (0x20B9D000)
--7947-- Reading debug info from /usr/lib/libsasl2.so.2.0.22...
--7947-- ... CRC mismatch (computed 702055a8 wanted 33f05302)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libssl.so.0.9.8 (0x20DB6000)
--7947-- Reading debug info from /usr/lib/libssl.so.0.9.8...
--7947-- ... CRC mismatch (computed 81d12423 wanted 9e65664a)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libcrypto.so.0.9.8 (0x21000000)
--7947-- Reading debug info from /usr/lib/libcrypto.so.0.9.8...
--7947-- ... CRC mismatch (computed 4c77ca08 wanted 62b6fe3f)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libkrb5.so.3.3 (0x21380000)
--7947-- Reading debug info from /usr/lib/libkrb5.so.3.3...
--7947-- ... CRC mismatch (computed 5984bc14 wanted f7b21757)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libcom_err.so.2.1 (0x21617000)
--7947-- Reading debug info from /lib/libcom_err.so.2.1...
--7947-- ... CRC mismatch (computed 8d112d17 wanted 0e952244)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libgssapi_krb5.so.2.2 (0x21819000)
--7947-- Reading debug info from /usr/lib/libgssapi_krb5.so.2.2...
--7947-- ... CRC mismatch (computed 422a65aa wanted f12854ac)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libk5crypto.so.3.1 (0x21A44000)
--7947-- Reading debug info from /usr/lib/libk5crypto.so.3.1...
--7947-- ... CRC mismatch (computed e14f5de9 wanted 1e868fae)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /usr/lib/libkrb5support.so.0.1 (0x21C68000)
--7947-- Reading debug info from /usr/lib/libkrb5support.so.0.1...
--7947-- ... CRC mismatch (computed fe0592a5 wanted ef85f36e)
--7947--    object doesn't have a symbol table
--7947-- Reading syms from /lib/libkeyutils-1.2.so (0x21E6F000)
--7947-- Reading debug info from /lib/libkeyutils-1.2.so...
--7947-- ... CRC mismatch (computed 775fbe7d wanted d95e5972)
--7947--    object doesn't have a symbol table
--7947-- memcheck GC: 32768 nodes, 29844 survivors ( 91.0%)
--7947-- memcheck GC: increase table size to 65536
--7947-- memcheck GC: 65536 nodes, 58276 survivors ( 88.9%)
--7947-- memcheck GC: increase table size to 131072
==7947== 
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x2354F60B: ???
==7947==  Address 0x7feffd410 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--7947-- memcheck GC: 131072 nodes, 116914 survivors ( 89.1%)
--7947-- memcheck GC: increase table size to 262144
--7947-- memcheck GC: 262144 nodes, 232716 survivors ( 88.7%)
--7947-- memcheck GC: increase table size to 524288
--7947-- memcheck GC: 524288 nodes, 468977 survivors ( 89.4%)
--7947-- memcheck GC: increase table size to 1048576
--7947-- Discarding syms at 0x6ADC000-0x6CE5000 in /lib/libnss_compat-2.7.so due to munmap()
--7947-- Discarding syms at 0x6EFE000-0x7109000 in /lib/libnss_nis-2.7.so due to munmap()
--7947-- Discarding syms at 0x7315000-0x7520000 in /lib/libnss_winbind.so.2 due to munmap()
--7947-- Discarding syms at 0x7109000-0x7315000 in /lib/libnss_files-2.7.so due to munmap()
--7947-- Discarding syms at 0x1861C000-0x1881E000 in /lib/libnss_mdns4_minimal.so.2 due to munmap()
--7947-- Discarding syms at 0x1881E000-0x18A24000 in /lib/libnss_dns-2.7.so due to munmap()
==7947== 
==7947== ERROR SUMMARY: 6786 errors from 111 contexts (suppressed: 15432828 from 3)
==7947== 
==7947== 1 errors in context 1 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1D97C41F: ???
==7947==    by 0x1D97BFC1: ???
==7947==    by 0x1D97BE07: ???
==7947==    by 0x170C8DC7: ???
==7947==  Address 0x7feffc770 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 2 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1CA58F8F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x153D298F: ???
==7947==    by 0x1ABC277F: ???
==7947==    by 0x1B54065F: ???
==7947==    by 0x1CA58ED7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1B5419F7: ???
==7947==    by 0x1CA58D4B: ???
==7947==  Address 0x7feffc5a0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 3 of 111:
==7947== Thread 11:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1ACAB7B7: ???
==7947==    by 0x1ACA69F5: ???
==7947==    by 0x1ACA66BB: ???
==7947==    by 0x4C76DE: mono_runtime_invoke_array (object.c:3228)
==7947==    by 0x4C9E8A: mono_message_invoke (object.c:4743)
==7947==    by 0x4EC784: mono_async_invoke (threadpool.c:938)
==7947==    by 0x4ED9A9: async_invoke_io_thread (threadpool.c:260)
==7947==    by 0x4CE76C: start_wrapper (threads.c:621)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==  Address 0x1b0b5800 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 4 of 111:
==7947== Thread 8:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5AE5AF: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af540 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 5 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5AE593: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af6a0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 6 of 111:
==7947== Thread 1:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xD26BE48: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947==    by 0x1806D6DF: ???
==7947== 
==7947== 1 errors in context 7 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC286E9: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 8 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28697: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 9 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC280CC: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 10 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0x4C2502A: memcpy (mc_replace_strmem.c:402)
==7947==    by 0xCC280BD: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947== 
==7947== 1 errors in context 11 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC27FFB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 12 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC27FE9: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2865D: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 13 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2931F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 14 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F637: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 15 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F615: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 16 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F60C: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 17 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F366: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 18 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F29F: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 19 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F294: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 20 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F282: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 1 errors in context 21 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC292AA: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 22 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC294A5: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 23 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC29459: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 24 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC2942F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 25 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC29484: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 26 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2946A: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 27 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28BC3: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 28 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC28BB5: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 29 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC28CB4: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 30 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC28C71: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 31 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1FEC4: crc32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD255AAC: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26BF77: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 1 errors in context 32 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1FEBA: crc32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD255AAC: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25D394: png_write_chunk_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25DF96: png_write_chunk (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25EEA4: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25EFBE: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947== 
==7947== 1 errors in context 33 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24322: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 1 errors in context 34 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC24318: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 1 errors in context 35 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC242B6: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 1 errors in context 36 of 111:
==7947== Thread 6:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A2FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1808DF9F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A2FF: ???
==7947==    by 0x1808DF9F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 37 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A37F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x16FE7F4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A37F: ???
==7947==    by 0x16FE7F4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 38 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A3FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A07CF: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A3FF: ???
==7947==    by 0x170A07CF: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 39 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A77F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A09FF: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A77F: ???
==7947==    by 0x170A09FF: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 40 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803AC7F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0A4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803AC7F: ???
==7947==    by 0x170A0A4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 41 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x16FC6C7F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0B8F: ???
==7947==    by 0xA: ???
==7947==    by 0x16FC6C7F: ???
==7947==    by 0x170A0B8F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 42 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1708F0FF: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x170A0BDF: ???
==7947==    by 0xA: ???
==7947==    by 0x1708F0FF: ???
==7947==    by 0x170A0BDF: ???
==7947==    by 0xFFFFFFFEFFFFFFFF: ???
==7947==    by 0x16FA7D1F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1902F27C: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 1 errors in context 43 of 111:
==7947== Thread 1:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1526680F: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x152665D7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0xE47B3BB: ???
==7947==  Address 0x7feffe7b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 2 errors in context 44 of 111:
==7947== Thread 8:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1A5ADEE3: ???
==7947==    by 0x1A5AD344: ???
==7947==    by 0x1A5AC7CB: ???
==7947==    by 0x1A5AC233: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7af860 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 2 errors in context 45 of 111:
==7947== Thread 1:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC294E4: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 2 errors in context 46 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0x9E31909: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E32DEA: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947==    by 0x1806D6DF: ???
==7947==    by 0x17FEF31F: ???
==7947== 
==7947== 2 errors in context 47 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC25DCB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC278B0: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC246EB: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947== 
==7947== 2 errors in context 48 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC246A7: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 49 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24696: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 50 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24186: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 51 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC2447F: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 52 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24413: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 53 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24210: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 54 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2438C: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 55 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24400: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 2 errors in context 56 of 111:
==7947== Invalid read of size 8
==7947==    at 0x40165A5: (within /lib/ld-2.7.so)
==7947==    by 0x400A50E: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==7947==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947==    by 0x41AD343: ???
==7947== 
==7947== 2 errors in context 57 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400A4CF: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0x512D5B: mono_dl_symbol (mono-dl.c:357)
==7947==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==  Address 0x8c115c0 is 8 bytes inside a block of size 14 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481FFC: mono_lookup_pinvoke_call (loader.c:1270)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947==    by 0x41AD343: ???
==7947== 
==7947== 2 errors in context 58 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x919680F: ???
==7947==    by 0x919680F: ???
==7947==    by 0x919680F: ???
==7947==    by 0x918C628: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x918BD2F: ???
==7947==    by 0x918BA1F: ???
==7947==    by 0x918B6DF: ???
==7947==  Address 0x7feffe9f0 is not stack'd, malloc'd or (recently) free'd
==7947== 
==7947== 3 errors in context 59 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2441F: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 3 errors in context 60 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243F0: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 3 errors in context 61 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243C8: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 3 errors in context 62 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC243B7: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 3 errors in context 63 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24356: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 3 errors in context 64 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 3 errors in context 65 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x400E093: (within /lib/ld-2.7.so)
==7947==    by 0x400A547: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xB49EC7E: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==  Address 0x925b958 is 48 bytes inside a block of size 50 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0x9A5DFFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 4 errors in context 66 of 111:
==7947== Thread 13:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x1CA691DF: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1ce78c40 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 4 errors in context 67 of 111:
==7947== Thread 1:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC1F600: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 4 errors in context 68 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F5A1: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 4 errors in context 69 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F54D: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 4 errors in context 70 of 111:
==7947== Use of uninitialised value of size 8
==7947==    at 0xCC1F51B: adler32 (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC299A1: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947== 
==7947== 4 errors in context 71 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2437A: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 4 errors in context 72 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24368: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 4 errors in context 73 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==  Address 0x640c8c0 is 32 bytes inside a block of size 39 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4005F47: (within /lib/ld-2.7.so)
==7947==    by 0x400885F: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947== 
==7947== 5 errors in context 74 of 111:
==7947== Thread 8:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x8FD47DE: ???
==7947==    by 0x4CE7C4: start_wrapper (threads.c:627)
==7947==    by 0x4F7692: thread_start_routine (threads.c:279)
==7947==    by 0x514FE5: GC_start_routine (pthread_support.c:1369)
==7947==    by 0x56FE3F6: start_thread (in /lib/libpthread-2.7.so)
==7947==    by 0x5C6CB2C: clone (in /lib/libc-2.7.so)
==7947==  Address 0x1a7afbc0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 5 errors in context 75 of 111:
==7947== Thread 1:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400A99D: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==  Address 0x84306c0 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0xB49E932: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xB285A2B: g_type_module_use (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xA4FB1C8: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FB288: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FB306: pango_map_get_engines (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FE459: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FE6CE: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 7 errors in context 76 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400522C: (within /lib/ld-2.7.so)
==7947==    by 0x40079E5: (within /lib/ld-2.7.so)
==7947==    by 0x40089D7: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==  Address 0x8f83150 is 8 bytes inside a block of size 9 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x4007979: (within /lib/ld-2.7.so)
==7947==    by 0x40089D7: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947== 
==7947== 7 errors in context 77 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x400E093: (within /lib/ld-2.7.so)
==7947==    by 0x400A547: (within /lib/ld-2.7.so)
==7947==    by 0x5CA32F3: (within /lib/libc-2.7.so)
==7947==    by 0x54F50F3: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F50A9: dlsym (in /lib/libdl-2.7.so)
==7947==    by 0xB49E571: g_module_symbol (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xB49EBF1: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==  Address 0x65fbe40 is 40 bytes inside a block of size 47 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0xA4FB0DA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 10 errors in context 78 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400A99D: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==  Address 0x92083b0 is 16 bytes inside a block of size 20 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481B94: mono_lookup_pinvoke_call (loader.c:1121)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947== 
==7947== 16 errors in context 79 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==  Address 0x823d4e8 is 96 bytes inside a block of size 98 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== 17 errors in context 80 of 111:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x2354F60B: ???
==7947==  Address 0x7feffd410 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
==7947== 
==7947== 17 errors in context 81 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== 17 errors in context 82 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EB0: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== 17 errors in context 83 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015CF0: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== 17 errors in context 84 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015CF0: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x8315f58 is 64 bytes inside a block of size 67 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x49BE22: ves_icall_System_Reflection_Assembly_LoadFrom (appdomain.c:1440)
==7947==    by 0x905C18F: ???
==7947==    by 0x905B10B: ???
==7947== 
==7947== 22 errors in context 85 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947== 
==7947== 22 errors in context 86 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x84b07e0 is 8 bytes inside a block of size 13 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947== 
==7947== 27 errors in context 87 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== 27 errors in context 88 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== 35 errors in context 89 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC2943F: inflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD26BDCD: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26C08A: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0x19463CC7: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x1708ACFF: ???
==7947== 
==7947== 36 errors in context 90 of 111:
==7947== Conditional jump or move depends on uninitialised value(s)
==7947==    at 0xCC24544: (within /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xCC2337C: deflate (in /usr/lib/libz.so.1.2.3.3)
==7947==    by 0xD25EF3C: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F20B: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD25F548: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD263130: png_write_row (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0x194B5B8C: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194663E3: ???
==7947==    by 0x19465F6B: ???
==7947==    by 0x19464A07: ???
==7947==    by 0x190332E3: ???
==7947==    by 0x17FEF3DF: ???
==7947== 
==7947== 40 errors in context 91 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947== 
==7947== 40 errors in context 92 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x6357378 is 24 bytes inside a block of size 26 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947== 
==7947== 44 errors in context 93 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== 46 errors in context 94 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015ECA: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==  Address 0x63795a8 is 72 bytes inside a block of size 74 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== 46 errors in context 95 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==  Address 0x6387e00 is 16 bytes inside a block of size 17 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4008B75: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947== 
==7947== 52 errors in context 96 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D33: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x6379438 is 40 bytes inside a block of size 43 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== 60 errors in context 97 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x400AB93: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==7947==  Address 0x63899b8 is 24 bytes inside a block of size 25 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4008B75: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D91D: __nss_next (in /lib/libc-2.7.so)
==7947==    by 0x5C31A6F: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 61 errors in context 98 of 111:
==7947== Invalid read of size 8
==7947==    at 0x51E420: GC_push_all_eager (mark.c:1468)
==7947==    by 0x51E491: GC_push_all_stack (mark.c:1521)
==7947==    by 0x5192DD: pthread_push_all_stacks (pthread_stop_world.c:278)
==7947==    by 0x519357: GC_push_all_stacks (pthread_stop_world.c:309)
==7947==    by 0x5807A5: GC_default_push_other_roots (os_dep.c:2078)
==7947==    by 0x51BE20: GC_push_roots (mark_rts.c:646)
==7947==    by 0x51C980: GC_mark_some (mark.c:326)
==7947==    by 0x51A449: GC_stopped_mark (alloc.c:543)
==7947==    by 0x51A026: GC_try_to_collect_inner (alloc.c:382)
==7947==    by 0x51B048: GC_collect_or_expand (alloc.c:1045)
==7947==    by 0x51B2C6: GC_allocobj (alloc.c:1125)
==7947==    by 0x51EFEE: GC_generic_malloc_inner (malloc.c:136)
==7947==  Address 0x16f58e00 is on thread 5's stack
==7947== 
==7947== 79 errors in context 99 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==  Address 0x64d08b0 is 120 bytes inside a block of size 123 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== 86 errors in context 100 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 86 errors in context 101 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 520 errors in context 102 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x4007817: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== 520 errors in context 103 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x400780A: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== 534 errors in context 104 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x40087D1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947== 
==7947== 534 errors in context 105 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x40085B1: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==  Address 0x8f78540 is 16 bytes inside a block of size 23 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5081B52: g_strconcat (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x512CF6: mono_dl_build_path (mono-dl.c:426)
==7947==    by 0x481D3A: mono_lookup_pinvoke_call (loader.c:1156)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5596EC: inline_method (mini.c:4018)
==7947==    by 0x543D6B: mono_method_to_ir (mini.c:6074)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947== 
==7947== 560 errors in context 106 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EFE: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== 560 errors in context 107 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015DA1: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x64d0768 is 88 bytes inside a block of size 92 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947== 
==7947== 607 errors in context 108 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x4011C2B: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==  Address 0x646ec60 is 80 bytes inside a block of size 84 alloc'd
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400DF00: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947== 
==7947== 610 errors in context 109 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015EE4: (within /lib/ld-2.7.so)
==7947==    by 0x400DEE6: (within /lib/ld-2.7.so)
==7947==    by 0x4008DA5: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 625 errors in context 110 of 111:
==7947== Invalid read of size 8
==7947==    at 0x4015D6E: (within /lib/ld-2.7.so)
==7947==    by 0x4011F31: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==  Address 0x646eb40 is 48 bytes inside a block of size 53 alloc'd
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5C00725: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x422AF5: load_aot_module (aot-runtime.c:551)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x417914: mono_main (driver.c:1480)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 646 errors in context 111 of 111:
==7947== Thread 6:
==7947== Invalid read of size 8
==7947==    at 0x415C0C2: ???
==7947==    by 0x194615FC: ???
==7947==    by 0x1803A27F: ???
==7947==    by 0x19023ACF: ???
==7947==    by 0x1808DF4F: ???
==7947==    by 0xA: ???
==7947==    by 0x1803A27F: ???
==7947==    by 0x1808DF4F: ???
==7947==  Address 0x190237b0 is just below the stack ptr.  To suppress, use: --workaround-gcc296-bugs=yes
--7947-- 
--7947-- supp: 8934348 mono - Conditional jump or move depends on uninitialised value
--7947-- supp:    810 dl-hack3-1
--7947-- supp: 6497670 mono - Use of uninitialized value of size 8
==7947== 
==7947== IN SUMMARY: 6786 errors from 111 contexts (suppressed: 15432828 from 3)
==7947== 
==7947== malloc/free: in use at exit: 895,671,958 bytes in 1,796,705 blocks.
==7947== malloc/free: 71,641,684 allocs, 69,844,979 frees, 4,602,227,037 bytes allocated.
==7947== 
==7947== searching for pointers to 1,796,705 not-freed blocks.
==7947== checked 709,386,600 bytes.
==7947== 
==7947== Thread 1:
==7947== 
==7947== 1 bytes in 1 blocks are still reachable in loss record 1 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA787726: _XlcDefaultMapModifiers (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA787794: XSetLocaleModifiers (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA090743: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947== 
==7947== 
==7947== 6 bytes in 1 blocks are still reachable in loss record 2 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA78107F: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 6 bytes in 1 blocks are still reachable in loss record 3 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC56C6EF: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 6 bytes in 1 blocks are still reachable in loss record 4 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC56C70C: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 8 bytes in 1 blocks are still reachable in loss record 5 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA770EDE: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 8 bytes in 1 blocks are still reachable in loss record 6 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC15C354: _XiGetExtensionVersion (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xC15E6D2: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xC15CFDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 12 bytes in 1 blocks are still reachable in loss record 7 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA780C32: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 8 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF26BABD: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF2692B4: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x1145D30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==7947==    by 0x1779A73F: ???
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 9 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF26B9FD: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF2692A8: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x1145D30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==7947==    by 0x1779A73F: ???
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 10 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xF26929C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x1145D30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==7947==    by 0x1779A73F: ???
==7947==    by 0x7FEFFA02F: ???
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 11 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7731F2: _XCBInitDisplayLock (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75CAB4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 12 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xD0404AD: (within /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03FA0C: (within /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03E65E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 13 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91162C: FcBlanksCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB927115: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 14 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA785EFD: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77B5EE: _XlcOpenConverter (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA781460: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7709CF: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 16 bytes in 1 blocks are still reachable in loss record 15 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA78143C: _XrmDefaultInitParseInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7709CF: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 21 bytes in 1 blocks are still reachable in loss record 16 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75CC95: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 17 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF26AD29: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26998E: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF268F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF2692C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 18 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xF269290: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x1145D30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==7947==    by 0x1779A73F: ???
==7947==    by 0x7FEFFA02F: ???
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 19 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA770F24: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 20 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xBB49B8D: XextCreateExtension (in /usr/lib/libXext.so.6.4.0)
==7947==    by 0xC15E735: XInput_find_display (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xC15CFBA: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 21 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EDAA6: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EDF1F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 22 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA76D503: XAddConnectionWatch (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080487: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 23 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA7870D5: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0368: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 24 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA77DFB3: _XlcResolveLocaleName (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F40: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 24 bytes in 1 blocks are still reachable in loss record 25 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA780446: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 24 bytes in 3 blocks are indirectly lost in loss record 26 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6AC8A5: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AC906: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AC9B4: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6ACB3B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA087738: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA07786B: gdk_window_begin_paint_region (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x999FD12: gtk_main_do_event (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xA077CAA: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0782C6: gdk_window_process_all_updates (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9915DA0: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05F89D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 28 bytes in 1 blocks are still reachable in loss record 27 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF269936: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF268F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF2692C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x1145D30D: gnome_icon_lookup_sync (in /usr/lib/libgnomeui-2.so.0.2201.0)
==7947== 
==7947== 
==7947== 29 bytes in 3 blocks are still reachable in loss record 28 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AC0C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 29 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xF268C02: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26999B: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF268F80: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF2692C9: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF26966C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF255FA7: gnome_vfs_mime_type_from_name_or_default (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF25607C: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xF256862: (within /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0x177A23FA: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0x177A2A03: (within /usr/lib/gnome-vfs-2.0/modules/libfile.so)
==7947==    by 0xF25A0DC: gnome_vfs_get_file_info (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 30 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xAE36A97: XFixesFindDisplay (in /usr/lib/libXfixes.so.3.1.0)
==7947==    by 0xAE36CE8: XFixesQueryExtension (in /usr/lib/libXfixes.so.3.1.0)
==7947==    by 0xA0805EE: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 31 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91CCFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91CDFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB921F09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92201C: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 32 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xD03F72C: (within /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03E44E: (within /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03FE59: xcb_wait_for_reply (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD04025B: xcb_get_extension_data (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03EB8E: xcb_prefetch_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD03EC0B: xcb_get_maximum_request_length (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xA75CFE3: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are possibly lost in loss record 33 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB921FCD: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50905D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x158BDD0F: ???
==7947==    by 0x158BCA4A: ???
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 34 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xAC31C77: XDamageFindDisplay (in /usr/lib/libXdamage.so.1.1.0)
==7947==    by 0xAC322F8: XDamageQueryExtension (in /usr/lib/libXdamage.so.1.1.0)
==7947==    by 0xA080632: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 35 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xAA2FE2C: XCompositeFindDisplay (in /usr/lib/libXcomposite.so.1.0.0)
==7947==    by 0xAA30878: XCompositeQueryExtension (in /usr/lib/libXcomposite.so.1.0.0)
==7947==    by 0xA080610: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 32 bytes in 4 blocks are still reachable in loss record 36 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77F743: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 37 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77099A: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77218D: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 32 bytes in 1 blocks are still reachable in loss record 38 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xBD53ACE: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 34 bytes in 2 blocks are still reachable in loss record 39 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x19488E92: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194B620B: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x15472527: ???
==7947== 
==7947== 
==7947== 40 bytes in 1 blocks are still reachable in loss record 40 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA76C41D: _XPollfdCacheInit (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75CAC4: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 40 bytes in 1 blocks are still reachable in loss record 41 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77C256: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 41 bytes in 1 blocks are still reachable in loss record 42 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xDDE0E06: XauFileName (in /usr/lib/libXau.so.6.0.0)
==7947==    by 0xDDE1042: XauGetBestAuthByAddr (in /usr/lib/libXau.so.6.0.0)
==7947==    by 0xD040E93: (within /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD040AD1: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947== 
==7947== 
==7947== 48 bytes in 1 blocks are still reachable in loss record 43 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BB729: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB278BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 48 bytes in 1 blocks are still reachable in loss record 44 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA7711CE: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 48 bytes in 2 blocks are still reachable in loss record 45 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x19488E27: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194B620B: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x15472527: ???
==7947== 
==7947== 
==7947== 48 bytes in 3 blocks are still reachable in loss record 46 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB9201E5: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9212A3: FcPatternGetString (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77A3AA: pango_fc_font_description_from_pattern (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC779CBE: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xB26A0DB: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26AF65: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xA2E4B4A: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77BC3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 48 bytes in 2 blocks are still reachable in loss record 47 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xFC5A752: (within /usr/lib/libdbus-1.so.3.4.0)
==7947==    by 0xFC54B3A: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==7947==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xE47C9D7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0xE47C8AB: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==7947== 
==7947== 
==7947== 48 bytes in 3 blocks are still reachable in loss record 48 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91BB9C: FcFontSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB915432: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 52 bytes in 1 blocks are still reachable in loss record 49 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77342D: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 96 bytes in 3 blocks are still reachable in loss record 50 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x54F554A: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x422B0A: load_aot_module (aot-runtime.c:553)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947==    by 0x526D9D: mini_init (mini.c:13999)
==7947== 
==7947== 
==7947== 292 (52 direct, 240 indirect) bytes in 1 blocks are definitely lost in loss record 51 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C7D240: (within /lib/libc-2.7.so)
==7947==    by 0x5C7DAFE: __nss_database_lookup (in /lib/libc-2.7.so)
==7947==    by 0x6ADE42F: ???
==7947==    by 0x6ADF968: ???
==7947==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==7947==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947== 
==7947== 
==7947== 56 bytes in 2 blocks are still reachable in loss record 52 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1071E199: (within /lib/libresolv-2.7.so)
==7947==    by 0x1071CAB7: __libc_res_nquery (in /lib/libresolv-2.7.so)
==7947==    by 0x1071CD66: (within /lib/libresolv-2.7.so)
==7947==    by 0x1071D005: __libc_res_nsearch (in /lib/libresolv-2.7.so)
==7947==    by 0x18820980: ???
==7947==    by 0x18820B90: ???
==7947==    by 0x5C83C22: gethostbyname_r (in /lib/libc-2.7.so)
==7947==    by 0x5C83453: gethostbyname (in /lib/libc-2.7.so)
==7947==    by 0x1839C724: NetTcpAddr(char*, AddrType, sockaddr_in*, Error*) (in /usr/mono-2.0/lib/libp4api.so)
==7947==    by 0x1839D174: NetTcpEndPoint::Connect(Error*) (in /usr/mono-2.0/lib/libp4api.so)
==7947==    by 0x18399542: Rpc::Connect(Error*) (in /usr/mono-2.0/lib/libp4api.so)
==7947== 
==7947== 
==7947== 56 bytes in 1 blocks are still reachable in loss record 53 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA77E9A9: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77F23B: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 62 bytes in 8 blocks are still reachable in loss record 54 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF76F20F: xmlStrndup (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FF626: xmlNewCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FF754: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FFC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF728EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF707194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0x143C8C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0x1418BD7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E338D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE4794CB: ???
==7947== 
==7947== 
==7947== 64 bytes in 1 blocks are still reachable in loss record 55 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA773EDF: _XReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7688A9: XSync (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA089B8D: gdk_flush (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x999FF18: gtk_main (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x1B0C4327: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 
==7947== 64 bytes in 2 blocks are still reachable in loss record 56 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x19488216: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194889DE: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194B6018: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 64 bytes in 1 blocks are still reachable in loss record 57 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7C94C1: XkbAllocServerMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BA61A: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 64 bytes in 2 blocks are still reachable in loss record 58 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC9AA9DD: FT_New_Memory (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9AACE0: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xA2E5184: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xA2E2D8E: pango_cairo_font_map_get_default (in /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA0680A9: gdk_pango_context_get_for_screen (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AB01ED: gtk_widget_create_pango_context (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 64 bytes in 1 blocks are still reachable in loss record 59 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA761D79: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 64 bytes in 2 blocks are still reachable in loss record 60 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC15D4CA: XOpenDevice (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xA0A62BC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 72 bytes in 1 blocks are still reachable in loss record 61 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BB70E: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB278BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 72 bytes in 1 blocks are still reachable in loss record 62 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA75CB66: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 72 bytes in 3 blocks are still reachable in loss record 63 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92502A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255B6: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 72 bytes in 3 blocks are still reachable in loss record 64 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92508A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255D2: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 80 bytes in 3 blocks are still reachable in loss record 65 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA77F676: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 80 bytes in 5 blocks are indirectly lost in loss record 66 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C7CE7F: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x6ADE44A: ???
==7947==    by 0x6ADF968: ???
==7947==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==7947==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947==    by 0x4E4E6E: mono_init_internal (domain.c:1277)
==7947== 
==7947== 
==7947== 85 bytes in 10 blocks are still reachable in loss record 67 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA757323: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xBD53B81: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 96 bytes in 1 blocks are still reachable in loss record 68 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0A4AF3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 96 bytes in 3 blocks are still reachable in loss record 69 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91F679: FcMatrixCopy (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9250AF: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255D2: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925C48: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926F2E: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947== 
==7947== 
==7947== 102 bytes in 15 blocks are still reachable in loss record 70 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0A47E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947== 
==7947== 
==7947== 104 bytes in 3 blocks are still reachable in loss record 71 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BA665: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 104 bytes in 3 blocks are still reachable in loss record 72 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA77BCDE: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 104 bytes in 1 blocks are still reachable in loss record 73 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF76C4EC: xmlNewRMutex (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF7BA1C4: (within /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF7BA3E1: xmlDictCreate (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF70320B: xmlInitParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF70327D: xmlNewParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF7071A5: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0x143C8C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0x1418BD7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E338D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE4794CB: ???
==7947== 
==7947== 
==7947== 112 bytes in 1 blocks are still reachable in loss record 74 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75CE7D: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 112 bytes in 1 blocks are still reachable in loss record 75 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7733C6: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 112 bytes in 7 blocks are still reachable in loss record 76 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x40079C3: (within /lib/ld-2.7.so)
==7947==    by 0x40089D7: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947== 
==7947== 
==7947== 112 bytes in 2 blocks are still reachable in loss record 77 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x19487C8A: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194889CB: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194B6018: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 120 bytes in 1 blocks are still reachable in loss record 78 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xFC54AEC: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==7947==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xE47C9D7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0xE47C8AB: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==7947==    by 0x4C745C: mono_runtime_invoke_array (object.c:3214)
==7947== 
==7947== 
==7947== 128 bytes in 1 blocks are still reachable in loss record 79 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EBBAB: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EC72C: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E904F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA08771A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA06018C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 128 bytes in 1 blocks are still reachable in loss record 80 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75CD92: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 128 bytes in 2 blocks are still reachable in loss record 81 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x401346B: (within /lib/ld-2.7.so)
==7947==    by 0x4013D7B: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA3164: __libc_dlclose (in /lib/libc-2.7.so)
==7947==    by 0x5CA4B57: (within /lib/libc-2.7.so)
==7947==    by 0x5CA4878: __libc_freeres (in /lib/libc-2.7.so)
==7947==    by 0x4A1F31C: _vgnU_freeres (vg_preloaded.c:60)
==7947== 
==7947== 
==7947== 128 bytes in 4 blocks are still reachable in loss record 82 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB9145A9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9149D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91F02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 136 bytes in 1 blocks are still reachable in loss record 83 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB915621: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BE9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 144 bytes in 6 blocks are still reachable in loss record 84 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92340C: FcStrSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB915644: FcConfigCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BE9F: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 152 bytes in 1 blocks are still reachable in loss record 85 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BFB7F: XkbUseExtension (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75D0DE: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 152 bytes in 1 blocks are indirectly lost in loss record 86 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6C6711: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B291D: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6ABEEE: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA060197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 160 bytes in 5 blocks are still reachable in loss record 87 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xBB49BDB: XextAddDisplay (in /usr/lib/libXext.so.6.4.0)
==7947==    by 0xBB44AC8: XShapeQueryExtension (in /usr/lib/libXext.so.6.4.0)
==7947==    by 0xA08065C: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947== 
==7947== 
==7947== 160 bytes in 5 blocks are indirectly lost in loss record 88 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C6B0D9: tsearch (in /lib/libc-2.7.so)
==7947==    by 0x5C7CE29: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x6ADE44A: ???
==7947==    by 0x6ADF968: ???
==7947==    by 0x5C31A40: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5093737: g_get_home_dir (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x4EB50D: mono_config_for_assembly (mono-config.c:461)
==7947==    by 0x4E8CA4: mono_assembly_open_full (assembly.c:1304)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947== 
==7947== 
==7947== 168 bytes in 1 blocks are still reachable in loss record 89 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75CD07: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 168 bytes in 7 blocks are still reachable in loss record 90 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924F19: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255F1: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925A31: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9269AC: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 168 bytes in 1 blocks are still reachable in loss record 91 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA780495: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 168 bytes in 1 blocks are still reachable in loss record 92 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EC796: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E904F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA08771A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA06018C: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE68ABA3: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0x99D867D: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99D6C1A: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 168 bytes in 7 blocks are still reachable in loss record 93 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924EC4: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255E1: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925A31: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9269AC: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 176 bytes in 2 blocks are still reachable in loss record 94 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA770D19: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 176 bytes in 2 blocks are still reachable in loss record 95 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1948810B: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194889F4: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x194B6018: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 176 bytes in 1 blocks are still reachable in loss record 96 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA780472: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BC3: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 182 bytes in 3 blocks are still reachable in loss record 97 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xA77BD15: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 192 bytes in 1 blocks are still reachable in loss record 98 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1E650B21: apr_allocator_create (in /usr/lib/libapr-1.so.0.2.11)
==7947==    by 0x1E65129E: apr_pool_initialize (in /usr/lib/libapr-1.so.0.2.11)
==7947==    by 0x1E6520E4: apr_initialize (in /usr/lib/libapr-1.so.0.2.11)
==7947==    by 0x1D97CED7: ???
==7947==    by 0x1D97C493: ???
==7947==    by 0x1D97BFC1: ???
==7947==    by 0x1D97BE07: ???
==7947==    by 0x170C8DC7: ???
==7947== 
==7947== 
==7947== 192 bytes in 33 blocks are indirectly lost in loss record 99 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x9A714E9: gtk_tree_path_append_index (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A800F8: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x1D9885E3: ???
==7947==    by 0x1D9882DF: ???
==7947==    by 0x1D977E9B: ???
==7947==    by 0x1C0E7637: ???
==7947==    by 0x1523172E: ???
==7947==    by 0x52EA557: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x5087C53: g_thread_self (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 200 bytes in 1 blocks are still reachable in loss record 100 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC15E6B4: _XiCheckExtInit (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xC15CFDE: XListInputDevices (in /usr/lib/libXi.so.6.0.0)
==7947==    by 0xA0A5F7D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080831: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947== 
==7947== 
==7947== 208 bytes in 1 blocks are still reachable in loss record 101 of 238
==7947==    at 0x4C23809: operator new(unsigned long) (vg_replace_malloc.c:230)
==7947==    by 0x1838BFE7: CSharp_new_ClientUser (p4api_wrap.cc:2451)
==7947==    by 0x17FD6937: ???
==7947==    by 0x4C745C: mono_runtime_invoke_array (object.c:3214)
==7947==    by 0x4D9E0F: ves_icall_InternalInvoke (icall.c:3016)
==7947==    by 0x8FD476F: ???
==7947==    by 0x8FD4251: ???
==7947==    by 0x180607A7: ???
==7947==    by 0x1FF: ???
==7947== 
==7947== 
==7947== 208 bytes in 1 blocks are definitely lost in loss record 102 of 238
==7947==    at 0x4C23809: operator new(unsigned long) (vg_replace_malloc.c:230)
==7947==    by 0x1838BFE7: CSharp_new_ClientUser (p4api_wrap.cc:2451)
==7947==    by 0x17FD6937: ???
==7947==    by 0xE47CFE7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x17FD5397: ???
==7947==    by 0x4C745C: mono_runtime_invoke_array (object.c:3214)
==7947==    by 0x4D9E0F: ves_icall_InternalInvoke (icall.c:3016)
==7947==    by 0x8FD476F: ???
==7947== 
==7947== 
==7947== 208 bytes in 13 blocks are still reachable in loss record 103 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA770C80: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 240 bytes in 5 blocks are still reachable in loss record 104 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4007823: (within /lib/ld-2.7.so)
==7947==    by 0x40085CE: (within /lib/ld-2.7.so)
==7947==    by 0x4012048: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xB49E975: g_module_open (in /usr/lib/libgmodule-2.0.so.0.1600.4)
==7947==    by 0x9E31151: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 256 bytes in 1 blocks are still reachable in loss record 105 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7C9877: XkbAllocClientMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BABAB: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 256 bytes in 1 blocks are still reachable in loss record 106 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xB9115B5: FcBlanksAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB927092: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BF95: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 256 bytes in 1 blocks are still reachable in loss record 107 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91BB7F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9268C6: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 256 bytes in 2 blocks are still reachable in loss record 108 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA757245: XAddExtension (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56C620: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 288 (256 direct, 32 indirect) bytes in 1 blocks are definitely lost in loss record 109 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92181B: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB922105: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB922219: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926C08: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 290 bytes in 5 blocks are still reachable in loss record 110 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C0FDD1: strdup (in /lib/libc-2.7.so)
==7947==    by 0xB6EDCEE: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EDF99: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E4E1C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xEBA22E4: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==7947==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 304 bytes in 2 blocks are indirectly lost in loss record 111 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6C5104: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BEDC3: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF20F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D75A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 304 bytes in 19 blocks are still reachable in loss record 112 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x512ED3: mono_dl_open (mono-dl.c:298)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481CF2: mono_lookup_pinvoke_call (loader.c:1159)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x559420: mono_jit_runtime_invoke (mini.c:13163)
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947== 
==7947== 
==7947== 320 bytes in 8 blocks are still reachable in loss record 113 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF6FF640: xmlNewCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FF7CA: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FFC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF728EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF707194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0x143C8C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0x1418BD7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E338D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE4794CB: ???
==7947==    by 0x63686F7: ???
==7947== 
==7947== 
==7947== 336 bytes in 14 blocks are still reachable in loss record 114 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB9250FA: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9255A8: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925800: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926A94: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 362 bytes in 38 blocks are still reachable in loss record 115 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77BDE8: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 400 bytes in 1 blocks are still reachable in loss record 116 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xF6FF70A: xmlInitCharEncodingHandlers (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF6FFC88: xmlGetCharEncodingHandler (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF728EFA: xmlAllocParserInputBuffer (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0xF707194: xmlCreatePushParserCtxt (in /usr/lib/libxml2.so.2.6.31)
==7947==    by 0x143C8C8F: (within /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0x1418BD7B: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E338D6: gdk_pixbuf_loader_write (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE4794CB: ???
==7947==    by 0x63686F7: ???
==7947==    by 0x513EBA: GC_local_malloc_atomic (pthread_support.c:368)
==7947== 
==7947== 
==7947== 408 bytes in 1 blocks are still reachable in loss record 117 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4011CF4: (within /lib/ld-2.7.so)
==7947==    by 0x400C9BD: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D114: (within /lib/libc-2.7.so)
==7947==    by 0x5C83A1A: gethostbyname2_r (in /lib/libc-2.7.so)
==7947== 
==7947== 
==7947== 408 bytes in 51 blocks are still reachable in loss record 118 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA7710AF: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 432 bytes in 27 blocks are still reachable in loss record 119 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0A4EA7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0A468F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 448 bytes in 2 blocks are still reachable in loss record 120 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xD482ACF: (within /usr/lib/libpixman-1.so.0.10.0)
==7947==    by 0xD48308B: pixman_image_create_bits (in /usr/lib/libpixman-1.so.0.10.0)
==7947==    by 0xB6B45A7: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0x194B6075: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 456 bytes in 1 blocks are still reachable in loss record 121 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC56C601: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B190: g_object_new (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 464 bytes in 27 blocks are still reachable in loss record 122 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0A472F: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947== 
==7947== 
==7947== 481 bytes in 16 blocks are still reachable in loss record 123 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4005F47: (within /lib/ld-2.7.so)
==7947==    by 0x400896C: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947== 
==7947== 
==7947== 492 bytes in 41 blocks are still reachable in loss record 124 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77C9D1: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 496 bytes in 1 blocks are still reachable in loss record 125 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BDCD3: XkbGetNames (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0933B2: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB278BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 497 bytes in 1 blocks are still reachable in loss record 126 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA752CF4: XGetWindowProperty (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0896EB: gdk_x11_screen_supports_net_wm_hint (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA09FC9A: gdk_window_focus (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x1778A957: ???
==7947==    by 0x91E8AB7: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 
==7947== 512 bytes in 1 blocks are still reachable in loss record 127 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA757684: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA757C42: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0965FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA097BE5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0804D0: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 512 bytes in 1 blocks are possibly lost in loss record 128 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xB921792: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB922105: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 520 bytes in 1 blocks are still reachable in loss record 129 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1949AE3F: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1948C3DE: GdiplusStartup (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1903483B: ???
==7947==    by 0x41ADF06: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x1903411F: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 520 bytes in 5 blocks are still reachable in loss record 130 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EE481: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EE608: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E4E1C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xEBA22E4: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==7947==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 560 bytes in 7 blocks are still reachable in loss record 131 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77E967: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77F23B: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 560 bytes in 7 blocks are still reachable in loss record 132 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6E815F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF28B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D75A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA068F29: gdk_draw_layout_with_colors (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 560 bytes in 14 blocks are still reachable in loss record 133 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6AE78F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BC27D: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F0137: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F0506: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BBED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0879: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0ED6: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 584 bytes in 4 blocks are still reachable in loss record 134 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB923D0E: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB923E1D: FcStrSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92619B: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947== 
==7947== 
==7947== 592 bytes in 2 blocks are still reachable in loss record 135 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6B42D2: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B45B9: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0x194B6075: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x1806D0AF: ???
==7947==    by 0x170D498F: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 600 bytes in 15 blocks are still reachable in loss record 136 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EBAD8: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9A7F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C11B5: cairo_surface_finish (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C1234: cairo_surface_destroy (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C6C2C: cairo_pattern_destroy (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B23B5: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AB8AA: cairo_set_source (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AB9AB: cairo_set_source_rgba (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xE68F884: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE69408C: ubuntulooks_draw_progressbar_trough (in /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE68B82B: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947== 
==7947== 
==7947== 606 bytes in 41 blocks are still reachable in loss record 137 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77CBD9: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 608 bytes in 4 blocks are still reachable in loss record 138 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6C5104: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BEDC3: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF20F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D75A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 608 bytes in 38 blocks are still reachable in loss record 139 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77BE33: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CB7A: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 620 bytes in 1 blocks are still reachable in loss record 140 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xD03E7C8: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 640 bytes in 16 blocks are still reachable in loss record 141 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6B309A: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AE7A2: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BC27D: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F0137: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F0506: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BBED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0879: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0ED6: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 672 bytes in 42 blocks are still reachable in loss record 142 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91FEB6: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91FF62: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9201D6: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9223A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9224F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C0EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 677 bytes in 51 blocks are still reachable in loss record 143 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AF7B: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 816 bytes in 6 blocks are still reachable in loss record 144 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA755EB5: XCreateImage (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0910E1: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0674F7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0677AD: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA087E51: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0798AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x158BD43F: ???
==7947==    by 0x158BD36F: ???
==7947==    by 0x158BCBAF: ???
==7947==    by 0x158BCA4A: ???
==7947==    by 0xE475FCF: ???
==7947== 
==7947== 
==7947== 816 bytes in 34 blocks are still reachable in loss record 145 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924E79: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925601: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9256D9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925800: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926A94: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 832 bytes in 1 blocks are still reachable in loss record 146 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1949AE21: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1948C3DE: GdiplusStartup (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1903483B: ???
==7947==    by 0x41ADF06: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x1903411F: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D498F: ???
==7947== 
==7947== 
==7947== 832 bytes in 52 blocks are still reachable in loss record 147 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AE5E: _XlcAddCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AC92: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 840 bytes in 15 blocks are still reachable in loss record 148 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xFC5C9EA: (within /usr/lib/libdbus-1.so.3.4.0)
==7947==    by 0xFC54B0C: dbus_threads_init (in /usr/lib/libdbus-1.so.3.4.0)
==7947==    by 0xF24EE2F: gnome_vfs_init (in /usr/lib/libgnomevfs-2.so.0.2200.0)
==7947==    by 0xE47C9D7: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x558C14: mono_jit_compile_method (mini.c:12963)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0xE47C8AB: ???
==7947==    by 0x4C8939: mono_runtime_class_init_full (object.c:336)
==7947==    by 0x5593FC: mono_jit_runtime_invoke (mini.c:13153)
==7947== 
==7947== 
==7947== 864 bytes in 27 blocks are still reachable in loss record 149 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0A470B: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0A4C20: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08C863: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA080506: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947== 
==7947== 
==7947== 864 bytes in 27 blocks are still reachable in loss record 150 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EBFCB: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E8185: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF28B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D75A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 896 bytes in 28 blocks are still reachable in loss record 151 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB921FCD: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 920 bytes in 16 blocks are still reachable in loss record 152 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91253C: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB912B32: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB912C48: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9128BD: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB912999: FcDirCacheLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB918AC2: FcDirCacheRead (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9151E8: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB915455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 928 bytes in 4 blocks are definitely lost in loss record 153 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6C5485: cairo_pattern_create_linear (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0x2260E303: ???
==7947==    by 0x19F91471: ???
==7947==    by 0x19F92EAF: ???
==7947==    by 0x158BCA4A: ???
==7947==    by 0xE475FCF: ???
==7947==    by 0xEF72F47: ???
==7947== 
==7947== 
==7947== 952 bytes in 2 blocks are still reachable in loss record 154 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75CEF1: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 1,000 bytes in 1 blocks are still reachable in loss record 155 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7C97A9: XkbAllocClientMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BA5D1: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,008 bytes in 1 blocks are still reachable in loss record 156 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77C1F5: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,068 bytes in 52 blocks are still reachable in loss record 157 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AF1C: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,092 bytes in 35 blocks are still reachable in loss record 158 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB923E6F: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9240F5: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB924248: FcStrSetAddFilename (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926DD2: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BEBA: FcInitLoadConfig (in /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 1,120 bytes in 35 blocks are indirectly lost in loss record 159 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB9143CB: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9145D4: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9149D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91F02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50905D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 1,280 bytes in 10 blocks are still reachable in loss record 160 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7572FB: XInitExtension (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xBD53B81: XRenderFindDisplay (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xBD54A28: XRenderQueryExtension (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xC56C666: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,304 bytes in 147 blocks are indirectly lost in loss record 161 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x9A714E9: gtk_tree_path_append_index (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A800F8: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x1D9885E3: ???
==7947==    by 0x1D988417: ???
==7947==    by 0x22A21CAA: ???
==7947==    by 0x22A21BAB: ???
==7947==    by 0x22A21A73: ???
==7947==    by 0x22081D5A: ???
==7947==    by 0x1D98E6DF: ???
==7947==    by 0x1C0E760C: ???
==7947== 
==7947== 
==7947== 1,308 bytes in 24 blocks are still reachable in loss record 162 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BA5F5: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,320 bytes in 5 blocks are still reachable in loss record 163 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6EDF7E: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E4E1C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xEBA22E4: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==7947==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 1,344 bytes in 1 blocks are still reachable in loss record 164 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91FDCA: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB920207: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92024D: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9223A4: FcPatternAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9224F7: FcPatternBuild (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C0EB: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 1,376 bytes in 4 blocks are still reachable in loss record 165 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xB6B30C1: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BB9B1: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BBE3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,416 bytes in 3 blocks are indirectly lost in loss record 166 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6E9065: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9530: cairo_xlib_surface_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA08771A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA07786B: gdk_window_begin_paint_region (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x999FD12: gtk_main_do_event (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xA077CAA: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0782C6: gdk_window_process_all_updates (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9915DA0: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05F89D: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x50623D3: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50656E4: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,416 bytes in 1 blocks are still reachable in loss record 167 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xBD54210: XRenderQueryFormats (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xBD549CC: XRenderQueryVersion (in /usr/lib/libXrender.so.1.3.0)
==7947==    by 0xC56C9E1: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB269F5C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26A54F: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,538 bytes in 45 blocks are still reachable in loss record 168 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA757713: _XUpdateAtomCache (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA757CF8: XInternAtom (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0965FD: gdk_x11_atom_to_xatom_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA09BBC3: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA09BE26: gdk_window_set_decorations (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AC26DA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0x9AB3956: gtk_widget_realize (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,584 bytes in 66 blocks are still reachable in loss record 169 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA771023: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,640 bytes in 41 blocks are still reachable in loss record 170 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77C97C: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77CD2E: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77C432: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,726 bytes in 45 blocks are still reachable in loss record 171 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5C00777: vasprintf (in /lib/libc-2.7.so)
==7947==    by 0x509377F: g_vasprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50816EF: g_strdup_vprintf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x508178C: g_strdup_printf (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x494C0B: mono_guid_to_string (metadata.c:4993)
==7947==    by 0x4D34E5: do_mono_image_load (image.c:394)
==7947==    by 0x4D3A98: do_mono_image_open (image.c:944)
==7947==    by 0x4D3C44: mono_image_open_full (image.c:1200)
==7947==    by 0x4E8BFF: mono_assembly_open_full (assembly.c:1279)
==7947==    by 0x4E8D61: load_in_path (assembly.c:399)
==7947==    by 0x4E8E4B: mono_assembly_load_corlib (assembly.c:2195)
==7947== 
==7947== 
==7947== 1,728 bytes in 27 blocks are still reachable in loss record 172 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77B4F0: _XlcSetConverter (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA785120: _XlcAddUtf8LocaleConverters (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A084B: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x506F766: g_option_context_parse (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x99A030E: gtk_parse_args (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 1,936 bytes in 63 blocks are indirectly lost in loss record 173 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x499E56: mono_debug_list_add (mono-debug.c:1065)
==7947==    by 0x49AB91: mono_debug_open_image (mono-debug.c:385)
==7947==    by 0x49AD2C: mono_debug_add_assembly (mono-debug.c:402)
==7947==    by 0x4E6C8E: mono_assembly_invoke_load_hook (assembly.c:923)
==7947==    by 0x4E8896: mono_assembly_load_from_full (assembly.c:1482)
==7947==    by 0x4E8C60: mono_assembly_open_full (assembly.c:1298)
==7947==    by 0x4EA22E: mono_assembly_load_full_nosearch (assembly.c:2157)
==7947==    by 0x4EA2F7: mono_assembly_load_full (assembly.c:2295)
==7947==    by 0x4EA45E: mono_assembly_load_reference (assembly.c:848)
==7947==    by 0x4A945C: mono_class_from_typeref (class.c:144)
==7947== 
==7947== 
==7947== 2,048 bytes in 1 blocks are still reachable in loss record 174 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BA977: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 2,048 bytes in 2 blocks are still reachable in loss record 175 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x194B5FE1: (within /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x1949B895: GdipLoadImageFromDelegate_linux (in /usr/lib/libgdiplus.so.0.0.0)
==7947==    by 0x19462D67: ???
==7947==    by 0x190341F7: ???
==7947==    by 0x19033A63: ???
==7947==    by 0x170D486F: ???
==7947==    by 0x1806D6DF: ???
==7947==    by 0x170D486F: ???
==7947==    by 0x170D486F: ???
==7947==    by 0x1547250F: ???
==7947==    by 0x13A55EFF: ???
==7947== 
==7947== 
==7947== 2,048 bytes in 1 blocks are still reachable in loss record 176 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77BF9C: _XlcCreateLocaleDataBase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780F88: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0716: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 2,048 bytes in 1 blocks are still reachable in loss record 177 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xB91BB2F: FcFontSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91519A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB915201: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB915455: FcConfigBuildFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91BFAA: FcInitLoadConfigAndFonts (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91C06C: FcInit (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914751: FcConfigGetCurrent (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB914E81: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xA2E511F: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77C188: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 2,064 bytes in 1 blocks are still reachable in loss record 178 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6BB996: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BBE3A: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 2,127 bytes in 81 blocks are indirectly lost in loss record 179 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x49779C: mono_metadata_type_dup (metadata.c:4142)
==7947==    by 0x47F479: mono_mb_create_method (method-builder.c:153)
==7947==    by 0x47971C: mono_marshal_get_managed_wrapper (marshal.c:8948)
==7947==    by 0x479A12: mono_delegate_to_ftnptr (marshal.c:684)
==7947==    by 0x9844757: ???
==7947==    by 0x17FDAAB3: ???
==7947==    by 0x1703DEDF: ???
==7947==    by 0x7FEFFA1EF: ???
==7947==    by 0x9052E57: ???
==7947==    by 0x170C306F: ???
==7947== 
==7947== 
==7947== 2,208 bytes in 1 blocks are still reachable in loss record 180 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4011E14: (within /lib/ld-2.7.so)
==7947==    by 0x4012335: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==7947== 
==7947== 
==7947== 2,440 bytes in 98 blocks are still reachable in loss record 181 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4008B75: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947== 
==7947== 
==7947== 2,525 bytes in 48 blocks are still reachable in loss record 182 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AA7D: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0952E8: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 2,544 bytes in 8 blocks are possibly lost in loss record 183 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x401132B: _dl_allocate_tls (in /lib/ld-2.7.so)
==7947==    by 0x56FEB87: pthread_create@@GLIBC_2.2.5 (in /lib/libpthread-2.7.so)
==7947==    by 0x4F513D: _wapi_collection_init (collection.c:73)
==7947==    by 0x4F897A: shared_init (handles.c:241)
==7947==    by 0x4F7784: mono_once (mono-mutex.c:80)
==7947==    by 0x4F86E3: _wapi_handle_new (handles.c:413)
==7947==    by 0x4F4AD4: sem_create (semaphores.c:181)
==7947==    by 0x4F4E6C: CreateSemaphore (semaphores.c:353)
==7947==    by 0x4ED66A: mono_thread_pool_init (threadpool.c:989)
==7947==    by 0x49DBB4: mono_runtime_init (appdomain.c:142)
==7947==    by 0x526CF2: mini_init (mini.c:14205)
==7947== 
==7947== 
==7947== 2,616 bytes in 1 blocks are still reachable in loss record 184 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA75C790: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 3,161 bytes in 119 blocks are still reachable in loss record 185 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400AC49: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947== 
==7947== 
==7947== 3,660 bytes in 183 blocks are still reachable in loss record 186 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6B04BA: cairo_font_options_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1884: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77BA5E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 3,744 bytes in 52 blocks are still reachable in loss record 187 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA77AEC6: _XlcCreateDefaultCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AC7E: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA0906A5: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 4,096 bytes in 1 blocks are still reachable in loss record 188 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA761B90: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7875A8: XSupportsLocale (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 4,200 bytes in 175 blocks are still reachable in loss record 189 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91366A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB927179: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 4,628 bytes in 194 blocks are still reachable in loss record 190 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA7710FF: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA771D58: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7721B7: XrmGetStringDatabase (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA750EDF: XGetDefault (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xC56CADD: _XcursorGetDisplayInfo (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xC56CB48: XcursorGetTheme (in /usr/lib/libXcursor.so.1.0.2)
==7947==    by 0xA07EF9B: gdk_x11_display_set_cursor_theme (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A01E9C: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A02395: gtk_settings_get_for_screen (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1B288: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB284723: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 4,672 bytes in 46 blocks are still reachable in loss record 191 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4012436: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0xA74A39C: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA74A9B3: XCreateGlyphCursor (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA74ADF0: XCreateFontCursor (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA07F644: gdk_cursor_new_for_display (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 4,920 (2,952 direct, 1,968 indirect) bytes in 3 blocks are definitely lost in loss record 192 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6ABEB4: cairo_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA060197: gdk_cairo_create (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xE689285: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0xE6894F7: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0x98D140E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A587E: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB278BD7: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB279F7E: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0x9AACE54: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 3,072 bytes in 1 blocks are still reachable in loss record 193 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA7BABFB: _XkbReadGetMapReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BAC60: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB687: XkbGetUpdatedMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7BB764: XkbGetMap (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA093404: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093AFC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA093BB2: gdk_keymap_get_direction (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A50FB9: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54155: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A54858: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A55093: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 5,304 bytes in 221 blocks are still reachable in loss record 194 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924DE9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925D79: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 5,568 bytes in 232 blocks are still reachable in loss record 195 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92113C: FcPatternCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EF1D: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508FDF: pango_layout_get_pixel_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50905D: pango_layout_get_pixel_size (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x158BDD0F: ???
==7947==    by 0x158BCA4A: ???
==7947== 
==7947== 
==7947== 5,936 bytes in 14 blocks are still reachable in loss record 196 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6F0037: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F0506: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BBED4: cairo_scaled_font_create (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1FA3: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 6,016 bytes in 188 blocks are still reachable in loss record 197 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924BA9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925DF3: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 6,381 bytes in 1 blocks are still reachable in loss record 198 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA75D346: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 6,528 bytes in 204 blocks are still reachable in loss record 199 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB924F8D: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB925E50: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926EBB: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 6,720 bytes in 42 blocks are still reachable in loss record 200 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA74A161: XCreateGC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA08E36A: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x996411B: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x504766F: g_cache_insert (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x9964534: gtk_gc_get (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A1BDFA: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264BCE: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A642: g_signal_emit (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0x9A13FD7: gtk_style_attach (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 7,360 bytes in 230 blocks are indirectly lost in loss record 201 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB91CCFC: FcLangSetCreate (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91CDFD: FcLangSetCopy (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB921F09: FcValueSave (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92201C: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 7,552 bytes in 16 blocks are still reachable in loss record 202 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6E9065: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9602: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C12C1: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C1395: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C47CA: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C56A5: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E9C80: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF987: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C2E21: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C2195: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6C2B1D: (within /usr/lib/libcairo.so.2.17.3)
==7947== 
==7947== 
==7947== 8,589 bytes in 596 blocks are still reachable in loss record 203 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB923DC3: FcStrCopy (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB923E08: FcStrSetAdd (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB92619B: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947== 
==7947== 
==7947== 8,680 bytes in 1 blocks are still reachable in loss record 204 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xD03E57E: xcb_connect_to_fd (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xD040ADF: xcb_connect (in /usr/lib/libxcb.so.1.0.0)
==7947==    by 0xA773529: _XConnectXCB (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA75C7C5: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 9,224 bytes in 95 blocks are still reachable in loss record 205 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400C582: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x5CA30E6: __libc_dlopen_mode (in /lib/libc-2.7.so)
==7947==    by 0x5C7D03C: __nss_lookup_function (in /lib/libc-2.7.so)
==7947==    by 0x5C7D114: (within /lib/libc-2.7.so)
==7947==    by 0x5C31ABC: getpwnam_r (in /lib/libc-2.7.so)
==7947==    by 0x5091F6F: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 9,712 bytes in 26 blocks are still reachable in loss record 206 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x400C679: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==7947== 
==7947== 
==7947== 13,040 bytes in 652 blocks are still reachable in loss record 207 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6B047C: cairo_font_options_copy (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1E4C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E4C2C: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xC77BC3A: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 13,080 bytes in 545 blocks are still reachable in loss record 208 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB92515A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926C59: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xDBC60E0: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC6EE3: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC7C6C: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC8FEA: (within /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xDBC0000: XML_ParseBuffer (in /usr/lib/libexpat.so.1.5.2)
==7947==    by 0xB9262B7: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926533: FcConfigParseAndLoad (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926623: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB926E1A: (within /usr/lib/libfontconfig.so.1.3.0)
==7947== 
==7947== 
==7947== 16,272 bytes in 119 blocks are still reachable in loss record 209 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x400F8F4: (within /lib/ld-2.7.so)
==7947==    by 0x4012328: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x54F4F8A: (within /lib/libdl-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x54F54EC: (within /lib/libdl-2.7.so)
==7947==    by 0x54F4EF0: dlopen (in /lib/libdl-2.7.so)
==7947==    by 0x512EFB: mono_dl_open (mono-dl.c:305)
==7947==    by 0x4818B0: cached_module_load (loader.c:1048)
==7947==    by 0x481DF8: mono_lookup_pinvoke_call (loader.c:1193)
==7947== 
==7947== 
==7947== 16,352 bytes in 2 blocks are still reachable in loss record 210 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA761964: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA761D39: _XrmInternalStringToQuark (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AE08: _XlcGetCharSet (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77AA4C: _XlcAddCT (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77ACEF: _XlcInitCTInfo (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780E26: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA77EFB7: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA780BE5: _XlcCreateLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7A080F: _XlcUtf8Loader (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7870C3: _XOpenLC (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7871B7: _XlcCurrentLC (in /usr/lib/libX11.so.6.2.0)
==7947== 
==7947== 
==7947== 16,384 bytes in 2 blocks are still reachable in loss record 211 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x1E651147: apr_pool_create_ex (in /usr/lib/libapr-1.so.0.2.11)
==7947==    by 0x1E6520FA: apr_initialize (in /usr/lib/libapr-1.so.0.2.11)
==7947==    by 0x1D97CED7: ???
==7947==    by 0x1D97C493: ???
==7947==    by 0x1D97BFC1: ???
==7947==    by 0x1D97BE07: ???
==7947==    by 0x170C8DC7: ???
==7947== 
==7947== 
==7947== 16,384 bytes in 1 blocks are still reachable in loss record 212 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xA75CB15: XOpenDisplay (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA080448: gdk_display_open (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA05FAA3: gdk_display_open_default_libgtk_only (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0373: gtk_init_check (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x99A0398: gtk_init (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9844B6B: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947==    by 0x4C9ACF: mono_runtime_exec_main (object.c:3031)
==7947==    by 0x4CAEB2: mono_runtime_run_main (object.c:2825)
==7947==    by 0x417A2F: mono_main (driver.c:942)
==7947== 
==7947== 
==7947== 16,837 bytes in 387 blocks are still reachable in loss record 213 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB921211: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB922089: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 17,280 bytes in 12 blocks are still reachable in loss record 214 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0xB6B2C6B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B2EAE: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AE697: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BC548: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E7841: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF28B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 18,400 bytes in 31 blocks are possibly lost in loss record 215 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x49A93F: create_data_table (mono-debug.c:132)
==7947==    by 0x49ACE8: mono_debug_init (mono-debug.c:238)
==7947==    by 0x4179B4: mono_main (driver.c:1421)
==7947==    by 0x5BB31C3: (below main) (in /lib/libc-2.7.so)
==7947== 
==7947== 
==7947== 23,775 (19,592 direct, 4,183 indirect) bytes in 506 blocks are definitely lost in loss record 216 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x996CDDD: gtk_icon_source_new (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xE47ED67: ???
==7947==    by 0x63686F7: ???
==7947==    by 0x8FA3677: ???
==7947==    by 0x8A5087F: ???
==7947==    by 0x8FA3677: ???
==7947==    by 0x8FE6D7F: ???
==7947==    by 0x8FE6D7F: ???
==7947==    by 0x7FEFFF0EF: ???
==7947==    by 0x9151D8F: ???
==7947== 
==7947== 
==7947== 22,784 bytes in 5 blocks are still reachable in loss record 217 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069D45: g_try_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x143CDED0: rsvg_handle_get_pixbuf_sub (in /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0x1418BE4C: (within /usr/lib/gtk-2.0/2.10.0/loaders/svg_loader.so)
==7947==    by 0x9E33309: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0xE47E0D7: ???
==7947==    by 0xE47D16E: ???
==7947==    by 0xE47CFE7: ???
==7947==    by 0x91E8AB7: ???
==7947==    by 0x41AD377: ???
==7947== 
==7947== 
==7947== 29,415 bytes in 22 blocks are still reachable in loss record 218 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xC9AFD5B: ft_mem_qrealloc (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9AFDFA: ft_mem_realloc (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9B0781: FT_CMap_New (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9E2125: (within /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9E23E8: (within /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9BF08E: (within /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9B0A56: (within /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9B23D5: FT_Open_Face (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9B2FD1: FT_New_Face (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xB6EE75F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6F001F: (within /usr/lib/libcairo.so.2.17.3)
==7947== 
==7947== 
==7947== 38,816 bytes in 1,213 blocks are indirectly lost in loss record 219 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB9145A9: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB9149D7: FcConfigSubstituteWithPat (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91F02C: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 42,496 bytes in 1 blocks are still reachable in loss record 220 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA76C1CF: _XAllocScratch (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA761138: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7614F0: XPutImage (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA088489: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA08826C: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0798AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x158BD43F: ???
==7947==    by 0x158BD36F: ???
==7947==    by 0x1B0BFB53: ???
==7947==    by 0x158BCA4A: ???
==7947==    by 0xE475FCF: ???
==7947== 
==7947== 
==7947== 52,184 bytes in 3 blocks are still reachable in loss record 221 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xC793887: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC793E88: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC793FCD: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xEBA2392: (within /usr/lib/pango/1.6.0/modules/pango-basic-fc.so)
==7947==    by 0xA510679: pango_shape (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50481E: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506966: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5071B2: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9A46F57: gtk_text_layout_get_line_display (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A4A6E1: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 56,884 (55,580 direct, 1,304 indirect) bytes in 1,814 blocks are definitely lost in loss record 222 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x481ECF: mono_lookup_pinvoke_call (loader.c:1297)
==7947==    by 0x47A6C3: mono_marshal_get_native_wrapper (marshal.c:8504)
==7947==    by 0x54CCCD: mono_method_to_ir (mini.c:5741)
==7947==    by 0x5570D3: mini_method_compile (mini.c:12275)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x95F8E23: ???
==7947==    by 0x41AD343: ???
==7947== 
==7947== 
==7947== 74,040 bytes in 617 blocks are still reachable in loss record 223 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB6BC4E9: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6E7841: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6BF28B: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6B0F79: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6AA5EB: cairo_show_glyphs (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E49C5: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA2E3907: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA50CDBD: pango_renderer_draw_glyphs (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D311: pango_renderer_draw_layout_line (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA50D75A: pango_renderer_draw_layout (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 77,168 bytes in 371 blocks are still reachable in loss record 224 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA76CD75: _XEnq (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA773CED: (within /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA773FA4: _XReply (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA7534D4: _XGetWindowAttributes (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA753647: XGetWindowAttributes (in /usr/lib/libX11.so.6.2.0)
==7947==    by 0xA09B156: gdk_window_get_events (in /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AAF5B7: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AB3973: gtk_widget_realize (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AB3BD7: gtk_widget_map (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9918138: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9A68910: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947== 
==7947== 
==7947== 78,144 bytes in 43 blocks are still reachable in loss record 225 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x9E2DFAC: gdk_pixbuf_copy (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E35C0B: gdk_pixbuf_add_alpha (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE6890C6: (within /usr/lib/gtk-2.0/2.10.0/engines/libubuntulooks.so)
==7947==    by 0x9A11EE9: gtk_style_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x996F1D7: gtk_icon_set_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9AB2F99: gtk_widget_render_icon (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9982790: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0x9982848: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB27A254: g_signal_emit_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 125,384 bytes in 4,362 blocks are still reachable in loss record 226 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x4C230F4: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0xB2671FB: g_object_add_toggle_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xE477123: ???
==7947==    by 0x9853C7B: ???
==7947==    by 0xE47E0D7: ???
==7947==    by 0xE47D16E: ???
==7947==    by 0xE47CFE7: ???
==7947==    by 0x91E8AB7: ???
==7947==    by 0x41AD377: ???
==7947==    by 0x41AD245: ???
==7947== 
==7947== 
==7947== 138,282 bytes in 119 blocks are still reachable in loss record 227 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x400A9D4: (within /lib/ld-2.7.so)
==7947==    by 0x40061E4: (within /lib/ld-2.7.so)
==7947==    by 0x4008677: (within /lib/ld-2.7.so)
==7947==    by 0x400BE0C: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x400C4D0: (within /lib/ld-2.7.so)
==7947==    by 0x40120A8: (within /lib/ld-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947==    by 0x401191A: (within /lib/ld-2.7.so)
==7947==    by 0x5CA2F7F: (within /lib/libc-2.7.so)
==7947==    by 0x400DDF5: (within /lib/ld-2.7.so)
==7947== 
==7947== 
==7947== 146,692 bytes in 238 blocks are still reachable in loss record 228 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC9AE30F: ft_mem_qalloc (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9AFC52: ft_mem_alloc (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9B062F: FT_New_Library (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xC9AACF3: FT_Init_FreeType (in /usr/lib/libfreetype.so.6.3.16)
==7947==    by 0xB6EDACB: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EDF1F: (within /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xB6EE5EA: cairo_ft_font_face_create_for_pattern (in /usr/lib/libcairo.so.2.17.3)
==7947==    by 0xA2E1F87: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA2E2157: (within /usr/lib/libpangocairo-1.0.so.0.2002.3)
==7947==    by 0xA5040AA: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 191,296 bytes in 5,978 blocks are indirectly lost in loss record 229 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xB921FCD: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77C514: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA50408A: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504455: pango_layout_line_get_extents (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA504586: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA5081B5: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 383,200 (144,640 direct, 238,560 indirect) bytes in 230 blocks are definitely lost in loss record 230 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0xB921792: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB922105: (within /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xB91EFB5: FcFontRenderPrepare (in /usr/lib/libfontconfig.so.1.3.0)
==7947==    by 0xC77C283: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xA4FE9DC: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA4FED3B: pango_itemize_with_base_dir (in /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA506E7D: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0xA508040: (within /usr/lib/libpango-1.0.so.0.2002.3)
==7947==    by 0x9992375: (within /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xB264C9B: g_closure_invoke (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2784CD: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 393,216 bytes in 6 blocks are still reachable in loss record 231 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xA0910FB: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0674F7: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0677AD: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA087E51: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0xA0798AC: (within /usr/lib/libgdk-x11-2.0.so.0.1200.9)
==7947==    by 0x158BD43F: ???
==7947==    by 0x158BD36F: ???
==7947==    by 0x158BCBAF: ???
==7947==    by 0x158BCA4A: ???
==7947==    by 0xE475FCF: ???
==7947==    by 0x8A35137: ???
==7947== 
==7947== 
==7947== 502,648 bytes in 5,200 blocks are still reachable in loss record 232 of 238
==7947==    at 0x4C23082: realloc (vg_replace_malloc.c:429)
==7947==    by 0x5069DD8: g_realloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0xB27471C: (within /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB2764E3: g_signal_connect_data (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xE477E5F: ???
==7947==    by 0x7FEFF9F8F: ???
==7947==    by 0x170C431F: ???
==7947==    by 0x1806AC3F: ???
==7947==    by 0x7FEFF9D0F: ???
==7947==    by 0x8847A7F: ???
==7947==    by 0x7FEFF9D0F: ???
==7947==    by 0x7FEFF9C4F: ???
==7947== 
==7947== 
==7947== 887,456 bytes in 806 blocks are possibly lost in loss record 233 of 238
==7947==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==7947==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==7947==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x507E1E5: g_slice_alloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0xB2842BE: g_type_create_instance (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26C97D: g_param_spec_internal (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26E604: g_param_spec_double (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0x143CE2D9: (within /usr/lib/librsvg-2.so.2.22.2)
==7947==    by 0xB283C50: g_type_class_ref (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26AB11: g_object_newv (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947==    by 0xB26B051: g_object_new_valist (in /usr/lib/libgobject-2.0.so.0.1600.4)
==7947== 
==7947== 
==7947== 1,678,438 bytes in 8,322 blocks are still reachable in loss record 234 of 238
==7947==    at 0x4C220BC: calloc (vg_replace_malloc.c:397)
==7947==    by 0x5069E62: g_malloc0 (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x495B55: mono_metadata_load_generic_param_constraints (metadata.c:5028)
==7947==    by 0x482B61: mono_get_method_from_token (loader.c:1399)
==7947==    by 0x48316A: mono_get_method_full (loader.c:1476)
==7947==    by 0x4A79A0: mono_class_setup_methods (class.c:1555)
==7947==    by 0x4A3B30: mono_class_setup_vtable (class.c:2410)
==7947==    by 0x4E0F7B: ves_icall_Type_GetMethodsByName (icall.c:3544)
==7947==    by 0x95F9E6B: ???
==7947==    by 0x95F9F38: ???
==7947==    by 0x1522CBC3: ???
==7947==    by 0x1522C643: ???
==7947== 
==7947== 
==7947== 4,699,254 bytes in 7,344 blocks are still reachable in loss record 235 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0xC782201: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC79016E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC790C2E: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC7921A3: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC7928A6: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77F604: pango_ot_info_get_gsub (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77F654: (within /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC77FEDB: pango_ot_info_find_script (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC7809B9: pango_ot_ruleset_new_for (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC780A75: pango_ot_ruleset_new_from_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947==    by 0xC780BBE: pango_ot_ruleset_get_for_description (in /usr/lib/libpangoft2-1.0.so.0.2002.3)
==7947== 
==7947== 
==7947== 11,223,669 bytes in 14,838 blocks are still reachable in loss record 236 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x5069EBB: g_malloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x50810EE: g_strdup (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x996D74A: gtk_icon_factory_add (in /usr/lib/libgtk-x11-2.0.so.0.1200.9)
==7947==    by 0xE47EC9F: ???
==7947==    by 0x63686F7: ???
==7947==    by 0x139E239F: ???
==7947==    by 0x7FEFFF1DF: ???
==7947== 
==7947== 
==7947== 12,468,844 bytes in 608 blocks are still reachable in loss record 237 of 238
==7947==    at 0x4C22FAB: malloc (vg_replace_malloc.c:207)
==7947==    by 0x9E2DE94: gdk_pixbuf_new (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE899F57: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0xD26C9F2: (within /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xD26CFEA: png_process_data (in /usr/lib/libpng12.so.0.15.0)
==7947==    by 0xE8995FB: (within /usr/lib/gtk-2.0/2.10.0/loaders/libpixbufloader-png.so)
==7947==    by 0x9E32D68: (within /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0x9E333EB: gdk_pixbuf_loader_close (in /usr/lib/libgdk_pixbuf-2.0.so.0.1200.9)
==7947==    by 0xE479633: ???
==7947==    by 0xE47E617: ???
==7947==    by 0xE47E0D7: ???
==7947==    by 0xE47D16E: ???
==7947== 
==7947== 
==7947== 862,223,392 bytes in 1,737,838 blocks are still reachable in loss record 238 of 238
==7947==    at 0x4C21F8F: memalign (vg_replace_malloc.c:460)
==7947==    by 0x4C22028: posix_memalign (vg_replace_malloc.c:569)
==7947==    by 0x507D299: (within /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x507E0F0: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x506035D: g_list_prepend (in /usr/lib/libglib-2.0.so.0.1600.4)
==7947==    by 0x432953: mono_arch_get_allocatable_int_vars (mini-amd64.c:910)
==7947==    by 0x5579A9: mini_method_compile (mini.c:12490)
==7947==    by 0x558CF8: mono_jit_compile_method (mini.c:12819)
==7947==    by 0x42C5A2: mono_magic_trampoline (mini-trampolines.c:249)
==7947==    by 0x415B164: ???
==7947==    by 0x8FCA917: ???
==7947==    by 0x85E7E9F: ???
==7947== 
==7947== LEAK SUMMARY:
==7947==    definitely lost: 224,208 bytes in 2,560 blocks.
==7947==    indirectly lost: 246,287 bytes in 7,799 blocks.
==7947==      possibly lost: 908,944 bytes in 847 blocks.
==7947==    still reachable: 894,292,519 bytes in 1,785,499 blocks.
==7947==         suppressed: 0 bytes in 0 blocks.
--7947--  memcheck: sanity checks: 1062234 cheap, 1436 expensive
--7947--  memcheck: auxmaps: 0 auxmap entries (0k, 0M) in use
--7947--  memcheck: auxmaps_L1: 0 searches, 0 cmps, ratio 0:10
--7947--  memcheck: auxmaps_L2: 0 searches, 0 nodes
--7947--  memcheck: SMs: n_issued      = 31487 (503792k, 491M)
--7947--  memcheck: SMs: n_deissued    = 313 (5008k, 4M)
--7947--  memcheck: SMs: max_noaccess  = 524287 (8388592k, 8191M)
--7947--  memcheck: SMs: max_undefined = 11 (176k, 0M)
--7947--  memcheck: SMs: max_defined   = 6004 (96064k, 93M)
--7947--  memcheck: SMs: max_non_DSM   = 31177 (498832k, 487M)
--7947--  memcheck: max sec V bit nodes:    799106 (68673k, 67M)
--7947--  memcheck: set_sec_vbits8 calls: 37980753 (new: 909881, updates: 37070872)
--7947--  memcheck: max shadow mem size:   571649k, 558M
--7947-- translate:            fast SP updates identified: 207,899 ( 84.4%)
--7947-- translate:   generic_known SP updates identified: 31,898 ( 12.9%)
--7947-- translate: generic_unknown SP updates identified: 6,270 (  2.5%)
--7947--     tt/tc: 1,544,534,350 tt lookups requiring 152,509,294,503 probes
--7947--     tt/tc: 1,544,534,350 fast-cache updates, 19,465 flushes
--7947--  transtab: new        270,571 (5,533,431 -> 104,838,640; ratio 189:10) [270,571 scs]
--7947--  transtab: dumped     0 (0 -> ??)
--7947--  transtab: discarded  135,142 (3,188,611 -> ??)
--7947-- scheduler: 96,071,300,033 jumps (bb entries).
--7947-- scheduler: 1,062,234/1,698,904,082 major/minor sched events.
--7947--    sanity: 1062235 cheap, 1436 expensive checks.
--7947--    exectx: 50,331,653 lists, 32,102,897 contexts (avg 0 per list)
--7947--    exectx: 156,473,555 searches, 150,817,689 full compares (963 per 1000)
--7947--    exectx: 397,539,175 cmp2, 589,412 cmp4, 0 cmpAll
--7947--  errormgr: 537 supplist searches, 28,011 comparisons during search
--7947--  errormgr: 15,439,614 errlist searches, 68,392,420 comparisons during search
