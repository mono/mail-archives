Index: reflection.c
===================================================================
--- reflection.c	(revision 37473)
+++ reflection.c	(working copy)
@@ -7041,7 +7041,13 @@
 		break;
 	}
 	/* it may be a boxed value or a Type */
-	case MONO_TYPE_OBJECT: {
+	case MONO_TYPE_OBJECT: {
+		if (arg == NULL) {
+			*p++ = MONO_TYPE_STRING;
+			*p++ = 0xFF;
+			break;
+		}
+		
 		MonoClass *klass = mono_object_class (arg);
 		char *str;
 		guint32 slen;
