Index: Mono.Xml.Xsl/XmlWriterEmitter.cs
===================================================================
--- Mono.Xml.Xsl/XmlWriterEmitter.cs	(revision 40268)
+++ Mono.Xml.Xsl/XmlWriterEmitter.cs	(working copy)
@@ -115,13 +115,14 @@
 		}		
 
 		public override void WriteComment (string text) {
-			if (text.IndexOf ("--") >= 0)
+			//FIXME: horrible performance!!!
+			while (text.IndexOf ("--")>=0)
 				text = text.Replace ("--", "- -");
 
-			if (text.EndsWith ("-"))
-				writer.WriteComment (text + ' ');
-			else
-				writer.WriteComment (text);
+			if ((text.EndsWith("-")))
+				text += ' ';
+
+			writer.WriteComment (text);
 		}
 
 		public override void WriteProcessingInstruction (string name, string text)