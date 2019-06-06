Index: metadata/icall.c
===================================================================
--- metadata/icall.c	(revision 69048)
+++ metadata/icall.c	(working copy)
@@ -1999,7 +1999,7 @@
 	MONO_ARCH_SAVE_REGS;
 
 	count = mono_array_length (type_array);
-	types = g_new0 (MonoType *, count);
+	types = g_newa (MonoType *, count);
 
 	for (i = 0; i < count; i++) {
 		MonoReflectionType *t = mono_array_get (type_array, gpointer, i);
