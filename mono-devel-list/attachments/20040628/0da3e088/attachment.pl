Index: runtime/Makefile.am
===================================================================
RCS file: /mono/mono/runtime/Makefile.am,v
retrieving revision 1.79
diff -u -r1.79 Makefile.am
--- runtime/Makefile.am	18 Jun 2004 12:07:45 -0000	1.79
+++ runtime/Makefile.am	27 Jun 2004 07:43:45 -0000
@@ -34,8 +34,12 @@
 	mcs.exe					\
 	mbas.exe
 
+if PLATFORM_WIN32
+monotwo_DATA =
+else
 monotwo_DATA = \
 	gmcs.exe
+endif
 
 EXTRA_DIST= $(monobins_DATA) $(monoone_DATA) $(monotwo_DATA)
 

