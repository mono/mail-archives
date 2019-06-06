Index: metadata/appdomain.c
===================================================================
--- metadata/appdomain.c	(revision 142262)
+++ metadata/appdomain.c	(working copy)
@@ -1431,8 +1431,10 @@
 		mono_raise_exception (exc);
 	}	
 
-	if (!private_file_needs_copying (filename, &src_sbuf, shadow))
+	if (!private_file_needs_copying (filename, &src_sbuf, shadow)) {
+		mono_trace (G_LOG_LEVEL_INFO, MONO_TRACE_ASSEMBLY, "Shadow copy %s of %s is up-to-date.\n", shadow, filename);
 		return (char*) shadow;
+	}
 
 	orig = g_utf8_to_utf16 (filename, strlen (filename), NULL, NULL, NULL);
 	dest = g_utf8_to_utf16 (shadow, strlen (shadow), NULL, NULL, NULL);
