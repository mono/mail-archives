Index: class/corlib/System.Threading/ThreadPool.cs
===================================================================
--- class/corlib/System.Threading/ThreadPool.cs	(revision 72561)
+++ class/corlib/System.Threading/ThreadPool.cs	(working copy)
@@ -75,10 +75,18 @@
 			
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		public static extern void GetMinThreads (out int workerThreads, out int completionPortThreads);
-			
+
+		[MonoTODO("The min number of completion port threads is not evaluated.")]
 		[MethodImplAttribute(MethodImplOptions.InternalCall)]
 		[SecurityPermission (SecurityAction.Demand, ControlThread=true)]
 		public static extern bool SetMinThreads (int workerThreads, int completionPortThreads);
+
+#if NET_2_0
+		[MonoTODO("The max number of threads cannot be decremented.")]
+		[MethodImplAttribute(MethodImplOptions.InternalCall)]
+		[SecurityPermission (SecurityAction.Demand, ControlThread=true)]
+		public static extern bool SetMaxThreads (int workerThreads, int completionPortThreads);
+#endif
 			
 		public static bool QueueUserWorkItem (WaitCallback callback)
 		{
