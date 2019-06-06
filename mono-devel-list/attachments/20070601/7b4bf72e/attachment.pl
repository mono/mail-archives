2007-05-31  Randolph Chung  <tausq@debian.org>

	* mini-exceptions.c: Adjust stack differently for architectures where
	the stack grows up.

Index: mono/mini/mini-exceptions.c
===================================================================
--- mono/mini/mini-exceptions.c	(revision 78364)
+++ mono/mini/mini-exceptions.c	(working copy)
@@ -723,7 +723,11 @@
 				has_dynamic_methods = TRUE;
 
 			if (stack_overflow)
+#ifndef MONO_ARCH_STACK_GROWS_UP
 				free_stack = (guint8*)(MONO_CONTEXT_GET_SP (ctx)) - (guint8*)(MONO_CONTEXT_GET_SP (&initial_ctx));
+#else
+				free_stack = (guint8*)(MONO_CONTEXT_GET_SP (&initial_ctx)) - (guint8*)(MONO_CONTEXT_GET_SP (ctx));
+#endif
 			else
 				free_stack = 0xffffff;
 
@@ -829,8 +833,13 @@
 					/* Switch back to normal stack */
 					if (stack_overflow) {
 						/* Free up some stack space */
+#ifndef MONO_ARCH_STACK_GROWS_UP
 						MONO_CONTEXT_SET_SP (&initial_ctx, (gssize)(MONO_CONTEXT_GET_SP (&initial_ctx)) + (64 * 1024));
 						g_assert ((gssize)MONO_CONTEXT_GET_SP (&initial_ctx) < (gssize)jit_tls->end_of_stack);
+#else
+						MONO_CONTEXT_SET_SP (&initial_ctx, (gssize)(MONO_CONTEXT_GET_SP (&initial_ctx)) - (64 * 1024));
+						g_assert ((gssize)MONO_CONTEXT_GET_SP (&initial_ctx) > (gssize)jit_tls->end_of_stack);
+#endif
 					}
 #ifdef MONO_CONTEXT_SET_FUNC
 					/* jit_tls->abort_func is a function descriptor on ia64 */

