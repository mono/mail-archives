Index: icall.c
===================================================================
RCS file: /cvs/public/mono/mono/metadata/icall.c,v
retrieving revision 1.336
diff -u -r1.336 icall.c
--- icall.c	17 Sep 2003 04:34:00 -0000	1.336
+++ icall.c	18 Sep 2003 20:54:55 -0000
@@ -2933,10 +2933,13 @@
 static MonoBoolean
 ves_icall_Type_IsArrayImpl (MonoReflectionType *t)
 {
+	MonoType *type;
+	MonoBoolean res;
+
 	MONO_ARCH_SAVE_REGS;
 
-	MonoType *type = t->type;
-	MonoBoolean res = !type->byref && (type->type == MONO_TYPE_ARRAY || type->type == MONO_TYPE_SZARRAY);
+	type = t->type;
+	res = !type->byref && (type->type == MONO_TYPE_ARRAY || type->type == MONO_TYPE_SZARRAY);
 
 	return res;
 }
