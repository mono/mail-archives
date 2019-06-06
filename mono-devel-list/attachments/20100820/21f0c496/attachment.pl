diff --git a/mono/mini/mini-exceptions.c b/mono/mini/mini-exceptions.c
index ce67a2f..6bd09fd 100644
--- a/mono/mini/mini-exceptions.c
+++ b/mono/mini/mini-exceptions.c
@@ -1213,7 +1213,7 @@ mono_handle_exception_internal (MonoContext *ctx, gpointer obj, gpointer origina
 			if (msg == NULL) {
 				msg = message ? mono_string_to_utf8 ((MonoString *) message) : g_strdup ("(System.Exception.Message property not available)");
 			}
-			g_print ("[%p:] EXCEPTION handling: %s.%s: %s\n", (void*)GetCurrentThreadId (), mono_object_class (obj)->name_space, mono_object_class (obj)->name, msg);
+			printf ("[%p:] EXCEPTION handling: %s.%s: %s\n", (void*)GetCurrentThreadId (), mono_object_class (obj)->name_space, mono_object_class (obj)->name, msg);
 			g_free (msg);
 			if (mono_ex && mono_trace_eval_exception (mono_object_class (mono_ex)))
 				mono_print_thread_dump_from_ctx (ctx);
@@ -1412,7 +1412,7 @@ mono_handle_exception_internal (MonoContext *ctx, gpointer obj, gpointer origina
 							}
 
 							if (mono_trace_is_enabled () && mono_trace_eval (ji->method))
-								g_print ("EXCEPTION: catch found at clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
+								printf ("EXCEPTION: catch found at clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
 							mono_profiler_exception_clause_handler (ji->method, ei->flags, i);
 							mono_debugger_call_exception_handler (ei->handler_start, MONO_CONTEXT_GET_SP (ctx), obj);
 							MONO_CONTEXT_SET_IP (ctx, ei->handler_start);
@@ -1426,7 +1426,7 @@ mono_handle_exception_internal (MonoContext *ctx, gpointer obj, gpointer origina
 						if (!test_only && is_address_protected (ji, ei, MONO_CONTEXT_GET_IP (ctx)) &&
 						    (ei->flags == MONO_EXCEPTION_CLAUSE_FAULT)) {
 							if (mono_trace_is_enabled () && mono_trace_eval (ji->method))
-								g_print ("EXCEPTION: fault clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
+								printf ("EXCEPTION: fault clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
 							mono_profiler_exception_clause_handler (ji->method, ei->flags, i);
 							mono_debugger_call_exception_handler (ei->handler_start, MONO_CONTEXT_GET_SP (ctx), obj);
 							call_filter (ctx, ei->handler_start);
@@ -1434,7 +1434,7 @@ mono_handle_exception_internal (MonoContext *ctx, gpointer obj, gpointer origina
 						if (!test_only && is_address_protected (ji, ei, MONO_CONTEXT_GET_IP (ctx)) &&
 						    (ei->flags == MONO_EXCEPTION_CLAUSE_FINALLY)) {
 							if (mono_trace_is_enabled () && mono_trace_eval (ji->method))
-								g_print ("EXCEPTION: finally clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
+								printf ("EXCEPTION: finally clause %d of %s\n", i, mono_method_full_name (ji->method, TRUE));
 							mono_profiler_exception_clause_handler (ji->method, ei->flags, i);
 							mono_debugger_call_exception_handler (ei->handler_start, MONO_CONTEXT_GET_SP (ctx), obj);
 							mono_perfcounters->exceptions_finallys++;
