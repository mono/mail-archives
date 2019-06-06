--- mono-2.10/mono/mini/exceptions-amd64.c
+++ mono-local/mono/mini/exceptions-amd64.c
@@ -414,13 +414,19 @@
 	guint8 *code;
 	MonoJumpInfo *ji = NULL;
 	GSList *unwind_ops = NULL;
-	int i, stack_size, arg_offsets [16], regs_offset;
+	int i, stack_size, arg_offsets [16], regs_offset, dummy_stack_space;
 	const guint kMaxCodeSize = NACL_SIZE (256, 512);
 
+#ifdef TARGET_WIN32
+	dummy_stack_space = 6 * sizeof(mgreg_t);	/* Windows expects stack space allocated for all 6 dummy args. */
+#else
+	dummy_stack_space = 0;
+#endif
+
 	start = code = mono_global_codeman_reserve (kMaxCodeSize);
 
 	/* The stack is unaligned on entry */
-	stack_size = 192 + 8;
+	stack_size = 192 + 8 + dummy_stack_space;
 
 	code = start;
 
@@ -437,11 +443,11 @@
 	 * the stack by passing 6 dummy values in registers.
 	 */
 
-	arg_offsets [0] = 0;
-	arg_offsets [1] = sizeof(mgreg_t);
-	arg_offsets [2] = sizeof(mgreg_t) * 2;
-	arg_offsets [3] = sizeof(mgreg_t) * 3;
-	regs_offset = sizeof(mgreg_t) * 4;
+	arg_offsets [0] = dummy_stack_space + 0;
+	arg_offsets [1] = dummy_stack_space + sizeof(mgreg_t);
+	arg_offsets [2] = dummy_stack_space + sizeof(mgreg_t) * 2;
+	arg_offsets [3] = dummy_stack_space + sizeof(mgreg_t) * 3;
+	regs_offset = dummy_stack_space + sizeof(mgreg_t) * 4;
 
 	/* Save registers */
 	for (i = 0; i < AMD64_NREG; ++i)

