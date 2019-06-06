Index: Microsoft.CSharp/CSharpCodeCompiler.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.CSharp/CSharpCodeCompiler.cs,v
retrieving revision 1.15
diff -u -r1.15 CSharpCodeCompiler.cs
--- Microsoft.CSharp/CSharpCodeCompiler.cs	21 Jun 2004 17:59:11 -0000	1.15
+++ Microsoft.CSharp/CSharpCodeCompiler.cs	23 Jun 2004 00:37:19 -0000
@@ -44,6 +44,18 @@
 
 	internal class CSharpCodeCompiler : CSharpCodeGenerator, ICodeCompiler
 	{
+		static string windowsMcsPath;
+
+		static CSharpCodeCompiler ()
+		{
+			PropertyInfo gac = typeof (System.Environment).GetProperty ("GacPath",
+					BindingFlags.Static|BindingFlags.NonPublic);
+			MethodInfo get_gac = gac.GetGetMethod (true);
+			string p = Path.GetDirectoryName ((string) get_gac.Invoke (null, null));
+			windowsMcsPath = Path.Combine (Path.GetDirectoryName (Path.GetDirectoryName (p)), "bin\\mono.exe") + " " + Path.Combine (p, "1.0\\mcs.exe");
+Console.WriteLine ("*** running mcs as " + windowsMcsPath);
+		}
+
 		//
 		// Constructors
 		//
@@ -105,17 +117,26 @@
 			CompilerResults results=new CompilerResults(options.TempFiles);
 			Process mcs=new Process();
 
-			string mcs_output;
+			string mcs_output = String.Empty;
 			string[] mcs_output_lines;
-			mcs.StartInfo.FileName="mcs";
+			// FIXME: these lines had better platform independent.
+			if (Path.DirectorySeparatorChar == '\\')
+				mcs.StartInfo.FileName = windowsMcsPath;
+			else
+				mcs.StartInfo.FileName="mcs";
 			mcs.StartInfo.Arguments=BuildArgs(options,fileNames);
 			mcs.StartInfo.CreateNoWindow=true;
-			mcs.StartInfo.UseShellExecute=false;
-			mcs.StartInfo.RedirectStandardOutput=true;
+			// FIXME: these lines shoule be platform independent.
+			if (Path.DirectorySeparatorChar != '\\') {
+				mcs.StartInfo.UseShellExecute=false;
+				mcs.StartInfo.RedirectStandardOutput=true;
+			}
 			try {
 				mcs.Start();
-				mcs_output=mcs.StandardOutput.ReadToEnd();
 				mcs.WaitForExit();
+				// FIXME: these lines shoule be platform independent.
+				if (Path.DirectorySeparatorChar != '\\')
+					mcs_output=mcs.StandardOutput.ReadToEnd();
 			} finally {
 				results.NativeCompilerReturnValue = mcs.ExitCode;
 				mcs.Close();