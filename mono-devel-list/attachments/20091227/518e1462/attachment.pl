Index: monowrap.cs
===================================================================
--- monowrap.cs	(revision 148912)
+++ monowrap.cs	(working copy)
@@ -115,12 +115,19 @@
 			}
 			Environment.SetEnvironmentVariable ("MONO_PATH", sb.ToString ());
 
+			string compilerargs = compiler + " " + String.Join (" ", args);
+			int responseFileStart = compilerargs.IndexOf("@");
+			if (responseFileStart!=-1)
+				compilerargs = compilerargs.Insert(responseFileStart+1,"\"") + '\"';
+
 			Console.WriteLine ("Compiler: {0}", compiler);
 			Console.WriteLine ("MONO_PATH: {0}", sb.ToString ());
+			Console.WriteLine ("Arguments: {0}", compilerargs);
+			
 			var pi = new ProcessStartInfo() {
 				FileName = mono_cmd,
 				WindowStyle = ProcessWindowStyle.Hidden,
-				Arguments = compiler + " " + String.Join (" ", args),
+				Arguments = compilerargs,
 				UseShellExecute = false
 			};
 