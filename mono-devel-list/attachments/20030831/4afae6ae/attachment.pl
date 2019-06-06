# This patch adds a check for the signbit function/macro;
# FreeBSD versions bellow 5.1 dont have it.
# Check: http://www.freebsd.org/cgi/man.cgi?query=signbit&manpath=FreeBSD+5.1-RELEASE
# -- Rui Lopes <rui@ruilopes.com> 
Index: acconfig.h
===================================================================
RCS file: /mono/mono/acconfig.h,v
retrieving revision 1.31
diff -u -r1.31 acconfig.h
--- acconfig.h	31 Jul 2003 14:32:40 -0000	1.31
+++ acconfig.h	31 Aug 2003 13:30:51 -0000
@@ -27,3 +27,4 @@
 #undef HAVE_GC_GCJ_MALLOC
 #undef WITH_BUNDLE
 #undef HAVE_GETHOSTBYNAME2_R
+#undef HAVE_SIGNBIT
Index: configure.in
===================================================================
RCS file: /mono/mono/configure.in,v
retrieving revision 1.161
diff -u -r1.161 configure.in
--- configure.in	22 Aug 2003 13:54:36 -0000	1.161
+++ configure.in	31 Aug 2003 13:30:51 -0000
@@ -568,6 +568,19 @@
 	dnl *** have it in the library (duh))                            ***
 	dnl ****************************************************************
 	AC_CHECK_FUNCS(poll)
+
+	dnl *************************
+	dnl *** Check for signbit ***
+	dnl *************************
+	AC_MSG_CHECKING(for signbit)
+	AC_TRY_COMPILE([#include <math.h>], [
+		int s = signbit(1.0);
+	], [
+		AC_MSG_RESULT(yes)
+		AC_DEFINE(HAVE_SIGNBIT)
+	], [
+		AC_MSG_RESULT(no)
+	]) 
 else
 	AC_CHECK_LIB(ws2_32, main, LIBS="$LIBS -lws2_32", AC_ERROR(bad mingw install?))
 	AC_CHECK_LIB(psapi, main, LIBS="$LIBS -lpsapi", AC_ERROR(bad mingw install?))
Index: mono/mini/mini-x86.c
===================================================================
RCS file: /mono/mono/mono/mini/mini-x86.c,v
retrieving revision 1.35
diff -u -r1.35 mini-x86.c
--- mono/mini/mini-x86.c	28 Aug 2003 02:09:40 -0000	1.35
+++ mono/mini/mini-x86.c	31 Aug 2003 13:32:29 -0000
@@ -2500,9 +2500,12 @@
 		case OP_R8CONST: {
 			double d = *(double *)ins->inst_p0;
 
+#ifdef HAVE_SIGNBIT
 			if ((d == 0.0) && (signbit (d) == 0)) {
 				x86_fldz (code);
-			} else if (d == 1.0) {
+			} else
+#endif
+			if (d == 1.0) {
 				x86_fld1 (code);
 			} else {
 				mono_add_patch_info (cfg, offset, MONO_PATCH_INFO_R8, ins->inst_p0);
@@ -2513,9 +2516,12 @@
 		case OP_R4CONST: {
 			float f = *(float *)ins->inst_p0;
 
+#ifdef HAVE_SIGNBIT
 			if ((f == 0.0) && (signbit (f) == 0)) {
 				x86_fldz (code);
-			} else if (f == 1.0) {
+			} else
+#endif
+			if (f == 1.0) {
 				x86_fld1 (code);
 			} else {
 				mono_add_patch_info (cfg, offset, MONO_PATCH_INFO_R4, ins->inst_p0);
