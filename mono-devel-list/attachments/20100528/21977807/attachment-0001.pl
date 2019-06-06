Index: mono/metadata/icall.c
===================================================================
--- mono/metadata/icall.c	(revision 158032)
+++ mono/metadata/icall.c	(working copy)
@@ -1475,7 +1475,14 @@
 		return TYPECODE_DOUBLE;
 	case MONO_TYPE_VALUETYPE:
 		if (type->type->data.klass->enumtype) {
-			t = mono_class_enum_basetype (type->type->data.klass)->type;
+			MonoType *etype = mono_class_enum_basetype (type->type->data.klass);
+			if (etype) {
+				t = etype->type;
+			} else {
+				g_warning ("could not find base type of enum %s",
+					   mono_type_get_name (type->type));
+				t = MONO_TYPE_I4;
+			}
 			goto handle_enum;
 		} else {
 			MonoClass *k =  type->type->data.klass;

