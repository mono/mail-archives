Index: libgc/include/private/gcconfig.h
===================================================================
--- libgc/include/private/gcconfig.h	(revision 42489)
+++ libgc/include/private/gcconfig.h	(working copy)
@@ -1186,8 +1186,8 @@
 #	ifndef GC_FREEBSD_THREADS
 #	    define MPROTECT_VDB
 #	endif
-#	define SIG_SUSPEND SIGUSR1
-#	define SIG_THR_RESTART SIGUSR2
+#      define SIG_SUSPEND SIGTSTP
+#      define SIG_THR_RESTART SIGCONT
 #	define FREEBSD_STACKBOTTOM
 #	ifdef __ELF__
 #	    define DYNAMIC_LOADING
@@ -1501,8 +1501,8 @@
 #   ifdef FREEBSD
 #	define OS_TYPE "FREEBSD"
 /* MPROTECT_VDB is not yet supported at all on FreeBSD/alpha. */
-#	define SIG_SUSPEND SIGUSR1
-#	define SIG_THR_RESTART SIGUSR2
+#      define SIG_SUSPEND SIGTSTP
+#      define SIG_THR_RESTART SIGCONT
 #	define FREEBSD_STACKBOTTOM
 #	ifdef __ELF__
 #	    define DYNAMIC_LOADING
Index: libgc/os_dep.c
===================================================================
--- libgc/os_dep.c	(revision 42489)
+++ libgc/os_dep.c	(working copy)
@@ -702,10 +702,10 @@
 #   endif
 
 #   if defined(SUNOS5SIGS) || defined(IRIX5) || defined(OSF1) \
-    || defined(HURD) || defined(NETBSD)
+    || defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 	static struct sigaction old_segv_act;
 #	if defined(_sigargs) /* !Irix6.x */ || defined(HPUX) \
-	|| defined(HURD) || defined(NETBSD)
+	|| defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 	    static struct sigaction old_bus_act;
 #	endif
 #   else
@@ -720,7 +720,7 @@
 #   endif
     {
 #	if defined(SUNOS5SIGS) || defined(IRIX5)  \
-        || defined(OSF1) || defined(HURD) || defined(NETBSD)
+        || defined(OSF1) || defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 	  struct sigaction	act;
 
 	  act.sa_handler	= h;
@@ -740,7 +740,7 @@
 #	  else
 	        (void) sigaction(SIGSEGV, &act, &old_segv_act);
 #		if defined(IRIX5) && defined(_sigargs) /* Irix 5.x, not 6.x */ \
-		   || defined(HPUX) || defined(HURD) || defined(NETBSD)
+		   || defined(HPUX) || defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 		    /* Under Irix 5.x or HP/UX, we may get SIGBUS.	*/
 		    /* Pthreads doesn't exist under Irix 5.x, so we	*/
 		    /* don't have to worry in the threads case.		*/
@@ -776,10 +776,10 @@
     void GC_reset_fault_handler()
     {
 #       if defined(SUNOS5SIGS) || defined(IRIX5) \
-	   || defined(OSF1) || defined(HURD) || defined(NETBSD)
+	   || defined(OSF1) || defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 	  (void) sigaction(SIGSEGV, &old_segv_act, 0);
 #	  if defined(IRIX5) && defined(_sigargs) /* Irix 5.x, not 6.x */ \
-	     || defined(HPUX) || defined(HURD) || defined(NETBSD)
+	     || defined(HPUX) || defined(HURD) || defined(NETBSD) || defined(FREEBSD)
 	      (void) sigaction(SIGBUS, &old_bus_act, 0);
 #	  endif
 #       else
Index: libgc/dyn_load.c
===================================================================
--- libgc/dyn_load.c	(revision 42489)
+++ libgc/dyn_load.c	(working copy)
@@ -96,20 +96,28 @@
 /* Newer versions of GNU/Linux define this macro.  We
  * define it similarly for any ELF systems that don't.  */
 #  ifndef ElfW
-#    ifdef NETBSD
-#      if ELFSIZE == 32
+#    ifdef FREEBSD
+#      if __ELF_WORD_SIZE == 32
 #        define ElfW(type) Elf32_##type
 #      else
 #        define ElfW(type) Elf64_##type
 #      endif
 #    else
-#      if !defined(ELF_CLASS) || ELF_CLASS == ELFCLASS32
-#        define ElfW(type) Elf32_##type
+#      ifdef NETBSD
+#        if ELFSIZE == 32
+#          define ElfW(type) Elf32_##type
+#        else
+#          define ElfW(type) Elf64_##type
+#        endif
 #      else
-#        define ElfW(type) Elf64_##type
+#        if !defined(ELF_CLASS) || ELF_CLASS == ELFCLASS32
+#          define ElfW(type) Elf32_##type
+#        else
+#          define ElfW(type) Elf64_##type
+#        endif
 #      endif
 #    endif
-#  endif
+#  endif 
 
 #if defined(SUNOS5DL) && !defined(USE_PROC_FOR_LIBRARIES)
 
Index: mono/mini/exceptions-x86.c
===================================================================
--- mono/mini/exceptions-x86.c	(revision 42489)
+++ mono/mini/exceptions-x86.c	(working copy)
@@ -148,17 +148,17 @@
 	x86_mov_reg_membase (code, X86_EAX, X86_ESP, 4, 4);
 
 	/* get return address, stored in EDX */
-	x86_mov_reg_membase (code, X86_EDX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, eip), 4);
+	x86_mov_reg_membase (code, X86_EDX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EIP), 4);
 	/* restore EBX */
-	x86_mov_reg_membase (code, X86_EBX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, ebx), 4);
+	x86_mov_reg_membase (code, X86_EBX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EBX), 4);
 	/* restore EDI */
-	x86_mov_reg_membase (code, X86_EDI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, edi), 4);
+	x86_mov_reg_membase (code, X86_EDI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EDI), 4);
 	/* restore ESI */
-	x86_mov_reg_membase (code, X86_ESI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, esi), 4);
+	x86_mov_reg_membase (code, X86_ESI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_ESI), 4);
 	/* restore ESP */
-	x86_mov_reg_membase (code, X86_ESP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, esp), 4);
+	x86_mov_reg_membase (code, X86_ESP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_ESP), 4);
 	/* restore EBP */
-	x86_mov_reg_membase (code, X86_EBP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, ebp), 4);
+	x86_mov_reg_membase (code, X86_EBP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EBP), 4);
 
 	/* jump to the saved IP */
 	x86_jump_reg (code, X86_EDX);
@@ -201,11 +201,11 @@
 	x86_push_reg (code, X86_EBP);
 
 	/* set new EBP */
-	x86_mov_reg_membase (code, X86_EBP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, ebp), 4);
+	x86_mov_reg_membase (code, X86_EBP, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EBP), 4);
 	/* restore registers used by global register allocation (EBX & ESI) */
-	x86_mov_reg_membase (code, X86_EBX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, ebx), 4);
-	x86_mov_reg_membase (code, X86_ESI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, esi), 4);
-	x86_mov_reg_membase (code, X86_EDI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, edi), 4);
+	x86_mov_reg_membase (code, X86_EBX, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EBX), 4);
+	x86_mov_reg_membase (code, X86_ESI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_ESI), 4);
+	x86_mov_reg_membase (code, X86_EDI, X86_EAX,  G_STRUCT_OFFSET (MonoContext, SC_EDI), 4);
 
 	/* call the handler */
 	x86_call_reg (code, X86_ECX);
@@ -236,15 +236,15 @@
 		restore_context = mono_arch_get_restore_context ();
 
 	/* Pop argument and return address */
-	ctx.esp = esp + (2 * sizeof (gpointer));
-	ctx.eip = eip;
-	ctx.ebp = ebp;
-	ctx.edi = edi;
-	ctx.esi = esi;
-	ctx.ebx = ebx;
-	ctx.edx = edx;
-	ctx.ecx = ecx;
-	ctx.eax = eax;
+	ctx.SC_ESP = esp + (2 * sizeof (gpointer));
+	ctx.SC_EIP = eip;
+	ctx.SC_EBP = ebp;
+	ctx.SC_EDI = edi;
+	ctx.SC_ESI = esi;
+	ctx.SC_EBX = ebx;
+	ctx.SC_EDX = edx;
+	ctx.SC_ECX = ecx;
+	ctx.SC_EAX = eax;
 
 	if (mono_debugger_throw_exception ((gpointer)(eip - 5), (gpointer)esp, exc)) {
 		/*
@@ -252,14 +252,14 @@
 		 * By the time we get here, it already inserted a breakpoint on
 		 * eip - 5 (which is the address of the call).
 		 */
-		ctx.eip = eip - 5;
-		ctx.esp = esp + sizeof (gpointer);
+		ctx.SC_EIP = eip - 5;
+		ctx.SC_ESP = esp + sizeof (gpointer);
 		restore_context (&ctx);
 		g_assert_not_reached ();
 	}
 
 	/* adjust eip so that it point into the call instruction */
-	ctx.eip -= 1;
+	ctx.SC_EIP -= 1;
 
 	if (mono_object_isinst (exc, mono_defaults.exception_class)) {
 		MonoException *mono_ex = (MonoException*)exc;
@@ -472,24 +472,24 @@
 			 * code, since otherwise the lmf was already popped of the stack.
 			 */
 			if (*lmf && (MONO_CONTEXT_GET_BP (ctx) >= (gpointer)(*lmf)->ebp)) {
-				new_ctx->esi = (*lmf)->esi;
-				new_ctx->edi = (*lmf)->edi;
-				new_ctx->ebx = (*lmf)->ebx;
+				new_ctx->SC_ESI = (*lmf)->esi;
+				new_ctx->SC_EDI = (*lmf)->edi;
+				new_ctx->SC_EBX = (*lmf)->ebx;
 			}
 		}
 		else {
 			offset = -1;
 			/* restore caller saved registers */
 			if (ji->used_regs & X86_EBX_MASK) {
-				new_ctx->ebx = *((int *)ctx->ebp + offset);
+				new_ctx->SC_EBX = *((int *)ctx->SC_EBP + offset);
 				offset--;
 			}
 			if (ji->used_regs & X86_EDI_MASK) {
-				new_ctx->edi = *((int *)ctx->ebp + offset);
+				new_ctx->SC_EDI = *((int *)ctx->SC_EBP + offset);
 				offset--;
 			}
 			if (ji->used_regs & X86_ESI_MASK) {
-				new_ctx->esi = *((int *)ctx->ebp + offset);
+				new_ctx->SC_ESI = *((int *)ctx->SC_EBP + offset);
 			}
 		}
 
@@ -499,17 +499,17 @@
 		}
 
 		/* Pop EBP and the return address */
-		new_ctx->esp = ctx->SC_EBP + (2 * sizeof (gpointer));
+		new_ctx->SC_ESP = ctx->SC_EBP + (2 * sizeof (gpointer));
 		/* we substract 1, so that the IP points into the call instruction */
-		new_ctx->eip = *((int *)ctx->ebp + 1) - 1;
-		new_ctx->ebp = *((int *)ctx->ebp);
+		new_ctx->SC_EIP = *((int *)ctx->SC_EBP + 1) - 1;
+		new_ctx->SC_EBP = *((int *)ctx->SC_EBP );
 
 		/* Pop arguments off the stack */
 		{
 			MonoJitArgumentInfo *arg_info = g_newa (MonoJitArgumentInfo, mono_method_signature (ji->method)->param_count + 1);
 
 			guint32 stack_to_pop = mono_arch_get_argument_info (mono_method_signature (ji->method), mono_method_signature (ji->method)->param_count, arg_info);
-			new_ctx->esp += stack_to_pop;
+			new_ctx->SC_ESP += stack_to_pop;
 		}
 
 		return ji;
@@ -526,14 +526,14 @@
 			res->method = (*lmf)->method;
 		}
 
-		new_ctx->esi = (*lmf)->esi;
-		new_ctx->edi = (*lmf)->edi;
-		new_ctx->ebx = (*lmf)->ebx;
-		new_ctx->ebp = (*lmf)->ebp;
-		new_ctx->eip = (*lmf)->eip;
+		new_ctx->SC_ESI = (*lmf)->esi;
+		new_ctx->SC_EDI = (*lmf)->edi;
+		new_ctx->SC_EBX = (*lmf)->ebx;
+		new_ctx->SC_EBP = (*lmf)->ebp;
+		new_ctx->SC_EIP = (*lmf)->eip;
 		/* the lmf is always stored on the stack, so the following
 		 * expression points to a stack location which can be used as ESP */
-		new_ctx->esp = (unsigned long)&((*lmf)->eip);
+		new_ctx->SC_ESP = (unsigned long)&((*lmf)->eip);
 
 		*lmf = (*lmf)->previous_lmf;
 
@@ -602,7 +602,7 @@
 
 	mono_arch_sigctx_to_monoctx (sigctx, &mctx);
 
-	mono_handle_exception (&mctx, obj, (gpointer)mctx.eip, test_only);
+	mono_handle_exception (&mctx, obj, (gpointer)mctx.SC_EIP, test_only);
 
 	mono_arch_monoctx_to_sigctx (&mctx, sigctx);
 
Index: mono/mini/mini-x86.c
===================================================================
--- mono/mini/mini-x86.c	(revision 42489)
+++ mono/mini/mini-x86.c	(working copy)
@@ -586,7 +586,7 @@
 
 	mono_arch_sigctx_to_monoctx (sigctx, &ctx);
 
-	ip = (guint8*)ctx.eip;
+	ip = (guint8*)ctx.SC_EIP;
 
 	if ((ip [0] == 0xf7) && (x86_modrm_mod (ip [1]) == 0x3) && (x86_modrm_reg (ip [1]) == 0x7)) {
 		gint32 reg;
@@ -594,10 +594,10 @@
 		/* idiv REG */
 		switch (x86_modrm_rm (ip [1])) {
 		case X86_ECX:
-			reg = ctx.ecx;
+			reg = ctx.SC_ECX;
 			break;
 		case X86_EBX:
-			reg = ctx.ebx;
+			reg = ctx.SC_EBX;
 			break;
 		default:
 			g_assert_not_reached ();
Index: mono/mini/mini-x86.h
===================================================================
--- mono/mini/mini-x86.h	(revision 42489)
+++ mono/mini/mini-x86.h	(working copy)
@@ -169,13 +169,13 @@
 
 #endif
 
-#define MONO_CONTEXT_SET_IP(ctx,ip) do { (ctx)->eip = (long)(ip); } while (0); 
-#define MONO_CONTEXT_SET_BP(ctx,bp) do { (ctx)->ebp = (long)(bp); } while (0); 
-#define MONO_CONTEXT_SET_SP(ctx,sp) do { (ctx)->esp = (long)(sp); } while (0); 
+#define MONO_CONTEXT_SET_IP(ctx,ip) do { (ctx)->SC_EIP = (long)(ip); } while (0); 
+#define MONO_CONTEXT_SET_BP(ctx,bp) do { (ctx)->SC_EBP = (long)(bp); } while (0); 
+#define MONO_CONTEXT_SET_SP(ctx,sp) do { (ctx)->SC_ESP = (long)(sp); } while (0); 
 
-#define MONO_CONTEXT_GET_IP(ctx) ((gpointer)((ctx)->eip))
-#define MONO_CONTEXT_GET_BP(ctx) ((gpointer)((ctx)->ebp))
-#define MONO_CONTEXT_GET_SP(ctx) ((gpointer)((ctx)->esp))
+#define MONO_CONTEXT_GET_IP(ctx) ((gpointer)((ctx)->SC_EIP))
+#define MONO_CONTEXT_GET_BP(ctx) ((gpointer)((ctx)->SC_EBP))
+#define MONO_CONTEXT_GET_SP(ctx) ((gpointer)((ctx)->SC_ESP))
 
 #define MONO_INIT_CONTEXT_FROM_FUNC(ctx,start_func) do {	\
 		mono_arch_flush_register_windows ();	\
