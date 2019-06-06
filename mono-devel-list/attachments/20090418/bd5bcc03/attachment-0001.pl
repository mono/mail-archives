Index: mini/mini-exceptions.c
===================================================================
--- mini/mini-exceptions.c	(revision 131605)
+++ mini/mini-exceptions.c	(working copy)
@@ -921,7 +921,7 @@
 	if (!test_only) {
 		MonoContext ctx_cp = *ctx;
 		if (mono_trace_is_enabled ())
-			g_print ("EXCEPTION handling: %s\n", mono_object_class (obj)->name);
+			g_print ("[Thread %p] EXCEPTION handling: %s\n", (void*)GetCurrentThreadId (), mono_object_class (obj)->name);
 		mono_profiler_exception_thrown (obj);
 		if (!mono_handle_exception_internal (&ctx_cp, obj, original_ip, TRUE, &first_filter_idx)) {
 			if (mono_break_on_exc)
