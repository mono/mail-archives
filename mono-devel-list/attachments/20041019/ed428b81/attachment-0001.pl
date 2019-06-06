Index: main.c
===================================================================
RCS file: /mono/mono/mono/dis/main.c,v
retrieving revision 1.121
diff -u -p -r1.121 main.c
--- main.c	4 Oct 2004 22:22:47 -0000	1.121
+++ main.c	19 Oct 2004 18:50:32 -0000
@@ -183,9 +183,10 @@ dis_directive_assemblyref (MonoImage *m)
 		return;
 
 	for (i = 0; i < t->rows; i++){
+		char *esc;
 		mono_metadata_decode_row (t, i, cols, MONO_ASSEMBLYREF_SIZE);
 
-		char *esc = get_escaped_name (mono_metadata_string_heap (m, cols [MONO_ASSEMBLYREF_NAME]));
+		esc = get_escaped_name (mono_metadata_string_heap (m, cols [MONO_ASSEMBLYREF_NAME]));
 		
 		fprintf (output,
 			 ".assembly extern %s\n"
