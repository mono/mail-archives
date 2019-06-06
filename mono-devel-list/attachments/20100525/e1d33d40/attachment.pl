Index: debug-mono-symfile.c
===================================================================
--- debug-mono-symfile.c	(revision 42294)
+++ debug-mono-symfile.c	(working copy)
@@ -123,10 +123,11 @@
 		symfile->raw_contents = p = g_malloc (size);
 		memcpy (p, raw_contents, size);
 		symfile->filename = g_strdup_printf ("LoadedFromMemory");
+		symfile->was_loaded_from_memory = TRUE;
 	} else {
 		MonoFileMap *f;
 		symfile->filename = g_strdup_printf ("%s.mdb", mono_image_get_filename (handle->image));
-
+		symfile->was_loaded_from_memory = FALSE;
 		if ((f = mono_file_map_open (symfile->filename))) {
 			symfile->raw_contents_size = mono_file_map_size (f);
 			if (symfile->raw_contents_size == 0) {
@@ -165,7 +166,12 @@
 		g_hash_table_destroy (symfile->method_hash);
 
 	if (symfile->raw_contents)
-		mono_file_unmap ((gpointer) symfile->raw_contents, symfile->raw_contents_handle);
+	{
+		if (symfile->was_loaded_from_memory)
+			g_free(symfile->raw_contents);
+		else
+			mono_file_unmap ((gpointer) symfile->raw_contents, symfile->raw_contents_handle);
+	}
 
 	if (symfile->filename)
 		g_free (symfile->filename);
Index: debug-mono-symfile.h
===================================================================
--- debug-mono-symfile.h	(revision 42294)
+++ debug-mono-symfile.h	(working copy)
@@ -91,6 +91,7 @@
 	gchar *filename;
 	GHashTable *method_hash;
 	MonoSymbolFileOffsetTable *offset_table;
+	gboolean was_loaded_from_memory;
 };
 
 #define MONO_SYMBOL_FILE_MAJOR_VERSION		50
