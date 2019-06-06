Index: mono-debugger-0.11.orig/backends/ProcessStart.cs
===================================================================
--- mono-debugger-0.11.orig.orig/backends/ProcessStart.cs	2005-12-14 23:22:05.000000000 +0100
+++ mono-debugger-0.11.orig/backends/ProcessStart.cs	2006-01-04 19:39:33.000000000 +0100
@@ -23,12 +23,13 @@
 
 		static ProcessStart ()
 		{
-			string base_directory = System.AppDomain.CurrentDomain.BaseDirectory;
-
-			/* Use relative path based on where Mono.Debugger.dll is at to enable relocation */
+			/* Use relative path based on where mscorlib.dll is at to enable relocation */
+			string corlibURI = typeof (object).Assembly.CodeBase;
+			string corlibPath= new Uri (corlibURI).AbsolutePath;
+			string corlibDirPath = Path.GetDirectoryName (corlibPath);
 			JitWrapper = Path.GetFullPath (
-				base_directory + Path.DirectorySeparatorChar +
-				Path.DirectorySeparatorChar + "mono-debugger-mini-wrapper");
+				corlibDirPath + Path.DirectorySeparatorChar +
+				"mono-debugger-mini-wrapper");
 		}
 
 		protected static bool IsMonoAssembly (string filename)
