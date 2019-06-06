--- mono/mini/mini-llvm.c.orig	2014-01-22 11:02:34.000000000 -0600
+++ mono/mini/mini-llvm.c	2014-01-22 14:02:39.044979804 -0600
@@ -244,6 +244,25 @@
 	return size;
 }
 
+static gboolean
+mini_llvm_is_gsharedvt_variable_type (MonoCompile *cfg, MonoType *t)
+{
+        return FALSE;
+}
+
+static gboolean
+mini_llvm_type_is_vtype (MonoCompile *cfg, MonoType *t)
+{
+    return MONO_TYPE_ISSTRUCT (t) || mini_llvm_is_gsharedvt_variable_type (cfg, t);
+}
+
+
+static gboolean
+mini_llvm_is_gsharedvt_klass (MonoCompile *cfg, MonoClass *klass)
+{
+        return FALSE;
+}
+
 /*
  * simd_class_to_llvm_type:
  *
@@ -1079,7 +1098,7 @@
 		} else {
 			g_assert_not_reached ();
 		}
-	} else if (cinfo && mini_type_is_vtype (ctx->cfg, sig->ret)) {
+	} else if (cinfo && mini_llvm_type_is_vtype (ctx->cfg, sig->ret)) {
 		g_assert (cinfo->ret.storage == LLVMArgVtypeRetAddr);
 		vretaddr = TRUE;
 		ret_type = LLVMVoidType ();
@@ -1744,7 +1763,7 @@
 		MonoInst *var = cfg->varinfo [i];
 		LLVMTypeRef vtype;
 
-		if (var->flags & (MONO_INST_VOLATILE|MONO_INST_INDIRECT) || mini_type_is_vtype (cfg, var->inst_vtype)) {
+		if (var->flags & (MONO_INST_VOLATILE|MONO_INST_INDIRECT) || mini_llvm_type_is_vtype (cfg, var->inst_vtype)) {
 			vtype = type_to_llvm_type (ctx, var->inst_vtype);
 			CHECK_FAILURE (ctx);
 			/* Could be already created by an OP_VPHI */
@@ -1797,7 +1816,7 @@
 	if (sig->hasthis)
 		emit_volatile_store (ctx, cfg->args [0]->dreg);
 	for (i = 0; i < sig->param_count; ++i)
-		if (!mini_type_is_vtype (cfg, sig->params [i]))
+		if (!mini_llvm_type_is_vtype (cfg, sig->params [i]))
 			emit_volatile_store (ctx, cfg->args [i + sig->hasthis]->dreg);
 
 	if (sig->hasthis && !cfg->rgctx_var && cfg->generic_sharing_context) {
@@ -3441,7 +3460,7 @@
 				break;
 			}
 
-			if (mini_is_gsharedvt_klass (cfg, klass)) {
+			if (mini_llvm_is_gsharedvt_klass (cfg, klass)) {
 				// FIXME:
 				LLVM_FAILURE (ctx, "gsharedvt");
 				break;
@@ -4772,9 +4791,10 @@
 	 * with it.
 	 */
 	cfg->encoded_unwind_ops = mono_unwind_decode_fde ((guint8*)data, &cfg->encoded_unwind_ops_len, NULL, &ei, &ei_len, &type_info, &this_reg, &this_offset);
+	/*
 	if (cfg->verbose_level > 1)
 		mono_print_unwind_info (cfg->encoded_unwind_ops, cfg->encoded_unwind_ops_len);
-
+	*/
 	/* Count nested clauses */
 	nested_len = 0;
 	for (i = 0; i < ei_len; ++i) {
