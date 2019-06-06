--- old\XmlEntityReference.cs	2004-01-14 16:16:55.000000000 +0200
+++ new\XmlEntityReference.cs	2004-01-14 16:04:56.552521500 +0200
@@ -19,6 +19,15 @@
 			: base (doc)
 		{
 			entityName = doc.NameTable.Add (name);
+			// fetch entity reference value from document dtd
+			// and add it as a text child to entity reference
+			string entityValueText = (doc.DocumentType != null) ? doc.DocumentType.DTD.ResolveEntity(name) : null;
+			if(entityValueText != null && entityValueText.Length > 0)
+			{
+				XmlNode entityValueNode = new XmlText(entityValueText,doc);
+				//can't just AppendChild because EntityReference node is always read-only
+				this.insertBeforeIntern(entityValueNode,null);
+			}
 		}
 
 		// Properties
