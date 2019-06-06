Index: compiler-tester.cs
===================================================================
--- compiler-tester.cs	(revision 48485)
+++ compiler-tester.cs	(working copy)
@@ -370,6 +370,8 @@
 
 		bool ExecuteFile (string exe_name, string filename)
 		{
+			if (exe_name.EndsWith ("dll"))
+				return true;
 			if (mono == null)
 				pi.FileName = exe_name;
 			else
@@ -388,6 +390,9 @@
 
 		bool ExecuteFile (MethodInfo entry_point, string filename)
 		{
+			if (entry_point == null)
+				return true;
+
 			TextWriter standart_ouput = Console.Out;
 			TextWriter standart_error = Console.Error;
 			Console.SetOut (TextWriter.Null);
