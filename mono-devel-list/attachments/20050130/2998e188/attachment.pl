Index: mini-amd64.c
===================================================================
--- mini-amd64.c	(revision 39728)
+++ mini-amd64.c	(working copy)
@@ -1272,7 +1272,7 @@
 			}
 			break;
 		case OP_COMPARE_IMM:
-			/* OP_COMPARE_IMM (reg, 0) 
+			/* OP_COMPARE_IMM (reg, 0)
 			 * --> 
 			 * OP_AMD64_TEST_NULL (reg) 
 			 */
@@ -3298,7 +3298,7 @@
 			}
 			break;
 		case OP_X86_COMPARE_MEMBASE_REG:
-			amd64_alu_membase_reg (code, X86_CMP, ins->inst_basereg, ins->inst_offset, ins->sreg2);
+			amd64_alu_membase_reg_size (code, X86_CMP, ins->inst_basereg, ins->inst_offset, ins->sreg2, 4);
 			break;
 		case OP_X86_COMPARE_MEMBASE_IMM:
 			g_assert (amd64_is_imm32 (ins->inst_imm));
