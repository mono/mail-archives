Index: mono/mono/mini/exceptions-alpha.c
===================================================================
--- mono/mono/mini/exceptions-alpha.c	(revision 65271)
+++ mono/mono/mini/exceptions-alpha.c	(working copy)
@@ -310,6 +310,7 @@
   /* Exception is in a0 already */
   alpha_mov1(code, alpha_ra, alpha_a1);  // Return address
   alpha_mov1(code, alpha_sp, alpha_a2);  // Stack pointer
+
   if (rethrow)
     alpha_lda(code, alpha_a3, alpha_zero, 1);
   else
@@ -746,6 +747,7 @@
 {
   static guint8 *start;
   static int inited = 0;
+  unsigned int *code;
   
   if (inited)
     return start;
@@ -754,6 +756,10 @@
   //        get_throw_exception_generic (start, SZ_THROW, TRUE, FALSE);
   inited = 1;
 
+  code = (unsigned int *)start;
+
+  alpha_call_pal(code, 0x80);
+
   return start;
 }
 /*========================= End of Function ========================*/
@@ -912,9 +918,12 @@
 	  /* Some how we should find size of frame. One way:
 	   read 3rd instruction (alpha_lda(alpha_sp, alpha_sp, -stack_size ))
 	   and extract "stack_size" from there
+	   read 4th and 5th insts to get offsets to saved RA & FP
 	  */
 	  unsigned int *code = (unsigned int *)ji->code_start;
 	  short stack_size = -((short)(code[2] & 0xFFFF));
+	  short ra_off = code[3] & 0xFFFF;
+	  short fp_off = code[4] & 0xFFFF;
 
 	  /* Restore stack - value of FP reg + stack_size */
 	  new_ctx->uc_mcontext.sc_regs[alpha_sp] =
@@ -923,11 +932,11 @@
 	  /* we substract 1, so that the IP points into the call instruction */
 	  /* restore PC - @FP + 0 */
 	  new_ctx->uc_mcontext.sc_pc = 
-	    *((guint64 *)ctx->uc_mcontext.sc_regs[alpha_r15]);
+	    *((guint64 *)(ctx->uc_mcontext.sc_regs[alpha_r15] + ra_off));
 	  
 	  /* Restore FP reg - @FP + 8 */
 	  new_ctx->uc_mcontext.sc_regs[alpha_r15] = 
-	    *((guint64 *)(ctx->uc_mcontext.sc_regs[alpha_r15] + 8));
+	    *((guint64 *)(ctx->uc_mcontext.sc_regs[alpha_r15] + fp_off));
 
 	  /* Restore GP - read two insts that restore GP from sc_pc and */
 	  /* do the same. Use sc_pc as RA */
@@ -945,7 +954,10 @@
 	    }
 	}
 
+#if 0
       /* Pop arguments off the stack */
+      // No poping args off stack on Alpha
+      // We use fixed place
       {
 	MonoJitArgumentInfo *arg_info =
 	  g_newa (MonoJitArgumentInfo,
@@ -957,7 +969,7 @@
 				       arg_info);
 	new_ctx->uc_mcontext.sc_regs[alpha_sp] += stack_to_pop;
       }
-
+#endif
       return ji;
     }
   else if (*lmf)
Index: mono/mono/mini/cpu-alpha.md
===================================================================
--- mono/mono/mini/cpu-alpha.md	(revision 65271)
+++ mono/mono/mini/cpu-alpha.md	(working copy)
@@ -57,7 +57,7 @@
 arg:
 arglist:
 break: len:4
-jmp: len:4
+jmp: len:48
 br: len:4
 beq: len:4
 bge: len:4
@@ -99,8 +99,8 @@
 shr.un: dest:i src1:i src2:s len:8
 neg: dest:i src1:i len:4
 not: dest:i src1:i len:4
-conv.i1: dest:i src1:i len:4
-conv.i2: dest:i src1:i len:4
+conv.i1: dest:i src1:i len:12
+conv.i2: dest:i src1:i len:12
 conv.i4: dest:i src1:i len:4
 conv.i8: dest:i src1:i len:4
 conv.r4: dest:f src1:i len:20
@@ -126,7 +126,7 @@
 cgt.un: dest:c len:8
 clt: dest:c len:8
 clt.un: dest:c len:8
-localloc: dest:i src1:i len:84
+localloc: dest:i src1:i len:20
 compare: src1:i src2:i len:4
 lcompare: src1:i src2:i len:4
 icompare: src1:i src2:i len:4
@@ -304,7 +304,7 @@
 call_handler: len:4
 start_handler: len:96
 endfinally: len:96
-op_endfilter: len:96
+op_endfilter: src1:i len:96
 aot_const: dest:i len:10
 # x86_test_null: src1:i len:5
 # x86_compare_membase_reg: src1:b src2:i len:9
Index: mono/mono/mini/tramp-alpha.c
===================================================================
--- mono/mono/mini/tramp-alpha.c	(revision 65271)
+++ mono/mono/mini/tramp-alpha.c	(working copy)
@@ -625,3 +625,25 @@
         g_assert_not_reached ();
 }
 
+/*
+ * This method is only called when running in the Mono Debugger.
+ */
+guint8 *
+mono_debugger_create_notification_function (MonoCodeManager *codeman)
+{
+  guint8 *code;
+  unsigned int *buf;
+
+  code = mono_code_manager_reserve (codeman, 16);
+  buf = (unsigned int *)code;
+
+  *buf = 0;
+
+  alpha_call_pal(buf, 0x80);
+  alpha_ret(buf, alpha_ra, 1);
+  //x86_breakpoint (buf);
+  //x86_ret (buf);
+
+  return code;
+}
+
Index: mono/mono/mini/inssel-alpha.brg
===================================================================
--- mono/mono/mini/inssel-alpha.brg	(revision 65271)
+++ mono/mono/mini/inssel-alpha.brg	(working copy)
@@ -187,35 +187,24 @@
 }
 
 stmt: OP_START_HANDLER {
-        /*MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
-        MONO_EMIT_NEW_STORE_MEMBASE (s, OP_STORE_MEMBASE_REG,
-		spvar->inst_basereg, spvar->inst_offset, alpha_sp);
-	tree->inst_left = spvar; */
+        MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
+	tree->inst_left = spvar;
 	mono_bblock_add_inst (s->cbb, tree);
 }
 
-stmt: OP_ENDFILTER (reg) {
-        /*MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
-        MONO_EMIT_NEW_UNALU (s, OP_MOVE, alpha_r0, state->left->reg1);
-        MONO_EMIT_NEW_LOAD_MEMBASE (s, alpha_sp, spvar->inst_basereg,
-		spvar->inst_offset);
-        tree->opcode = CEE_RET;
-	tree->inst_left = spvar;
-	tree->sreg1 = state->left->reg1;*/
+stmt: CEE_ENDFINALLY {
+        MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
+        tree->inst_left = spvar;
         mono_bblock_add_inst (s->cbb, tree);
 }
 
-stmt: CEE_ENDFINALLY {
-        /*MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
-        MONO_EMIT_NEW_LOAD_MEMBASE (s, alpha_sp, spvar->inst_basereg,
-		spvar->inst_offset);
-        tree->opcode = CEE_RET;
-	tree->inst_left = spvar; */
+stmt: OP_ENDFILTER (reg) {
+        MonoInst *spvar = mono_find_spvar_for_region (s, s->cbb->region);
+	tree->inst_left = spvar;
+	tree->sreg1 = state->left->reg1;
         mono_bblock_add_inst (s->cbb, tree);
 }
 
-
-
 stmt: CEE_SWITCH (reg) {
         MonoInst *label;
         int offset_reg = mono_regstate_next_int (s->rs);
@@ -497,6 +486,18 @@
         mono_bblock_add_inst (s->cbb, tree);
 }
 
+reg: OP_LCONV_TO_I4 (reg) "0" {
+        /* Sign extend the value in the lower word into the upper word */
+        MONO_EMIT_BIALU_IMM (s, tree, CEE_CONV_I4, state->reg1,
+		state->left->reg1, 0);
+}
+
+reg: OP_LCONV_TO_U4 (reg) "0" {
+        /* Clean out the upper word */
+        MONO_EMIT_BIALU_IMM (s, tree, CEE_CONV_U4, state->reg1,
+		state->left->reg1, 0);
+}
+
 freg: OP_LCONV_TO_R8 (reg) {
         /* FIXME: Move this inssel-long.brg */
         tree->sreg1 = state->left->reg1;
Index: mono/mono/mini/mini-alpha.c
===================================================================
--- mono/mono/mini/mini-alpha.c	(revision 65271)
+++ mono/mono/mini/mini-alpha.c	(working copy)
@@ -39,7 +39,6 @@
 #define DEBUG(a) if (cfg->verbose_level > 1) a
 
 #define CFG_DEBUG(LVL) if (cfg->verbose_level > LVL)
-//#define CFG_DEBUG(LVL) if (mini_alpha_verbose_level > LVL)
 
 //#define ALPHA_IS_CALLEE_SAVED_REG(reg) (MONO_ARCH_CALLEE_SAVED_REGS & (1 << (reg)))
 #define ALPHA_ARGS_REGS ((regmask_t)0x03F0000)
@@ -476,6 +475,102 @@
 	    }
 	  
 	  break;
+
+	case OP_LOADI8_MEMBASE:
+          /*
+           * Note: if reg1 = reg2 the load op is removed
+           *
+           * OP_STOREI8_MEMBASE_REG reg1, offset(basereg)
+           * OP_LOADI8_MEMBASE offset(basereg), reg2
+           * -->
+           * OP_STOREI8_MEMBASE_REG reg1, offset(basereg)
+           * OP_MOVE reg1, reg2
+           */
+          if (last_ins && (last_ins->opcode == OP_STOREI8_MEMBASE_REG) &&
+              ins->inst_basereg == last_ins->inst_destbasereg &&
+              ins->inst_offset == last_ins->inst_offset)
+            {
+              if (ins->dreg == last_ins->sreg1)
+                {
+                  last_ins->next = ins->next;
+
+                  ins = ins->next;
+                  continue;
+                }
+              else
+                {
+                  //static int c = 0; printf ("MATCHX %s %d\n", cfg->method->name,c++);
+                  ins->opcode = OP_MOVE;
+                  ins->sreg1 = last_ins->sreg1;
+                }
+            }
+	  break;
+
+#if 0
+       	case OP_LOAD_MEMBASE:
+	case OP_LOADI4_MEMBASE:
+	  /*
+	   * Note: if reg1 = reg2 the load op is removed
+	   *
+	   * OP_STORE_MEMBASE_REG reg1, offset(basereg)
+	   * OP_LOAD_MEMBASE offset(basereg), reg2
+	   * -->
+	   * OP_STORE_MEMBASE_REG reg1, offset(basereg)
+	   * OP_MOVE reg1, reg2
+	   */
+	  if (last_ins && (last_ins->opcode == OP_STOREI4_MEMBASE_REG
+			   /*|| last_ins->opcode == OP_STORE_MEMBASE_REG*/) &&
+	      ins->inst_basereg == last_ins->inst_destbasereg &&
+	      ins->inst_offset == last_ins->inst_offset)
+	    {
+	      if (ins->dreg == last_ins->sreg1)
+		{
+		  last_ins->next = ins->next;
+
+		  ins = ins->next;
+		  continue;
+		}
+	      else
+		{
+		  //static int c = 0; printf ("MATCHX %s %d\n", cfg->method->name,c++);
+		  ins->opcode = OP_MOVE;
+		  ins->sreg1 = last_ins->sreg1;
+		}
+	    }
+	  /*
+	   * Note: reg1 must be different from the basereg in the second load
+	   * Note: if reg1 = reg2 is equal then second load is removed
+	   *
+	   * OP_LOAD_MEMBASE offset(basereg), reg1
+	   * OP_LOAD_MEMBASE offset(basereg), reg2
+	   * -->
+	   * OP_LOAD_MEMBASE offset(basereg), reg1
+	   * OP_MOVE reg1, reg2
+	   */
+
+	  if (last_ins && (last_ins->opcode == OP_LOADI4_MEMBASE
+			   || last_ins->opcode == OP_LOAD_MEMBASE) &&
+	      ins->inst_basereg != last_ins->dreg &&
+	      ins->inst_basereg == last_ins->inst_basereg &&
+	      ins->inst_offset == last_ins->inst_offset)
+	    {
+	      if (ins->dreg == last_ins->dreg)
+		{
+		  last_ins->next = ins->next;
+		  
+		  ins = ins->next;
+		  continue;
+		}
+	      else
+		{
+		  ins->opcode = OP_MOVE;
+		  ins->sreg1 = last_ins->dreg;
+		}
+
+	      //g_assert_not_reached ();
+	    }
+	  break;      
+#endif
 	}
       
       last_ins = ins;
@@ -1198,50 +1293,104 @@
         ret zero,(ra),1
 */
 
-
-static void calculate_size(MonoMethodSignature *sig, int * INSTRUCTIONS,
-						   int * STACK )
+/*
+ * emit_load_volatile_arguments:
+ *
+ *  Load volatile arguments from the stack to the original input registers.
+ * Required before a tail call.
+ */
+static unsigned int*
+emit_load_volatile_arguments (MonoCompile *cfg, unsigned int *code)
 {
-   int alpharegs;
-   
-   alpharegs = AXP_GENERAL_REGS - (sig->hasthis?1:0);
-   
-   *STACK        = AXP_MIN_STACK_SIZE;
-   *INSTRUCTIONS = 20;  // Base: 20 instructions.
-   
-   if( sig->param_count - alpharegs > 0 )
-     {
-       *STACK += 1 * (sig->param_count - alpharegs );
-       // plus 3 (potential) for each stack parameter.
-       *INSTRUCTIONS += ( sig->param_count - alpharegs ) * 3;
-       // plus 2 (potential) for each register parameter.
-       *INSTRUCTIONS += ( alpharegs * 2 );
-     }
-   else
-     {
-       // plus 2 (potential) for each register parameter.
-       *INSTRUCTIONS += ( sig->param_count * 2 );
-     }
-}
+  MonoMethod *method = cfg->method;
+  MonoMethodSignature *sig;
+  MonoInst *inst;
+  CallInfo *cinfo;
+  guint32 i;
 
-//*****
+  /* FIXME: Generate intermediate code instead */
 
+  sig = mono_method_signature (method);
 
+  cinfo = get_call_info (sig, FALSE);
+
+  if (sig->ret->type != MONO_TYPE_VOID) {
+    if ((cinfo->ret.storage == ArgInIReg) &&
+	(cfg->ret->opcode != OP_REGVAR))
+      {
+	alpha_ldq(code, cinfo->ret.reg, cfg->ret->inst_basereg,
+		  cfg->ret->inst_offset);
+      }
+  }
+
+  for (i = 0; i < sig->param_count + sig->hasthis; ++i)
+    {
+      ArgInfo *ainfo = &cinfo->args [i];
+      MonoInst *inst = cfg->varinfo [i];
+
+      switch(ainfo->storage)
+	{
+	case ArgInIReg:
+	  // We need to save all used a0-a5 params
+	  //for (i=0; i<PARAM_REGS; i++)
+	  //  {
+	  //    if (i < cinfo->reg_usage)
+	  {
+	    //alpha_stq(code, ainfo->reg, alpha_fp, offset);
+	    alpha_ldq(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
+
+	    CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d at offset: %0lx\n",
+				 ainfo->reg, inst->inst_offset/*offset*/);
+	  }
+	  //}
+	  break;
+	case ArgInDoubleSSEReg:
+	case ArgInFloatSSEReg:
+	  // We need to save all used af0-af5 params
+	  //for (i=0; i<PARAM_REGS; i++)
+	  //  {
+	  //    if (i < cinfo->freg_usage)
+	  {
+	    switch(cinfo->args[i].storage)
+	      {
+	      case ArgInFloatSSEReg:
+		//alpha_sts(code, ainfo->reg, alpha_fp, offset);
+		alpha_lds(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
+		break;
+	      case ArgInDoubleSSEReg:
+		//alpha_stt(code, ainfo->reg, alpha_fp, offset);
+		alpha_ldt(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
+		break;
+	      default:
+		;
+	      }
+
+	    CFG_DEBUG(3) g_print("ALPHA: Saved float arg reg %d at offset: %0lx\n",
+				 ainfo->reg, /*offset*/inst->inst_offset);
+	  }
+	}
+    }
+  g_free (cinfo);
+
+  return code;
+}
+
 /*------------------------------------------------------------------*/
 /*                                                                  */
 /* Name         - mono_arch_emit_prolog                             */
 /*                                                                  */
 /* Function     - Create the instruction sequence for a function    */
 /*                prolog.                                           */
-/* 
+/*
+ * How to handle consts and method addreses: 
  * For method we will allocate array of qword after method epiloge.
  * These qword will hold readonly info to method to properly to run.
  * For example: qword constants, method addreses
- * GP will point to method start. Offsets to the data will be equal
- * to "address" of data itself (GP = 0 during method jiting). 
+ * GP will point to start of data. Offsets to the data will be equal
+ * to "address" of data - start of GP. (GP = 0 during method jiting). 
  * GP is easily calculated from passed PV (method start address).
- * This array should not be far
- * from method and I hope +- 32Kb offset is enough to get to it.
+ * The patch will update GP loadings.
+ * The GOT section should be more than 32Kb.
  * The patch code should put proper offset since the real position of
  * qword array will be known after the function epiloge.
  */
@@ -1251,19 +1400,15 @@
 mono_arch_emit_prolog (MonoCompile *cfg)
 {
    MonoMethod *method = cfg->method;
-   MonoBasicBlock *bb;
    MonoMethodSignature *sig = mono_method_signature (method);
-   MonoInst *inst;
-   int alloc_size, offset, max_offset, i, quad;
+   //int alloc_size, code_size, max_offset, quad;
    unsigned int *code;
    CallInfo *cinfo;
-   int	stack_size, code_size;
+   int	i, stack_size, offset;
    gint32 lmf_offset = cfg->arch.lmf_offset;
 
    CFG_DEBUG(2) ALPHA_DEBUG("mono_arch_emit_prolog");
    
-//   calculate_size( sig, &code_size, &stack_size );	
-   
    // FIXME: Use just one field to hold calculated stack size
    cfg->arch.stack_size = stack_size = cfg->stack_offset;
    cfg->arch.got_data = 0;
@@ -1278,11 +1423,13 @@
    ALPHA_LOAD_GP(0)
    alpha_ldah( code, alpha_gp, alpha_pv, 0 );
    alpha_lda( code, alpha_gp, alpha_gp, 0 );     // ldgp gp, 0(pv)
-   alpha_lda( code, alpha_sp, alpha_sp, -stack_size );
+   alpha_lda( code, alpha_sp, alpha_sp, -(stack_size) );
 
+   offset = cfg->arch.params_stack_size;
+
    /* store call convention parameters on stack */
-   alpha_stq( code, alpha_ra, alpha_sp, 0 ); // RA
-   alpha_stq( code, alpha_fp, alpha_sp, 8 ); // FP
+   alpha_stq( code, alpha_ra, alpha_sp, (offset + 0) ); // RA
+   alpha_stq( code, alpha_fp, alpha_sp, (offset + 8) ); // FP
    
    /* set the frame pointer */
    alpha_mov1( code, alpha_sp, alpha_fp );
@@ -1341,7 +1488,7 @@
 	     //alpha_stq(code, ainfo->reg, alpha_fp, offset);
 	     alpha_stq(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
 		   
-	     CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d at offset: %0x\n",
+	     CFG_DEBUG(3) g_print("ALPHA: Saved int arg reg %d at offset: %0lx\n",
 				  ainfo->reg, inst->inst_offset/*offset*/);
 		   
 	     offset += 8;
@@ -1369,7 +1516,7 @@
 		 ;
 	       }
 		   
-	     CFG_DEBUG(3) g_print("ALPHA: Saved float arg reg %d at offset: %0x\n",
+	     CFG_DEBUG(3) g_print("ALPHA: Saved float arg reg %d at offset: %0lx\n",
 				  ainfo->reg, /*offset*/inst->inst_offset);
 		   
 	     offset += 8;
@@ -1483,7 +1630,6 @@
 	  guint32 patch_type, gconstpointer data)
 {
   int offset;
-  short high_off, low_off;
   AlphaGotData ge_data;
   
   offset = (char *)code - (char *)cfg->native_code;
@@ -1618,8 +1764,10 @@
       }
   
   /* restore fp, ra, sp */
-  alpha_ldq( code, alpha_ra, alpha_sp, 0 );
-  alpha_ldq( code, alpha_fp, alpha_sp, 8 );
+  offset = cfg->arch.params_stack_size;
+
+  alpha_ldq( code, alpha_ra, alpha_sp, (offset + 0) );
+  alpha_ldq( code, alpha_fp, alpha_sp, (offset + 8) );
   alpha_lda( code, alpha_sp, alpha_sp, stack_size );
   
   /* return */
@@ -2034,6 +2182,8 @@
    cpos = bb->max_offset;
    
    offset = ((char *)code) - ((char *)cfg->native_code);
+
+   mono_debug_open_block (cfg, bb, offset);
    
    ins = bb->code;
    while (ins)
@@ -2386,7 +2536,6 @@
 	 case OP_CHECK_THIS:
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [check_this] sreg1=%d\n",
 		  ins->sreg1);
-	   //alpha_cmpeq_(code, ins->sreg1, 0, alpha_at);
 	   alpha_ldl(code, alpha_at, ins->sreg1, 0);
 	   break;
 
@@ -2480,10 +2629,7 @@
 
 		 add_got_entry(cfg, GT_LONG, ge_data,
 			       lo, MONO_PATCH_INFO_NONE, 0);
-		 //mono_add_patch_info(cfg, lo, MONO_PATCH_INFO_GOT_OFFSET,
-		 //		     ins->inst_c0);
 		 alpha_ldq(code, ins->dreg, alpha_gp, 0);
-
 	       }
 	     break;
 	   }
@@ -2504,6 +2650,7 @@
 
 	     break;
 	   }
+
 	 case OP_R4CONST:
            {
              float d = *(float *)ins->inst_p0;
@@ -2521,7 +2668,6 @@
              break;
            }
 
-
 	 case OP_LOADU4_MEMBASE:
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [loadu4_membase] dreg=%d, basereg=%d, offset=%0lx\n",
 		  ins->dreg, ins->inst_basereg, ins->inst_offset);
@@ -2956,13 +3102,11 @@
 	 case OP_COND_EXC_IOV:
 	 case OP_COND_EXC_OV:
 	   EMIT_COND_EXC_BRANCH(bne, alpha_at, "OverflowException");
-	   //emit_cond_system_exception (cfg, code, "OverflowException", 6);
 	   break;
 
 	 case OP_COND_EXC_IC:
 	 case OP_COND_EXC_C:
 	   EMIT_COND_EXC_BRANCH(bne, alpha_pv, "OverflowException");
-	   //emit_cond_system_exception (cfg, code, "OverflowException", 7);
 	   break;
 
 	 case CEE_CONV_OVF_U4:
@@ -2986,17 +3130,23 @@
            alpha_mov1(code, ins->sreg1, ins->dreg);
            break;
 
-
 	 case CEE_CONV_I1:
 	   // Move I1 (byte) to dreg(64 bits) and sign extend it
 	   // Read about sextb
-	   CFG_DEBUG(4) g_print("ALPHA_TODO: [conv_i1] sreg=%d, dreg=%d\n",
+	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [conv_i1] sreg=%d, dreg=%d\n",
 		  ins->sreg1, ins->dreg);
+           alpha_sll_(code, ins->sreg1, 24, alpha_at);
+           alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
+           alpha_sra_(code, ins->dreg, 24, ins->dreg);
 	   break;
+
 	 case CEE_CONV_I2:
 	   // Move I2 (word) to dreg(64 bits) and sign extend it
-	   CFG_DEBUG(4) g_print("ALPHA_TODO: [conv_i2] sreg=%d, dreg=%d\n",
+	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [conv_i2] sreg=%d, dreg=%d\n",
 		  ins->sreg1, ins->dreg);
+	   alpha_sll_(code, ins->sreg1, 16, alpha_at);
+	   alpha_addl(code, alpha_at, alpha_zero, ins->dreg);
+	   alpha_sra_(code, ins->dreg, 16, ins->dreg);
 	   break;
 	   
 	 case CEE_CONV_I4:
@@ -3008,10 +3158,11 @@
 
 	 case CEE_CONV_I8:
 	 case CEE_CONV_I:
-	   // Convert I4 (32 bit) to dreg (64 bit) and sign extend it
+	   // Convert I/I8 (64 bit) to dreg (64 bit) and sign extend it
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [conv_i8/conv_i] sreg=%d, dreg=%d\n",
 		  ins->sreg1, ins->dreg);
-	   alpha_addl(code, ins->sreg1, alpha_zero, ins->dreg);
+	   //alpha_addl(code, ins->sreg1, alpha_zero, ins->dreg);
+	   alpha_mov1(code, ins->sreg1, ins->dreg);
 	   break;
 	   
 	 case CEE_CONV_U1:
@@ -3142,13 +3293,16 @@
 	   break;
 
 	 case OP_LOCALLOC:
-	   // Allocate sreg1 bytes on stack, modify SP and put it into dreg
+	   // Allocate sreg1 bytes on stack, round bytes by 8,
+	   // modify SP, set dreg to end of current stack frame
+	   // top of stack is used for call params
 	   CFG_DEBUG(4) g_print("ALPHA_FIX: [localloc] sreg=%d, dreg=%d\n",
 				ins->sreg1, ins->dreg);
 	   alpha_addq_(code, ins->sreg1, (MONO_ARCH_FRAME_ALIGNMENT - 1), ins->sreg1);
 	   alpha_and_(code, ins->sreg1, ~(MONO_ARCH_FRAME_ALIGNMENT - 1), ins->sreg1);
 	   alpha_subq(code, alpha_sp, ins->sreg1, alpha_sp);
-	   alpha_mov1(code, alpha_sp, ins->dreg);
+	   alpha_lda(code, ins->dreg, alpha_zero, (cfg->arch.params_stack_size));
+	   alpha_addq(code, alpha_sp, ins->dreg, ins->dreg);
 	   break;
 
 	 case OP_MOVE:
@@ -3250,7 +3404,6 @@
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [fbne_un] [");
 	   alpha_fbeq(code, (alpha_at+1), 1);
 	   alpha_cpys(code, alpha_zero, alpha_zero, alpha_at);
-	   //EMIT_ALPHA_BRANCH(ins, fbne);
 	   EMIT_ALPHA_BRANCH(ins, alpha_at, fbeq);
 	   break;
 
@@ -3258,7 +3411,6 @@
            CFG_DEBUG(4) g_print("ALPHA_CHECK: [fbge_un] [");
            alpha_fbeq(code, (alpha_at+1), 1);
            alpha_cpys(code, alpha_zero, alpha_zero, alpha_at);
-           //EMIT_ALPHA_BRANCH(ins, fbne);
            EMIT_ALPHA_BRANCH(ins, alpha_at, fbeq);
            break;
 
@@ -3283,7 +3435,6 @@
            EMIT_ALPHA_BRANCH(ins, alpha_at, fbeq);
            break;
 
-
 	 case OP_IBEQ:
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [ibeq] [");
 	   EMIT_ALPHA_BRANCH(ins, alpha_at, beq);
@@ -3377,9 +3528,6 @@
 	   CFG_DEBUG(4) g_print("ALPHA_CHECK: [fcall/lcall/vcall/voidcall/call] Target: [");
 	   call = (MonoCallInst*)ins;
 	   
-	   if (call->stack_usage)
-	     alpha_lda(code, alpha_sp, alpha_sp, -(call->stack_usage));
-
 	   if (ins->flags & MONO_INST_HAS_METHOD)
 	     {
 	       CFG_DEBUG(4) g_print("MONO_PATCH_INFO_METHOD] %p\n", call->method);
@@ -3395,9 +3543,6 @@
 
 	   //code = emit_move_return_value (cfg, ins, code);
 
-           if (call->stack_usage)
-             alpha_lda(code, alpha_sp, alpha_sp, call->stack_usage);
-	   
 	   break;
 	   
 	 case OP_FCALL_REG:
@@ -3411,9 +3556,6 @@
 	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [fcall_reg/lcall_reg/vcall_reg/voidcall_reg/call_reg]: TargetReg: %d\n", ins->sreg1);
 	     call = (MonoCallInst*)ins;
 	   
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, -(call->stack_usage));
-
 	     alpha_mov1(code, ins->sreg1, alpha_pv);
 
 	     alpha_jsr(code, alpha_ra, alpha_pv, 0);
@@ -3424,10 +3566,6 @@
 	     ALPHA_LOAD_GP(offset)
              alpha_ldah(code, alpha_gp, alpha_ra, 0);
              alpha_lda(code, alpha_gp, alpha_gp, 0);
-
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, (call->stack_usage));
-
 	   }
 	   break;
 
@@ -3442,9 +3580,6 @@
 		    ins->inst_basereg, ins->inst_offset);
              call = (MonoCallInst*)ins;
 
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, -(call->stack_usage));
-
 	     alpha_ldq(code, alpha_pv, ins->inst_basereg, ins->inst_offset);
              alpha_jsr(code, alpha_ra, alpha_pv, 0);
 
@@ -3454,9 +3589,6 @@
 	     ALPHA_LOAD_GP(offset)
              alpha_ldah(code, alpha_gp, alpha_ra, 0);
              alpha_lda(code, alpha_gp, alpha_gp, 0);
-
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, (call->stack_usage));
 	   }
 	   break;
 
@@ -3468,9 +3600,6 @@
                     ins->inst_basereg, ins->inst_offset);
              call = (MonoCallInst*)ins;
 
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, -(call->stack_usage));
-
              alpha_ldq(code, alpha_pv, ins->inst_basereg, ins->inst_offset);
              alpha_jsr(code, alpha_ra, alpha_pv, 0);
 
@@ -3480,9 +3609,6 @@
 	     ALPHA_LOAD_GP(offset)
 	     alpha_ldah(code, alpha_gp, alpha_ra, 0);
 	     alpha_lda(code, alpha_gp, alpha_gp, 0);
-
-	     if (call->stack_usage)
-	       alpha_lda(code, alpha_sp, alpha_sp, (call->stack_usage));
            }
            break;
 
@@ -3492,41 +3618,44 @@
 	     // of by call_filter. There should be difference. For now just
 	     // handle - call_handler
 
-	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [start_handler]\n");
+	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [start_handler] basereg=%d, offset=%0x\n",
+		ins->inst_left->inst_basereg, ins->inst_left->inst_offset);
 
-	     alpha_lda(code, alpha_sp, alpha_sp, -8);
-	     alpha_stq(code, alpha_ra, alpha_sp, 0);
+	     alpha_stq(code, alpha_ra, ins->inst_left->inst_basereg, 
+			ins->inst_left->inst_offset);
 	   }
 	   break;
 
 	 case CEE_ENDFINALLY:
-	 case OP_ENDFILTER:
-	   {
-	     // Keep in sync with start_handler
+	{
+             // Keep in sync with start_handler
+             CFG_DEBUG(4) g_print("ALPHA_CHECK: [endfinally] basereg=%d, offset=%0x\n",
+                ins->inst_left->inst_basereg, ins->inst_left->inst_offset);
 
-	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [endfinally/endfilter]\n");
+             alpha_ldq(code, alpha_ra, ins->inst_left->inst_basereg,
+                        ins->inst_left->inst_offset);
 
-	     alpha_ldq(code, alpha_ra, alpha_sp, 0);
-	     alpha_lda(code, alpha_sp, alpha_sp, 8);
-	     alpha_ret(code, alpha_ra, 1);
-	   }
-	   break;
-#if 0
+             alpha_ret(code, alpha_ra, 1);
+
+	}
+	break;
 	 case OP_ENDFILTER:
 	   {
 	     // Keep in sync with start_handler
+	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [endfilter] sreg1=%d, basereg=%d, offset=%0x\n",
+		ins->sreg1, ins->inst_left->inst_basereg, ins->inst_left->inst_offset);
 
-             CFG_DEBUG(4) g_print("ALPHA_CHECK: [endfilter] sreg1=%d\n",
-				  ins->sreg1);
+	     alpha_ldq(code, alpha_ra, ins->inst_left->inst_basereg,
+			ins->inst_left->inst_offset);
 
-             alpha_ldq(code, alpha_ra, alpha_sp, 0);
-             alpha_lda(code, alpha_sp, alpha_sp, 8);
-             alpha_ret(code, alpha_ra, 1);
+	     if (ins->sreg1 != -1 && ins->sreg1 != alpha_r0)
+		alpha_mov1(code, ins->sreg1, alpha_r0);
 
+	     alpha_ret(code, alpha_ra, 1);
 	   }
 	   break;
-#endif
-	 case OP_CALL_HANDLER:
+	 
+	case OP_CALL_HANDLER:
 	   {
 	     int offset;
 
@@ -3565,7 +3694,41 @@
                              (gpointer)"mono_arch_rethrow_exception");
            break;
 
+	 case CEE_JMP:
+	   {
+	     CFG_DEBUG(4) g_print("ALPHA_CHECK: [jmp] %p\n", ins->inst_p0);
+	     /*
+	      * Note: this 'frame destruction' logic is useful for tail calls, too.
+	      * Keep in sync with the code in emit_epilog.
+	      */
+	     int pos = 0, i, offset;
+	     AlphaGotData ge_data;
 
+	     /* FIXME: no tracing support... */
+	     if (cfg->prof_options & MONO_PROFILE_ENTER_LEAVE)
+	       code = mono_arch_instrument_epilog (cfg, mono_profiler_method_leave, code, FALSE);
+	     g_assert (!cfg->method->save_lmf);
+
+	     alpha_mov1( code, alpha_fp, alpha_sp );
+
+	     code = emit_load_volatile_arguments (cfg, code);
+
+	     offset = cfg->arch.params_stack_size;
+
+	     alpha_ldq( code, alpha_ra, alpha_sp, (offset + 0) );
+	     alpha_ldq( code, alpha_fp, alpha_sp, (offset + 8) );
+	     alpha_lda( code, alpha_sp, alpha_sp, cfg->arch.stack_size );
+
+	     ge_data.data.p = ins->inst_p0;
+	     add_got_entry(cfg, GT_PTR, ge_data,
+			   (char *)code - (char *)cfg->native_code,
+			   MONO_PATCH_INFO_METHOD_JUMP, ins->inst_p0);
+	     alpha_ldq( code, alpha_pv, alpha_gp, 0);
+
+	     alpha_jsr( code, alpha_zero, alpha_pv, 0);
+	   }
+	   break;
+
 	 case OP_AOTCONST:
 	   mono_add_patch_info (cfg, offset,
 				(MonoJumpInfoType)ins->inst_i1, ins->inst_p0);
@@ -3793,6 +3956,7 @@
 	case MONO_PATCH_INFO_METHOD:
 	case MONO_PATCH_INFO_METHODCONST:
 	case MONO_PATCH_INFO_INTERNAL_METHOD:
+	case MONO_PATCH_INFO_METHOD_JUMP:
 	  {
 	    volatile unsigned int *p = (unsigned int *)ip;
 	    unsigned long t_addr;
@@ -4297,12 +4461,13 @@
 /*                includes pushing, moving argments to the correct  */
 /*                etc.                                              */
 /*
- * TSV (guess):
  * This method is called during converting method to IR
+ * We need to generate IR ints to follow calling convention
  *  cfg - points to currently compiled unit
  *  bb - ???
  *  call - points to structure that describes what we are going to
  *         call (at least number of parameters required for the call)
+ *
  * 
  * On return we need to pass back modified call structure
  */
@@ -4330,7 +4495,10 @@
 			sig->pinvoke ? "PInvoke" : "Managed",
 			sig->param_count, sig->hasthis,
 			CvtMonoType(sig->ret->type), sig->ret->type);
-   
+  
+   if (cinfo->stack_usage > cfg->arch.params_stack_size)
+	cfg->arch.params_stack_size = cinfo->stack_usage;
+ 
    if (!sig->pinvoke && (sig->call_convention == MONO_CALL_VARARG))
 	 sentinelpos = sig->sentinelpos + (is_virtual ? 1 : 0);
     
@@ -4423,7 +4591,8 @@
 
 	       MONO_INST_NEW (cfg, stack_addr, OP_REGOFFSET);
 	       stack_addr->inst_basereg = alpha_sp;
-	       stack_addr->inst_offset = -(cinfo->stack_usage - ainfo->offset);
+	       //stack_addr->inst_offset = -(cinfo->stack_usage - ainfo->offset);
+	       stack_addr->inst_offset = ainfo->offset;
 	       //stack_addr->inst_offset = 16 + ainfo->offset;
 	       stack_addr->inst_imm = size;
 
@@ -4449,7 +4618,8 @@
 		 break;
 	       case ArgOnStack:
 		 arg->opcode = OP_OUTARG;
-		 arg->dreg = -((n - i) * 8);
+		 //arg->dreg = -((n - i) * 8);
+		 arg->dreg = ainfo->offset;
 		 //arg->inst_left->inst_imm = (n - i - 1) * 8;
 
 		 if (!sig->params[i-sig->hasthis]->byref) {
@@ -4462,7 +4632,7 @@
 		 break;
 		case ArgInFloatSSEReg:
 		case ArgInDoubleSSEReg:
-			add_outarg_reg (cfg, call, arg, ainfo->storage, ainfo->reg, in);
+		  add_outarg_reg (cfg, call, arg, ainfo->storage, ainfo->reg, in);
 		break;
 	       default:
 		 g_assert_not_reached ();
@@ -5016,7 +5186,6 @@
 /*                                                                  */
 /* Parameter    - @m - Compile unit.                                */
 /*
- * TSV (guess)
  * This method is called right before working with BBs. Conversion to
  * IR was done and some analises what registers would be used.
  * Collect info about registers we used - if we want to use a register
@@ -5025,10 +5194,12 @@
  * 
  * Alpha calling convertion:
  * FP -> Stack top <- SP
- * 0:    RA
- * 8:    old FP
- * 16:
- *       [LMF info]
+ * 0:    Stack params to call others
+ *
+ *       RA               <- arch.params_stack_size
+ *       old FP
+ * 
+ *       [LMF info]       <- arch.lmf_offset
  * .
  *       [possible return values allocated on stack]
  *
@@ -5053,7 +5224,7 @@
    MonoMethodSignature *sig;
    MonoMethodHeader *header;
    MonoInst *inst;
-   int i, offset, l_offset;
+   int i, offset = 0, a_off = 0;
    guint32 locals_stack_size, locals_stack_align = 0;
    gint32 *offsets;
    CallInfo *cinfo;
@@ -5079,9 +5250,15 @@
       * FIXME: Check there Arg6...Argn are supposed to be
       */
      cfg->frame_reg = alpha_fp;
-     offset = MONO_ALPHA_VARS_OFFSET;
+     //     offset = MONO_ALPHA_VARS_OFFSET;
    }
 
+   CFG_DEBUG(3) g_print ("ALPHA: Size for call params is %d(%x)\n",
+                         cfg->arch.params_stack_size, cfg->arch.params_stack_size);
+   offset += cfg->arch.params_stack_size;
+
+   offset += 16;    // Size to save RA & FP
+
    if (cfg->method->save_lmf)
      {
        /* Reserve stack space for saving LMF + argument regs */
@@ -5163,12 +5340,12 @@
      }
    */
 
-   CFG_DEBUG(3) g_print ("ALPHA: Start offset is %x\n", offset);
+   cfg->arch.localloc_offset = offset;
+   
+   CFG_DEBUG(3) g_print ("ALPHA: Locals start offset is %d(%x)\n", offset, offset);
    CFG_DEBUG(3) g_print ("ALPHA: Locals size is %d(%x)\n",
 			  locals_stack_size, locals_stack_size);
 
-   l_offset = offset;
-
    for (i = cfg->locals_start; i < cfg->num_varinfo; i++)
      {
        if (offsets [i] != -1) {
@@ -5201,7 +5378,7 @@
    // Save offset for caller saved regs
    cfg->arch.reg_save_area_offset = offset;
 
-   CFG_DEBUG(3) g_print ("ALPHA: reg_save_area_offset at %x\n", offset);
+   CFG_DEBUG(3) g_print ("ALPHA: reg_save_area_offset at %d(%x)\n", offset, offset);
    
    // Reserve space for caller saved registers 
    for (i = 0; i < MONO_MAX_IREGS; ++i)
@@ -5214,7 +5391,7 @@
    // Save offset to args regs
    cfg->arch.args_save_area_offset = offset;
 
-   CFG_DEBUG(3) g_print ("ALPHA: args_save_area_offset at %x\n", offset);
+   CFG_DEBUG(3) g_print ("ALPHA: args_save_area_offset at %d(%x)\n", offset, offset);
 
    for (i = 0; i < PARAM_REGS; ++i)
      if (i < (sig->param_count + sig->hasthis))
@@ -5305,8 +5482,10 @@
 		 // offset += (ainfo->storage == ArgValuetypeInReg) ?
 		 // 2 * sizeof (gpointer) : sizeof (gpointer);
 
-		 inst->inst_offset = cfg->arch.args_save_area_offset +
-		   (/*(ainfo->reg - 16)*/ i * 8);
+		 inst->inst_offset = cfg->arch.args_save_area_offset + a_off;
+		a_off += 8;
+
+		//   (/*(ainfo->reg - 16)*/ i * 8);
 	       }
 	     }
 	 }
@@ -5366,7 +5545,7 @@
   guint32 reg, disp;
   int     start_index = -2;
 
-  ALPHA_PRINT g_debug("ALPHA_TODO: [mono_arch_get_vcall_slot_addr] code: %p regs: %p",
+  ALPHA_PRINT g_debug("ALPHA_CHECK: [mono_arch_get_vcall_slot_addr] code: %p regs: %p",
 	  pc, regs);
 
   // Check if we have parameters on stack
@@ -5384,7 +5563,7 @@
       disp = pc[start_index] & 0xFFFF;
       reg = 0; // For now
 
-      ALPHA_PRINT g_debug("ALPHA_TODO: [mono_arch_get_vcall_slot_addr callvirt] call_membase");
+      ALPHA_PRINT g_debug("ALPHA_CHECK: [mono_arch_get_vcall_slot_addr callvirt] call_membase");
 
       return (gpointer)(((guint64)(regs [reg])) + disp);
     }
@@ -5402,7 +5581,7 @@
       disp = pc[start_index] & 0xFFFF;;
       reg = 0; // For now
 
-      ALPHA_PRINT g_debug("ALPHA_TODO: [mono_arch_get_vcall_slot_addr interf callvir] call_membase");
+      ALPHA_PRINT g_debug("ALPHA_CHECK: [mono_arch_get_vcall_slot_addr interf callvir] call_membase");
 
       return (gpointer)(((guint64)(regs [reg])) + disp);
     }
Index: mono/mono/mini/mini-alpha.h
===================================================================
--- mono/mono/mini/mini-alpha.h	(revision 65271)
+++ mono/mono/mini/mini-alpha.h	(working copy)
@@ -46,13 +46,13 @@
   gint32 localloc_offset;
   gint32 reg_save_area_offset;
   gint32 args_save_area_offset;
-  
+  gint32 stack_size;        // Allocated stack size in bytes
+  gint32 params_stack_size;  // Stack size reserved for call params by this compile method
+
   gpointer    got_data;
  
 //  gpointer    litpool;
 //  glong       litsize;
-  glong       stack_size;	// Allocated stack size in bytes
-
   glong       bwx;
 } MonoCompileArch;
 
@@ -69,8 +69,6 @@
   guint64     rgp;          // GP
 };
 
-#define MONO_ALPHA_VARS_OFFSET 16
-
 #define MONO_ARCH_FRAME_ALIGNMENT 8
 #define MONO_ARCH_CODE_ALIGNMENT 8
 
Index: mono/mono/utils/strtod.c
===================================================================
--- mono/mono/utils/strtod.c	(revision 65271)
+++ mono/mono/utils/strtod.c	(working copy)
@@ -144,7 +144,7 @@
 
 #define IEEE_8087
 
-#elif defined(__x86_64__)
+#elif defined(__x86_64__) || defined(__alpha__)
 
 #define IEEE_8087
 
Index: mono/mono/arch/alpha/alpha-codegen.h
===================================================================
--- mono/mono/arch/alpha/alpha-codegen.h	(revision 65271)
+++ mono/mono/arch/alpha/alpha-codegen.h	(working copy)
@@ -292,7 +292,7 @@
 /* pal calls */
 /* #define alpha_halt( ins )            alpha_encode_palcall( ins, 0, 0 ) */
 
-#define alpha_call_pal( ins, func )  alpha_encode_palcall( ins, 0, x )
+#define alpha_call_pal( ins, func )  alpha_encode_palcall( ins, 0, func )
 
 /*memory*/
 #define alpha_lda( ins, Rdest, Rsrc, offset )	alpha_encode_mem( ins, 0x08, Rdest, Rsrc, offset )
@@ -538,11 +538,17 @@
 #define alpha_subt(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A1, Rsrc1, Rsrc2, Rdest )
 #define alpha_mult(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A2, Rsrc1, Rsrc2, Rdest )
 #define alpha_divt(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A3, Rsrc1, Rsrc2, Rdest )
+
 #define alpha_cmptun(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A4, Rsrc1, Rsrc2, Rdest )
 #define alpha_cmpteq(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A5, Rsrc1, Rsrc2, Rdest )
 #define alpha_cmptlt(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A6, Rsrc1, Rsrc2, Rdest )
 #define alpha_cmptle(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0A7, Rsrc1, Rsrc2, Rdest )
 
+#define alpha_cmptun_su(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x5A4, Rsrc1, Rsrc2, Rdest )
+#define alpha_cmpteq_su(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x5A5, Rsrc1, Rsrc2, Rdest )
+#define alpha_cmptlt_su(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x5A6, Rsrc1, Rsrc2, Rdest )
+#define alpha_cmptle_su(ins, Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x5A7, Rsrc1, Rsrc2, Rdest )                                                                           
+
 #define alpha_cvtts(ins, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0AC, alpha_fzero, Rsrc2, Rdest )
 #define alpha_cvttq(ins, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0AF, alpha_fzero, Rsrc2, Rdest )
 #define alpha_cvtqs(ins, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x16, 0x0BC, alpha_fzero, Rsrc2, Rdest )
@@ -553,6 +559,7 @@
 #define alpha_cpysn(ins,  Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x17, 0x021, Rsrc1, Rsrc2, Rdest )
 #define alpha_cpyse(ins,  Rsrc1, Rsrc2, Rdest) alpha_encode_fpop( ins, 0x17, 0x022, Rsrc1, Rsrc2, Rdest )
 
+#define	alpha_trapb(ins)	alpha_encode_op(ins, 0x18, 0, 0, 0, 0);
 
 #endif
 
