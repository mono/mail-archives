Index: Microsoft.CSharp/CSharpCodeCompiler.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.CSharp/CSharpCodeCompiler.cs,v
retrieving revision 1.15
diff -u -r1.15 CSharpCodeCompiler.cs
--- Microsoft.CSharp/CSharpCodeCompiler.cs	21 Jun 2004 17:59:11 -0000	1.15
+++ Microsoft.CSharp/CSharpCodeCompiler.cs	23 Jun 2004 23:48:32 -0000
@@ -44,6 +44,25 @@
 
 	internal class CSharpCodeCompiler : CSharpCodeGenerator, ICodeCompiler
 	{
+		static string windowsMcsPath;
+		static string windowsMonoPath;
+
+		static CSharpCodeCompiler ()
+		{
+			if (Path.DirectorySeparatorChar == '\\') {
+				PropertyInfo gac = typeof (Environment).GetProperty ("GacPath", BindingFlags.Static|BindingFlags.NonPublic);
+				MethodInfo get_gac = gac.GetGetMethod (true);
+				string p = Path.GetDirectoryName (
+					(string) get_gac.Invoke (null, null));
+				windowsMonoPath = Path.Combine (
+					Path.GetDirectoryName (
+						Path.GetDirectoryName (p)),
+					"bin\\mono.exe");
+				windowsMcsPath =
+					Path.Combine (p, "1.0\\mcs.exe");
+			}
+		}
+
 		//
 		// Constructors
 		//
@@ -107,15 +126,22 @@
 
 			string mcs_output;
 			string[] mcs_output_lines;
-			mcs.StartInfo.FileName="mcs";
-			mcs.StartInfo.Arguments=BuildArgs(options,fileNames);
+			// FIXME: these lines had better be platform independent.
+			if (Path.DirectorySeparatorChar == '\\') {
+				mcs.StartInfo.FileName = windowsMonoPath;
+				mcs.StartInfo.Arguments = windowsMcsPath + ' ' + BuildArgs (options, fileNames);
+			}
+			else {
+				mcs.StartInfo.FileName="mcs";
+				mcs.StartInfo.Arguments=BuildArgs(options,fileNames);
+			}
 			mcs.StartInfo.CreateNoWindow=true;
 			mcs.StartInfo.UseShellExecute=false;
 			mcs.StartInfo.RedirectStandardOutput=true;
 			try {
 				mcs.Start();
-				mcs_output=mcs.StandardOutput.ReadToEnd();
 				mcs.WaitForExit();
+				mcs_output=mcs.StandardOutput.ReadToEnd();
 			} finally {
 				results.NativeCompilerReturnValue = mcs.ExitCode;
 				mcs.Close();
Index: System.Diagnostics/Process.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/System.Diagnostics/Process.cs,v
retrieving revision 1.28
diff -u -r1.28 Process.cs
--- System.Diagnostics/Process.cs	21 Jun 2004 18:00:47 -0000	1.28
+++ System.Diagnostics/Process.cs	23 Jun 2004 23:48:34 -0000
@@ -770,7 +770,11 @@
 					cmdline = startInfo.FileName + " " + startInfo.Arguments.Trim ();
 			} else {
 				appname = startInfo.FileName;
-				cmdline = startInfo.Arguments.Trim ();
+				// FIXME: There seems something wrong in process.c. We should not require extraneous command line
+				if (Path.DirectorySeparatorChar == '\\')
+					cmdline = appname + " " + startInfo.Arguments.Trim ();
+				else
+					cmdline = startInfo.Arguments.Trim ();
 			}
 
 			ret=Start_internal(appname,
