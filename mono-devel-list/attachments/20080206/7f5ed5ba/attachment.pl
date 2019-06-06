diff --git a/mcs/class/corlib/System/Environment.cs b/mcs/class/corlib/System/Environment.cs
index 9e09405..ff6ca28 100644
--- a/mcs/class/corlib/System/Environment.cs
+++ b/mcs/class/corlib/System/Environment.cs
@@ -232,14 +232,21 @@ namespace System {
 				return MachineName;
 			}
 		}
-
+		
+		private static bool IsInteractive = true;
+		
+		private static void SetUserInteractive(bool Value)
+		{
+			IsInteractive = Value;
+		}
+		
 		/// <summary>
-		/// Gets a flag indicating whether the process is in interactive mode
+		/// Gets a flag indicating whether the process is in interactive mode.
+		/// Running under mono-service sets this to false.
 		/// </summary>
-		[MonoTODO ("Currently always returns false, regardless of interactive state")]
 		public static bool UserInteractive {
 			get {
-				return false;
+				return IsInteractive;
 			}
 		}
 
diff --git a/mcs/tools/mono-service/mono-service.cs b/mcs/tools/mono-service/mono-service.cs
index 41c4931..54379e4 100644
--- a/mcs/tools/mono-service/mono-service.cs
+++ b/mcs/tools/mono-service/mono-service.cs
@@ -100,10 +100,13 @@ class MonoServiceRunner : MarshalByRefObject
 		if (lockfile == null)
 			lockfile = String.Format ("/tmp/{0}.lock", Path.GetFileName (assembly));
 
-		int lfp = Syscall.open (lockfile, OpenFlags.O_RDWR|OpenFlags.O_CREAT|OpenFlags.O_EXCL, 
+		int lfp = Syscall.open (lockfile, OpenFlags.O_RDWR, 
 			FilePermissions.S_IRUSR|FilePermissions.S_IWUSR|FilePermissions.S_IRGRP);
+		if (lfp<0)
+			lfp = Syscall.open (lockfile, OpenFlags.O_RDWR|OpenFlags.O_CREAT|OpenFlags.O_EXCL, 
+				FilePermissions.S_IRUSR|FilePermissions.S_IWUSR|FilePermissions.S_IRGRP);
 
-		if (lfp<0)  {
+		if (lfp<0) {
 		        // Provide some useful info
 			if (File.Exists (lockfile))
 				error (logname, String.Format ("Lock file already exists: {0}", lockfile));
@@ -119,6 +122,7 @@ class MonoServiceRunner : MarshalByRefObject
 		
 		try {
 			// Write pid to lock file
+			Syscall.ftruncate (lfp, 0);
 			string pid = Syscall.getpid ().ToString () + Environment.NewLine;
 			IntPtr buf = Marshal.StringToCoTaskMemAnsi (pid);
 			Syscall.write (lfp, buf, (ulong)pid.Length);
@@ -169,9 +173,18 @@ class MonoServiceRunner : MarshalByRefObject
 			
 			// Hook up 
 			Stdlib.signal (Signum.SIGTERM, new SignalHandler (my_handler));
+			Stdlib.signal (Signum.SIGINT,  new SignalHandler (my_handler));
 			Stdlib.signal (Signum.SIGUSR1, new SignalHandler (my_handler));
 			Stdlib.signal (Signum.SIGUSR2, new SignalHandler (my_handler));
 	
+			// Tell the application we're not interactive
+			// (ie. no GUI)
+			Type.GetType ("System.Environment")
+				.GetMethod ("SetUserInteractive",
+					    System.Reflection.BindingFlags.Static
+					  | System.Reflection.BindingFlags.NonPublic)
+				.Invoke (null, new object[] { false });
+			
 			// Load service assembly
 			Assembly a = null;
 			
@@ -261,6 +274,7 @@ class MonoServiceRunner : MarshalByRefObject
 					
 					switch (v){
 					case Signum.SIGTERM:
+					case Signum.SIGINT:
 						if (service.CanStop) {
 							info (logname, "Stopping service {0}", service.ServiceName);
 							call (service, "OnStop", null);