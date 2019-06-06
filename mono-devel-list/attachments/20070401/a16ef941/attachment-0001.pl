Index: mono/metadata/threadpool.c
===================================================================
--- mono/metadata/threadpool.c	(revision 72710)
+++ mono/metadata/threadpool.c	(working copy)
@@ -57,6 +57,7 @@
 static int mono_max_worker_threads;
 static int mono_min_worker_threads;
 static int mono_io_max_worker_threads;
+static int mono_io_min_worker_threads;
 
 /* current number of worker threads */
 static int mono_worker_threads = 0;
@@ -1261,13 +1262,14 @@
 void
 ves_icall_System_Threading_ThreadPool_GetAvailableThreads (gint *workerThreads, gint *completionPortThreads)
 {
-	gint busy;
+	gint busy, busy_io;
 
 	MONO_ARCH_SAVE_REGS;
 
 	busy = (gint) InterlockedCompareExchange (&busy_worker_threads, 0, -1);
+	busy_io = (gint) InterlockedCompareExchange (&busy_io_worker_threads, 0, -1);
 	*workerThreads = mono_max_worker_threads - busy;
-	*completionPortThreads = 0;
+	*completionPortThreads = mono_io_max_worker_threads - busy_io;
 }
 
 void
@@ -1276,19 +1278,21 @@
 	MONO_ARCH_SAVE_REGS;
 
 	*workerThreads = mono_max_worker_threads;
-	*completionPortThreads = 0;
+	*completionPortThreads = mono_io_max_worker_threads;
 }
 
 void
 ves_icall_System_Threading_ThreadPool_GetMinThreads (gint *workerThreads, gint *completionPortThreads)
 {
-	gint workers;
+	gint workers, workers_io;
 
 	MONO_ARCH_SAVE_REGS;
 
 	workers = (gint) InterlockedCompareExchange (&mono_min_worker_threads, 0, -1);
+	workers_io = (gint) InterlockedCompareExchange (&mono_io_min_worker_threads, 0, -1);
+
 	*workerThreads = workers;
-	*completionPortThreads = 0;
+	*completionPortThreads = workers_io;
 }
 
 MonoBoolean
@@ -1298,8 +1302,28 @@
 
 	if (workerThreads < 0 || workerThreads > mono_max_worker_threads)
 		return FALSE;
+
+	if (completionPortThreads < 0 || completionPortThreads > mono_io_max_worker_threads)
+		return FALSE;
+
 	InterlockedExchange (&mono_min_worker_threads, workerThreads);
+	InterlockedExchange (&mono_io_min_worker_threads, completionPortThreads);
 	/* FIXME: should actually start the idle threads if needed */
 	return TRUE;
 }
 
+MonoBoolean
+ves_icall_System_Threading_ThreadPool_SetMaxThreads (gint workerThreads, gint completionPortThreads)
+{
+	MONO_ARCH_SAVE_REGS;
+
+	if (workerThreads < mono_max_worker_threads)
+		return FALSE;
+
+	if (completionPortThreads < mono_io_max_worker_threads)
+		return FALSE;
+
+	InterlockedExchange (&mono_max_worker_threads, workerThreads);
+	InterlockedExchange (&mono_io_max_worker_threads, completionPortThreads);
+	return TRUE;
+}
