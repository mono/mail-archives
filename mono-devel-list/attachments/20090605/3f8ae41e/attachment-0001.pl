Index: class.c
===================================================================
--- class.c	(revision 134593)
+++ class.c	(working copy)
@@ -4328,7 +4328,7 @@
 		class->method.count = 0;
 
 	/* reserve space to store vector pointer in arrays */
-	if (!strcmp (nspace, "System") && !strcmp (name, "Array")) {
+	if (is_corlib_image (image) &&  !strcmp (nspace, "System") && !strcmp (name, "Array")) {
 		class->instance_size += 2 * sizeof (gpointer);
 		g_assert (class->field.count == 0);
 	}
