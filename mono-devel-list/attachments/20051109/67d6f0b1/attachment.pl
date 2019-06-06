Index: src/mod_mono.c
===================================================================
--- src/mod_mono.c	(Revision 52789)
+++ src/mod_mono.c	(Arbeitskopie)
@@ -1298,8 +1298,8 @@
 	size += get_table_send_size (r->headers_in);
 	size++; /* byte. TRUE->auto_app, FALSE: configured application */
 	if (auto_app != FALSE) {
-		if (r->canonical_filename != NULL) {
-			size += strlen (r->canonical_filename) + sizeof (int32_t);
+		if (r->filename != NULL) {
+			size += strlen (r->filename) + sizeof (int32_t);
 		} else {
 			auto_app = FALSE;
 		}
@@ -1326,7 +1326,7 @@
 	ptr += write_table_to_buffer (ptr, r->headers_in);
 	*ptr++ = auto_app;
 	if (auto_app != FALSE)
-		ptr += write_string_to_buffer (ptr, 0, r->canonical_filename);
+		ptr += write_string_to_buffer (ptr, 0, r->filename);
 
 	if (write_data (sock, str, size) != size)
 		return -1;
Index: src/mod_mono.h
===================================================================
--- src/mod_mono.h	(Revision 52789)
+++ src/mod_mono.h	(Arbeitskopie)
@@ -64,6 +64,7 @@
 #endif
 
 #include "multithread.h"
+#include "util_script.h"
 
 #define apr_psprintf ap_psprintf
 #define apr_uri_t uri_components
Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 52789)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,7 @@
+2005-11-09  Robert Jordan  <robertj@gmx.net>
+
+	* src/mod_mono.*: fixed compatibility issue with Apache 1.3.
+
 2005-11-02 Gonzalo Paniagua Javier <gonzalo@ximian.com>
 
 	* mod_mono.conf.in: added ASP.NET extensions to the configuration file.
