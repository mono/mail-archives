Index: mono/mono/mini/mini-alpha.c
===================================================================
--- mono/mono/mini/mini-alpha.c	(revision 65696)
+++ mono/mono/mini/mini-alpha.c	(working copy)
@@ -34,7 +34,14 @@
    insert_after_ins (bb, last_ins, (dest)); \
 } while (0)
 
+#define NEW_ICONST(cfg,dest,val) do {					\
+    (dest) = mono_mempool_alloc0 ((cfg)->mempool, sizeof (MonoInst));	\
+    (dest)->opcode = OP_ICONST;						\
+    (dest)->inst_c0 = (val);						\
+    (dest)->type = STACK_I4;						\
+  } while (0)
 
+
 #undef DEBUG
 #define DEBUG(a) if (cfg->verbose_level > 1) a
 
@@ -95,24 +102,23 @@
 
 typedef enum {
         ArgInIReg,
-        ArgInFloatSSEReg,
-        ArgInDoubleSSEReg,
+        ArgInFloatReg,
+        ArgInDoubleReg,
         ArgOnStack,
-        ArgValuetypeInReg,
-//        ArgOnFloatFpStack,
-//        ArgOnDoubleFpStack,
+	ArgValuetypeInReg, // ??
+	ArgAggregate,
         ArgNone
 } ArgStorage;
 
 
 typedef struct {
-   gint16 offset;
-   gint8  reg;
-   ArgStorage storage;
+  gint16 offset;
+  gint8  reg;
+  ArgStorage storage;
 
-   /* Only if storage == ArgValuetypeInReg */
-   ArgStorage pair_storage [2];
-   gint8 pair_regs [2];
+  /* Only if storage == ArgAggregate */
+  int nregs, nslots;
+  //AggregateType atype; // So far use only AggregateNormal
 } ArgInfo;
 
 typedef struct {
@@ -180,9 +186,10 @@
    {
      /* A double register */
      if (is_double)
-       ainfo->storage = ArgInDoubleSSEReg;
+       ainfo->storage = ArgInDoubleReg;
      else
-       ainfo->storage = ArgInFloatSSEReg;
+       ainfo->storage = ArgInFloatReg;
+
      ainfo->reg = fparam_regs [*gr];
      (*gr) += 1;
    }
@@ -207,7 +214,7 @@
   else
     size = mono_type_stack_size (&klass->byval_arg, NULL);
 
-  if (!sig->pinvoke || (size == 0)) {
+  if (!sig->pinvoke || (size == 0) || is_return) {
     /* Allways pass in memory */
     ainfo->offset = *stack_size;
     *stack_size += ALIGN_TO (size, 8);
@@ -216,18 +223,40 @@
     return;
   }
 
-        info = mono_marshal_load_type_info (klass);
-        g_assert (info);
-        if (info->native_size/* > 16*/) {
-                ainfo->offset = *stack_size;
-                *stack_size += ALIGN_TO (info->native_size, 8);
-                ainfo->storage = ArgOnStack;
+  info = mono_marshal_load_type_info (klass);
+  g_assert (info);
 
-                return;
-        }
+  ainfo->storage = ArgAggregate;
+  //ainfo->atype = AggregateNormal;
 
+#if 0
+  /* This also handles returning of TypedByRef used by some icalls */
+  if (is_return) {
+    if (size <= 32) {
+      ainfo->reg = IA64_R8;
+      ainfo->nregs = (size + 7) / 8;
+      ainfo->nslots = ainfo->nregs;
+      return;
+    }
+    NOT_IMPLEMENTED;
+  }
+#endif
 
-  NOT_IMPLEMENTED("add_valuetype: more");
+  ainfo->reg =  param_regs [*gr];
+  ainfo->offset = *stack_size;
+  ainfo->nslots = (size + 7) / 8;
+
+  if (((*gr) + ainfo->nslots) <= 6) {
+    /* Fits entirely in registers */
+    ainfo->nregs = ainfo->nslots;
+    (*gr) += ainfo->nregs;
+    return;
+  }
+
+  ainfo->nregs = 6 - (*gr);
+  (*gr) = 6;
+  (*stack_size) += (ainfo->nslots - ainfo->nregs) * 8;
+
 }
 
 // This function is called from mono_arch_call_opcode and
@@ -237,7 +266,7 @@
 // that will be used in calls
 static void
 add_outarg_reg (MonoCompile *cfg, MonoCallInst *call, MonoInst *arg,
-				ArgStorage storage, int reg, MonoInst *tree)
+		ArgStorage storage, int reg, MonoInst *tree)
 {
   switch (storage)
     {
@@ -248,14 +277,14 @@
       arg->unused = reg;
       call->used_iregs |= 1 << reg;
       break;
-    case ArgInFloatSSEReg:
+    case ArgInFloatReg:
       arg->opcode = OP_OUTARG_FREG;
       arg->inst_left = tree;
       arg->inst_right = (MonoInst*)call;
       arg->unused = reg;
       call->used_fregs |= 1 << reg;
       break;
-    case ArgInDoubleSSEReg:
+    case ArgInDoubleReg:
       arg->opcode = OP_OUTARG_FREG;
       arg->inst_left = tree;
       arg->inst_right = (MonoInst*)call;
@@ -1344,8 +1373,8 @@
 	  }
 	  //}
 	  break;
-	case ArgInDoubleSSEReg:
-	case ArgInFloatSSEReg:
+	case ArgInDoubleReg:
+	case ArgInFloatReg:
 	  // We need to save all used af0-af5 params
 	  //for (i=0; i<PARAM_REGS; i++)
 	  //  {
@@ -1353,11 +1382,11 @@
 	  {
 	    switch(cinfo->args[i].storage)
 	      {
-	      case ArgInFloatSSEReg:
+	      case ArgInFloatReg:
 		//alpha_sts(code, ainfo->reg, alpha_fp, offset);
 		alpha_lds(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
 		break;
-	      case ArgInDoubleSSEReg:
+	      case ArgInDoubleReg:
 		//alpha_stt(code, ainfo->reg, alpha_fp, offset);
 		alpha_ldt(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
 		break;
@@ -1495,8 +1524,8 @@
 	   }
 	   //}
 	   break;
-	 case ArgInDoubleSSEReg:
-	 case ArgInFloatSSEReg:
+	 case ArgInDoubleReg:
+	 case ArgInFloatReg:
 	   // We need to save all used af0-af5 params
 	   //for (i=0; i<PARAM_REGS; i++)
 	   //  {
@@ -1504,11 +1533,11 @@
 	   {
 	     switch(cinfo->args[i].storage)
 	       {
-	       case ArgInFloatSSEReg:
+	       case ArgInFloatReg:
 		 //alpha_sts(code, ainfo->reg, alpha_fp, offset);
 		 alpha_sts(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
 		 break;
-	       case ArgInDoubleSSEReg:
+	       case ArgInDoubleReg:
 		 //alpha_stt(code, ainfo->reg, alpha_fp, offset);
 		 alpha_stt(code, ainfo->reg, inst->inst_basereg, inst->inst_offset);
 		 break;
@@ -3789,8 +3818,8 @@
    /*----------------------------------------------------------*/
    /* no alpha-specific optimizations yet                       */
    /*----------------------------------------------------------*/
-   *exclude_mask = MONO_OPT_INLINE|MONO_OPT_LINEARS;
-   //      *exclude_mask = MONO_OPT_INLINE;
+   *exclude_mask = MONO_OPT_LINEARS;
+   //      *exclude_mask = MONO_OPT_INLINE|MONO_OPT_INLINE;
 
    return opts;
 }
@@ -4186,7 +4215,7 @@
 static CallInfo*
 get_call_info (MonoMethodSignature *sig, gboolean is_pinvoke)
 {
-   guint32 i, gr, fr;
+   guint32 i, gr, fr, *pgr, *pfr;
    MonoType *ret_type;
    int n = sig->hasthis + sig->param_count;
    guint32 stack_size = 0;
@@ -4197,6 +4226,14 @@
    gr = 0;
    fr = 0;
    
+   if (is_pinvoke)
+	pgr = pfr = &gr;
+   else
+   {
+	pgr = &gr;
+	pfr = &fr;
+   }
+
    /* return value */
    {
      ret_type = mono_type_get_underlying_type (sig->ret);
@@ -4227,13 +4264,21 @@
        cinfo->ret.reg = alpha_r0;
        break;
      case MONO_TYPE_R4:
-       cinfo->ret.storage = ArgInFloatSSEReg;
+       cinfo->ret.storage = ArgInFloatReg;
        cinfo->ret.reg = alpha_f0;
        break;
      case MONO_TYPE_R8:
-       cinfo->ret.storage = ArgInDoubleSSEReg;
+       cinfo->ret.storage = ArgInDoubleReg;
        cinfo->ret.reg = alpha_f0;
        break;
+     case MONO_TYPE_GENERICINST:
+       if (!mono_type_generic_inst_is_valuetype (sig->ret))
+	 {
+	   cinfo->ret.storage = ArgInIReg;
+	   cinfo->ret.reg = alpha_r0;
+	   break;
+	 }
+       /* Fall through */
      case MONO_TYPE_VALUETYPE:
        {
 	 guint32 tmp_gr = 0, tmp_fr = 0, tmp_stacksize = 0;
@@ -4244,25 +4289,24 @@
 	 if (cinfo->ret.storage == ArgOnStack)
 	   /* The caller passes the address where the value
 	      is stored */
-	   add_general (&gr, &stack_size, &cinfo->ret);
+	   add_general (pgr, &stack_size, &cinfo->ret);
 	 break;
        }
      case MONO_TYPE_TYPEDBYREF:
        /* Same as a valuetype with size 24 */
-       add_general (&gr, &stack_size, &cinfo->ret);
+       add_general (pgr, &stack_size, &cinfo->ret);
        ;
        break;
      case MONO_TYPE_VOID:
        break;
      default:
-       g_error ("Can't handle as return value 0x%x", sig->ret->
-		type);
+       g_error ("Can't handle as return value 0x%x", sig->ret->type);
      }
    }
    
    /* this */
    if (sig->hasthis)
-     add_general (&gr, &stack_size, cinfo->args + 0);
+     add_general (pgr, &stack_size, cinfo->args + 0);
    
    if (!sig->pinvoke &&
 	   (sig->call_convention == MONO_CALL_VARARG) && (n == 0))
@@ -4272,7 +4316,7 @@
 		
        /* Emit the signature cookie just before the implicit arguments
 	*/
-       add_general (&gr, &stack_size, &cinfo->sig_cookie);
+       add_general (pgr, &stack_size, &cinfo->sig_cookie);
      }
    
    for (i = 0; i < sig->param_count; ++i)
@@ -4294,11 +4338,11 @@
 	   fr = FLOAT_PARAM_REGS;
 			 
 	   /* Emit the signature cookie just before the implicit arguments */
-	   add_general (&gr, &stack_size, &cinfo->sig_cookie);
+	   add_general (pgr, &stack_size, &cinfo->sig_cookie);
 	 }
 		
        if (sig->params [i]->byref) {
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 continue;
        }
        
@@ -4308,16 +4352,16 @@
        case MONO_TYPE_BOOLEAN:
        case MONO_TYPE_I1:
        case MONO_TYPE_U1:
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 break;
        case MONO_TYPE_I2:
        case MONO_TYPE_U2:
        case MONO_TYPE_CHAR:
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 break;
        case MONO_TYPE_I4:
        case MONO_TYPE_U4:
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 break;
        case MONO_TYPE_I:
        case MONO_TYPE_U:
@@ -4328,11 +4372,20 @@
        case MONO_TYPE_STRING:
        case MONO_TYPE_SZARRAY:
        case MONO_TYPE_ARRAY:
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 break;
+       case MONO_TYPE_GENERICINST:
+	 if (!mono_type_generic_inst_is_valuetype (sig->params [i]))
+	   {
+	     add_general (pgr, &stack_size, ainfo);
+	     break;
+	   }
+	 /* Fall through */
        case MONO_TYPE_VALUETYPE:
+	 /* FIXME: */
+	 /* We allways pass valuetypes on the stack */
 	 add_valuetype (sig, ainfo, sig->params [i],
-			FALSE, &gr, &fr, &stack_size);
+			FALSE, pgr, pfr, &stack_size);
 	 break;
        case MONO_TYPE_TYPEDBYREF:
 	 stack_size += sizeof (MonoTypedRef);
@@ -4340,13 +4393,13 @@
 	 break;
        case MONO_TYPE_U8:
        case MONO_TYPE_I8:
-	 add_general (&gr, &stack_size, ainfo);
+	 add_general (pgr, &stack_size, ainfo);
 	 break;
        case MONO_TYPE_R4:
-	 add_float (&fr, &stack_size, ainfo, FALSE);
+	 add_float (pfr, &stack_size, ainfo, FALSE);
 	 break;
        case MONO_TYPE_R8:
-	 add_float (&fr, &stack_size, ainfo, TRUE);
+	 add_float (pfr, &stack_size, ainfo, TRUE);
 	 break;
        default:
 	 g_assert_not_reached ();
@@ -4361,7 +4414,7 @@
 		
        /* Emit the signature cookie just before the implicit arguments
 	*/
-       add_general (&gr, &stack_size, &cinfo->sig_cookie);
+       add_general (pgr, &stack_size, &cinfo->sig_cookie);
      }
    
    cinfo->stack_usage = stack_size;
@@ -4584,27 +4637,126 @@
 	       else
 		 size = mono_type_stack_size (&in->klass->byval_arg, &align);
 
-	     {
-	       MonoInst *stack_addr;
+	     if (ainfo->storage == ArgAggregate)
+	       {
+		 MonoInst *vtaddr, *load, *load2, *offset_ins, *set_reg;
+		 int slot, j;
 
-	       CFG_DEBUG(3) g_print("value type, size:%d\n", size);
+                 CFG_DEBUG(3) g_print("aggregate value type, size:%d\n", size);
 
-	       MONO_INST_NEW (cfg, stack_addr, OP_REGOFFSET);
-	       stack_addr->inst_basereg = alpha_sp;
-	       //stack_addr->inst_offset = -(cinfo->stack_usage - ainfo->offset);
-	       stack_addr->inst_offset = ainfo->offset;
-	       //stack_addr->inst_offset = 16 + ainfo->offset;
-	       stack_addr->inst_imm = size;
+		 vtaddr = mono_compile_create_var (cfg,
+			      &mono_defaults.int_class->byval_arg, OP_LOCAL);
 
-	       arg->opcode = OP_OUTARG_VT;
-	       arg->inst_right = stack_addr;
-	     }
+		 /*
+		  * Part of the structure is passed in registers.
+		  */
+		 for (j = 0; j < ainfo->nregs; ++j)
+		   {
+		     int offset, load_op, dest_reg, arg_storage;
 
+		     slot = ainfo->reg + j;
+		     load_op = CEE_LDIND_I;
+		     offset = j * 8;
+		     dest_reg = ainfo->reg + j;
+		     arg_storage = ArgInIReg;
+		     
+		     MONO_INST_NEW (cfg, load, CEE_LDIND_I);
+		     load->ssa_op = MONO_SSA_LOAD;
+		     load->inst_i0 = (cfg)->varinfo [vtaddr->inst_c0];
+
+		     NEW_ICONST (cfg, offset_ins, offset);
+		     MONO_INST_NEW (cfg, load2, CEE_ADD);
+		     load2->inst_left = load;
+		     load2->inst_right = offset_ins;
+
+		     MONO_INST_NEW (cfg, load, load_op);
+		     load->inst_left = load2;
+
+		     if (j == 0)
+		       set_reg = arg;
+		     else
+		       MONO_INST_NEW (cfg, set_reg, OP_OUTARG_REG);
+
+		     add_outarg_reg (cfg, call, set_reg, arg_storage,
+				     dest_reg, load);
+		     if (set_reg != call->out_args)
+		       {
+			 set_reg->next = call->out_args;
+			 call->out_args = set_reg;
+		     }
+		   }
+
+		 /*
+		  * Part of the structure is passed on the stack.
+		  */
+		 for (j = ainfo->nregs; j < ainfo->nslots; ++j)
+		   {
+		     MonoInst *outarg;
+
+		     slot = ainfo->reg + j;
+
+		     MONO_INST_NEW (cfg, load, CEE_LDIND_I);
+		     load->ssa_op = MONO_SSA_LOAD;
+		     load->inst_i0 = (cfg)->varinfo [vtaddr->inst_c0];
+
+		     NEW_ICONST (cfg, offset_ins, (j * sizeof (gpointer)));
+		     MONO_INST_NEW (cfg, load2, CEE_ADD);
+		     load2->inst_left = load;
+		     load2->inst_right = offset_ins;
+
+		     MONO_INST_NEW (cfg, load, CEE_LDIND_I);
+		     load->inst_left = load2;
+
+		     if (j == 0)
+		       outarg = arg;
+		     else
+		       MONO_INST_NEW (cfg, outarg, OP_OUTARG);
+		     
+		     outarg->inst_left = load;
+		     //outarg->inst_imm = 16 + ainfo->offset + (slot - 8) * 8;
+		     outarg->dreg = ainfo->offset + (slot - 22) * 8;
+
+		     if (outarg != call->out_args)
+		       {
+			 outarg->next = call->out_args;
+			 call->out_args = outarg;
+		       }
+		   }
+		
+		 /* Trees can't be shared so make a copy*/
+		 MONO_INST_NEW (cfg, arg, CEE_STIND_I);
+		 arg->cil_code = in->cil_code;
+		 arg->ssa_op = MONO_SSA_STORE;
+		 arg->inst_left = vtaddr;
+		 arg->inst_right = in;
+		 arg->type = in->type;
+
+		 /* prepend, so they get reversed */
+		 arg->next = call->out_args;
+		 call->out_args = arg;
+	       }
+	     else
+	       {
+		 MonoInst *stack_addr;
+
+		 CFG_DEBUG(3) g_print("value type, size:%d\n", size);
+
+		 MONO_INST_NEW (cfg, stack_addr, OP_REGOFFSET);
+		 stack_addr->inst_basereg = alpha_sp;
+		 //stack_addr->inst_offset = -(cinfo->stack_usage - ainfo->offset);
+		 stack_addr->inst_offset = ainfo->offset;
+		 //stack_addr->inst_offset = 16 + ainfo->offset;
+		 stack_addr->inst_imm = size;
+
+		 arg->opcode = OP_OUTARG_VT;
+		 arg->inst_right = stack_addr;
+	       }
+
 	     /*
-	     arg->opcode = OP_OUTARG_VT;
-	     arg->klass = in->klass;
-	     arg->unused = sig->pinvoke;
-	     arg->inst_imm = size; */
+	       arg->opcode = OP_OUTARG_VT;
+	       arg->klass = in->klass;
+	       arg->unused = sig->pinvoke;
+	       arg->inst_imm = size; */
 	   }
 	 else
 	   {
@@ -4630,8 +4782,8 @@
 		       arg->opcode = OP_OUTARG_R8;
 		 }
 		 break;
-		case ArgInFloatSSEReg:
-		case ArgInDoubleSSEReg:
+		case ArgInFloatReg:
+		case ArgInDoubleReg:
 		  add_outarg_reg (cfg, call, arg, ainfo->storage, ainfo->reg, in);
 		break;
 	       default:
@@ -4641,35 +4793,36 @@
        }
      }
 
-   if (sig->ret && MONO_TYPE_ISSTRUCT (sig->ret)) {
-     if (cinfo->ret.storage == ArgValuetypeInReg) {
-       MonoInst *zero_inst;
-       /*
-	* After the call, the struct is in registers, but needs to be saved to the
-	memory pointed
-	* to by vt_arg in this_vret_args. This means that vt_ar
-	g needs to be saved somewhere
-	* before calling the function. So we add a dummy instru
-	ction to represent pushing the
-	* struct return address to the stack. The return addres
-	s will be saved to this stack slot
-	* by the code emitted in this_vret_args.
-	*/
-       MONO_INST_NEW (cfg, arg, OP_OUTARG);
-       MONO_INST_NEW (cfg, zero_inst, OP_ICONST);
-       zero_inst->inst_p0 = 0;
-       arg->inst_left = zero_inst;
-       arg->type = STACK_PTR;
-       /* prepend, so they get reversed */
-       arg->next = call->out_args;
-       call->out_args = arg;
+   if (sig->ret && MONO_TYPE_ISSTRUCT (sig->ret))
+     {
+       if (cinfo->ret.storage == ArgValuetypeInReg) {
+	 MonoInst *zero_inst;
+	 /*
+	  * After the call, the struct is in registers, but needs to be saved
+	  to the memory pointed
+	  * to by vt_arg in this_vret_args. This means that vt_ar
+	  g needs to be saved somewhere
+	  * before calling the function. So we add a dummy instru
+	  ction to represent pushing the
+	  * struct return address to the stack. The return addres
+	  s will be saved to this stack slot
+	  * by the code emitted in this_vret_args.
+	  */
+	 MONO_INST_NEW (cfg, arg, OP_OUTARG);
+	 MONO_INST_NEW (cfg, zero_inst, OP_ICONST);
+	 zero_inst->inst_p0 = 0;
+	 arg->inst_left = zero_inst;
+	 arg->type = STACK_PTR;
+	 /* prepend, so they get reversed */
+	 arg->next = call->out_args;
+	 call->out_args = arg;
+       }
+       else
+	 /* if the function returns a struct, the called method a
+	    lready does a ret $0x4 */
+	 if (sig->ret && MONO_TYPE_ISSTRUCT (sig->ret))
+	   ; //cinfo->stack_usage -= 4;
      }
-     else
-       /* if the function returns a struct, the called method a
-	  lready does a ret $0x4 */
-       if (sig->ret && MONO_TYPE_ISSTRUCT (sig->ret))
-	 ; //cinfo->stack_usage -= 4;
-   }
    
    // stack_usage shows how much stack we would need to do the call
    // (for example for params that we pass on stack
@@ -5004,10 +5157,10 @@
 	    {
 	      switch(cinfo->args[i].storage)
 		{
-		case ArgInDoubleSSEReg:
+		case ArgInDoubleReg:
 		  alpha_stt(code, inst->dreg, alpha_sp, (i*8));
                   break;
-		case ArgInFloatSSEReg:
+		case ArgInFloatReg:
 		  alpha_sts(code, inst->dreg, alpha_sp, (i*8));
 		  break;
 		default:
@@ -5280,8 +5433,8 @@
        switch (cinfo->ret.storage)
 	 {
 	 case ArgInIReg:
-	 case ArgInFloatSSEReg:
-	 case ArgInDoubleSSEReg:
+	 case ArgInFloatReg:
+	 case ArgInDoubleReg:
 	   if ((MONO_TYPE_ISSTRUCT (sig->ret) &&
 		!mono_class_from_mono_type (sig->ret)->enumtype) ||
 	       (sig->ret->type == MONO_TYPE_TYPEDBYREF))
@@ -5393,7 +5546,8 @@
 
    CFG_DEBUG(3) g_print ("ALPHA: args_save_area_offset at %d(%x)\n", offset, offset);
 
-   for (i = 0; i < PARAM_REGS; ++i)
+   // Consider floats passed in regs too
+   for (i = 0; i < (PARAM_REGS*2); ++i)
      if (i < (sig->param_count + sig->hasthis))
 	 //(cfg->used_int_regs & (1 << param_regs[i])))
        {
@@ -5436,8 +5590,8 @@
 	     inreg = FALSE;
 		 
 	   if (//(ainfo->storage == ArgInIReg) ||
-	       (ainfo->storage == ArgInFloatSSEReg) ||
-	       (ainfo->storage == ArgInDoubleSSEReg) ||
+	       (ainfo->storage == ArgInFloatReg) ||
+	       (ainfo->storage == ArgInDoubleReg) ||
 	       (ainfo->storage == ArgValuetypeInReg))
 	     inreg = FALSE;
 		 
@@ -5446,8 +5600,8 @@
 	   switch (ainfo->storage)
 	     {
 	     case ArgInIReg:
-	     case ArgInFloatSSEReg:
-	     case ArgInDoubleSSEReg:
+	     case ArgInFloatReg:
+	     case ArgInDoubleReg:
 	       inst->opcode = OP_REGVAR;
 	       inst->dreg = ainfo->reg;
 	       break;
@@ -5463,6 +5617,10 @@
 	       break;
 	     case ArgValuetypeInReg:
 	       break;
+	     case ArgAggregate:
+	       inreg = FALSE;
+	       break;
+
 	     default:
 	       NOT_IMPLEMENTED("");
 	     }
@@ -5483,8 +5641,14 @@
 		 // 2 * sizeof (gpointer) : sizeof (gpointer);
 
 		 inst->inst_offset = cfg->arch.args_save_area_offset + a_off;
-		a_off += 8;
-
+		 switch(ainfo->storage)
+		   {
+		   case ArgAggregate:
+		     a_off += ainfo->nslots * 8;
+		     break;
+		   default:
+		     a_off += sizeof (gpointer);
+		   }
 		//   (/*(ainfo->reg - 16)*/ i * 8);
 	       }
 	     }
