Index: exceptions-amd64.c
===================================================================
--- exceptions-amd64.c	(revision 32648)
+++ exceptions-amd64.c	(working copy)
@@ -38,10 +38,12 @@
 static MonoW32ExceptionHandler ill_handler;
 static MonoW32ExceptionHandler segv_handler;
 
-static LPTOP_LEVEL_EXCEPTION_FILTER old_handler;
+LPTOP_LEVEL_EXCEPTION_FILTER old_win32_toplevel_exception_filter;
+guint64 win32_chained_exception_filter_result;
+gboolean win32_chained_exception_filter_didrun;
 
 #define W32_SEH_HANDLE_EX(_ex) \
-	if (_ex##_handler) _ex##_handler(0, er, sctx)
+	if (_ex##_handler) _ex##_handler(0, ep, sctx)
 
 /*
  * Unhandled Exception Filter
@@ -54,6 +56,7 @@
 	MonoContext* sctx;
 	LONG res;
 
+	win32_chained_exception_filter_didrun = FALSE;
 	res = EXCEPTION_CONTINUE_EXECUTION;
 
 	er = ep->ExceptionRecord;
@@ -114,17 +117,20 @@
 
 	g_free (sctx);
 
+	if (win32_chained_exception_filter_didrun)
+		res = win32_chained_exception_filter_result;
+
 	return res;
 }
 
 void win32_seh_init()
 {
-	old_handler = SetUnhandledExceptionFilter(seh_handler);
+	old_win32_toplevel_exception_filter = SetUnhandledExceptionFilter(seh_handler);
 }
 
 void win32_seh_cleanup()
 {
-	if (old_handler) SetUnhandledExceptionFilter(old_handler);
+	if (old_win32_toplevel_exception_filter) SetUnhandledExceptionFilter(old_win32_toplevel_exception_filter);
 }
 
 void win32_seh_set_handler(int type, MonoW32ExceptionHandler handler)
Index: exceptions-x86.c
===================================================================
--- exceptions-x86.c	(revision 32648)
+++ exceptions-x86.c	(working copy)
@@ -34,10 +34,12 @@
 static MonoW32ExceptionHandler ill_handler;
 static MonoW32ExceptionHandler segv_handler;
 
-static LPTOP_LEVEL_EXCEPTION_FILTER old_handler;
+LPTOP_LEVEL_EXCEPTION_FILTER old_win32_toplevel_exception_filter;
+guint64 win32_chained_exception_filter_result;
+gboolean win32_chained_exception_filter_didrun;
 
 #define W32_SEH_HANDLE_EX(_ex) \
-	if (_ex##_handler) _ex##_handler(0, er, sctx)
+	if (_ex##_handler) _ex##_handler(0, ep, sctx)
 
 /*
  * mono_win32_get_handle_stackoverflow (void):
@@ -167,6 +169,7 @@
 	struct sigcontext* sctx;
 	LONG res;
 
+	win32_chained_exception_filter_didrun = FALSE;
 	res = EXCEPTION_CONTINUE_EXECUTION;
 
 	er = ep->ExceptionRecord;
@@ -219,6 +222,9 @@
 
 	g_free (sctx);
 
+	if (win32_chained_exception_filter_didrun)
+		res = win32_chained_exception_filter_result;
+
 	return res;
 }
 
@@ -228,12 +234,12 @@
 	if (!restore_stack)
 		restore_stack = mono_win32_get_handle_stackoverflow ();
 
-	old_handler = SetUnhandledExceptionFilter(seh_handler);
+	old_win32_toplevel_exception_filter = SetUnhandledExceptionFilter(seh_handler);
 }
 
 void win32_seh_cleanup()
 {
-	if (old_handler) SetUnhandledExceptionFilter(old_handler);
+	if (old_win32_toplevel_exception_filter) SetUnhandledExceptionFilter(old_win32_toplevel_exception_filter);
 }
 
 void win32_seh_set_handler(int type, MonoW32ExceptionHandler handler)
Index: mini-windows.c
===================================================================
--- mini-windows.c	(revision 32648)
+++ mini-windows.c	(working copy)
@@ -50,6 +50,10 @@
 
 #include "jit-icalls.h"
 
+extern LPTOP_LEVEL_EXCEPTION_FILTER old_win32_toplevel_exception_filter;
+extern guint64 win32_chained_exception_filter_result;
+extern gboolean win32_chained_exception_filter_didrun;
+
 void
 mono_runtime_install_handlers (void)
 {
@@ -67,9 +71,24 @@
 	win32_seh_cleanup();
 }
 
+
+/* mono_chain_signal:
+ *
+ *   Call the original signal handler for the signal given by the arguments, which
+ * should be the same as for a signal handler. Returns TRUE if the original handler
+ * was called, false otherwise.
+ */
 gboolean
 SIG_HANDLER_SIGNATURE (mono_chain_signal)
 {
+	int signal = _dummy;
+	GET_CONTEXT;
+
+	if (old_win32_toplevel_exception_filter) {
+		win32_chained_exception_filter_didrun = TRUE;
+		win32_chained_exception_filter_result = (*old_win32_toplevel_exception_filter)(info);
+		return TRUE;
+	}
 	return FALSE;
 }
 
Index: mini-x86.h
===================================================================
--- mini-x86.h	(revision 32648)
+++ mini-x86.h	(working copy)
@@ -23,7 +23,7 @@
 	unsigned int eip;
 };
 
-typedef void (* MonoW32ExceptionHandler) (int _dummy, EXCEPTION_RECORD *info, void *context);
+typedef void (* MonoW32ExceptionHandler) (int _dummy, EXCEPTION_POINTERS *info, void *context);
 void win32_seh_init(void);
 void win32_seh_cleanup(void);
 void win32_seh_set_handler(int type, MonoW32ExceptionHandler handler);
Index: mini.h
===================================================================
--- mini.h	(revision 32648)
+++ mini.h	(working copy)
@@ -1958,7 +1958,7 @@
 #define SIG_HANDLER_SIGNATURE(ftn) ftn (int _dummy, siginfo_t *info, void *context)
 #define SIG_HANDLER_PARAMS _dummy, info, context
 #elif defined(PLATFORM_WIN32)
-#define SIG_HANDLER_SIGNATURE(ftn) ftn (int _dummy, EXCEPTION_RECORD *info, void *context)
+#define SIG_HANDLER_SIGNATURE(ftn) ftn (int _dummy, EXCEPTION_POINTERS *info, void *context)
 #define SIG_HANDLER_PARAMS _dummy, info, context
 #elif defined(__sparc__)
 #define SIG_HANDLER_SIGNATURE(ftn) ftn (int _dummy, void *sigctx)