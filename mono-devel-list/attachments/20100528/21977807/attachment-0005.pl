Index: test/string-util.c
===================================================================
--- test/string-util.c	(revision 158032)
+++ test/string-util.c	(working copy)
@@ -397,7 +397,7 @@
 	return OK;
 }
 
-#define urit(so,j) do { s = g_filename_to_uri (so, NULL, NULL); if (strcmp (s, j) != 0) return FAILED("Got %s expected %s", s, j); g_free (s); } while (0);
+#define urit(so,j) do { s = g_filename_to_uri (so, NULL, NULL); if (!s || strcmp (s, j) != 0) return FAILED("Got %s expected %s", s, j); g_free (s); } while (0);
 
 #define errit(so) do { s = g_filename_to_uri (so, NULL, NULL); if (s != NULL) return FAILED ("got %s, expected NULL", s); } while (0);
 
@@ -417,7 +417,11 @@
 	urit ("/\042\043\045", "file:///%22%23%25");
 	urit ("/0123456789:=", "file:///0123456789:=");
 	urit ("/\073\074\076\077", "file:///%3B%3C%3E%3F");
+#ifndef G_OS_WIN32
+	/* there is an embedded '\' in the string that gets converted to '/'
+	   under Windows because '\' is a path separator char. Hence the test is failing. */
 	urit ("/\133\134\135\136_\140\173\174\175", "file:///%5B%5C%5D%5E_%60%7B%7C%7D");
+#endif
 	urit ("/\173\174\175\176\177\200", "file:///%7B%7C%7D~%7F%80");
 	urit ("/@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", "file:///@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz");
 	errit ("a");
@@ -426,7 +430,7 @@
 	return OK;
 }
 
-#define fileit(so,j) do { s = g_filename_from_uri (so, NULL, NULL); if (strcmp (s, j) != 0) return FAILED("Got %s expected %s", s, j); g_free (s); } while (0);
+#define fileit(so,j) do { s = g_filename_from_uri (so, NULL, NULL); if (!s || strcmp (s, j) != 0) return FAILED("Got %s expected %s", s, j); g_free (s); } while (0);
 
 #define ferrit(so) do { s = g_filename_from_uri (so, NULL, NULL); if (s != NULL) return FAILED ("got %s, expected NULL", s); } while (0);
 
Index: test/test.c
===================================================================
--- test/test.c	(revision 158032)
+++ test/test.c	(working copy)
@@ -203,6 +203,18 @@
  * Duplicating code here from EGlib to avoid g_strsplit skew between
  * EGLib and GLib
  */
+
+#ifndef HAVE_STRTOK_R
+
+/* borrow this from gpath.cs
+
+  FIXME: since we also need this function when building the tests against
+  GLib, we should rather extract strtok_r into its own file and add it
+  to test_glib_SOURCES in Makefile.am.
+*/
+char *strtok_r(char *s, const char *delim, char **last);
+
+#endif
  
 gchar ** 
 eg_strsplit (const gchar *string, const gchar *delimiter, gint max_tokens)
Index: test/Makefile.am
===================================================================
--- test/Makefile.am	(revision 158032)
+++ test/Makefile.am	(working copy)
@@ -30,7 +30,12 @@
 test_eglib_SOURCES = $(SOURCES)
 
 test_eglib_CFLAGS = -Wall -Werror -D_FORTIFY_SOURCE=2 -I$(srcdir)/../src -I../src -DDRIVER_NAME=\"EGlib\"
+
+if HOST_WIN32
+test_eglib_LDADD = ../src/libeglib.la -lwsock32
+else
 test_eglib_LDADD = ../src/libeglib.la
+endif
 
 run-eglib: all
 	./test-eglib
Index: test/path.c
===================================================================
--- test/path.c	(revision 158032)
+++ test/path.c	(working copy)
@@ -125,7 +125,7 @@
 #endif
 		return FAILED ("1 Got wrong result, got: %s", s);
 
-#ifndef OS_WIN32
+#ifndef G_OS_WIN32
 	s = g_build_filename ("/", "foo", "/bar", "tolo/", "/meo/", NULL);
 	if (strcmp (s, "/foo/bar/tolo/meo/") != 0)
 		return FAILED ("1 Got wrong result, got: %s", s);
@@ -242,7 +242,7 @@
 	char *s;
 	const char *path = g_getenv ("PATH");
 #ifdef G_OS_WIN32
-	const gchar *searchfor = "test_eglib.exe";
+	const gchar *searchfor = "test-eglib.exe";
 #else
 	const gchar *searchfor = "test-glib";
 #endif
Index: src/gmisc-win32.c
===================================================================
--- src/gmisc-win32.c	(revision 158032)
+++ src/gmisc-win32.c	(working copy)
@@ -97,8 +97,11 @@
 		if (filename[1] == ':' && filename[2] != '\0' && 
 			(filename[2] == '\\' || filename[2] == '/'))
 			return TRUE;
+		/* absolute w/out a drive spec */
+		if (filename[0] == '\\' || filename[0] == '/')
+			return TRUE;
 		/* UNC paths */
-		else if (filename[0] == '\\' && filename[1] == '\\' && 
+		if (filename[0] == '\\' && filename[1] == '\\' && 
 			filename[2] != '\0')
 			return TRUE;
 
Index: src/gstr.c
===================================================================
--- src/gstr.c	(revision 158032)
+++ src/gstr.c	(working copy)
@@ -527,11 +527,7 @@
 	size_t n;
 	char *ret, *rp;
 	const char *p;
-#ifdef G_OS_WIN32
-	const char *uriPrefix = "file:///";
-#else
 	const char *uriPrefix = "file://";
-#endif
 	
 	g_return_val_if_fail (filename != NULL, NULL);
 
@@ -621,9 +617,7 @@
 		} 
 		flen++;
 	}
-#ifndef G_OS_WIN32
 	flen++;
-#endif
 
 	result = g_malloc (flen + 1);
 	result [flen] = 0;
@@ -632,7 +626,14 @@
 	*result = '/';
 	r = result + 1;
 #else
-	r = result;
+	p = uri + 8;
+	if (*p && p[1] == ':') {
+		result [flen - 1] = 0; /* because  we don't prepend a '/' */
+		r = result;
+	} else {
+		*result = '/';
+		r = result + 1;
+	}
 #endif
 
 	for (p = uri + 8; *p; p++){
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 158032)
+++ ChangeLog	(working copy)
@@ -1,3 +1,23 @@
+2010-05-28  Robert Jordan  <robertj@gmx.net>
+
+	* test/Makefile.am: Fix Windows build.
+
+	* test/test.c: Import strtok_r from eglib.
+
+	* test/path.c: Fix 2 typos causing test failures under Windows.
+
+	* test/string-util.c (test_filename_to_uri): Comment out test
+	doomed to fail under Windows because it contains a '\' which
+	is a valid path separator under Windows.
+
+	* test/string-util.c (urit, fileit): Prevent SIGSEGVs if a unit test fails.
+
+	* src/gstr.c (g_filename_from_uri): Handle both "file:///dir/file" and
+	"file:///c:/dir/file" in the Windows case.
+
+	* src/gmisc-win32.c (g_path_is_absolute): Handle paths starting
+	with "/" or "\" as absolute, as GLib does.
+
 2010-05-25  Zoltan Varga  <vargaz@gmail.com>
 
 	* Applied patch from Burkhard Linke (blinke@cebitec.uni-bielefeld.de). Fix

