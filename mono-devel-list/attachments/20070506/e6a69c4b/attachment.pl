Index: runtime/Makefile.am
===================================================================
--- runtime/Makefile.am	(revision 76761)
+++ runtime/Makefile.am	(working copy)
@@ -95,6 +95,8 @@
 
 CLEANFILES = etc/mono/config
 
+.NOTPARALLEL: etc/mono/config
+
 # depend on $(symlinks) to ensure 'etc/mono' directory exists
 etc/mono/config: ../data/config Makefile $(symlinks)
 	d=`cd ../support && pwd`; \
