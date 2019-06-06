Index: util/XmlResultVisitor.cs
===================================================================
--- util/XmlResultVisitor.cs	(revision 36905)
+++ util/XmlResultVisitor.cs	(working copy)
@@ -103,12 +103,12 @@
 						xmlWriter.WriteStartElement("error");
 				
 					xmlWriter.WriteStartElement("message");
-					xmlWriter.WriteCData( EncodeCData( caseResult.Message ) );
+					xmlWriter.WriteString( caseResult.Message );
 					xmlWriter.WriteEndElement();
 				
 					xmlWriter.WriteStartElement("stack-trace");
 					if(caseResult.StackTrace != null)
-						xmlWriter.WriteCData( EncodeCData( StackTraceFilter.Filter( caseResult.StackTrace ) ) );
+						xmlWriter.WriteString( StackTraceFilter.Filter( caseResult.StackTrace ) );
 					xmlWriter.WriteEndElement();
 				
 					xmlWriter.WriteEndElement();
