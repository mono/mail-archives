Index: libgc/include/gc_pthread_redirects.h
===================================================================
--- libgc/include/gc_pthread_redirects.h	(revision 71903)
+++ libgc/include/gc_pthread_redirects.h	(working copy)
@@ -74,7 +74,10 @@
 # define pthread_join GC_pthread_join
 # define pthread_detach GC_pthread_detach
 
-#ifndef GC_DARWIN_THREADS
+#ifndef GC_DARWIN_THREADS 
+# ifdef GC_NETBSD_THREADS
+#  undef pthread_sigmask
+# endif
 # define pthread_sigmask GC_pthread_sigmask
 # define dlopen GC_dlopen
 #endif
Index: libgc/include/gc_config_macros.h
===================================================================
--- libgc/include/gc_config_macros.h	(revision 71903)
+++ libgc/include/gc_config_macros.h	(working copy)
@@ -56,7 +56,7 @@
 	defined(GC_IRIX_THREADS) || defined(GC_LINUX_THREADS) || \
 	defined(GC_HPUX_THREADS) || defined(GC_OSF1_THREADS) || \
 	defined(GC_DGUX386_THREADS) || defined(GC_DARWIN_THREADS) || \
-	defined(GC_AIX_THREADS) || \
+	defined(GC_AIX_THREADS) || defined(GC_NETBSD_THREADS) || \
         (defined(GC_WIN32_THREADS) && defined(__CYGWIN32__))
 #   define GC_PTHREADS
 # endif
Index: libgc/include/private/gc_priv.h
===================================================================
--- libgc/include/private/gc_priv.h	(revision 71903)
+++ libgc/include/private/gc_priv.h	(working copy)
@@ -1956,7 +1956,7 @@
   /* in Linux glibc, but it's not exported.)  Thus we continue to use	*/
   /* the same hard-coded signals we've always used.			*/
 #  if !defined(SIG_SUSPEND)
-#   if defined(GC_LINUX_THREADS) || defined(GC_DGUX386_THREADS)
+#   if defined(GC_LINUX_THREADS) || defined(GC_DGUX386_THREADS) || defined(GC_NETBSD_THREADS)
 #    if defined(SPARC) && !defined(SIGPWR)
        /* SPARC/Linux doesn't properly define SIGPWR in <signal.h>.
         * It is aliased to SIGLOST in asm/signal.h, though.		*/
Index: libgc/configure.in
===================================================================
--- libgc/configure.in	(revision 71903)
+++ libgc/configure.in	(working copy)
@@ -151,6 +151,13 @@
 	  AC_DEFINE(PARALLEL_MARK)
 	fi
 	;;
+     *-*-netbsd*)
+	AC_DEFINE(GC_NETBSD_THREADS)
+	if test "${enable_parallel_mark}" = yes; then
+	  AC_DEFINE(PARALLEL_MARK)
+	fi
+	AC_DEFINE(THREAD_LOCAL_ALLOC)
+	;;
      *-*-osf*)
 	AC_DEFINE(GC_OSF1_THREADS)
         if test "${enable_parallel_mark}" = yes; then
Index: libgc/pthread_support.c
===================================================================
--- libgc/pthread_support.c	(revision 71903)
+++ libgc/pthread_support.c	(working copy)
@@ -67,8 +67,8 @@
 # endif
 
 # if (defined(GC_DGUX386_THREADS) || defined(GC_OSF1_THREADS) || \
-      defined(GC_DARWIN_THREADS) || defined(GC_AIX_THREADS)) \
-      && !defined(USE_PTHREAD_SPECIFIC)
+      defined(GC_DARWIN_THREADS) || defined(GC_AIX_THREADS)) || \
+      defined(GC_NETBSD_THREADS) && !defined(USE_PTHREAD_SPECIFIC)
 #   define USE_PTHREAD_SPECIFIC
 # endif
 
@@ -126,8 +126,13 @@
 # include <sys/sysctl.h>
 #endif /* GC_DARWIN_THREADS */
 
+#if defined(GC_NETBSD_THREADS)
+# include <sys/param.h>
+# include <sys/sysctl.h>
+#endif
 
 
+
 #if defined(GC_DGUX386_THREADS)
 # include <sys/dg_sys_info.h>
 # include <sys/_int_psem.h>
@@ -1013,7 +1018,7 @@
 	  GC_nprocs = sysconf(_SC_NPROC_ONLN);
 	  if (GC_nprocs <= 0) GC_nprocs = 1;
 #       endif
-#       if defined(GC_DARWIN_THREADS) || defined(GC_FREEBSD_THREADS)
+#       if defined(GC_DARWIN_THREADS) || defined(GC_FREEBSD_THREADS) || defined(GC_NETBSD_THREADS)
 	  int ncpus = 1;
 	  size_t len = sizeof(ncpus);
 	  sysctl((int[2]) {CTL_HW, HW_NCPU}, 2, &ncpus, &len, NULL, 0);
Index: libgc/specific.c
===================================================================
--- libgc/specific.c	(revision 71903)
+++ libgc/specific.c	(working copy)
@@ -13,7 +13,7 @@
 
 #include "private/gc_priv.h" /* For GC_compare_and_exchange, GC_memory_barrier */
 
-#if defined(GC_LINUX_THREADS)
+#if defined(GC_LINUX_THREADS) || defined(GC_NETBSD_THREADS)
 
 #include "private/specific.h"
 
Index: mono/io-layer/collection.c
===================================================================
--- mono/io-layer/collection.c	(revision 71807)
+++ mono/io-layer/collection.c	(working copy)
@@ -60,7 +60,7 @@
 	g_assert (ret == 0);
 	
 #ifdef HAVE_PTHREAD_ATTR_SETSTACKSIZE
-#ifdef __FreeBSD__
+#if defined(__FreeBSD__) || defined(__NetBSD__)
 	ret = pthread_attr_setstacksize (&attr, 65536);
 #else
 	ret = pthread_attr_setstacksize (&attr, PTHREAD_STACK_MIN);
Index: mono/mini/mini-x86.h
===================================================================
--- mono/mini/mini-x86.h	(revision 71807)
+++ mono/mini/mini-x86.h	(working copy)
@@ -43,7 +43,7 @@
 
 #endif /* PLATFORM_WIN32 */
 
-#if defined( __linux__) || defined(__sun) || defined(__APPLE__)
+#if defined( __linux__) || defined(__sun) || defined(__APPLE__) || defined(__NetBSD__)
 #define MONO_ARCH_USE_SIGACTION
 #endif
 
@@ -153,6 +153,16 @@
 	#define UCONTEXT_REG_ESI(ctx) ((ctx)->uc_mcontext->ss.esi)
 	#define UCONTEXT_REG_EDI(ctx) ((ctx)->uc_mcontext->ss.edi)
 	#define UCONTEXT_REG_EIP(ctx) ((ctx)->uc_mcontext->ss.eip)
+#elif defined(__NetBSD__)
+	#define UCONTEXT_REG_EAX(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EAX])
+	#define UCONTEXT_REG_EBX(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EBX])
+	#define UCONTEXT_REG_ECX(ctx) ((ctx)->uc_mcontext.__gregs [_REG_ECX])
+	#define UCONTEXT_REG_EDX(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EDX])
+	#define UCONTEXT_REG_EBP(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EBP])
+	#define UCONTEXT_REG_ESP(ctx) ((ctx)->uc_mcontext.__gregs [_REG_ESP])
+	#define UCONTEXT_REG_ESI(ctx) ((ctx)->uc_mcontext.__gregs [_REG_ESI])
+	#define UCONTEXT_REG_EDI(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EDI])
+	#define UCONTEXT_REG_EIP(ctx) ((ctx)->uc_mcontext.__gregs [_REG_EIP])
 #else
 	#define UCONTEXT_REG_EAX(ctx) ((ctx)->uc_mcontext.gregs [REG_EAX])
 	#define UCONTEXT_REG_EBX(ctx) ((ctx)->uc_mcontext.gregs [REG_EBX])
Index: configure.in
===================================================================
--- configure.in	(revision 71807)
+++ configure.in	(working copy)
@@ -82,14 +82,15 @@
 		;;
 	*-*-*netbsd*)
 		platform_win32=no
-		CPPFLAGS="$CPPFLAGS -D_REENTRANT"
+		CPPFLAGS="$CPPFLAGS -D_REENTRANT -DGC_NETBSD_THREADS -D_GNU_SOURCE"
 		libmono_cflags="-D_REENTRANT"
 		LDFLAGS="$LDFLAGS -pthread"
 		CPPFLAGS="$CPPFLAGS -DPLATFORM_BSD"
 		libmono_ldflags="-pthread"
 		need_link_unlink=yes
-		libdl=
-		libgc_threads=no
+		libdl="-ldl"
+		libgc_threads=pthreads
+		with_sigaltstack=no
 		;;
 # these flags will work for all versions of -STABLE
 #
