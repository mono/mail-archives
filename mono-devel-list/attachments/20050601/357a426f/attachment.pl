Index: XmlEntityReference.cs
===================================================================
--- XmlEntityReference.cs	(revision 45243)
+++ XmlEntityReference.cs	(working copy)
@@ -52,6 +52,45 @@
 			get { return base.BaseURI; }
 		}
 
+		private XmlEntity Entity {
+			get {
+				XmlDocumentType doctype = OwnerDocument.DocumentType;
+				if (doctype == null)
+					return null;
+
+				if (doctype.Entities == null)
+					return null;
+
+				return doctype.Entities.GetNamedItem (Name) as XmlEntity;
+			}
+		}
+
+		protected override string ChildrenBaseURI {
+			get {
+				XmlEntity ent = Entity;
+				if (ent == null)
+					return string.Empty;
+
+				if (ent.SystemId == null || ent.SystemId.Length == 0)
+					return ent.BaseURI;
+
+				if (ent.BaseURI == null || ent.BaseURI.Length == 0)
+					return ent.SystemId;
+				
+				Uri baseUri = null;
+				try {
+					baseUri = new Uri (ent.BaseURI);
+				} catch (UriFormatException) {
+				}
+
+				XmlResolver resolver = OwnerDocument.Resolver;
+				if (resolver != null)
+					return resolver.ResolveUri (baseUri, ent.SystemId).ToString ();
+
+				return new Uri (baseUri, ent.SystemId).ToString ();
+			}
+		}
+
 		public override bool IsReadOnly {
 			get { return true; } 
 		}
@@ -110,11 +149,10 @@
 			if (FirstChild != null)
 				return;
 
-			XmlDocumentType doctype = OwnerDocument.DocumentType;
-			if (doctype == null)
+			if (OwnerDocument.DocumentType == null)
 				return;
 
-			XmlEntity ent = doctype.Entities.GetNamedItem (Name) as XmlEntity;
+			XmlEntity ent = Entity;
 			if (ent == null)
 				InsertBefore (OwnerDocument.CreateTextNode (String.Empty), null, false, true);
 			else {
Index: XmlNode.cs
===================================================================
--- XmlNode.cs	(revision 45243)
+++ XmlNode.cs	(working copy)
@@ -72,10 +72,16 @@
 			get {
 				// Isn't it conformant to W3C XML Base Recommendation?
 				// As far as I tested, there are not...
-				return (ParentNode != null) ? ParentNode.BaseURI : String.Empty;
+				return (ParentNode != null) ? ParentNode.ChildrenBaseURI : String.Empty;
 			}
 		}
 
+		protected virtual string ChildrenBaseURI {
+			get {
+				return BaseURI;
+			}
+		}
+
 		public virtual XmlNodeList ChildNodes {
 			get {
 				if (childNodes == null)
