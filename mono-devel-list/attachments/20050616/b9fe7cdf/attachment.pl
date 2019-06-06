Index: System.Xml/XmlEntity.cs
===================================================================
--- System.Xml/XmlEntity.cs	(revision 46082)
+++ System.Xml/XmlEntity.cs	(working copy)
@@ -57,6 +57,7 @@
 		string publicId;
 		string systemId;
 		string baseUri;
+		bool isEntityExpanding;
 
 		#endregion
 
@@ -66,6 +67,17 @@
 			get {  return baseUri; }
 		}
 
+		internal override XmlLinkedNode LastLinkedChild {
+			get {
+				if (base.LastLinkedChild == null && !isEntityExpanding) {
+					isEntityExpanding = true;
+					SetEntityContent ();
+				}
+				return base.LastLinkedChild; 
+			}
+			set { base.LastLinkedChild = value; }
+		}
+
 		public override string InnerText {
 			get { return base.InnerText; }
 			set { throw new InvalidOperationException ("This operation is not supported."); }
Index: System.Xml/XmlEntityReference.cs
===================================================================
--- System.Xml/XmlEntityReference.cs	(revision 46082)
+++ System.Xml/XmlEntityReference.cs	(working copy)
@@ -143,23 +143,5 @@
 			w.WriteName (Name);
 			w.WriteRaw (";");
 		}
-
-		internal void SetReferencedEntityContent ()
-		{
-			if (FirstChild != null)
-				return;
-
-			if (OwnerDocument.DocumentType == null)
-				return;
-
-			XmlEntity ent = Entity;
-			if (ent == null)
-				InsertBefore (OwnerDocument.CreateTextNode (String.Empty), null, false, true);
-			else {
-				ent.SetEntityContent ();
-				for (int i = 0; i < ent.ChildNodes.Count; i++)
-					InsertBefore (ent.ChildNodes [i].CloneNode (true), null, false, true);
-			}
-		}
 	}
 }
Index: System.Xml/XmlNode.cs
===================================================================
--- System.Xml/XmlNode.cs	(revision 46082)
+++ System.Xml/XmlNode.cs	(working copy)
@@ -495,18 +495,6 @@
 						prev.NextLinkedSibling = newLinkedChild;
 					newLinkedChild.NextLinkedSibling = refChild as XmlLinkedNode;
 				}
-				switch (newChild.NodeType) {
-				case XmlNodeType.EntityReference:
-					((XmlEntityReference) newChild).SetReferencedEntityContent ();
-					break;
-				case XmlNodeType.Entity:
-					((XmlEntity) newChild).SetEntityContent ();
-					break;
-				case XmlNodeType.DocumentType:
-					foreach (XmlEntity ent in ((XmlDocumentType)newChild).Entities)
-						ent.SetEntityContent ();
-					break;
-				}
 
 				if (raiseEvent)
 					ownerDoc.onNodeInserted (newChild, newChild.ParentNode);
Index: System.Xml/XmlDocument.cs
===================================================================
--- System.Xml/XmlDocument.cs	(revision 46082)
+++ System.Xml/XmlDocument.cs	(working copy)
@@ -36,7 +36,7 @@
 //
 
 using System;
-using System.Globalization;
+using System.Globalization;
 using System.IO;
 using System.Text;
 using System.Xml.XPath;
@@ -605,31 +605,53 @@
 			}
 		}
 
+		private XmlValidatingReader CreateValidatingReader( XmlTextReader reader ) 
+		{
+			XmlValidatingReader vreader = new XmlValidatingReader(reader);
+			vreader.EntityHandling = EntityHandling.ExpandCharEntities;
+			vreader.ValidationType = ValidationType.None;
+			vreader.XmlResolver = resolver;
+			return vreader;
+		}
+
 		public virtual void Load (Stream inStream)
 		{
-			XmlTextReader reader = new XmlTextReader (inStream, NameTable);
-			reader.XmlResolver = resolver;
-			Load (reader);
+			XmlTextReader xr = new XmlTextReader (inStream, NameTable);
+			XmlValidatingReader vreader = CreateValidatingReader(xr);
+			try
+			{
+				Load (vreader);
+			}
+			finally
+			{
+				vreader.Close();
+			}
 		}
 
 		public virtual void Load (string filename)
 		{
-			XmlTextReader xr = null;
+			XmlTextReader xr = new XmlTextReader (filename, NameTable);
+			xr.XmlResolver = resolver;
+			XmlValidatingReader vreader = CreateValidatingReader(xr);
 			try {
-				xr = new XmlTextReader (filename, NameTable);
-				xr.XmlResolver = resolver;
-				Load (xr);
+				Load (vreader);
 			} finally {
-				if (xr != null)
-					xr.Close ();
+				vreader.Close ();
 			}
 		}
 
 		public virtual void Load (TextReader txtReader)
 		{
 			XmlTextReader xr = new XmlTextReader (txtReader, NameTable);
-			xr.XmlResolver = resolver;
-			Load (xr);
+			XmlValidatingReader vreader = CreateValidatingReader(xr);
+			try 
+			{
+				Load (vreader);
+			} 
+			finally 
+			{
+				vreader.Close ();
+			}
 		}
 
 		public virtual void Load (XmlReader xmlReader)
@@ -666,9 +688,10 @@
 				xml,
 				XmlNodeType.Document,
 				new XmlParserContext (NameTable, null, null, XmlSpace.None));
+			xmlReader.XmlResolver = resolver;
+			XmlValidatingReader vreader = CreateValidatingReader(xmlReader);
 			try {
-				xmlReader.XmlResolver = resolver;
-				Load (xmlReader);
+				Load (vreader);
 			} finally {
 				xmlReader.Close ();
 			}
