Index: icall.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/icall.c,v
retrieving revision 1.482
diff -u -r1.482 icall.c
--- icall.c	24 May 2004 14:32:56 -0000	1.482
+++ icall.c	25 May 2004 15:55:53 -0000
@@ -3849,7 +3849,7 @@
 	SYSTEMTIME st;
 	FILETIME ft;
 	
-	GetLocalTime (&st);
+	GetSystemTime (&st);
 	SystemTimeToFileTime (&st, &ft);
 	return (gint64) FILETIME_ADJUST + ((((gint64)ft.dwHighDateTime)<<32) | ft.dwLowDateTime);
 #else