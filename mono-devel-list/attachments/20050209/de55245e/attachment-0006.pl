Index: Mono.Xml.Xsl/XsltCompiledContext.cs
===================================================================
--- Mono.Xml.Xsl/XsltCompiledContext.cs	(revision 40268)
+++ Mono.Xml.Xsl/XsltCompiledContext.cs	(working copy)
@@ -106,6 +106,7 @@
 				return mi [0]; // if we dont have info on the arg types, nothing we can do
 
 
+			name = name.Replace('-', '_');
 			free = 0;
 			// filter on name + num args
 			int numArgs = argTypes.Length;