Index: Microsoft.CSharp/CSharpCodeCompiler.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.CSharp/CSharpCodeCompiler.cs,v
retrieving revision 1.16
diff -u -r1.16 CSharpCodeCompiler.cs
--- Microsoft.CSharp/CSharpCodeCompiler.cs	24 Jun 2004 11:56:57 -0000	1.16
+++ Microsoft.CSharp/CSharpCodeCompiler.cs	25 Jun 2004 04:57:41 -0000
@@ -59,7 +59,12 @@
 				windowsMonoPath = Path.Combine (
 					Path.GetDirectoryName (
 						Path.GetDirectoryName (p)),
-					"bin\\mono.exe");
+					"bin\\mono.bat");
+				if (!File.Exists (windowsMonoPath))
+					windowsMonoPath = Path.Combine (
+						Path.GetDirectoryName (
+							Path.GetDirectoryName (p)),
+						"bin\\mono.exe");
 				windowsMcsPath =
 					Path.Combine (p, "1.0\\mcs.exe");
 			}
Index: Microsoft.VisualBasic/VBCodeCompiler.cs
===================================================================
RCS file: /cvs/public/mcs/class/System/Microsoft.VisualBasic/VBCodeCompiler.cs,v
retrieving revision 1.9
diff -u -r1.9 VBCodeCompiler.cs
--- Microsoft.VisualBasic/VBCodeCompiler.cs	24 Jun 2004 12:23:39 -0000	1.9
+++ Microsoft.VisualBasic/VBCodeCompiler.cs	25 Jun 2004 04:57:41 -0000
@@ -61,7 +61,12 @@
 				windowsMonoPath = Path.Combine (
 					Path.GetDirectoryName (
 						Path.GetDirectoryName (p)),
-					"bin\\mono.exe");
+					"bin\\mono.bat");
+				if (!File.Exists (windowsMonoPath))
+					windowsMonoPath = Path.Combine (
+						Path.GetDirectoryName (
+							Path.GetDirectoryName (p)),
+						"bin\\mono.exe");
 				windowsMbasPath =
 					Path.Combine (p, "1.0\\mbas.exe");
 			}