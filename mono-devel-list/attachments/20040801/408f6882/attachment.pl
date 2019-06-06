? buildfix.diff
Index: DebuggingInfo.cs
===================================================================
RCS file: /cvs/public/mcs/ilasm/codegen/DebuggingInfo.cs,v
retrieving revision 1.2
diff -u -r1.2 DebuggingInfo.cs
--- DebuggingInfo.cs	30 Jul 2004 17:01:05 -0000	1.2
+++ DebuggingInfo.cs	31 Jul 2004 17:34:40 -0000
@@ -18,7 +18,7 @@
 	public class SymbolWriter : MonoSymbolWriter
 	{
 		ArrayList sources;
-		SourceMethod current_method;
+		Mono.ILASM.SourceMethod current_method;
 		SourceFile current_source;
 
 		public SymbolWriter (string filename)
@@ -27,9 +27,9 @@
 			sources = new ArrayList ();
 		}
 
-		public SourceMethod BeginMethod (MethodDef method, Location location)
+		public Mono.ILASM.SourceMethod BeginMethod (MethodDef method, Location location)
 		{
-			current_method = new SourceMethod (method, location);
+			current_method = new Mono.ILASM.SourceMethod (method, location);
 			current_source.AddMethod (current_method);
 			return current_method;
 		}