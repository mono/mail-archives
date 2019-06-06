Index: Makefile
===================================================================
--- Makefile	(revision 48814)
+++ Makefile	(working copy)
@@ -4,7 +4,7 @@
 
 LIBRARY = System.Drawing.dll
 
-LIB_MCS_FLAGS = /unsafe /r:$(corlib) /r:System.dll /nowarn:649 /nowarn:169
+LIB_MCS_FLAGS = /unsafe /r:$(corlib) /r:System.dll /nowarn:649 /nowarn:169 /codepage:65001
 
 TEST_MCS_FLAGS = $(LIB_MCS_FLAGS) /r:System.Drawing.dll -nowarn:0618 -nowarn:219 -nowarn:169 -nowarn:1595
 
