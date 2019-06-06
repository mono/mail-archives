Index: mono/metadata/threadpool.h
===================================================================
--- mono/metadata/threadpool.h	(revision 72710)
+++ mono/metadata/threadpool.h	(working copy)
@@ -33,4 +33,8 @@
 ves_icall_System_Threading_ThreadPool_SetMinThreads (gint workerThreads, 
 								gint completionPortThreads) MONO_INTERNAL;
 
+MonoBoolean
+ves_icall_System_Threading_ThreadPool_SetMaxThreads (gint workerThreads, 
+								gint completionPortThreads) MONO_INTERNAL;
+
 #endif
Index: mono/metadata/icall-def.h
===================================================================
--- mono/metadata/icall-def.h	(revision 72713)
+++ mono/metadata/icall-def.h	(working copy)
@@ -804,6 +804,7 @@
 ICALL(THREADP_2, "GetMaxThreads", ves_icall_System_Threading_ThreadPool_GetMaxThreads)
 ICALL(THREADP_3, "GetMinThreads", ves_icall_System_Threading_ThreadPool_GetMinThreads)
 ICALL(THREADP_4, "SetMinThreads", ves_icall_System_Threading_ThreadPool_SetMinThreads)
+ICALL(THREADP_5, "SetMaxThreads", ves_icall_System_Threading_ThreadPool_SetMaxThreads)
 
 ICALL_TYPE(WAITH, "System.Threading.WaitHandle", WAITH_1)
 ICALL(WAITH_1, "WaitAll_internal", ves_icall_System_Threading_WaitHandle_WaitAll_internal)
