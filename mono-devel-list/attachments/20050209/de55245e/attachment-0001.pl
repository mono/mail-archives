Index: Mono.Xml.Xsl.Operations/XslForEach.cs
===================================================================
--- Mono.Xml.Xsl.Operations/XslForEach.cs	(revision 40268)
+++ Mono.Xml.Xsl.Operations/XslForEach.cs	(working copy)
@@ -72,6 +72,9 @@
 		
 		public override void Evaluate (XslTransformProcessor p)
 		{
+			if (children == null)
+				return;
+
 			p.PushNodeset (p.Select (select));
 			p.PushForEachContext ();
 			