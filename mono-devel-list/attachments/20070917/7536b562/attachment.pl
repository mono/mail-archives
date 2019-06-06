Index: mono/metadata/boehm-gc.c
===================================================================
--- mono/metadata/boehm-gc.c	(revision 85859)
+++ mono/metadata/boehm-gc.c	(working copy)
@@ -258,7 +258,7 @@
 {
 }
 
-#if defined(USE_INCLUDED_LIBGC) && defined(__linux__) && (defined(__i386__) || defined(__x86_64__))
+#if defined(USE_COMPILER_TLS) && defined(USE_INCLUDED_LIBGC) && defined(__linux__) && (defined(__i386__) || defined(__x86_64__))
 extern __thread MONO_TLS_FAST void* GC_thread_tls;
 #include "metadata-internals.h"
 