Index: libgc/include/gc_pthread_redirects.h
===================================================================
--- libgc/include/gc_pthread_redirects.h	(revision 71775)
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
--- libgc/include/gc_config_macros.h	(revision 71775)
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
--- libgc/include/private/gc_priv.h	(revision 71775)
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
--- libgc/configure.in	(revision 71775)
+++ libgc/configure.in	(working copy)
@@ -151,6 +151,14 @@
 	  AC_DEFINE(PARALLEL_MARK)
 	fi
 	;;
+     *-*-netbsd*)
+	AC_DEFINE(GC_NETBSD_THREADS)
+	AC_DEFINE(THREAD_LOCAL_ALLOC)
+	if test "${enable_parallel_mark}" = yes; then
+	  AC_DEFINE(PARALLEL_MARK)
+	fi
+	AC_DEFINE(THREAD_LOCAL_ALLOC)
+	;;
      *-*-osf*)
 	AC_DEFINE(GC_OSF1_THREADS)
         if test "${enable_parallel_mark}" = yes; then
Index: libgc/pthread_stop_world.c
===================================================================
--- libgc/pthread_stop_world.c	(revision 71775)
+++ libgc/pthread_stop_world.c	(working copy)
@@ -111,6 +111,7 @@
 #  endif
 #endif
 
+#if !defined(GC_NETBSD_THREADS)
 sem_t GC_suspend_ack_sem;
 
 static void _GC_suspend_handler(int sig)
@@ -220,6 +221,7 @@
     GC_printf1("In GC_restart_handler for 0x%lx\n", pthread_self());
 #endif
 }
+#endif /* !GC_NETBSD_THREADS */
 
 # ifdef IA64
 #   define IF_IA64(x) x
@@ -295,12 +297,14 @@
       ABORT("Collecting from unknown thread.");
 }
 
+#if !defined(GC_NETBSD_THREADS)
 void GC_restart_handler(int sig)
 {
 	int old_errno = errno;
 	_GC_restart_handler (sig);
 	errno = old_errno;
 }
+#endif
 
 /* We hold allocation lock.  Should do exactly the right thing if the	*/
 /* world is stopped.  Should not fail if it isn't.			*/
@@ -309,6 +313,28 @@
     pthread_push_all_stacks();
 }
 
+#if defined(GC_NETBSD_THREADS)
+/* 
+ * Get the stack start address for the specified address.
+ */ 
+int 
+np_stackinfo(pthread_t p, void **addr) 
+{ 
+	pthread_attr_t attr; 
+	int ret = -1; 
+
+	if (pthread_attr_init(&attr)) 
+		return -1;
+
+	if (!pthread_attr_get_np(p, &attr))
+		if (!pthread_attr_getstackaddr(&attr, addr)) 
+			ret = 0;
+
+	pthread_attr_destroy(&attr); 
+	return ret; 
+}
+#endif
+
 /* There seems to be a very rare thread stopping problem.  To help us  */
 /* debug that, we save the ids of the stopping thread. */
 pthread_t GC_stopping_thread;
@@ -334,6 +360,7 @@
             if (p -> stop_info.last_stop_count == GC_stop_count) continue;
 	    if (p -> thread_blocked) /* Will wait */ continue;
             n_live_threads++;
+#if !defined(GC_NETBSD_THREADS)
 	    #if DEBUG_THREADS
 	      GC_printf1("Sending suspend signal to 0x%lx\n", p -> id);
 	    #endif
@@ -349,6 +376,23 @@
                 default:
                     ABORT("pthread_kill failed");
             }
+#else
+	    #if DEBUG_THREADS
+	      GC_printf1("Suspending 0x%lx ...\n", p -> id);
+	    #endif
+
+		if(pthread_suspend_np(p -> id) != 0)
+			GC_printf1("Could not susend thread... 0x%lx\n", p -> id);
+
+		/* Right now, this is not enough. Retreiving the stack base address is not the correct */
+		/* info to give to the GC, but since there is no way to get the current stack pointer  */
+		/* for the suspended thread, base pointer will have to be enough. Mono seems to be     */
+		/* happy with it so... */
+		if(np_stackinfo(p -> id, &(p -> stop_info.stack_ptr)) != 0)
+			GC_err_printf1("Could not get thread stack address... 0x%lx\n", p -> id);			
+
+        n_live_threads--;
+#endif /* !GC_NETBSD_THREADS */
         }
       }
     }
@@ -368,6 +412,7 @@
 
     n_live_threads = GC_suspend_all();
 
+#if !defined(GC_NETBSD_THREADS)
       if (GC_retry_signals) {
 	  unsigned long wait_usecs = 0;  /* Total wait since retry.	*/
 #	  define WAIT_UNIT 3000
@@ -405,6 +450,8 @@
 	      }
 	  }
     }
+#endif /* !GC_NETBSD_THREADS */
+
     #if DEBUG_THREADS
       GC_printf1("World stopped from 0x%lx\n", pthread_self());
     #endif
@@ -456,6 +503,7 @@
             if (p -> flags & FINISHED) continue;
 	    if (p -> thread_blocked) continue;
             n_live_threads++;
+#if !defined(GC_NETBSD_THREADS)
 	    #if DEBUG_THREADS
 	      GC_printf1("Sending restart signal to 0x%lx\n", p -> id);
 	    #endif
@@ -471,10 +519,18 @@
                 default:
                     ABORT("pthread_kill failed");
             }
+#else
+	    #if DEBUG_THREADS
+	      GC_printf1("Resuming Thread 0x%lx\n", p -> id);
+	    #endif
+		pthread_resume_np(p -> id);
+		n_live_threads--;
+#endif /* !GC_NETBSD_THREADS */
         }
       }
     }
 
+#if !defined(GC_NETBSD_THREADS)
     #if DEBUG_THREADS
     GC_printf0 ("All threads signaled");
     #endif
@@ -487,6 +543,7 @@
 	    }
 	}
     }
+#endif /* !GC_NETBSD_THREADS */
   
     #if DEBUG_THREADS
       GC_printf0("World started\n");
@@ -504,6 +561,8 @@
 }
 
 static void pthread_stop_init() {
+
+#if !defined(GC_NETBSD_THREADS)
     struct sigaction act;
     
     if (sem_init(&GC_suspend_ack_sem, 0, 0) != 0)
@@ -544,6 +603,16 @@
               GC_printf0("Will retry suspend signal if necessary.\n");
 	  }
 #     endif
+#else
+    struct sigaction act;
+
+    act.sa_flags = SA_RESTART;
+    if (sigfillset(&act.sa_mask) != 0) {
+    	ABORT("sigfillset() failed");
+    }
+    GC_remove_allowed_signals(&act.sa_mask);
+
+#endif /* !GC_NETBSD_THREADS */
 }
 
 /* We hold the allocation lock.	*/
Index: libgc/pthread_support.c
===================================================================
--- libgc/pthread_support.c	(revision 71775)
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
--- libgc/specific.c	(revision 71775)
+++ libgc/specific.c	(working copy)
@@ -13,7 +13,7 @@
 
 #include "private/gc_priv.h" /* For GC_compare_and_exchange, GC_memory_barrier */
 
-#if defined(GC_LINUX_THREADS)
+#if defined(GC_LINUX_THREADS) || defined(GC_NETBSD_THREADS)
 
 #include "private/specific.h"
 
Index: libgc/dyn_load.c
===================================================================
--- libgc/dyn_load.c	(revision 71775)
+++ libgc/dyn_load.c	(working copy)
@@ -75,6 +75,11 @@
 #   include <dlfcn.h>
 #   include <link.h>
 #endif
+
+#ifdef NETBSD 
+#include <dlfcn.h>
+#endif
+
 #ifdef SUNOS4
 #   include <dlfcn.h>
 #   include <link.h>
@@ -519,6 +524,31 @@
                 break;
             }
         }
+
+#if defined(NETBSD)
+#undef dlopen
+#undef dlsym
+#undef dlclose
+		/* This is a hack. For now, it seems that NetBSD 2.0 does not provide
+		   a _DYNAMIC with the neccessary DT_DEBUG information. A simple dlopen(0, RTLD_LAZY)
+		   does the job. Maybe a NetBSD guru could explain this...
+	     */		
+		if(cachedResult == 0) {
+			void* startupSyms = dlopen(0, RTLD_LAZY);
+			dp = (ElfW(Dyn)*)dlsym(startupSyms, "_DYNAMIC");
+
+			for(; (tag = dp->d_tag) != 0; dp++ ) {
+				if( tag == DT_DEBUG ) {
+					struct link_map *lm
+							= ((struct r_debug *)(dp->d_un.d_ptr))->r_map;
+					if( lm != 0 ) cachedResult = lm->l_next; /* might be NIL */
+					break;
+				}
+			}
+
+			dlclose(startupSyms);
+		}
+#endif
     }
     return cachedResult;
 }
Index: mono/io-layer/collection.c
===================================================================
--- mono/io-layer/collection.c	(revision 71775)
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
--- mono/mini/mini-x86.h	(revision 71775)
+++ mono/mini/mini-x86.h	(working copy)
@@ -53,6 +53,10 @@
 #define MONO_ARCH_SIGSEGV_ON_ALTSTACK
 #define MONO_ARCH_USE_SIGACTION
 
+#else
+#ifdef __NetBSD__
+#define MONO_ARCH_USE_SIGACTION
+#endif
 #endif /* HAVE_WORKING_SIGALTSTACK */
 #endif /* !PLATFORM_WIN32 */
 
@@ -153,6 +157,16 @@
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
Index: mono/tests/tests-config
===================================================================
--- mono/tests/tests-config	(revision 71775)
+++ mono/tests/tests-config	(working copy)
@@ -1,5 +1,5 @@
 <configuration>
-	<dllmap dll="cygwin1.dll" target="libc.so.6" />
-	<dllmap dll="libc" target="libc.so.6" />
+	<dllmap dll="cygwin1.dll" target="libc.so.12" />
+	<dllmap dll="libc" target="libc.so.12" />
 </configuration>
 
Index: configure.in
===================================================================
--- configure.in	(revision 71775)
+++ configure.in	(working copy)
@@ -82,14 +82,16 @@
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
+		libdl="-ldl /libexec/ld.elf_so"
+		libgc_threads=pthreads
+		with_tls=__thread
+		with_sigaltstack=no
 		;;
 # these flags will work for all versions of -STABLE
 #
