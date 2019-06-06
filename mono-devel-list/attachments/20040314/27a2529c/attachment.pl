make  all-recursive
make[1]: Entering directory `/home/manoj/Mono/mono-0.30.1'
Making all in libgc
make[2]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc'
Making all in include
make[3]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc/include'
Making all in private
make[4]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc/include/private'
make[4]: Nothing to be done for `all'.
make[4]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc/include/private'
make[4]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc/include'
make[4]: Nothing to be done for `all-am'.
make[4]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc/include'
make[3]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc/include'
Making all in doc
make[3]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc/doc'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc/doc'
make[3]: Entering directory `/home/manoj/Mono/mono-0.30.1/libgc'
source='allchblk.c' object='allchblk.lo' libtool=yes \
depfile='.deps/allchblk.Plo' tmpdepfile='.deps/allchblk.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o allchblk.lo `test -f 'allchblk.c' || echo './'`allchblk.c
mkdir .libs
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c allchblk.c -MT allchblk.lo -MD -MP -MF .deps/allchblk.TPlo  -fPIC -DPIC -o .libs/allchblk.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c allchblk.c -MT allchblk.lo -MD -MP -MF .deps/allchblk.TPlo -o allchblk.o >/dev/null 2>&1
mv -f .libs/allchblk.lo allchblk.lo
source='alloc.c' object='alloc.lo' libtool=yes \
depfile='.deps/alloc.Plo' tmpdepfile='.deps/alloc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o alloc.lo `test -f 'alloc.c' || echo './'`alloc.c
rm -f .libs/alloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c alloc.c -MT alloc.lo -MD -MP -MF .deps/alloc.TPlo  -fPIC -DPIC -o .libs/alloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c alloc.c -MT alloc.lo -MD -MP -MF .deps/alloc.TPlo -o alloc.o >/dev/null 2>&1
mv -f .libs/alloc.lo alloc.lo
source='blacklst.c' object='blacklst.lo' libtool=yes \
depfile='.deps/blacklst.Plo' tmpdepfile='.deps/blacklst.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o blacklst.lo `test -f 'blacklst.c' || echo './'`blacklst.c
rm -f .libs/blacklst.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c blacklst.c -MT blacklst.lo -MD -MP -MF .deps/blacklst.TPlo  -fPIC -DPIC -o .libs/blacklst.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c blacklst.c -MT blacklst.lo -MD -MP -MF .deps/blacklst.TPlo -o blacklst.o >/dev/null 2>&1
mv -f .libs/blacklst.lo blacklst.lo
source='checksums.c' object='checksums.lo' libtool=yes \
depfile='.deps/checksums.Plo' tmpdepfile='.deps/checksums.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o checksums.lo `test -f 'checksums.c' || echo './'`checksums.c
rm -f .libs/checksums.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c checksums.c -MT checksums.lo -MD -MP -MF .deps/checksums.TPlo  -fPIC -DPIC -o .libs/checksums.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c checksums.c -MT checksums.lo -MD -MP -MF .deps/checksums.TPlo -o checksums.o >/dev/null 2>&1
mv -f .libs/checksums.lo checksums.lo
source='dbg_mlc.c' object='dbg_mlc.lo' libtool=yes \
depfile='.deps/dbg_mlc.Plo' tmpdepfile='.deps/dbg_mlc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o dbg_mlc.lo `test -f 'dbg_mlc.c' || echo './'`dbg_mlc.c
rm -f .libs/dbg_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c dbg_mlc.c -MT dbg_mlc.lo -MD -MP -MF .deps/dbg_mlc.TPlo  -fPIC -DPIC -o .libs/dbg_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c dbg_mlc.c -MT dbg_mlc.lo -MD -MP -MF .deps/dbg_mlc.TPlo -o dbg_mlc.o >/dev/null 2>&1
mv -f .libs/dbg_mlc.lo dbg_mlc.lo
source='dyn_load.c' object='dyn_load.lo' libtool=yes \
depfile='.deps/dyn_load.Plo' tmpdepfile='.deps/dyn_load.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o dyn_load.lo `test -f 'dyn_load.c' || echo './'`dyn_load.c
rm -f .libs/dyn_load.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c dyn_load.c -MT dyn_load.lo -MD -MP -MF .deps/dyn_load.TPlo  -fPIC -DPIC -o .libs/dyn_load.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c dyn_load.c -MT dyn_load.lo -MD -MP -MF .deps/dyn_load.TPlo -o dyn_load.o >/dev/null 2>&1
mv -f .libs/dyn_load.lo dyn_load.lo
source='finalize.c' object='finalize.lo' libtool=yes \
depfile='.deps/finalize.Plo' tmpdepfile='.deps/finalize.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o finalize.lo `test -f 'finalize.c' || echo './'`finalize.c
rm -f .libs/finalize.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c finalize.c -MT finalize.lo -MD -MP -MF .deps/finalize.TPlo  -fPIC -DPIC -o .libs/finalize.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c finalize.c -MT finalize.lo -MD -MP -MF .deps/finalize.TPlo -o finalize.o >/dev/null 2>&1
mv -f .libs/finalize.lo finalize.lo
source='gc_dlopen.c' object='gc_dlopen.lo' libtool=yes \
depfile='.deps/gc_dlopen.Plo' tmpdepfile='.deps/gc_dlopen.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o gc_dlopen.lo `test -f 'gc_dlopen.c' || echo './'`gc_dlopen.c
rm -f .libs/gc_dlopen.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c gc_dlopen.c -MT gc_dlopen.lo -MD -MP -MF .deps/gc_dlopen.TPlo  -fPIC -DPIC -o .libs/gc_dlopen.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c gc_dlopen.c -MT gc_dlopen.lo -MD -MP -MF .deps/gc_dlopen.TPlo -o gc_dlopen.o >/dev/null 2>&1
mv -f .libs/gc_dlopen.lo gc_dlopen.lo
source='gcj_mlc.c' object='gcj_mlc.lo' libtool=yes \
depfile='.deps/gcj_mlc.Plo' tmpdepfile='.deps/gcj_mlc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o gcj_mlc.lo `test -f 'gcj_mlc.c' || echo './'`gcj_mlc.c
rm -f .libs/gcj_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c gcj_mlc.c -MT gcj_mlc.lo -MD -MP -MF .deps/gcj_mlc.TPlo  -fPIC -DPIC -o .libs/gcj_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c gcj_mlc.c -MT gcj_mlc.lo -MD -MP -MF .deps/gcj_mlc.TPlo -o gcj_mlc.o >/dev/null 2>&1
mv -f .libs/gcj_mlc.lo gcj_mlc.lo
source='headers.c' object='headers.lo' libtool=yes \
depfile='.deps/headers.Plo' tmpdepfile='.deps/headers.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o headers.lo `test -f 'headers.c' || echo './'`headers.c
rm -f .libs/headers.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c headers.c -MT headers.lo -MD -MP -MF .deps/headers.TPlo  -fPIC -DPIC -o .libs/headers.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c headers.c -MT headers.lo -MD -MP -MF .deps/headers.TPlo -o headers.o >/dev/null 2>&1
mv -f .libs/headers.lo headers.lo
source='irix_threads.c' object='irix_threads.lo' libtool=yes \
depfile='.deps/irix_threads.Plo' tmpdepfile='.deps/irix_threads.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o irix_threads.lo `test -f 'irix_threads.c' || echo './'`irix_threads.c
rm -f .libs/irix_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c irix_threads.c -MT irix_threads.lo -MD -MP -MF .deps/irix_threads.TPlo  -fPIC -DPIC -o .libs/irix_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c irix_threads.c -MT irix_threads.lo -MD -MP -MF .deps/irix_threads.TPlo -o irix_threads.o >/dev/null 2>&1
mv -f .libs/irix_threads.lo irix_threads.lo
source='linux_threads.c' object='linux_threads.lo' libtool=yes \
depfile='.deps/linux_threads.Plo' tmpdepfile='.deps/linux_threads.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o linux_threads.lo `test -f 'linux_threads.c' || echo './'`linux_threads.c
rm -f .libs/linux_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c linux_threads.c -MT linux_threads.lo -MD -MP -MF .deps/linux_threads.TPlo  -fPIC -DPIC -o .libs/linux_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c linux_threads.c -MT linux_threads.lo -MD -MP -MF .deps/linux_threads.TPlo -o linux_threads.o >/dev/null 2>&1
mv -f .libs/linux_threads.lo linux_threads.lo
source='malloc.c' object='malloc.lo' libtool=yes \
depfile='.deps/malloc.Plo' tmpdepfile='.deps/malloc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o malloc.lo `test -f 'malloc.c' || echo './'`malloc.c
rm -f .libs/malloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c malloc.c -MT malloc.lo -MD -MP -MF .deps/malloc.TPlo  -fPIC -DPIC -o .libs/malloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c malloc.c -MT malloc.lo -MD -MP -MF .deps/malloc.TPlo -o malloc.o >/dev/null 2>&1
mv -f .libs/malloc.lo malloc.lo
source='mallocx.c' object='mallocx.lo' libtool=yes \
depfile='.deps/mallocx.Plo' tmpdepfile='.deps/mallocx.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o mallocx.lo `test -f 'mallocx.c' || echo './'`mallocx.c
rm -f .libs/mallocx.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mallocx.c -MT mallocx.lo -MD -MP -MF .deps/mallocx.TPlo  -fPIC -DPIC -o .libs/mallocx.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mallocx.c -MT mallocx.lo -MD -MP -MF .deps/mallocx.TPlo -o mallocx.o >/dev/null 2>&1
mv -f .libs/mallocx.lo mallocx.lo
source='mark.c' object='mark.lo' libtool=yes \
depfile='.deps/mark.Plo' tmpdepfile='.deps/mark.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o mark.lo `test -f 'mark.c' || echo './'`mark.c
rm -f .libs/mark.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mark.c -MT mark.lo -MD -MP -MF .deps/mark.TPlo  -fPIC -DPIC -o .libs/mark.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mark.c -MT mark.lo -MD -MP -MF .deps/mark.TPlo -o mark.o >/dev/null 2>&1
mv -f .libs/mark.lo mark.lo
source='mark_rts.c' object='mark_rts.lo' libtool=yes \
depfile='.deps/mark_rts.Plo' tmpdepfile='.deps/mark_rts.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o mark_rts.lo `test -f 'mark_rts.c' || echo './'`mark_rts.c
rm -f .libs/mark_rts.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mark_rts.c -MT mark_rts.lo -MD -MP -MF .deps/mark_rts.TPlo  -fPIC -DPIC -o .libs/mark_rts.lo
mark_rts.c: In function `GC_approx_sp':
mark_rts.c:376: warning: function returns address of local variable
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mark_rts.c -MT mark_rts.lo -MD -MP -MF .deps/mark_rts.TPlo -o mark_rts.o >/dev/null 2>&1
mv -f .libs/mark_rts.lo mark_rts.lo
source='misc.c' object='misc.lo' libtool=yes \
depfile='.deps/misc.Plo' tmpdepfile='.deps/misc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o misc.lo `test -f 'misc.c' || echo './'`misc.c
rm -f .libs/misc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c misc.c -MT misc.lo -MD -MP -MF .deps/misc.TPlo  -fPIC -DPIC -o .libs/misc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c misc.c -MT misc.lo -MD -MP -MF .deps/misc.TPlo -o misc.o >/dev/null 2>&1
mv -f .libs/misc.lo misc.lo
source='new_hblk.c' object='new_hblk.lo' libtool=yes \
depfile='.deps/new_hblk.Plo' tmpdepfile='.deps/new_hblk.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o new_hblk.lo `test -f 'new_hblk.c' || echo './'`new_hblk.c
rm -f .libs/new_hblk.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c new_hblk.c -MT new_hblk.lo -MD -MP -MF .deps/new_hblk.TPlo  -fPIC -DPIC -o .libs/new_hblk.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c new_hblk.c -MT new_hblk.lo -MD -MP -MF .deps/new_hblk.TPlo -o new_hblk.o >/dev/null 2>&1
mv -f .libs/new_hblk.lo new_hblk.lo
source='obj_map.c' object='obj_map.lo' libtool=yes \
depfile='.deps/obj_map.Plo' tmpdepfile='.deps/obj_map.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o obj_map.lo `test -f 'obj_map.c' || echo './'`obj_map.c
rm -f .libs/obj_map.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c obj_map.c -MT obj_map.lo -MD -MP -MF .deps/obj_map.TPlo  -fPIC -DPIC -o .libs/obj_map.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c obj_map.c -MT obj_map.lo -MD -MP -MF .deps/obj_map.TPlo -o obj_map.o >/dev/null 2>&1
mv -f .libs/obj_map.lo obj_map.lo
source='os_dep.c' object='os_dep.lo' libtool=yes \
depfile='.deps/os_dep.Plo' tmpdepfile='.deps/os_dep.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o os_dep.lo `test -f 'os_dep.c' || echo './'`os_dep.c
rm -f .libs/os_dep.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c os_dep.c -MT os_dep.lo -MD -MP -MF .deps/os_dep.TPlo  -fPIC -DPIC -o .libs/os_dep.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c os_dep.c -MT os_dep.lo -MD -MP -MF .deps/os_dep.TPlo -o os_dep.o >/dev/null 2>&1
mv -f .libs/os_dep.lo os_dep.lo
source='pcr_interface.c' object='pcr_interface.lo' libtool=yes \
depfile='.deps/pcr_interface.Plo' tmpdepfile='.deps/pcr_interface.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o pcr_interface.lo `test -f 'pcr_interface.c' || echo './'`pcr_interface.c
rm -f .libs/pcr_interface.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c pcr_interface.c -MT pcr_interface.lo -MD -MP -MF .deps/pcr_interface.TPlo  -fPIC -DPIC -o .libs/pcr_interface.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c pcr_interface.c -MT pcr_interface.lo -MD -MP -MF .deps/pcr_interface.TPlo -o pcr_interface.o >/dev/null 2>&1
mv -f .libs/pcr_interface.lo pcr_interface.lo
source='ptr_chck.c' object='ptr_chck.lo' libtool=yes \
depfile='.deps/ptr_chck.Plo' tmpdepfile='.deps/ptr_chck.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o ptr_chck.lo `test -f 'ptr_chck.c' || echo './'`ptr_chck.c
rm -f .libs/ptr_chck.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c ptr_chck.c -MT ptr_chck.lo -MD -MP -MF .deps/ptr_chck.TPlo  -fPIC -DPIC -o .libs/ptr_chck.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c ptr_chck.c -MT ptr_chck.lo -MD -MP -MF .deps/ptr_chck.TPlo -o ptr_chck.o >/dev/null 2>&1
mv -f .libs/ptr_chck.lo ptr_chck.lo
source='real_malloc.c' object='real_malloc.lo' libtool=yes \
depfile='.deps/real_malloc.Plo' tmpdepfile='.deps/real_malloc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o real_malloc.lo `test -f 'real_malloc.c' || echo './'`real_malloc.c
rm -f .libs/real_malloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c real_malloc.c -MT real_malloc.lo -MD -MP -MF .deps/real_malloc.TPlo  -fPIC -DPIC -o .libs/real_malloc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c real_malloc.c -MT real_malloc.lo -MD -MP -MF .deps/real_malloc.TPlo -o real_malloc.o >/dev/null 2>&1
mv -f .libs/real_malloc.lo real_malloc.lo
source='reclaim.c' object='reclaim.lo' libtool=yes \
depfile='.deps/reclaim.Plo' tmpdepfile='.deps/reclaim.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o reclaim.lo `test -f 'reclaim.c' || echo './'`reclaim.c
rm -f .libs/reclaim.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c reclaim.c -MT reclaim.lo -MD -MP -MF .deps/reclaim.TPlo  -fPIC -DPIC -o .libs/reclaim.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c reclaim.c -MT reclaim.lo -MD -MP -MF .deps/reclaim.TPlo -o reclaim.o >/dev/null 2>&1
mv -f .libs/reclaim.lo reclaim.lo
source='solaris_pthreads.c' object='solaris_pthreads.lo' libtool=yes \
depfile='.deps/solaris_pthreads.Plo' tmpdepfile='.deps/solaris_pthreads.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o solaris_pthreads.lo `test -f 'solaris_pthreads.c' || echo './'`solaris_pthreads.c
rm -f .libs/solaris_pthreads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c solaris_pthreads.c -MT solaris_pthreads.lo -MD -MP -MF .deps/solaris_pthreads.TPlo  -fPIC -DPIC -o .libs/solaris_pthreads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c solaris_pthreads.c -MT solaris_pthreads.lo -MD -MP -MF .deps/solaris_pthreads.TPlo -o solaris_pthreads.o >/dev/null 2>&1
mv -f .libs/solaris_pthreads.lo solaris_pthreads.lo
source='solaris_threads.c' object='solaris_threads.lo' libtool=yes \
depfile='.deps/solaris_threads.Plo' tmpdepfile='.deps/solaris_threads.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o solaris_threads.lo `test -f 'solaris_threads.c' || echo './'`solaris_threads.c
rm -f .libs/solaris_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c solaris_threads.c -MT solaris_threads.lo -MD -MP -MF .deps/solaris_threads.TPlo  -fPIC -DPIC -o .libs/solaris_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c solaris_threads.c -MT solaris_threads.lo -MD -MP -MF .deps/solaris_threads.TPlo -o solaris_threads.o >/dev/null 2>&1
mv -f .libs/solaris_threads.lo solaris_threads.lo
source='specific.c' object='specific.lo' libtool=yes \
depfile='.deps/specific.Plo' tmpdepfile='.deps/specific.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o specific.lo `test -f 'specific.c' || echo './'`specific.c
rm -f .libs/specific.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c specific.c -MT specific.lo -MD -MP -MF .deps/specific.TPlo  -fPIC -DPIC -o .libs/specific.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c specific.c -MT specific.lo -MD -MP -MF .deps/specific.TPlo -o specific.o >/dev/null 2>&1
mv -f .libs/specific.lo specific.lo
source='stubborn.c' object='stubborn.lo' libtool=yes \
depfile='.deps/stubborn.Plo' tmpdepfile='.deps/stubborn.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o stubborn.lo `test -f 'stubborn.c' || echo './'`stubborn.c
rm -f .libs/stubborn.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c stubborn.c -MT stubborn.lo -MD -MP -MF .deps/stubborn.TPlo  -fPIC -DPIC -o .libs/stubborn.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c stubborn.c -MT stubborn.lo -MD -MP -MF .deps/stubborn.TPlo -o stubborn.o >/dev/null 2>&1
mv -f .libs/stubborn.lo stubborn.lo
source='typd_mlc.c' object='typd_mlc.lo' libtool=yes \
depfile='.deps/typd_mlc.Plo' tmpdepfile='.deps/typd_mlc.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o typd_mlc.lo `test -f 'typd_mlc.c' || echo './'`typd_mlc.c
rm -f .libs/typd_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c typd_mlc.c -MT typd_mlc.lo -MD -MP -MF .deps/typd_mlc.TPlo  -fPIC -DPIC -o .libs/typd_mlc.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c typd_mlc.c -MT typd_mlc.lo -MD -MP -MF .deps/typd_mlc.TPlo -o typd_mlc.o >/dev/null 2>&1
mv -f .libs/typd_mlc.lo typd_mlc.lo
source='backgraph.c' object='backgraph.lo' libtool=yes \
depfile='.deps/backgraph.Plo' tmpdepfile='.deps/backgraph.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o backgraph.lo `test -f 'backgraph.c' || echo './'`backgraph.c
rm -f .libs/backgraph.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c backgraph.c -MT backgraph.lo -MD -MP -MF .deps/backgraph.TPlo  -fPIC -DPIC -o .libs/backgraph.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c backgraph.c -MT backgraph.lo -MD -MP -MF .deps/backgraph.TPlo -o backgraph.o >/dev/null 2>&1
mv -f .libs/backgraph.lo backgraph.lo
source='win32_threads.c' object='win32_threads.lo' libtool=yes \
depfile='.deps/win32_threads.Plo' tmpdepfile='.deps/win32_threads.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o win32_threads.lo `test -f 'win32_threads.c' || echo './'`win32_threads.c
rm -f .libs/win32_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c win32_threads.c -MT win32_threads.lo -MD -MP -MF .deps/win32_threads.TPlo  -fPIC -DPIC -o .libs/win32_threads.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c win32_threads.c -MT win32_threads.lo -MD -MP -MF .deps/win32_threads.TPlo -o win32_threads.o >/dev/null 2>&1
mv -f .libs/win32_threads.lo win32_threads.lo
source='mach_dep.c' object='mach_dep.lo' libtool=yes \
depfile='.deps/mach_dep.Plo' tmpdepfile='.deps/mach_dep.TPlo' \
depmode=gcc3 /bin/sh ./depcomp \
/bin/sh ./libtool --mode=compile gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" -DPACKAGE_STRING=\"libgc-mono\ 6.2\" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1  -I./include -I./include   -fexceptions -g -O2 -fexceptions  -c -o mach_dep.lo `test -f 'mach_dep.c' || echo './'`mach_dep.c
rm -f .libs/mach_dep.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mach_dep.c -MT mach_dep.lo -MD -MP -MF .deps/mach_dep.TPlo  -fPIC -DPIC -o .libs/mach_dep.lo
gcc -DPACKAGE_NAME=\"libgc-mono\" -DPACKAGE_TARNAME=\"libgc-mono\" -DPACKAGE_VERSION=\"6.2\" "-DPACKAGE_STRING=\"libgc-mono 6.2\"" -DPACKAGE_BUGREPORT=\"Hans_Boehm@hp.com\" -DGC_LINUX_THREADS=1 -D_REENTRANT=1 -DTHREAD_LOCAL_ALLOC=1 -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 -DHAVE_DLFCN_H=1 -DSILENT=1 -DNO_SIGNALS=1 -DNO_EXECUTE_PERMISSION=1 -DJAVA_FINALIZATION=1 -DGC_GCJ_SUPPORT=1 -DATOMIC_UNCOLLECTABLE=1 -D_IN_LIBGC=1 -I./include -I./include -fexceptions -g -O2 -fexceptions -c mach_dep.c -MT mach_dep.lo -MD -MP -MF .deps/mach_dep.TPlo -o mach_dep.o >/dev/null 2>&1
mv -f .libs/mach_dep.lo mach_dep.lo
/bin/sh ./libtool --mode=link gcc -fexceptions -g -O2  -o libmonogc.la  -version-info 1:1:0 allchblk.lo alloc.lo blacklst.lo checksums.lo dbg_mlc.lo dyn_load.lo finalize.lo gc_dlopen.lo gcj_mlc.lo headers.lo irix_threads.lo linux_threads.lo malloc.lo mallocx.lo mark.lo mark_rts.lo misc.lo new_hblk.lo obj_map.lo os_dep.lo pcr_interface.lo ptr_chck.lo real_malloc.lo reclaim.lo solaris_pthreads.lo solaris_threads.lo specific.lo stubborn.lo typd_mlc.lo backgraph.lo win32_threads.lo mach_dep.lo -lpthread 
libtool: link: warning: `-version-info' is ignored for convenience libraries
rm -fr .libs/libmonogc.la .libs/libmonogc.* .libs/libmonogc.*
ar cru .libs/libmonogc.al allchblk.lo alloc.lo blacklst.lo checksums.lo dbg_mlc.lo dyn_load.lo finalize.lo gc_dlopen.lo gcj_mlc.lo headers.lo irix_threads.lo linux_threads.lo malloc.lo mallocx.lo mark.lo mark_rts.lo misc.lo new_hblk.lo obj_map.lo os_dep.lo pcr_interface.lo ptr_chck.lo real_malloc.lo reclaim.lo solaris_pthreads.lo solaris_threads.lo specific.lo stubborn.lo typd_mlc.lo backgraph.lo win32_threads.lo mach_dep.lo
ranlib .libs/libmonogc.al
creating libmonogc.la
(cd .libs && rm -f libmonogc.la && ln -s ../libmonogc.la libmonogc.la)
make[3]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc'
make[2]: Leaving directory `/home/manoj/Mono/mono-0.30.1/libgc'
Making all in mono
make[2]: Entering directory `/home/manoj/Mono/mono-0.30.1/mono'
Making all in utils
make[3]: Entering directory `/home/manoj/Mono/mono-0.30.1/mono/utils'
source='mono-hash.c' object='mono-hash.lo' libtool=yes \
depfile='.deps/mono-hash.Plo' tmpdepfile='.deps/mono-hash.TPlo' \
depmode=gcc3 /bin/sh ../../depcomp \
/bin/sh ../../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../.. -I../../mono -I../../libgc/include -pthread -I../..//home/manoj/GLib/glib-2.2.1 -I../..//home/manoj/GLib/glib-2.2.1/. -I../..//home/manoj/GLib/glib-2.2.1/./glib   -I../..//home/manoj/GLib/glib-2.2.1/./gmodule -I../..//home/manoj/GLib/glib-2.2.1 -I../..//home/manoj/GLib/glib-2.2.1/. -I../..//home/manoj/GLib/glib-2.2.1/./glib    -DGC_LINUX_THREADS -DMONO_USE_EXC_TABLES -D_GNU_SOURCE -D_REENTRANT -fexceptions -D_FILE_OFFSET_BITS=64  -g -O2 -fno-strict-aliasing -g -Wall -Wunused -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes  -Wmissing-prototypes -Wnested-externs -Wpointer-arith -Wno-cast-qual -Wcast-align -Wwrite-strings -c -o mono-hash.lo `test -f 'mono-hash.c' || echo './'`mono-hash.c
mkdir .libs
gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../.. -I../../mono -I../../libgc/include -pthread -I../..//home/manoj/GLib/glib-2.2.1 -I../..//home/manoj/GLib/glib-2.2.1/. -I../..//home/manoj/GLib/glib-2.2.1/./glib -I../..//home/manoj/GLib/glib-2.2.1/./gmodule -I../..//home/manoj/GLib/glib-2.2.1 -I../..//home/manoj/GLib/glib-2.2.1/. -I../..//home/manoj/GLib/glib-2.2.1/./glib -DGC_LINUX_THREADS -DMONO_USE_EXC_TABLES -D_GNU_SOURCE -D_REENTRANT -fexceptions -D_FILE_OFFSET_BITS=64 -g -O2 -fno-strict-aliasing -g -Wall -Wunused -Wmissing-prototypes -Wmissing-declarations -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Wpointer-arith -Wno-cast-qual -Wcast-align -Wwrite-strings -c mono-hash.c -MT mono-hash.lo -MD -MP -MF .deps/mono-hash.TPlo  -fPIC -DPIC -o .libs/mono-hash.lo
mono-hash.c:39:18: glib.h: No such file or directory
In file included from mono-hash.c:41:
mono-hash.h:36:18: glib.h: No such file or directory
In file included from mono-hash.c:41:
mono-hash.h:40: syntax error before "typedef"
mono-hash.h:42: parse error before '*' token
mono-hash.h:42: parse error before "key"
mono-hash.h:43: warning: type defaults to `int' in declaration of `gpointer'
mono-hash.h:43: warning: function declaration isn't a prototype
mono-hash.h:43: `gpointer' declared as function returning a function
mono-hash.h:43: warning: function declaration isn't a prototype
mono-hash.h:47: parse error before "hash_func"
mono-hash.h:48: warning: function declaration isn't a prototype
mono-hash.h:49: parse error before "hash_func"
mono-hash.h:52: warning: function declaration isn't a prototype
mono-hash.h:60: parse error before "mono_g_hash_table_remove"
mono-hash.h:61: parse error before "gconstpointer"
mono-hash.h:61: warning: type defaults to `int' in declaration of `mono_g_hash_table_remove'
mono-hash.h:61: warning: function declaration isn't a prototype
mono-hash.h:61: warning: data definition has no type or storage class
mono-hash.h:62: parse error before "mono_g_hash_table_steal"
mono-hash.h:63: parse error before "gconstpointer"
mono-hash.h:63: warning: type defaults to `int' in declaration of `mono_g_hash_table_steal'
mono-hash.h:63: warning: function declaration isn't a prototype
mono-hash.h:63: warning: data definition has no type or storage class
mono-hash.h:65: parse error before "gconstpointer"
mono-hash.h:65: `mono_g_hash_table_lookup' declared as function returning a function
mono-hash.h:65: warning: function declaration isn't a prototype
mono-hash.h:66: parse error before "mono_g_hash_table_lookup_extended"
mono-hash.h:67: parse error before "gconstpointer"
mono-hash.h:69: warning: type defaults to `int' in declaration of `mono_g_hash_table_lookup_extended'
mono-hash.h:69: warning: function declaration isn't a prototype
mono-hash.h:69: warning: data definition has no type or storage class
mono-hash.h:71: parse error before "GHFunc"
mono-hash.h:72: warning: function declaration isn't a prototype
mono-hash.h:73: parse error before "mono_g_hash_table_foreach_remove"
mono-hash.h:74: parse error before "GHRFunc"
mono-hash.h:75: warning: type defaults to `int' in declaration of `mono_g_hash_table_foreach_remove'
mono-hash.h:75: warning: function declaration isn't a prototype
mono-hash.h:75: warning: data definition has no type or storage class
mono-hash.h:76: parse error before "mono_g_hash_table_foreach_steal"
mono-hash.h:77: parse error before "GHRFunc"
mono-hash.h:78: warning: type defaults to `int' in declaration of `mono_g_hash_table_foreach_steal'
mono-hash.h:78: warning: function declaration isn't a prototype
mono-hash.h:78: warning: data definition has no type or storage class
mono-hash.h:79: parse error before "mono_g_hash_table_size"
mono-hash.h:79: warning: type defaults to `int' in declaration of `mono_g_hash_table_size'
mono-hash.h:79: warning: data definition has no type or storage class
mono-hash.h:82: parse error before "MonoGRemapperFunc"
mono-hash.h:83: warning: function declaration isn't a prototype
mono-hash.c:47: syntax error before "typedef"
mono-hash.c:51: field `key' declared as a function
mono-hash.c:52: field `value' declared as a function
mono-hash.c:58: parse error before "gint"
mono-hash.c:58: warning: no semicolon at end of struct or union
mono-hash.c:59: warning: type defaults to `int' in declaration of `nnodes'
mono-hash.c:59: warning: data definition has no type or storage class
mono-hash.c:61: parse error before "hash_func"
mono-hash.c:61: warning: type defaults to `int' in declaration of `hash_func'
mono-hash.c:61: warning: data definition has no type or storage class
mono-hash.c:62: parse error before "key_equal_func"
mono-hash.c:62: warning: type defaults to `int' in declaration of `key_equal_func'
mono-hash.c:62: warning: data definition has no type or storage class
mono-hash.c:63: parse error before "key_destroy_func"
mono-hash.c:63: warning: type defaults to `int' in declaration of `key_destroy_func'
mono-hash.c:63: warning: data definition has no type or storage class
mono-hash.c:64: parse error before "value_destroy_func"
mono-hash.c:64: warning: type defaults to `int' in declaration of `value_destroy_func'
mono-hash.c:64: warning: data definition has no type or storage class
mono-hash.c:78: parse error before "gconstpointer"
mono-hash.c:78: warning: function declaration isn't a prototype
mono-hash.c:82: parse error before "GDestroyNotify"
mono-hash.c:83: warning: function declaration isn't a prototype
mono-hash.c:85: parse error before "GDestroyNotify"
mono-hash.c:86: warning: function declaration isn't a prototype
mono-hash.c:87: parse error before "g_hash_table_foreach_remove_or_steal"
mono-hash.c:88: parse error before "GHRFunc"
mono-hash.c:90: warning: type defaults to `int' in declaration of `g_hash_table_foreach_remove_or_steal'
mono-hash.c:90: warning: function declaration isn't a prototype
mono-hash.c:90: warning: data definition has no type or storage class
mono-hash.c:93: warning: type defaults to `int' in declaration of `G_LOCK_DEFINE_STATIC'
mono-hash.c:93: warning: parameter names (without types) in function declaration
mono-hash.c:93: warning: data definition has no type or storage class
mono-hash.c:119: parse error before "hash_func"
mono-hash.c:121: warning: function declaration isn't a prototype
mono-hash.c:144: parse error before "hash_func"
mono-hash.c:148: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_new_full':
mono-hash.c:152: sizeof applied to an incomplete type
mono-hash.c:156: dereferencing pointer to incomplete type
mono-hash.c:157: dereferencing pointer to incomplete type
mono-hash.c:158: dereferencing pointer to incomplete type
mono-hash.c:158: `g_direct_hash' undeclared (first use in this function)
mono-hash.c:158: (Each undeclared identifier is reported only once
mono-hash.c:158: for each function it appears in.)
mono-hash.c:159: dereferencing pointer to incomplete type
mono-hash.c:159: `g_direct_equal' undeclared (first use in this function)
mono-hash.c:160: dereferencing pointer to incomplete type
mono-hash.c:161: dereferencing pointer to incomplete type
mono-hash.c:163: dereferencing pointer to incomplete type
mono-hash.c:163: dereferencing pointer to incomplete type
mono-hash.c: In function `mono_g_hash_table_destroy':
mono-hash.c:184: `guint' undeclared (first use in this function)
mono-hash.c:184: parse error before "i"
mono-hash.c:186: warning: implicit declaration of function `g_return_if_fail'
mono-hash.c:188: `i' undeclared (first use in this function)
mono-hash.c:188: dereferencing pointer to incomplete type
mono-hash.c:189: dereferencing pointer to incomplete type
mono-hash.c:190: dereferencing pointer to incomplete type
mono-hash.c:191: dereferencing pointer to incomplete type
mono-hash.c: At top level:
mono-hash.c:202: parse error before "gconstpointer"
mono-hash.c:203: warning: function declaration isn't a prototype
mono-hash.c: In function `g_hash_table_lookup_node':
mono-hash.c:206: `hash_table' undeclared (first use in this function)
mono-hash.c:207: `key' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:235: parse error before "gconstpointer"
mono-hash.c:236: `mono_g_hash_table_lookup' declared as function returning a function
mono-hash.c:236: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_lookup':
mono-hash.c:239: warning: implicit declaration of function `g_return_val_if_fail'
mono-hash.c:239: `hash_table' undeclared (first use in this function)
mono-hash.c:241: `key' undeclared (first use in this function)
mono-hash.c:243: warning: return makes integer from pointer without a cast
mono-hash.c: At top level:
mono-hash.c:261: parse error before "mono_g_hash_table_lookup_extended"
mono-hash.c:262: parse error before "gconstpointer"
mono-hash.c:265: warning: return type defaults to `int'
mono-hash.c:265: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_lookup_extended':
mono-hash.c:268: `hash_table' undeclared (first use in this function)
mono-hash.c:268: `FALSE' undeclared (first use in this function)
mono-hash.c:270: `lookup_key' undeclared (first use in this function)
mono-hash.c:274: `orig_key' undeclared (first use in this function)
mono-hash.c:276: `value' undeclared (first use in this function)
mono-hash.c:278: `TRUE' undeclared (first use in this function)
mono-hash.c: In function `g_hash_node_new':
mono-hash.c:292: warning: implicit declaration of function `G_LOCK'
mono-hash.c:292: `g_hash_global' undeclared (first use in this function)
mono-hash.c:298: warning: implicit declaration of function `G_UNLOCK'
mono-hash.c: In function `mono_g_hash_table_insert':
mono-hash.c:361: dereferencing pointer to incomplete type
mono-hash.c:362: dereferencing pointer to incomplete type
mono-hash.c:364: dereferencing pointer to incomplete type
mono-hash.c:365: dereferencing pointer to incomplete type
mono-hash.c:372: dereferencing pointer to incomplete type
mono-hash.c:373: `G_STMT_START' undeclared (first use in this function)
mono-hash.c:373: parse error before '{' token
mono-hash.c:373: `G_STMT_END' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:375: parse error before '}' token
mono-hash.c: In function `mono_g_hash_table_replace':
mono-hash.c:403: dereferencing pointer to incomplete type
mono-hash.c:404: dereferencing pointer to incomplete type
mono-hash.c:406: dereferencing pointer to incomplete type
mono-hash.c:407: dereferencing pointer to incomplete type
mono-hash.c:415: dereferencing pointer to incomplete type
mono-hash.c:416: `G_STMT_START' undeclared (first use in this function)
mono-hash.c:416: parse error before '{' token
mono-hash.c:416: `G_STMT_END' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:418: parse error before '}' token
mono-hash.c:436: parse error before "gconstpointer"
mono-hash.c:437: warning: return type defaults to `int'
mono-hash.c:437: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_remove':
mono-hash.c:440: `hash_table' undeclared (first use in this function)
mono-hash.c:440: `FALSE' undeclared (first use in this function)
mono-hash.c:442: `key' undeclared (first use in this function)
mono-hash.c:452: `G_STMT_START' undeclared (first use in this function)
mono-hash.c:452: parse error before '{' token
mono-hash.c:452: `G_STMT_END' undeclared (first use in this function)
mono-hash.c:454: `TRUE' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:457: parse error before "return"
mono-hash.c:472: parse error before "gconstpointer"
mono-hash.c:473: warning: return type defaults to `int'
mono-hash.c:473: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_steal':
mono-hash.c:476: `hash_table' undeclared (first use in this function)
mono-hash.c:476: `FALSE' undeclared (first use in this function)
mono-hash.c:478: `key' undeclared (first use in this function)
mono-hash.c:486: `G_STMT_START' undeclared (first use in this function)
mono-hash.c:486: parse error before '{' token
mono-hash.c:486: `G_STMT_END' undeclared (first use in this function)
mono-hash.c:488: `TRUE' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:491: parse error before "return"
mono-hash.c:510: parse error before "GHRFunc"
mono-hash.c:512: warning: return type defaults to `int'
mono-hash.c:512: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_foreach_remove':
mono-hash.c:513: `hash_table' undeclared (first use in this function)
mono-hash.c:514: `func' undeclared (first use in this function)
mono-hash.c:516: `user_data' undeclared (first use in this function)
mono-hash.c:516: `TRUE' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:532: parse error before "mono_g_hash_table_foreach_steal"
mono-hash.c:533: parse error before "GHRFunc"
mono-hash.c:535: warning: return type defaults to `int'
mono-hash.c:535: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_foreach_steal':
mono-hash.c:536: `hash_table' undeclared (first use in this function)
mono-hash.c:537: `func' undeclared (first use in this function)
mono-hash.c:539: `user_data' undeclared (first use in this function)
mono-hash.c:539: `FALSE' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:543: parse error before "g_hash_table_foreach_remove_or_steal"
mono-hash.c:544: parse error before "GHRFunc"
mono-hash.c:547: warning: return type defaults to `int'
mono-hash.c:547: warning: function declaration isn't a prototype
mono-hash.c: In function `g_hash_table_foreach_remove_or_steal':
mono-hash.c:549: `guint' undeclared (first use in this function)
mono-hash.c:549: parse error before "i"
mono-hash.c:552: `i' undeclared (first use in this function)
mono-hash.c:552: `hash_table' undeclared (first use in this function)
mono-hash.c:560: `func' undeclared (first use in this function)
mono-hash.c:560: `user_data' undeclared (first use in this function)
mono-hash.c:562: `deleted' undeclared (first use in this function)
mono-hash.c:570: `notify' undeclared (first use in this function)
mono-hash.c:586: `G_STMT_START' undeclared (first use in this function)
mono-hash.c:586: parse error before '{' token
mono-hash.c: At top level:
mono-hash.c:586: warning: type defaults to `int' in declaration of `G_STMT_END'
mono-hash.c:586: `G_STMT_END' used prior to declaration
mono-hash.c:586: warning: data definition has no type or storage class
mono-hash.c:588: parse error before "return"
mono-hash.c:606: parse error before "GHFunc"
mono-hash.c:608: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_foreach':
mono-hash.c:610: `gint' undeclared (first use in this function)
mono-hash.c:610: parse error before "i"
mono-hash.c:612: `hash_table' undeclared (first use in this function)
mono-hash.c:613: `func' undeclared (first use in this function)
mono-hash.c:615: `i' undeclared (first use in this function)
mono-hash.c:617: `user_data' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:629: parse error before "mono_g_hash_table_size"
mono-hash.c:630: warning: return type defaults to `int'
mono-hash.c: In function `mono_g_hash_table_size':
mono-hash.c:633: dereferencing pointer to incomplete type
mono-hash.c: At top level:
mono-hash.c:646: parse error before "MonoGRemapperFunc"
mono-hash.c:648: warning: function declaration isn't a prototype
mono-hash.c: In function `mono_g_hash_table_remap':
mono-hash.c:650: `gint' undeclared (first use in this function)
mono-hash.c:650: parse error before "i"
mono-hash.c:652: `hash_table' undeclared (first use in this function)
mono-hash.c:653: `func' undeclared (first use in this function)
mono-hash.c:655: `i' undeclared (first use in this function)
mono-hash.c:657: `user_data' undeclared (first use in this function)
mono-hash.c: In function `g_hash_table_resize':
mono-hash.c:666: `guint' undeclared (first use in this function)
mono-hash.c:666: parse error before "hash_val"
mono-hash.c:667: `gint' undeclared (first use in this function)
mono-hash.c:670: `new_size' undeclared (first use in this function)
mono-hash.c:670: warning: implicit declaration of function `g_spaced_primes_closest'
mono-hash.c:670: dereferencing pointer to incomplete type
mono-hash.c:671: warning: implicit declaration of function `CLAMP'
mono-hash.c:679: `i' undeclared (first use in this function)
mono-hash.c:679: dereferencing pointer to incomplete type
mono-hash.c:680: dereferencing pointer to incomplete type
mono-hash.c:684: `hash_val' undeclared (first use in this function)
mono-hash.c:684: dereferencing pointer to incomplete type
mono-hash.c:694: dereferencing pointer to incomplete type
mono-hash.c:695: dereferencing pointer to incomplete type
mono-hash.c: At top level:
mono-hash.c:700: parse error before "GDestroyNotify"
mono-hash.c:702: warning: function declaration isn't a prototype
mono-hash.c: In function `g_hash_node_destroy':
mono-hash.c:704: `hash_node' undeclared (first use in this function)
mono-hash.c:704: called object is not a function
mono-hash.c:706: called object is not a function
mono-hash.c:711: `g_hash_global' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:719: parse error before "GFreeFunc"
mono-hash.c:721: warning: function declaration isn't a prototype
mono-hash.c: In function `g_hash_nodes_destroy':
mono-hash.c:722: `hash_node' undeclared (first use in this function)
mono-hash.c:729: called object is not a function
mono-hash.c:731: called object is not a function
mono-hash.c:740: called object is not a function
mono-hash.c:742: called object is not a function
mono-hash.c:747: `g_hash_global' undeclared (first use in this function)
mono-hash.c: At top level:
mono-hash.c:662: warning: `g_hash_table_resize' defined but not used
make[3]: *** [mono-hash.lo] Error 1
make[3]: Leaving directory `/home/manoj/Mono/mono-0.30.1/mono/utils'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/manoj/Mono/mono-0.30.1/mono'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/manoj/Mono/mono-0.30.1'
make: *** [all] Error 2

mono-0.30.1
glib-2.2.1
