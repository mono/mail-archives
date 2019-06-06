--- /root/mono/oldmono/mono-1.1.16.1/mcs/class/System/System.IO/FAMWatcher.cs	2006-04-14 13:49:40.000000000 -0400
+++ ./FAMWatcher.cs	2006-08-10 11:47:54.000000000 -0400
@@ -113,6 +113,8 @@
 		public void StartDispatching (FileSystemWatcher fsw)
 		{
 			FAMData data;
+			
+			
 			lock (this) {
 				if (thread == null) {
 					thread = new Thread (new ThreadStart (Monitor));
@@ -122,7 +124,8 @@
 
 				data = (FAMData) watches [fsw];
 			}
-
+			
+			
 			if (data == null) {
 				data = new FAMData ();
 				data.FSW = fsw;
@@ -149,14 +152,16 @@
 
 		static void StartMonitoringDirectory (FAMData data, bool justcreated)
 		{
+			Thread.Sleep(1);	//Sleep here to avoid deadlocks while recursivly adding directories
 			FAMRequest fr;
 			FileSystemWatcher fsw;
 			if (FAMMonitorDirectory (ref conn, data.Directory, out fr, IntPtr.Zero) == -1)
 				throw new Win32Exception ();
-
+			
 			fsw = data.FSW;
 			data.Request = fr;
-
+			
+			
 			if (data.IncludeSubdirs) {
 				foreach (string directory in Directory.GetDirectories (data.Directory)) {
 					FAMData fd = new FAMData ();