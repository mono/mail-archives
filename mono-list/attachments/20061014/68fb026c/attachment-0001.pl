Index: mono/io-layer/wapi.h
===================================================================
--- mono/io-layer/wapi.h	(revision 66673)
+++ mono/io-layer/wapi.h	(working copy)
@@ -10,6 +10,7 @@
 #ifndef _WAPI_WAPI_H_
 #define _WAPI_WAPI_H_
 
+#include <mono/io-layer/symbols.h>
 #include <mono/io-layer/types.h>
 #include <mono/io-layer/macros.h>
 #include <mono/io-layer/handles.h>
Index: mono/io-layer/Makefile.am
===================================================================
--- mono/io-layer/Makefile.am	(revision 66673)
+++ mono/io-layer/Makefile.am	(working copy)
@@ -29,6 +29,7 @@
 	semaphores.h	\
 	sockets.h	\
 	status.h	\
+	symbols.h	\
 	system.h	\
 	threads.h	\
 	timefuncs.h	\
@@ -86,6 +87,7 @@
 	socket-private.h	\
 	socket-wrappers.h	\
 	status.h		\
+	symbols.h		\
 	system.c		\
 	system.h		\
 	threads.c		\
