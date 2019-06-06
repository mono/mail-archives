2007-05-22  Randolph Chung  <tausq@debian.org>

	* mini-ops.h: Change ordering of branch opcodes so that their
	ordering correspond to the CIL opcode counterparts.

Index: mono/mini/mini-ops.h
===================================================================
--- mono/mini/mini-ops.h	(revision 77087)
+++ mono/mini/mini-ops.h	(working copy)
@@ -242,15 +242,15 @@
 MINI_OP(OP_LMUL_IMM,     "long_mul_imm")
 
 MINI_OP(OP_LBEQ,    "long_beq")
+MINI_OP(OP_LBGE,    "long_bge")
+MINI_OP(OP_LBGT,    "long_bgt")
+MINI_OP(OP_LBLE,    "long_ble")
+MINI_OP(OP_LBLT,    "long_blt")
 MINI_OP(OP_LBNE_UN, "long_bne_un")
-MINI_OP(OP_LBLT,    "long_blt")
-MINI_OP(OP_LBLT_UN, "long_blt_un")
-MINI_OP(OP_LBGT,    "long_bgt")
+MINI_OP(OP_LBGE_UN, "long_bge_un")
 MINI_OP(OP_LBGT_UN, "long_btg_un")
-MINI_OP(OP_LBGE,    "long_bge")
-MINI_OP(OP_LBGE_UN, "long_bge_un")
-MINI_OP(OP_LBLE,    "long_ble")
 MINI_OP(OP_LBLE_UN, "long_ble_un")
+MINI_OP(OP_LBLT_UN, "long_blt_un")
 
 MINI_OP(OP_LONG_SHRUN_32, "long_shr_un_32")
 
@@ -344,26 +344,26 @@
 MINI_OP(OP_ICLT_UN,"int_clt_un")
 
 MINI_OP(OP_IBEQ,    "int_beq")
+MINI_OP(OP_IBGE,    "int_bge")
+MINI_OP(OP_IBGT,    "int_bgt")
+MINI_OP(OP_IBLE,    "int_ble")
+MINI_OP(OP_IBLT,    "int_blt")
 MINI_OP(OP_IBNE_UN, "int_bne_un")
-MINI_OP(OP_IBLT,    "int_blt")
-MINI_OP(OP_IBLT_UN, "int_blt_un")
-MINI_OP(OP_IBGT,    "int_bgt")
+MINI_OP(OP_IBGE_UN, "int_bge_un")
 MINI_OP(OP_IBGT_UN, "int_bgt_un")
-MINI_OP(OP_IBGE,    "int_bge")
-MINI_OP(OP_IBGE_UN, "int_bge_un")
-MINI_OP(OP_IBLE,    "int_ble")
 MINI_OP(OP_IBLE_UN, "int_ble_un")
+MINI_OP(OP_IBLT_UN, "int_blt_un")
 
 MINI_OP(OP_FBEQ,   "float_beq")
+MINI_OP(OP_FBGE,   "float_bge")
+MINI_OP(OP_FBGT,   "float_bgt")
+MINI_OP(OP_FBLE,   "float_ble")
+MINI_OP(OP_FBLT,   "float_blt")
 MINI_OP(OP_FBNE_UN,"float_bne_un")
-MINI_OP(OP_FBLT,   "float_blt")
-MINI_OP(OP_FBLT_UN,"float_blt_un")
-MINI_OP(OP_FBGT,   "float_bgt")
+MINI_OP(OP_FBGE_UN,"float_bge_un")
 MINI_OP(OP_FBGT_UN,"float_btg_un")
-MINI_OP(OP_FBGE,   "float_bge")
-MINI_OP(OP_FBGE_UN,"float_bge_un")
-MINI_OP(OP_FBLE,   "float_ble")
 MINI_OP(OP_FBLE_UN,"float_ble_un")
+MINI_OP(OP_FBLT_UN,"float_blt_un")
 
 /* float opcodes: must be in the same order as the matching CEE_ opcodes: binops_op_map */
 MINI_OP(OP_FADD,   "float_add")
