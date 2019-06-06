Index: icall.c
===================================================================
RCS file: /mono/mono/mono/metadata/icall.c,v
retrieving revision 1.565
diff -u -p -r1.565 icall.c
--- icall.c	19 Oct 2004 13:40:53 -0000	1.565
+++ icall.c	19 Oct 2004 18:51:18 -0000
@@ -2439,6 +2439,9 @@ ves_icall_InternalExecute (MonoReflectio
 
 		} else if (!strcmp (m->name, "FieldSetter")) {
 			MonoClass *k = this->vtable->klass;
+			MonoString *name;
+			char *str;
+			int size, align;
 			
 			/* If this is a proxy, then it must be a CBO */
 			if (k == mono_defaults.transparent_proxy_class) {
@@ -2448,10 +2451,7 @@ ves_icall_InternalExecute (MonoReflectio
 				k = this->vtable->klass;
 			}
 			
-			MonoString *name = mono_array_get (params, MonoString *, 1);
-			int size, align;
-			char *str;
-
+			name = mono_array_get (params, MonoString *, 1);
 			str = mono_string_to_utf8 (name);
 		
 			do {
