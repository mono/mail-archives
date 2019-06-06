Index: platforms/win32.make
===================================================================
RCS file: /cvs/public/mcs/build/platforms/win32.make,v
retrieving revision 1.4
diff -u -r1.4 win32.make
--- platforms/win32.make	22 Oct 2003 14:23:54 -0000	1.4
+++ platforms/win32.make	28 Feb 2004 16:35:51 -0000
@@ -8,8 +8,8 @@
 PLATFORM_RUNTIME = 
 PLATFORM_CORLIB = mscorlib.dll
 
-BOOTSTRAP_MCS = csc.exe
-MCS = $(BOOTSTRAP_MCS)
+BOOTSTRAP_MCS = __SECURITY_BOOTSTRAP_DB=$(topdir)/class/corlib csc.exe
+MCS = csc.exe
 RESGEN = resgen.exe
 
 PLATFORM_MAKE_CORLIB_CMP = yes
