Index: mono/mono/io-layer/atomic.h
===================================================================
--- mono/mono/io-layer/atomic.h	(revision 66543)
+++ mono/mono/io-layer/atomic.h	(working copy)
@@ -869,12 +869,12 @@
 	
 	__asm__ __volatile__ (
 		"1:	ldl_l %0, %1\n"
-		"	addl %0, %3, %0\n"
+		"	subl %0, %3, %0\n"
 		"	mov %0, %2\n"
 		"	stl_c %0, %1\n"
 		"	beq %0, 1b\n"
 		: "=&r" (temp), "=m" (*val), "=r" (cur)
-		: "Ir" (-1), "m" (*val));
+		: "Ir" (1), "m" (*val));
 	return(cur);
 }
 
Index: mono/mono/mini/cpu-alpha.md
===================================================================
--- mono/mono/mini/cpu-alpha.md	(revision 66558)
+++ mono/mono/mini/cpu-alpha.md	(working copy)
@@ -94,9 +94,9 @@
 and: dest:i src1:i src2:i len:4
 or: dest:i src1:i src2:i len:4
 xor: dest:i src1:i src2:i len:4
-shl: dest:i src1:i src2:s len:4
-shr: dest:i src1:i src2:s len:8
-shr.un: dest:i src1:i src2:s len:8
+shl: dest:i src1:i src2:i len:4
+shr: dest:i src1:i src2:i len:4
+shr.un: dest:i src1:i src2:i len:8
 neg: dest:i src1:i len:4
 not: dest:i src1:i len:4
 conv.i1: dest:i src1:i len:12
@@ -244,9 +244,9 @@
 long_div_un: dest:a src1:a src2:i len:16 clob:d
 long_rem: dest:d src1:a src2:i len:16 clob:a
 long_rem_un: dest:d src1:a src2:i len:16 clob:a
-long_shl: dest:i src1:i src2:s clob:1 len:31
-long_shr: dest:i src1:i src2:s len:4
-long_shr_un: dest:i src1:i src2:s len:4
+long_shl: dest:i src1:i src2:i len:4
+long_shr: dest:i src1:i src2:i len:4
+long_shr_un: dest:i src1:i src2:i len:4
 long_conv_to_r4: dest:f src1:i len:20
 long_conv_to_r8: dest:f src1:i len:20
 long_conv_to_ovf_i: dest:i src1:i src2:i len:40
@@ -255,7 +255,7 @@
 long_conv_to_r_un: dest:f src1:i src2:i len:48 
 long_shr_imm: dest:i src1:i len:4
 long_shr_un_imm: dest:i src1:i len:4
-long_shl_imm: dest:i src1:i clob:1 len:11
+long_shl_imm: dest:i src1:i len:4
 float_beq: len:4
 float_bne_un: len:12
 float_blt: len:4
@@ -378,9 +378,9 @@
 int_and: dest:i src1:i src2:i len:4
 int_or: dest:i src1:i src2:i len:4
 int_xor: dest:i src1:i src2:i len:4
-int_shl: dest:i src1:i src2:s len:4
-int_shr: dest:i src1:i src2:s len:8
-int_shr_un: dest:i src1:i src2:s len:8
+int_shl: dest:i src1:i src2:i len:4
+int_shr: dest:i src1:i src2:i len:8
+int_shr_un: dest:i src1:i src2:i len:8
 int_adc: dest:i src1:i src2:i clob:1 len:64
 int_adc_imm: dest:i src1:i clob:1 len:64
 int_sbb: dest:i src1:i src2:i clob:1 len:64
Index: mono/mono/mini/tramp-alpha.c
===================================================================
--- mono/mono/mini/tramp-alpha.c	(revision 66558)
+++ mono/mono/mini/tramp-alpha.c	(working copy)
@@ -510,12 +510,68 @@
 
 }
 
+/*
+** This method is called after delegate method is compiled.
+** We need to patch call site to call compiled method directly
+** (not via trampoline stub)
+** Determine address to patch using fp reg
+** 
+*/
 
 void
 mono_arch_patch_delegate_trampoline (guint8 *code, guint8 *tramp,
 				     gssize *regs, guint8 *addr)
 {
+  unsigned int *pcode = (unsigned int *)code;
+  int reg;
+  short fp_disp, obj_disp;
+  unsigned long *pobj, obj;
+
   ALPHA_DEBUG("mono_arch_patch_delegate_trampoline");
+
+  // The call signature for now is
+  // -4 - ldq     v0,24(fp)
+  // -3 - ldq     v0,40(v0)
+  // -2 - mov     v0,t12
+  // -1 - jsr     ra,(t12),0x200041476e4
+  //  0 - ldah    gp,0(ra)
+  if (((pcode[-4] & 0xFF000000) == 0xA4000000) &&
+      ((pcode[-3] & 0xFF000000) == 0xA4000000) &&
+      ((pcode[-2] & 0xFF00FF00) == 0x47000400) &&
+      ((pcode[-1] & 0xFFFF0000) == 0x6B5B0000))
+    {
+      fp_disp = (pcode[-4] & 0xFFFF);
+      obj_disp = (pcode[-3] & 0xFFFF);
+
+      pobj = regs[15] + fp_disp;
+      obj = *pobj;
+      reg = 0;
+    }
+  else
+    // The non-optimized call signature for now is
+    // -5 - ldq     v0,24(fp)
+    // -4 - mov     v0,v0
+    // -3 - ldq     v0,40(v0)
+    // -2 - mov     v0,t12
+    // -1 - jsr     ra,(t12),0x200041476e4
+    //  0 - ldah    gp,0(ra)
+    if (((pcode[-5] & 0xFF000000) == 0xA4000000) &&
+	((pcode[-4] & 0xFF00FF00) == 0x47000400) &&
+	((pcode[-3] & 0xFF000000) == 0xA4000000) &&
+	((pcode[-2] & 0xFF00FF00) == 0x47000400) &&
+	((pcode[-1] & 0xFFFF0000) == 0x6B5B0000))
+      {
+	fp_disp = (pcode[-5] & 0xFFFF);
+	obj_disp = (pcode[-3] & 0xFFFF);
+
+	pobj = regs[15] + fp_disp;
+	obj = *pobj;
+	reg = 0;
+      }
+    else
+      g_assert_not_reached ();
+
+  *((gpointer*)(obj + obj_disp)) = addr;
 }
 
 void
Index: mono/mono/mini/inssel-alpha.brg
===================================================================
--- mono/mono/mini/inssel-alpha.brg	(revision 66558)
+++ mono/mono/mini/inssel-alpha.brg	(working copy)
@@ -512,4 +512,12 @@
         mono_bblock_add_inst (s->cbb, tree);
 }
 
+reg: CEE_LDIND_REF (OP_REGVAR),
+reg: CEE_LDIND_I (OP_REGVAR),
+reg: CEE_LDIND_I8 (OP_REGVAR),
+reg: CEE_LDIND_I4 (OP_REGVAR),
+reg: CEE_LDIND_U4 (OP_REGVAR) "0" {
+        state->reg1 = state->left->tree->dreg;
+        tree->dreg = state->reg1;
+}
 
Index: mono/mono/mini/mini-alpha.c
===================================================================
--- mono/mono/mini/mini-alpha.c	(revision 66558)
+++ mono/mono/mini/mini-alpha.c	(working copy)
@@ -82,6 +82,7 @@
 static int indent_level = 0;
 
 int mini_alpha_verbose_level = 0;
+static int bwx_supported = 0;
 
 static const char*const * ins_spec = alpha_desc;
 
@@ -446,6 +447,8 @@
   MonoInst *ins, *last_ins = NULL;
   ins = bb->code;
    
+  CFG_DEBUG(3) g_print ("ALPHA: PEEPHOLE pass\n");
+
   while (ins) 
     {	
       switch (ins->opcode) 
@@ -506,6 +509,7 @@
 	  break;
 
 	case OP_LOADI8_MEMBASE:
+	case OP_LOAD_MEMBASE:
           /*
            * Note: if reg1 = reg2 the load op is removed
            *
@@ -515,7 +519,9 @@
            * OP_STOREI8_MEMBASE_REG reg1, offset(basereg)
            * OP_MOVE reg1, reg2
            */
-          if (last_ins && (last_ins->opcode == OP_STOREI8_MEMBASE_REG) &&
+          if (last_ins &&
+	      (last_ins->opcode == OP_STOREI8_MEMBASE_REG ||
+		last_ins->opcode == OP_STORE_MEMBASE_REG) &&
               ins->inst_basereg == last_ins->inst_destbasereg &&
               ins->inst_offset == last_ins->inst_offset)
             {
@@ -1048,22 +1054,6 @@
 
            break;
 
-	   /*
-	     case OP_LOAD_MEMBASE:
-	     case OP_LOADI8_MEMBASE:
-	     if (!amd64_is_imm32 (ins->inst_offset)) 
-	     {
-	     
-	     NEW_INS (cfg, temp, OP_I8CONST);
-	     temp->inst_c0 = ins->inst_offset;
-	     temp->dreg = mono_regstate_next_int (cfg->rs);
-	     ins->opcode = OP_AMD64_LOADI8_MEMINDEX;
-	     ins->inst_indexreg = temp->dreg;
-	     }
-			 
-	     break;
-	   */
-
 	 case OP_STORE_MEMBASE_IMM:
 	 case OP_STOREI8_MEMBASE_IMM:
 	   if (ins->inst_imm != 0) 
@@ -1089,6 +1079,7 @@
 	   break;
 
          case OP_STOREI1_MEMBASE_IMM:
+	   if (ins->inst_imm != 0 || !bwx_supported)
              {
                MonoInst *temp;
                NEW_INS (cfg, temp, OP_ICONST);
@@ -1100,6 +1091,7 @@
            break;
 
          case OP_STOREI2_MEMBASE_IMM:
+           if (ins->inst_imm != 0 || !bwx_supported)
 	   {
 	     MonoInst *temp;
 	     NEW_INS (cfg, temp, OP_ICONST);
@@ -1199,6 +1191,19 @@
 	       ins->sreg2 = temp->dreg;
 	       ins->opcode = OP_LSHR;
 	     }
+	   break;
+         case OP_LSHL_IMM:
+           if (!alpha_is_imm(ins->inst_imm))
+             {
+               MonoInst *temp;
+               NEW_INS(cfg, temp, OP_ICONST);
+               temp->inst_c0 = ins->inst_imm;
+               temp->dreg = mono_regstate_next_int(cfg->rs);
+               ins->sreg2 = temp->dreg;
+               ins->opcode = OP_LSHL;
+             }
+           break;
+
 	 default:
 	   break;
 	 }
@@ -1482,8 +1487,21 @@
        // Save method
        alpha_stq(code, alpha_pv, alpha_fp,
                  (lmf_offset + G_STRUCT_OFFSET(MonoLMF, method)));
+     }
 
-     }
+   /* Save (global) regs */
+   offset = cfg->arch.reg_save_area_offset;
+
+   for (i = 0; i < MONO_MAX_IREGS; ++i)
+     if (ALPHA_IS_CALLEE_SAVED_REG (i) &&
+         (cfg->used_int_regs & (1 << i)) &&
+         !( ALPHA_ARGS_REGS & (1 << i)) )
+       {
+         alpha_stq(code, i, alpha_fp, offset);
+         CFG_DEBUG(3) g_print("ALPHA: Saved caller reg %d at offset: %0x\n",
+			      i, offset);
+         offset += 8;
+       }
    
    offset = cfg->arch.args_save_area_offset;
 
@@ -1505,31 +1523,46 @@
      {
        ArgInfo *ainfo = &cinfo->args [i];
        MonoInst *inst = cfg->varinfo [i];
+       int j;
 
        switch(ainfo->storage)
 	 {
 	 case ArgInIReg:
 	   // We need to save all used a0-a5 params
-	   //for (i=0; i<PARAM_REGS; i++)
-	   //  {
-	   //    if (i < cinfo->reg_usage)
 	   {
-	     //alpha_stq(code, ainfo->reg, alpha_fp, offset);
-	     alpha_stq(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
+	     if (inst->opcode == OP_REGVAR)
+	       {
+		 alpha_mov1(code, ainfo->reg, inst->dreg);
+		 CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d in reg %d\n",
+				      ainfo->reg, inst->dreg);
+	       }
+	     else
+	       {
+		 alpha_stq(code, ainfo->reg, inst->inst_basereg,
+			   inst->inst_offset);
 		   
-	     CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d at offset: %0lx\n",
-				  ainfo->reg, inst->inst_offset/*offset*/);
+		 CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d at offset: %0lx\n",
+				      ainfo->reg, inst->inst_offset);
 		   
-	     offset += 8;
+		 offset += 8;
+	       }
 	   }
-	   //}
 	   break;
+	 case ArgAggregate:
+	   {
+	     for(j=0; j<ainfo->nregs; j++)
+	       {
+		 CFG_DEBUG(3) g_print("ALPHA: Saved aggregate arg reg %d at offset: %0lx\n",
+				      ainfo->reg + j, inst->inst_offset + (8*j));
+		 alpha_stq(code, ainfo->reg+j, inst->inst_basereg,
+			   (inst->inst_offset + (8*j)));
+		 offset += 8;
+	       }
+	   }
+	   break;
 	 case ArgInDoubleReg:
 	 case ArgInFloatReg:
 	   // We need to save all used af0-af5 params
-	   //for (i=0; i<PARAM_REGS; i++)
-	   //  {
-	   //    if (i < cinfo->freg_usage)
 	   {
 	     switch(cinfo->args[i].storage)
 	       {
@@ -1554,7 +1587,8 @@
      }
 
    offset = cfg->arch.reg_save_area_offset;
-   
+
+   /*   
    for (i = 0; i < MONO_MAX_IREGS; ++i)
      if (ALPHA_IS_CALLEE_SAVED_REG (i) &&
 	 (cfg->used_int_regs & (1 << i)) &&
@@ -1565,7 +1599,7 @@
 		i, offset);
 	 offset += 8;
        }
-
+   */
    // TODO - check amd64 code for "Might need to attach the thread to the JIT"
 
    if (method->save_lmf)
@@ -1643,8 +1677,15 @@
 {
    /* FIXME: */
   CFG_DEBUG(2) ALPHA_DEBUG("mono_arch_regalloc_cost");
+  MonoInst *ins = cfg->varinfo [vmv->idx];
 
-  return 2;
+  if (cfg->method->save_lmf)
+    /* The register is already saved */
+    /* substract 1 for the invisible store in the prolog */
+    return (ins->opcode == OP_ARG) ? 1 : 0;
+  else
+    /* push+pop */
+    return (ins->opcode == OP_ARG) ? 2 : 1;
 }
 
 /*========================= End of Function ========================*/
@@ -2240,15 +2281,22 @@
 	   // Shift 64 bit value right
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shr] dreg=%d, sreg1=%d, sreg2=%d\n",
 		  ins->dreg, ins->sreg1, ins->sreg2);
-	   alpha_srl(code, ins->sreg1, ins->sreg2, ins->dreg);
+	   alpha_sra(code, ins->sreg1, ins->sreg2, ins->dreg);
 	   break;
 
+	case OP_LSHR_UN:
+	   // Shift 64 bit value right
+	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shr_un] dreg=%d, sreg1=%d, sreg2=%d\n",
+                  ins->dreg, ins->sreg1, ins->sreg2);
+           alpha_srl(code, ins->sreg1, ins->sreg2, ins->dreg);
+           break;
+
 	 case OP_LSHR_IMM:
 	   // Shift 64 bit value right by constant
 	   g_assert(alpha_is_imm(ins->inst_imm));
-	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shr] dreg=%d, sreg1=%d, const=%ld\n",
+	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shr_imm] dreg=%d, sreg1=%d, const=%ld\n",
 		  ins->dreg, ins->sreg1, ins->inst_imm);
-	   alpha_srl_(code, ins->sreg1, ins->inst_imm, ins->dreg);
+	   alpha_sra_(code, ins->sreg1, ins->inst_imm, ins->dreg);
 	   break;
 
 	 case OP_ISHL:
@@ -2273,6 +2321,14 @@
            alpha_sll_(code, ins->sreg1, ins->inst_imm, ins->dreg);
            break;
 
+         case OP_LSHL_IMM:
+           g_assert(alpha_is_imm(ins->inst_imm));
+           CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shl_imm] dreg=%d, sreg1=%d, const=%ld\n",
+                  ins->dreg, ins->sreg1, ins->inst_imm);
+           alpha_sll_(code, ins->sreg1, ins->inst_imm, ins->dreg);
+           break;
+
+
 	 case CEE_SHL:
            // Shift 32 bit value left
            CFG_DEBUG(4) g_print("ALPHA_CHECK: [shl] dreg=%d, sreg1=%d, sreg2=%d\n",
@@ -2280,7 +2336,14 @@
            alpha_sll(code, ins->sreg1, ins->sreg2, ins->dreg);
            break;
 
+         case OP_LSHL:
+           // Shift 64 bit value left
+           CFG_DEBUG(4) g_print("ALPHA_CHECK: [long_shl] dreg=%d, sreg1=%d, sreg2=%d\n",
+                  ins->dreg, ins->sreg1, ins->sreg2);
+           alpha_sll(code, ins->sreg1, ins->sreg2, ins->dreg);
+           break;
 
+
          case OP_ISHR:
            // Shift 32 bit value right
            CFG_DEBUG(4) g_print("ALPHA_CHECK: [int_shr] dreg=%d, sreg1=%d, sreg2=%d\n",
@@ -2709,10 +2772,15 @@
 	   // Load unassigned byte from REGOFFSET
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [loadu1_membase] dreg=%d, basereg=%d, offset=%0lx\n",
 		  ins->dreg, ins->inst_basereg, ins->inst_offset);
-
-	   alpha_ldq_u(code, alpha_r25, ins->inst_basereg, ins->inst_offset);
-	   alpha_lda(code, alpha_at, ins->inst_basereg, ins->inst_offset);
-	   alpha_extbl(code, alpha_r25, alpha_at, ins->dreg);
+	   if (bwx_supported)
+	     alpha_ldbu(code, ins->dreg, ins->inst_basereg, ins->inst_offset);
+	   else
+	     {
+	       alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
+			   ins->inst_offset);
+	       alpha_lda(code, alpha_at, ins->inst_basereg, ins->inst_offset);
+	       alpha_extbl(code, alpha_r25, alpha_at, ins->dreg);
+	     }
 	   break;
 	   
 	 case OP_LOADU2_MEMBASE:
@@ -2720,14 +2788,19 @@
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [loadu2_membase] dreg=%d, basereg=%d, offset=%0lx\n",
 		  ins->dreg, ins->inst_basereg, ins->inst_offset);
 
-           alpha_ldq_u(code, alpha_r24, ins->inst_basereg, ins->inst_offset);
-	   alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
-		       (ins->inst_offset+1));
-           alpha_lda(code, alpha_at, ins->inst_basereg, ins->inst_offset);
-           alpha_extwl(code, alpha_r24, alpha_at, ins->dreg);
-	   alpha_extwh(code, alpha_r25, alpha_at, alpha_r25);
-	   alpha_bis(code, alpha_r25, ins->dreg, ins->dreg);
-
+	   if (bwx_supported)
+	     alpha_ldwu(code, ins->dreg, ins->inst_basereg, ins->inst_offset);
+	   else
+	     {
+	       alpha_ldq_u(code, alpha_r24, ins->inst_basereg,
+			   ins->inst_offset);
+	       alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
+			   (ins->inst_offset+1));
+	       alpha_lda(code, alpha_at, ins->inst_basereg, ins->inst_offset);
+	       alpha_extwl(code, alpha_r24, alpha_at, ins->dreg);
+	       alpha_extwh(code, alpha_r25, alpha_at, alpha_r25);
+	       alpha_bis(code, alpha_r25, ins->dreg, ins->dreg);
+	     }
 	   break;
 	   
 	 case OP_LOAD_MEMBASE:
@@ -2752,71 +2825,104 @@
 	   // Load sign-extended byte from REGOFFSET
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [loadi1_membase] dreg=%d, basereg=%d, offset=%0lx\n",
 		  ins->dreg, ins->inst_basereg, ins->inst_offset);
-	   alpha_ldq_u(code, alpha_r25, ins->inst_basereg, ins->inst_offset);
-	   alpha_lda(code, alpha_at, ins->inst_basereg, (ins->inst_offset+1));
-	   alpha_extqh(code, alpha_r25, alpha_at, ins->dreg);
-	   alpha_sra_(code, ins->dreg, 56, ins->dreg);
+	   if (bwx_supported)
+	     {
+	       alpha_ldbu(code, ins->dreg, ins->inst_basereg,
+			  ins->inst_offset);
+	       alpha_sextb(code, ins->dreg, ins->dreg);
+	     }
+	   else
+	     {
+	       alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
+			   ins->inst_offset);
+	       alpha_lda(code, alpha_at, ins->inst_basereg,
+			 (ins->inst_offset+1));
+	       alpha_extqh(code, alpha_r25, alpha_at, ins->dreg);
+	       alpha_sra_(code, ins->dreg, 56, ins->dreg);
+	     }
 	   break;
 	   
 	 case OP_LOADI2_MEMBASE:
 	   // Load sign-extended word from REGOFFSET
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [loadi2_membase] dreg=%d, basereg=%d, offset=%0lx\n",
 		  ins->dreg, ins->inst_basereg, ins->inst_offset);
-           alpha_ldq_u(code, alpha_r24, ins->inst_basereg, ins->inst_offset);
-           alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
-		       (ins->inst_offset+1));
-           alpha_lda(code, alpha_at, ins->inst_basereg, (ins->inst_offset+2));
-           alpha_extql(code, alpha_r24, alpha_at, ins->dreg);
-           alpha_extqh(code, alpha_r25, alpha_at, alpha_r25);
-           alpha_bis(code, alpha_r25, ins->dreg, ins->dreg);
-	   alpha_sra_(code, ins->dreg, 48, ins->dreg);
-	   
+	   if (bwx_supported)
+	     {
+	       alpha_ldwu(code, ins->dreg, ins->inst_basereg,
+			  ins->inst_offset);
+	       alpha_sextw(code, ins->dreg, ins->dreg);
+	     }
+	   else
+	     {
+	       alpha_ldq_u(code, alpha_r24, ins->inst_basereg,
+			   ins->inst_offset);
+	       alpha_ldq_u(code, alpha_r25, ins->inst_basereg,
+			   (ins->inst_offset+1));
+	       alpha_lda(code, alpha_at, ins->inst_basereg,
+			 (ins->inst_offset+2));
+	       alpha_extql(code, alpha_r24, alpha_at, ins->dreg);
+	       alpha_extqh(code, alpha_r25, alpha_at, alpha_r25);
+	       alpha_bis(code, alpha_r25, ins->dreg, ins->dreg);
+	       alpha_sra_(code, ins->dreg, 48, ins->dreg);
+	     }
 	   break;			 
 	   
 	 case OP_STOREI1_MEMBASE_IMM:
 	   // Store signed byte at REGOFFSET
-	   // For now storei1_membase_reg will do the work
-	   g_assert_not_reached();
-	   /*
-	   printf("ALPHA_TODO: [storei1_membase_imm] const=%0lx, destbasereg=%d, offset=%0lx\n",
+	   // Valid only for storing 0
+	   // storei1_membase_reg will do the rest
+	   
+	   CFG_DEBUG(4) g_printf("ALPHA_CHECK: [storei1_membase_imm(0)] const=%0lx, destbasereg=%d, offset=%0lx\n",
 		  ins->inst_imm, ins->inst_destbasereg, ins->inst_offset);
-	   g_assert(alpha_is_imm(ins->inst_imm));
+	   g_assert(ins->inst_imm == 0);
 
-	   alpha_lda(code, alpha_r25, alpha_zero, ins->inst_imm);
+	   if (bwx_supported)
+		alpha_stb(code, alpha_zero, ins->inst_destbasereg,
+			ins->inst_offset);
+	   else
+		g_assert_not_reached();
 
-	   alpha_lda(code, alpha_at, ins->inst_destbasereg, ins->inst_offset);
-	   alpha_ldq_u(code, alpha_r24, ins->inst_destbasereg, ins->inst_offset);
-	   alpha_insbl(code, alpha_r25, alpha_at, alpha_r23);
-	   alpha_mskbl(code, alpha_r24, alpha_at, alpha_r24);
-	   alpha_bis(code, alpha_r24, alpha_r23, alpha_r24);
-	   alpha_stq_u(code, alpha_r24, ins->inst_destbasereg, ins->inst_offset);
-	   */
 	   break;
 
 	 case OP_STOREI1_MEMBASE_REG:
 	   // Store byte at REGOFFSET
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [storei1_membase_reg] sreg1=%d, destbasereg=%d, offset=%0lx\n",
 		  ins->sreg1, ins->inst_destbasereg, ins->inst_offset);
-
-           alpha_lda(code, alpha_at, ins->inst_destbasereg, ins->inst_offset);
-           alpha_ldq_u(code, alpha_r25, ins->inst_destbasereg,
-		       ins->inst_offset);
-           alpha_insbl(code, ins->sreg1, alpha_at, alpha_r24);
-           alpha_mskbl(code, alpha_r25, alpha_at, alpha_r25);
-           alpha_bis(code, alpha_r25, alpha_r24, alpha_r25);
-           alpha_stq_u(code, alpha_r25, ins->inst_destbasereg,
-		       ins->inst_offset);
-
+	   if (bwx_supported)
+	     {
+	       alpha_stb(code, ins->sreg1, ins->inst_destbasereg,
+			 ins->inst_offset);
+	     }
+	   else
+	     {
+	       alpha_lda(code, alpha_at, ins->inst_destbasereg,
+			 ins->inst_offset);
+	       alpha_ldq_u(code, alpha_r25, ins->inst_destbasereg,
+			   ins->inst_offset);
+	       alpha_insbl(code, ins->sreg1, alpha_at, alpha_r24);
+	       alpha_mskbl(code, alpha_r25, alpha_at, alpha_r25);
+	       alpha_bis(code, alpha_r25, alpha_r24, alpha_r25);
+	       alpha_stq_u(code, alpha_r25, ins->inst_destbasereg,
+			   ins->inst_offset);
+	     }
 	   break;
 	   
 	 case OP_STOREI2_MEMBASE_IMM:
            // Store signed word at REGOFFSET
+	   // Now work only for storing 0
            // For now storei2_membase_reg will do the work
-           g_assert_not_reached();
-	   /*
-	   printf("ALPHA_TODO: [storei2_membase_imm] const=%0lx, destbasereg=%d, offset=%0lx\n",
+	   
+	   CFG_DEBUG(4) g_printf("ALPHA_CHECK: [storei2_membase_imm(0)] const=%0lx, destbasereg=%d, offset=%0lx\n",
 		  ins->inst_imm, ins->inst_destbasereg, ins->inst_offset);
-	   */
+	   
+	   g_assert(ins->inst_imm == 0);
+	   
+	   if (bwx_supported)
+	   	alpha_stw(code, alpha_zero, ins->inst_destbasereg,
+			ins->inst_offset);
+	   else
+		g_assert_not_reached();
+
 	   break;
 	   
 	 case OP_STOREI2_MEMBASE_REG:
@@ -2824,21 +2930,30 @@
            CFG_DEBUG(4) g_print("ALPHA_CHECK: [storei2_membase_reg] sreg1=%d, destbasereg=%d, offset=%0lx\n",
                   ins->sreg1, ins->inst_destbasereg, ins->inst_offset);
 	   
-	   alpha_lda(code, alpha_at, ins->inst_destbasereg, ins->inst_offset);
-	   alpha_ldq_u(code, alpha_r25, ins->inst_destbasereg,
-		       (ins->inst_offset+1));
-	   alpha_ldq_u(code, alpha_r24, ins->inst_destbasereg,
-		       ins->inst_offset);
-	   alpha_inswh(code, ins->sreg1, alpha_at, alpha_r23);
-	   alpha_inswl(code, ins->sreg1, alpha_at, alpha_r22);
-	   alpha_mskwh(code, alpha_r25, alpha_at, alpha_r25);
-	   alpha_mskwl(code, alpha_r24, alpha_at, alpha_r24);
-	   alpha_bis(code, alpha_r25, alpha_r23, alpha_r25);
-	   alpha_bis(code, alpha_r24, alpha_r22, alpha_r24);
-	   alpha_stq_u(code, alpha_r25, ins->inst_destbasereg,
-		       (ins->inst_offset+1));
-	   alpha_stq_u(code, alpha_r24, ins->inst_destbasereg,
-                       ins->inst_offset);
+	   if (bwx_supported)
+	     {
+	       alpha_stw(code, ins->sreg1, ins->inst_destbasereg,
+			 ins->inst_offset);
+	     }
+	   else
+	     {
+	       alpha_lda(code, alpha_at, ins->inst_destbasereg,
+			 ins->inst_offset);
+	       alpha_ldq_u(code, alpha_r25, ins->inst_destbasereg,
+			   (ins->inst_offset+1));
+	       alpha_ldq_u(code, alpha_r24, ins->inst_destbasereg,
+			   ins->inst_offset);
+	       alpha_inswh(code, ins->sreg1, alpha_at, alpha_r23);
+	       alpha_inswl(code, ins->sreg1, alpha_at, alpha_r22);
+	       alpha_mskwh(code, alpha_r25, alpha_at, alpha_r25);
+	       alpha_mskwl(code, alpha_r24, alpha_at, alpha_r24);
+	       alpha_bis(code, alpha_r25, alpha_r23, alpha_r25);
+	       alpha_bis(code, alpha_r24, alpha_r22, alpha_r24);
+	       alpha_stq_u(code, alpha_r25, ins->inst_destbasereg,
+			   (ins->inst_offset+1));
+	       alpha_stq_u(code, alpha_r24, ins->inst_destbasereg,
+			   ins->inst_offset);
+	     }
 
 	   break;
 	   
@@ -3164,18 +3279,28 @@
 	   // Read about sextb
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [conv_i1] sreg=%d, dreg=%d\n",
 		  ins->sreg1, ins->dreg);
-           alpha_sll_(code, ins->sreg1, 24, alpha_at);
-           alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
-           alpha_sra_(code, ins->dreg, 24, ins->dreg);
+	   if (bwx_supported)
+	     alpha_sextb(code, ins->sreg1, ins->dreg);
+	   else
+	     {
+	       alpha_sll_(code, ins->sreg1, 24, alpha_at);
+	       alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
+	       alpha_sra_(code, ins->dreg, 24, ins->dreg);
+	     }
 	   break;
 
 	 case CEE_CONV_I2:
 	   // Move I2 (word) to dreg(64 bits) and sign extend it
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [conv_i2] sreg=%d, dreg=%d\n",
 		  ins->sreg1, ins->dreg);
-	   alpha_sll_(code, ins->sreg1, 16, alpha_at);
-	   alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
-	   alpha_sra_(code, ins->dreg, 16, ins->dreg);
+	   if (bwx_supported)
+	     alpha_sextw(code, ins->sreg1, ins->dreg);
+	   else
+	     {
+	       alpha_sll_(code, ins->sreg1, 16, alpha_at);
+	       alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
+	       alpha_sra_(code, ins->dreg, 16, ins->dreg);
+	     }
 	   break;
 	   
 	 case CEE_CONV_I4:
@@ -3325,7 +3450,7 @@
 	   // Allocate sreg1 bytes on stack, round bytes by 8,
 	   // modify SP, set dreg to end of current stack frame
 	   // top of stack is used for call params
-	   CFG_DEBUG(4) g_print("ALPHA_FIX: [localloc] sreg=%d, dreg=%d\n",
+	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [localloc] sreg=%d, dreg=%d\n",
 				ins->sreg1, ins->dreg);
 	   alpha_addq_(code, ins->sreg1, (MONO_ARCH_FRAME_ALIGNMENT - 1), ins->sreg1);
 	   alpha_and_(code, ins->sreg1, ~(MONO_ARCH_FRAME_ALIGNMENT - 1), ins->sreg1);
@@ -3656,7 +3781,7 @@
 	   break;
 
 	 case CEE_ENDFINALLY:
-	{
+	   {
              // Keep in sync with start_handler
              CFG_DEBUG(4) g_print("ALPHA_CHECK: [endfinally] basereg=%d, offset=%0x\n",
                 ins->inst_left->inst_basereg, ins->inst_left->inst_offset);
@@ -3666,8 +3791,8 @@
 
              alpha_ret(code, alpha_ra, 1);
 
-	}
-	break;
+	   }
+	   break;
 	 case OP_ENDFILTER:
 	   {
 	     // Keep in sync with start_handler
@@ -3697,7 +3822,6 @@
 				  MONO_PATCH_INFO_BB,
 				  ins->inst_target_bb);
 	     alpha_bsr(code, alpha_ra, 0);
-
 	   }
 	   break;
 	   
@@ -3735,7 +3859,8 @@
 
 	     /* FIXME: no tracing support... */
 	     if (cfg->prof_options & MONO_PROFILE_ENTER_LEAVE)
-	       code = mono_arch_instrument_epilog (cfg, mono_profiler_method_leave, code, FALSE);
+	       code = mono_arch_instrument_epilog (cfg,
+				   mono_profiler_method_leave, code, FALSE);
 	     g_assert (!cfg->method->save_lmf);
 
 	     alpha_mov1( code, alpha_fp, alpha_sp );
@@ -4198,7 +4323,20 @@
 void
 mono_arch_cpu_init (void)
 {
-   ALPHA_DEBUG("mono_arch_cpu_init");
+  unsigned long amask, implver;
+  register long v0 __asm__("$0") = -1;
+ 
+  ALPHA_DEBUG("mono_arch_cpu_init");
+
+  __asm__ (".long 0x47e00c20" : "=r"(v0) : "0"(v0));
+  amask = ~v0;
+  __asm__ (".long 0x47e03d80" : "=r"(v0));
+  implver = v0;
+
+  if (amask & 1)
+    bwx_supported = 1;
+
+  //printf("amask: %x, implver: %x", amask, implver);
 }
 
 
@@ -4886,9 +5024,9 @@
    
    CFG_DEBUG(2) ALPHA_DEBUG("mono_arch_get_global_int_regs");
    
-   regs = g_list_prepend (regs, (gpointer)alpha_r9);
-   regs = g_list_prepend (regs, (gpointer)alpha_r10);
-   regs = g_list_prepend (regs, (gpointer)alpha_r11);
+//   regs = g_list_prepend (regs, (gpointer)alpha_r9);
+//   regs = g_list_prepend (regs, (gpointer)alpha_r10);
+//   regs = g_list_prepend (regs, (gpointer)alpha_r11);
    regs = g_list_prepend (regs, (gpointer)alpha_r12);
    regs = g_list_prepend (regs, (gpointer)alpha_r13);
    regs = g_list_prepend (regs, (gpointer)alpha_r14);
@@ -5546,14 +5684,25 @@
 
    CFG_DEBUG(3) g_print ("ALPHA: args_save_area_offset at %d(%x)\n", offset, offset);
 
-   // Consider floats passed in regs too
-   for (i = 0; i < (PARAM_REGS*2); ++i)
-     if (i < (sig->param_count + sig->hasthis))
-	 //(cfg->used_int_regs & (1 << param_regs[i])))
-       {
-	 offset += sizeof (gpointer);
-       }
+   for (i = 0; i < sig->param_count + sig->hasthis; ++i)
+     {
+       ArgInfo *ainfo = &cinfo->args [i];
 
+       switch(ainfo->storage)
+	 {
+	 case ArgInIReg:
+	 case ArgInFloatReg:
+	 case ArgInDoubleReg:
+	   offset += sizeof (gpointer);
+	   break;
+	 case ArgAggregate:
+	   offset += ainfo->nregs * sizeof (gpointer);
+	   break;
+	 default:
+	   ;
+	 }
+     }
+
    CFG_DEBUG(3) g_print ("ALPHA: Stack size is %d(%x)\n",
 			  offset, offset);
    
Index: mono/mono/mini/mini-alpha.h
===================================================================
--- mono/mono/mini/mini-alpha.h	(revision 66558)
+++ mono/mono/mini/mini-alpha.h	(working copy)
@@ -50,9 +50,6 @@
   gint32 params_stack_size;  // Stack size reserved for call params by this compile method
 
   gpointer    got_data;
- 
-//  gpointer    litpool;
-//  glong       litsize;
   glong       bwx;
 } MonoCompileArch;
 
@@ -74,7 +71,12 @@
 
 // Regs available for allocation in compile unit
 // For Alpha: r1-r14, r22-r25
-#define MONO_ARCH_CALLEE_REGS	((regmask_t)0x03C07FFF)
+// 1111 1111 1111 1111 1111 1111 1111 1111
+//  098 7654 3210 9876 5432 1098 7654 3210
+// RRRR RRLL LLAA AAAA RLLL LLLL LLLL LLLL - No global regs
+// RRRR RRLL LLAA AAAA RGGG LLLL LLLL LLLL - 3 global regs
+//#define MONO_ARCH_CALLEE_REGS	((regmask_t)0x03C07FFF)
+#define MONO_ARCH_CALLEE_REGS ((regmask_t)0x03C00FFF)
 #define MONO_ARCH_CALLEE_FREGS	((regmask_t)0x03C07FFF)
 
 // These are the regs that are considered global
@@ -86,8 +88,8 @@
 // For Alpha - r9-r14. Actually later we could use some of the
 // upper "t" regs, since local reg allocator doesn't like registers
 // very much, so we could safely keep vars in them
-//#define MONO_ARCH_CALLEE_SAVED_REGS ((regmask_t)0xFC0080000)
-#define MONO_ARCH_CALLEE_SAVED_REGS ((regmask_t)0x3C00FE00)
+//#define MONO_ARCH_CALLEE_SAVED_REGS ((regmask_t)0x3C00FE00)
+#define MONO_ARCH_CALLEE_SAVED_REGS ((regmask_t)0x3C00F000)
 #define MONO_ARCH_CALLEE_SAVED_FREGS 0
 
 #define ALPHA_IS_CALLEE_SAVED_REG(reg) (MONO_ARCH_CALLEE_SAVED_REGS & (1 << (reg)))
@@ -112,7 +114,7 @@
 #define MONO_ARCH_USE_SIGACTION 1
 
 /* Use prerefered create trampoline callback method */
-#define MONO_ARCH_HAVE_CREATE_SPECIFIC_TRAMPOLINE
+#define MONO_ARCH_HAVE_CREATE_SPECIFIC_TRAMPOLINE 1
 
 //#define MONO_ARCH_INST_FIXED_REG(desc) ((desc == 'r') ? IA64_R8 : ((desc == 'g') ? 8 : -1))
 //#define MONO_ARCH_INST_IS_FLOAT(desc) ((desc == 'f') || (desc == 'g'))
@@ -125,8 +127,6 @@
 //#define MONO_ARCH_INST_FIXED_REG(desc)	(-1)
 #define MONO_ARCH_INST_FIXED_REG(desc)  ((desc == 'o') ? alpha_at : ( (desc == 'a') ? alpha_r0 : -1) )
 
-//#define MONO_ARCH_IS_GLOBAL_IREG(reg) (is_hard_ireg (reg) && ((reg) >= cfg->arch.reg_local0) && ((reg) < cfg->arch.reg_out0))
-
 #define MONO_ARCH_HAVE_CREATE_VARS 1
 
 #if 0
@@ -277,22 +277,20 @@
 
 unw_dyn_region_info_t* mono_ia64_create_unwind_region (Ia64CodegenState *code);
 
-#define MONO_ARCH_NO_EMULATE_LONG_SHIFT_OPS 1
 #define MONO_ARCH_NO_EMULATE_MUL_IMM 1
 
 #define MONO_ARCH_HAVE_IS_INT_OVERFLOW 1
 
-#define MONO_ARCH_ENABLE_EMIT_STATE_OPT 1
 #define MONO_ARCH_HAVE_INVALIDATE_METHOD 1
-#define MONO_ARCH_HAVE_THROW_CORLIB_EXCEPTION 1
 #define MONO_ARCH_HAVE_PIC_AOT 1
-#define MONO_ARCH_HAVE_CREATE_TRAMPOLINE_FROM_TOKEN 1
-#define MONO_ARCH_HAVE_CREATE_SPECIFIC_TRAMPOLINE 1
-#define MONO_ARCH_HAVE_CREATE_DELEGATE_TRAMPOLINE 1
 #define MONO_ARCH_HAVE_SAVE_UNWIND_INFO 1
 
 #endif
 
+#define MONO_ARCH_ENABLE_EMIT_STATE_OPT 1
+
+#define MONO_ARCH_NO_EMULATE_LONG_SHIFT_OPS 1
+
 #define MONO_ARCH_HAVE_THROW_CORLIB_EXCEPTION 1
 
 #define MONO_ARCH_EMULATE_CONV_R8_UN     1
Index: mono/mono/arch/alpha/alpha-codegen.h
===================================================================
--- mono/mono/arch/alpha/alpha-codegen.h	(revision 66543)
+++ mono/mono/arch/alpha/alpha-codegen.h	(working copy)
@@ -516,6 +516,9 @@
 #define alpha_mulq(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_op( ins, 0x13, 0x20, Rsrc1, Rsrc2, Rdest )
 #define alpha_mulq_(ins,  Rsrc1, lit, Rdest) alpha_encode_op( ins, 0x13, 0x20, Rsrc1, lit, Rdest )
 
+#define	alpha_sextb(ins, Rsrc2, Rdest) alpha_encode_op( ins, 0x1c, 0x00, alpha_zero, Rsrc2, Rdest )
+#define alpha_sextw(ins, Rsrc2, Rdest) alpha_encode_op( ins, 0x1c, 0x01, alpha_zero, Rsrc2, Rdest )
+
 // For 264 
 #define alpha_ftois( ins, RFsrc, Rdest ) alpha_encode_fpop( ins, 0x1c, 0x078, RFsrc, alpha_zero, Rdest ) 
 #define alpha_ftoit( ins, RFsrc, Rdest ) alpha_encode_fpop( ins, 0x1c, 0x070, RFsrc, alpha_zero, Rdest )
