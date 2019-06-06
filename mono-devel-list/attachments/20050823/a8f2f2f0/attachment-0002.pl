Index: Makefile
===================================================================
--- Makefile	(revision 48630)
+++ Makefile	(working copy)
@@ -2,7 +2,7 @@
 include ../../build/rules.make
 
 LIBRARY = System.Windows.Forms.dll
-LIB_MCS_FLAGS = /unsafe \
+LIB_MCS_FLAGS = /unsafe /codepage:65001 \
 	/r:$(corlib) /r:System.dll /r:System.Xml.dll \
 	/r:System.Drawing.dll /r:Accessibility.dll \
 	/r:System.Data.dll /r:Mono.Posix.dll \