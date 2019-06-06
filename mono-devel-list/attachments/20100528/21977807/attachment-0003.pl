Index: ChangeLog
===================================================================
--- ChangeLog	(revision 158032)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2010-05-28  Robert Jordan  <robertj@gmx.net>
+
+	* configure.in: Fix mcs_topdir* for the Windows build.
+
 2010-05-20  Miguel de Icaza  <miguel@novell.com>
 
 	* configure.in: drop again the pkg.m4 dependency and for eglib
Index: configure.in
===================================================================
--- configure.in	(revision 158032)
+++ configure.in	(working copy)
@@ -478,6 +478,12 @@
 mcs_topdir_from_srcdir='$(top_builddir)'/$mcsdir
 fi
 
+# Convert paths to Windows syntax.
+if test x$cross_compiling$host_win32 = xnoyes; then
+  mcs_topdir=$(cygpath -m -a $mcs_topdir)
+  mcs_topdir_from_srcdir=$(cygpath -m -a $mcs_topdir_from_srcdir)
+fi
+
 ## Maybe should also disable if mcsdir is invalid.  Let's punt the issue for now.
 AM_CONDITIONAL(BUILD_MCS, [test x$cross_compiling = xno && test x$enable_mcs_build != xno])
 

