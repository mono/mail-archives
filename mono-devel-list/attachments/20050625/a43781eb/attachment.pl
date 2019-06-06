Index: libgc/pthread_support.c
===================================================================
--- libgc/pthread_support.c	(revision 46453)
+++ libgc/pthread_support.c	(working copy)
@@ -168,11 +168,23 @@
 
 /* We don't really support thread-local allocation with DBG_HDRS_ALL */
 
+#if USE_COMPILER_TLS_ATTR
+#if defined(PIC) && defined(__x86_64__)
+#define COMPILER_TLS_ATTR 
+#elif defined (__powerpc__)
+#define COMPILER_TLS_ATTR 
+#else
+#define COMPILER_TLS_ATTR  __attribute__((tls_model("local-exec")))
+#endif
+#else
+#define COMPILER_TLS_ATTR
+#endif
+
 static
 #ifdef USE_COMPILER_TLS
   __thread
 #endif
-GC_key_t GC_thread_key;
+GC_key_t GC_thread_key COMPILER_TLS_ATTR;
 
 static GC_bool keys_initialized;
 
Index: configure.in
===================================================================
--- configure.in	(revision 46453)
+++ configure.in	(working copy)
@@ -1598,7 +1598,10 @@
 	AC_TRY_COMPILE([static __thread int foo __attribute__((tls_model("initial-exec")));], [
 		], [
 			AC_MSG_RESULT(yes)
-			AC_DEFINE(HAVE_TLS_MODEL_ATTR, 1, [tld_model available])
+			AC_DEFINE(HAVE_TLS_MODEL_ATTR, 1, [tls_model available])
+			# Pass the information to libgc as well
+			CPPFLAGS="$CPPFLAGS -DUSE_COMPILER_TLS_ATTR"
+			export CPPFLAGS
 		], [
 			AC_MSG_RESULT(no)
 	])
