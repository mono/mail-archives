mono/mini:

2007-05-31  Randolph Chung  <tausq@debian.org>

	* inssel.brg: Add a "CHAINED" rule for compare-and-branch code emission.
	Adjust the cost of the OP_{CEQ,CLT,CLT_UN,CGT,CGT_UN} rules so that they
	can be more easily overridden per architecture.
	* inssel-long32.brg: Adjust the cost of compare rules so that they
	can be more easily overridden per architecture. Adjust compare and
	branch rules so they use the compare and branch macros to emit code
	instead of emitting OP_COMPARE + branch separately.

Index: mono/mini/inssel.brg
===================================================================
--- mono/mini/inssel.brg	(revision 78364)
+++ mono/mini/inssel.brg	(working copy)
@@ -319,6 +319,13 @@
 	} while (0)
 #endif
 
+#ifndef MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED
+#define MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED(cfg, cmp_op, sreg1, sreg2, label) \
+        do { \
+                MONO_EMIT_NEW_BRANCH_LABEL (s, (cmp_op), (label)); \
+} while (0)
+#endif
+
 #ifndef MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL
 #define MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL(cfg, cmp_op, sreg1, imm, label) \
 	do { \
@@ -327,6 +334,13 @@
 	} while (0)
 #endif
 
+#ifndef MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL_CHAINED
+#define MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL_CHAINED(cfg, cmp_op, sreg1, imm, label) \
+        do { \
+                MONO_EMIT_NEW_BRANCH_LABEL (s, (cmp_op), (label)); \
+} while (0)
+#endif
+
 #ifndef MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK
 #define MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK(cfg, cmp_op, sreg1, sreg2, block) \
 	do { \
@@ -335,6 +349,13 @@
 	} while (0)
 #endif
 
+#ifndef MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED
+#define MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED(cfg, cmp_op, sreg1, sreg2, block) \
+        do { \
+                MONO_EMIT_NEW_BRANCH_BLOCK (s, (cmp_op), (block)); \
+} while (0)
+#endif
+
 #ifndef MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK
 #define MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK(cfg, cmp_op, sreg1, imm, block) \
 	do { \
@@ -343,6 +364,13 @@
 	} while (0)
 #endif
 
+#ifndef MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED
+#define MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED(cfg, cmp_op, sreg1, imm, block) \
+        do { \
+                MONO_EMIT_NEW_BRANCH_BLOCK (s, (cmp_op), (block)); \
+} while (0)
+#endif
+
 %%
 
 %termprefix OP_ CEE_
@@ -752,7 +780,7 @@
 reg: OP_CLT (cflags),
 reg: OP_CLT_UN (cflags),
 reg: OP_CGT (cflags),
-reg: OP_CGT_UN (cflags) {	
+reg: OP_CGT_UN (cflags) "2" {	
 	tree->dreg = state->reg1;
 	mono_bblock_add_inst (s->cbb, tree);
 }
Index: mono/mini/inssel-long32.brg
===================================================================
--- mono/mini/inssel-long32.brg	(revision 78364)
+++ mono/mini/inssel-long32.brg	(working copy)
@@ -123,7 +123,7 @@
 	}
 }
 
-cflags: OP_COMPARE (reg, reg) {
+cflags: OP_COMPARE (reg, reg) "2" {
 	tree->sreg1 = state->left->reg1;
 	tree->sreg2 = state->right->reg1;
 	mono_bblock_add_inst (s->cbb, tree);
@@ -132,7 +132,7 @@
 cflags: OP_COMPARE (CEE_LDIND_REF (OP_REGVAR), reg),
 cflags: OP_COMPARE (CEE_LDIND_I (OP_REGVAR), reg),
 cflags: OP_COMPARE (CEE_LDIND_I4 (OP_REGVAR), reg),
-cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), reg) {
+cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), reg) "2" {
 	tree->sreg1 = state->left->left->tree->dreg;
 	tree->sreg2 = state->right->reg1;
 	mono_bblock_add_inst (s->cbb, tree);
@@ -141,7 +141,7 @@
 cflags: OP_COMPARE (CEE_LDIND_REF (OP_REGVAR), CEE_LDIND_REF (OP_REGVAR)),
 cflags: OP_COMPARE (CEE_LDIND_I (OP_REGVAR), CEE_LDIND_I (OP_REGVAR)),
 cflags: OP_COMPARE (CEE_LDIND_I4 (OP_REGVAR), CEE_LDIND_I4 (OP_REGVAR)),
-cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), CEE_LDIND_U4 (OP_REGVAR)) {
+cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), CEE_LDIND_U4 (OP_REGVAR)) "2" {
 	tree->sreg1 = state->left->left->tree->dreg;
 	tree->sreg2 = state->right->left->tree->dreg;
 	mono_bblock_add_inst (s->cbb, tree);
@@ -150,14 +150,14 @@
 cflags: OP_COMPARE (CEE_LDIND_REF (OP_REGVAR), OP_ICONST),
 cflags: OP_COMPARE (CEE_LDIND_I (OP_REGVAR), OP_ICONST),
 cflags: OP_COMPARE (CEE_LDIND_I4 (OP_REGVAR), OP_ICONST),
-cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), OP_ICONST) {
+cflags: OP_COMPARE (CEE_LDIND_U4 (OP_REGVAR), OP_ICONST) "2" {
 	tree->opcode = OP_COMPARE_IMM;
 	tree->sreg1 = state->left->left->tree->dreg;
 	tree->inst_imm = state->right->tree->inst_c0;
 	mono_bblock_add_inst (s->cbb, tree);
 }
 
-cflags: OP_COMPARE (reg, OP_ICONST) {
+cflags: OP_COMPARE (reg, OP_ICONST) "2" {
 	tree->opcode = OP_COMPARE_IMM;
 	tree->sreg1 = state->left->reg1;
 	tree->inst_imm = state->right->tree->inst_c0;
@@ -173,7 +173,7 @@
 stmt: CEE_BGE  (cflags),
 stmt: CEE_BGE_UN (cflags),
 stmt: CEE_BLE  (cflags),
-stmt: CEE_BLE_UN (cflags) {
+stmt: CEE_BLE_UN (cflags) "2" {
 	mono_bblock_add_inst (s->cbb, tree);
 }
 
@@ -181,7 +181,7 @@
 reg: OP_CLT (cflags),
 reg: OP_CLT_UN (cflags),
 reg: OP_CGT (cflags),
-reg: OP_CGT_UN (cflags) {	
+reg: OP_CGT_UN (cflags) "2" {	
 	tree->dreg = state->reg1;
 	mono_bblock_add_inst (s->cbb, tree);
 }
@@ -384,10 +384,8 @@
 	MONO_NEW_LABEL (s, word_differs);
 
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 0);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, word_differs);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, word_differs);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, word_differs);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BNE_UN, state->left->left->reg1, state->left->right->reg1, word_differs);
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 1);
 	
 	mono_bblock_add_inst (s->cbb, word_differs);
@@ -400,11 +398,9 @@
 	MONO_NEW_LABEL (s, set_to_1);
 
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 0);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGT, set_to_0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, set_to_1);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGE_UN, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGT, state->left->left->reg2, state->left->right->reg2, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, set_to_1);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->reg1, set_to_0);
 	mono_bblock_add_inst (s->cbb, set_to_1);
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 1);
 	mono_bblock_add_inst (s->cbb, set_to_0);
@@ -417,11 +413,9 @@
 	MONO_NEW_LABEL (s, set_to_1);
 
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 0);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGT_UN, set_to_0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, set_to_1);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGE_UN, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGT_UN, state->left->left->reg2, state->left->right->reg2, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, set_to_1);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->reg1, set_to_0);
 	mono_bblock_add_inst (s->cbb, set_to_1);
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 1);
 	mono_bblock_add_inst (s->cbb, set_to_0);
@@ -434,11 +428,9 @@
 	MONO_NEW_LABEL (s, set_to_1);
 
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 0);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->right->reg2, state->left->left->reg2);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGT, set_to_0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, set_to_1);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->right->reg1, state->left->left->reg1);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGE_UN, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGT, state->left->right->reg2, state->left->left->reg2, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED (s, CEE_BNE_UN, state->left->right->reg2, state->left->left->reg2, set_to_1);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGE_UN, state->left->right->reg1, state->left->left->reg1, set_to_0);
 	mono_bblock_add_inst (s->cbb, set_to_1);
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 1);
 	mono_bblock_add_inst (s->cbb, set_to_0);
@@ -451,188 +443,129 @@
 	MONO_NEW_LABEL (s, set_to_1);
 
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 0);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->right->reg2, state->left->left->reg2);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGT_UN, set_to_0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BNE_UN, set_to_1);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->right->reg1, state->left->left->reg1);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BGE_UN, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGT_UN, state->left->right->reg2, state->left->left->reg2, set_to_0);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL_CHAINED (s, CEE_BNE_UN, state->left->right->reg2, state->left->left->reg2, set_to_1);
+	MONO_EMIT_NEW_COMPARE_BRANCH_LABEL (s, CEE_BGE_UN, state->left->right->reg1, state->left->left->reg1, set_to_0);
 	mono_bblock_add_inst (s->cbb, set_to_1);
      	MONO_EMIT_NEW_ICONST (s, state->reg1, 1);
 	mono_bblock_add_inst (s->cbb, set_to_0);
 }	
 
 stmt: CEE_BNE_UN (OP_LCOMPARE (lreg, lreg)) {
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	mono_bblock_add_inst (s->cbb, tree);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
 }
 
 stmt: CEE_BNE_UN (OP_LCOMPARE (lreg, i8con)) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	mono_bblock_add_inst (s->cbb, tree);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BEQ (OP_LCOMPARE (lreg, lreg)) {
-	
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	mono_bblock_add_inst (s->cbb, tree);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BEQ, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
 }
 
 stmt: CEE_BEQ (OP_LCOMPARE (lreg, i8con)) {
-	
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	mono_bblock_add_inst (s->cbb, tree);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BNE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BEQ, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BLE (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BLE (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BLE_UN (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BLE_UN (OP_LCOMPARE (lreg, i8con)) {
 
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BGE (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BGE (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BGE_UN (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BGE_UN (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGE_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGE_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BLT (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BLT (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BLT_UN (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BLT_UN (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BLT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BLT_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BGT (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGT, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BGT (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 stmt: CEE_BGT_UN (OP_LCOMPARE (lreg, lreg)) {
-
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg2, state->left->right->reg2);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU (s, OP_COMPARE, -1, state->left->left->reg1, state->left->right->reg1);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->reg2, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg1, state->left->right->reg1, tree->inst_true_bb);
 }
 
 stmt: CEE_BGT_UN (OP_LCOMPARE (lreg, i8con)) {
-
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg2, state->left->right->tree->inst_ms_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BNE_UN, tree->inst_false_bb);
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->left->reg1, state->left->right->tree->inst_ls_word);
-	MONO_EMIT_NEW_BRANCH_BLOCK (s, CEE_BGT_UN, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_true_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK_CHAINED (s, CEE_BNE_UN, state->left->left->reg2, state->left->right->tree->inst_ms_word, tree->inst_false_bb);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_BLOCK (s, CEE_BGT_UN, state->left->left->reg1, state->left->right->tree->inst_ls_word, tree->inst_true_bb);
 }
 
 lreg: CEE_CONV_I8 (OP_ICONST) {
@@ -668,8 +601,7 @@
 }
 
 lreg: CEE_CONV_OVF_U8 (reg) {
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 0);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg1, 0, "OverflowException");
 	MONO_EMIT_NEW_ICONST (s, state->reg2, 0);
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg1, state->left->reg1);
 }
@@ -747,13 +679,9 @@
 }
 
 reg: OP_LCONV_TO_OVF_I1_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
-
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 127);
-	MONO_EMIT_NEW_COND_EXC (s, GT, "OverflowException");
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, -128);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT, state->left->reg1, 127, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg1, -128, "OverflowException");
 	MONO_EMIT_UNALU (s, tree, CEE_CONV_I1, state->reg1, state->left->reg1);
 }
 
@@ -763,23 +691,17 @@
 	MONO_NEW_LABEL (s, is_negative);
 	MONO_NEW_LABEL (s, end_label);
 
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, GT, "OverflowException");
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, -1);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT, state->left->reg2, 0, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg2, -1, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL (s, CEE_BLT, state->left->reg2, 0, is_negative);
 
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BLT, is_negative);
-
 	/* Positive */
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 127);
-	MONO_EMIT_NEW_COND_EXC (s, GT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT_UN, state->left->reg1, 127, "OverflowException");
 	MONO_EMIT_NEW_BRANCH_LABEL (s, OP_BR, end_label);
 
 	/* Negative */
 	mono_bblock_add_inst (s->cbb, is_negative);
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, -128);
-	MONO_EMIT_NEW_COND_EXC (s, LT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT_UN, state->left->reg1, -128, "OverflowException");
 	mono_bblock_add_inst (s->cbb, end_label);
 
 	MONO_EMIT_UNALU (s, tree, CEE_CONV_I1, state->reg1, state->left->reg1);
@@ -787,12 +709,10 @@
 
 reg: OP_LCONV_TO_OVF_U1_UN (lreg),
 reg: OP_LCONV_TO_OVF_U1 (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 
 	/* probe value to be within 0 to 255 */
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 255);
-	MONO_EMIT_NEW_COND_EXC (s, GT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT_UN, state->left->reg1, 255, "OverflowException");
 	MONO_EMIT_BIALU_IMM (s, tree, OP_AND_IMM, state->reg1, state->left->reg1, 0xff);
 }
 
@@ -802,67 +722,54 @@
 	MONO_NEW_LABEL (s, is_negative);
 	MONO_NEW_LABEL (s, end_label);
 
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, GT, "OverflowException");
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, -1);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT, state->left->reg2, 0, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg2, -1, "OverflowException");
 
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_BRANCH_LABEL (s, CEE_BLT, is_negative);
+	MONO_EMIT_NEW_COMPARE_IMM_BRANCH_LABEL (s, CEE_BLT, state->left->reg2, 0, is_negative);
 
 	/* Positive */
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 32767);
-	MONO_EMIT_NEW_COND_EXC (s, GT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT_UN, state->left->reg1, 32767, "OverflowException");
 	MONO_EMIT_NEW_BRANCH_LABEL (s, OP_BR, end_label);
 
 	/* Negative */
 	mono_bblock_add_inst (s->cbb, is_negative);
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, -32768);
-	MONO_EMIT_NEW_COND_EXC (s, LT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT_UN, state->left->reg1, -32768, "OverflowException");
 	mono_bblock_add_inst (s->cbb, end_label);
 
 	MONO_EMIT_UNALU (s, tree, CEE_CONV_I2, state->reg1, state->left->reg1);
 }
 
 reg: OP_LCONV_TO_OVF_I2_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 
 	/* Probe value to be within -32768 and 32767 */
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 32767);
-	MONO_EMIT_NEW_COND_EXC (s, GT, "OverflowException");
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, -32768);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT, state->left->reg1, 32767, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg1, -32768, "OverflowException");
 	MONO_EMIT_UNALU (s, tree, CEE_CONV_I2, state->reg1, state->left->reg1);
 }
 
 reg: OP_LCONV_TO_OVF_U2_UN (lreg),
 reg: OP_LCONV_TO_OVF_U2 (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 
 	/* Probe value to be within 0 and 65535 */
-	MONO_EMIT_NEW_COMPARE_IMM (s, state->left->reg1, 0xffff);
-	MONO_EMIT_NEW_COND_EXC (s, GT_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, GT_UN, state->left->reg1, 0xffff, "OverflowException");
 	MONO_EMIT_BIALU_IMM (s, tree, OP_AND_IMM, state->reg1, state->left->reg1, 0xffff);
 }
 
 
 reg: OP_LCONV_TO_OVF_U4_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg1, state->left->reg1);
 }
 
 reg: OP_LCONV_TO_OVF_I_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg1, state->left->reg1);
 }
 
 reg: OP_LCONV_TO_OVF_U4 (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg1, state->left->reg1);
 }
 
@@ -874,10 +781,8 @@
 }
 
 reg: OP_LCONV_TO_OVF_I4_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, NE_UN, "OverflowException");
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg1, 0);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, NE_UN, state->left->reg2, 0, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg1, 0, "OverflowException");
 	MONO_EMIT_NEW_UNALU (s, OP_MOVE, state->reg1, state->left->reg1);
 }
 
@@ -890,16 +795,14 @@
 }
 
 lreg: OP_LCONV_TO_OVF_I8_UN (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg2, 0, "OverflowException");
 
 	MONO_EMIT_NEW_UNALU (s, OP_MOVE, state->reg1, state->left->reg1);
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg2, state->left->reg2);
 }
 
 lreg: OP_LCONV_TO_OVF_U8 (lreg) {
-	MONO_EMIT_NEW_BIALU_IMM (s, OP_COMPARE_IMM, -1, state->left->reg2, 0);
-	MONO_EMIT_NEW_COND_EXC (s, LT, "OverflowException");
+	MONO_EMIT_NEW_COMPARE_IMM_EXC (s, LT, state->left->reg2, 0, "OverflowException");
 
 	MONO_EMIT_NEW_UNALU (s, OP_MOVE, state->reg1, state->left->reg1);
 	MONO_EMIT_UNALU (s, tree, OP_MOVE, state->reg2, state->left->reg2);

