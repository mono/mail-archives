float64 cast for literals as done by ildasm was missing in monodis.  Might not
matter, but makes the output similiar.

I assume the same is true for float32, so it was also changed.

- Steven Brown <swbrown@ucsd.edu>


Index: mono/dis/get.c
===================================================================
RCS file: /mono/mono/mono/dis/get.c,v
retrieving revision 1.82
diff -u -r1.82 get.c
--- mono/dis/get.c	25 Jun 2004 18:54:50 -0000	1.82
+++ mono/dis/get.c	29 Jun 2004 06:13:14 -0000
@@ -1621,12 +1621,12 @@
 	case MONO_TYPE_R4: {
 		float r;
 		readr4 (ptr, &r);
-		return g_strdup_printf ("%g", (double) r);
+		return g_strdup_printf ("float32(%g)", (double) r);
 	}
 	case MONO_TYPE_R8: {
 		double r;
 		readr8 (ptr, &r);
-		return g_strdup_printf ("%g", r);
+		return g_strdup_printf ("float64(%g)", r);
 	}
 	case MONO_TYPE_STRING: {
 		int i, j, e;
