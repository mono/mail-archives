Index: System.Xml/XmlDocumentNavigator.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.XML/System.Xml/XmlDocumentNavigator.cs,v
retrieving revision 1.11
diff -u -r1.11 XmlDocumentNavigator.cs
--- System.Xml/XmlDocumentNavigator.cs	25 Jun 2003 17:31:57 -0000	1.11
+++ System.Xml/XmlDocumentNavigator.cs	29 Jun 2003 18:01:50 -0000
@@ -1,10 +1,12 @@
 //
 // System.Xml.XmlDocumentNavigator
 //
-// Author:
+// Authors:
 //   Jason Diamond <jason@injektilo.org>
+//   Atsushi Enomoto <ginga@kit.hi-ho.ne.jp>
 //
 // (C) 2002 Jason Diamond
+// (C) 2003 Atsushi Enomoto
 //
 
 using System;
@@ -28,10 +30,13 @@
 		#endregion
 
 		#region Fields
+		private const string Xmlns = "http://www.w3.org/2000/xmlns/";
+		private const string XmlnsXML = "http://www.w3.org/XML/1998/namespace";
 
 		private XmlNode node;
 		private XmlDocument document;
-		private IEnumerator attributesEnumerator;
+		// Current namespace node (ancestor's attribute of current node).
+		private XmlNode nsNode;
 
 		#endregion
 
@@ -45,9 +50,12 @@
 
 		public override bool HasAttributes {
 			get {
+				if (nsNode != null)
+					return false;
+
 				if (node.Attributes != null)
 					foreach (XmlAttribute attribute in node.Attributes)
-						if (attribute.NamespaceURI != "http://www.w3.org/2000/xmlns/")
+						if (attribute.NamespaceURI != Xmlns)
 							return true;
 				return false;
 			}
@@ -55,6 +63,9 @@
 
 		public override bool HasChildren {
 			get {
+				if (nsNode != null)
+					return false;
+
 				XPathNodeType nodeType = NodeType;
 				bool canHaveChildren = nodeType == XPathNodeType.Root || nodeType == XPathNodeType.Element;
 				return canHaveChildren && node.FirstChild != null;
@@ -63,6 +74,9 @@
 
 		public override bool IsEmptyElement {
 			get {
+				if (nsNode != null)
+					return false;
+
 				return node.NodeType == XmlNodeType.Element 
 					&& ((XmlElement) node).IsEmpty;
 			}
@@ -70,6 +84,13 @@
 
 		public override string LocalName {
 			get {
+				if (nsNode != null) {
+					if (nsNode == document)
+						return "xml";
+					else
+						return (nsNode.Name == "xmlns") ? String.Empty : nsNode.LocalName;
+				}
+
 				XPathNodeType nodeType = NodeType;
 				bool canHaveName = 
 					nodeType == XPathNodeType.Element || 
@@ -82,6 +103,9 @@
 
 		public override string Name {
 			get {
+				if (nsNode != null)
+					return LocalName;
+
 				XPathNodeType nodeType = NodeType;
 				bool canHaveName = 
 					nodeType == XPathNodeType.Element || 
@@ -93,9 +117,7 @@
 		}
 
 		public override string NamespaceURI {
-			get {
-				return node.NamespaceURI;
-			}
+			get { return (nsNode != null) ? String.Empty : node.NamespaceURI; }
 		}
 
 		public override XmlNameTable NameTable {
@@ -105,15 +127,11 @@
 		}
 
 		public override XPathNodeType NodeType {
-			get {
-				return node.XPathNodeType;
-			}
+			get { return (nsNode != null) ? XPathNodeType.Namespace : node.XPathNodeType; }
 		}
 
 		public override string Prefix {
-			get {
-				return node.Prefix;
-			}
+			get { return (nsNode != null) ? String.Empty : node.Prefix; }
 		}
 
 		public override string Value {
@@ -129,6 +147,8 @@
 				case XPathNodeType.Element:
 				case XPathNodeType.Root:
 					return node.InnerText;
+				case XPathNodeType.Namespace:
+					return nsNode == document ? XmlnsXML : nsNode.Value;
 				}
 				return String.Empty;
 			}
@@ -146,13 +166,18 @@
 
 		public override XPathNavigator Clone ()
 		{
-			return new XmlDocumentNavigator (node);
+			XmlDocumentNavigator clone = new XmlDocumentNavigator (node);
+			clone.nsNode = nsNode;
+			return clone;
 		}
 
 		public override string GetAttribute (string localName, string namespaceURI)
 		{
-			XmlElement el = Node as XmlElement;
-			return el != null ? el.GetAttribute (localName, namespaceURI) : String.Empty;
+			if (HasAttributes) {
+				XmlElement el = Node as XmlElement;
+				return el != null ? el.GetAttribute (localName, namespaceURI) : String.Empty;
+			}
+			return String.Empty;
 		}
 
 		public override string GetNamespace (string name)
@@ -168,7 +193,8 @@
 		{
 			XmlDocumentNavigator otherDocumentNavigator = other as XmlDocumentNavigator;
 			if (otherDocumentNavigator != null)
-				return node == otherDocumentNavigator.node;
+				return node == otherDocumentNavigator.node
+					&& nsNode == otherDocumentNavigator.nsNode;
 			return false;
 		}
 
@@ -178,6 +204,7 @@
 			if (otherDocumentNavigator != null) {
 				if (document == otherDocumentNavigator.document) {
 					node = otherDocumentNavigator.node;
+					nsNode = otherDocumentNavigator.nsNode;
 					return true;
 				}
 			}
@@ -186,12 +213,14 @@
 
 		public override bool MoveToAttribute (string localName, string namespaceURI)
 		{
-			attributesEnumerator = node.Attributes.GetEnumerator ();
-			while (attributesEnumerator.MoveNext ()) {
-				XmlAttribute attr = attributesEnumerator.Current as XmlAttribute;
-				if (attr.LocalName == localName && attr.NamespaceURI == namespaceURI) {
-					node = attr;
-					return true;
+			if (node.Attributes != null) {
+				foreach (XmlAttribute attr in node.Attributes) {
+					if (attr.LocalName == localName
+						&& attr.NamespaceURI == namespaceURI) {
+						node = attr;
+						nsNode = null;
+						return true;
+					}
 				}
 			}
 			return false;
@@ -199,7 +228,7 @@
 
 		public override bool MoveToFirst ()
 		{
-			if (node.NodeType != XmlNodeType.Attribute && node.ParentNode != null) {
+			if (nsNode == null && node.NodeType != XmlNodeType.Attribute && node.ParentNode != null) {
 				MoveToParent ();
 				// Follow these 2 steps so that we can skip 
 				// some types of nodes .
@@ -211,9 +240,16 @@
 
 		public override bool MoveToFirstAttribute ()
 		{
+			if (node.Attributes == null)
+				return false;
 			if (NodeType == XPathNodeType.Element) {
-				attributesEnumerator = node.Attributes.GetEnumerator ();
-				return MoveToNextAttribute ();
+				foreach (XmlAttribute attr in node.Attributes) {
+					if (attr.NamespaceURI != Xmlns) {
+						node = attr;
+						nsNode = null;
+						return true;
+					}
+				}
 			}
 			return false;
 		}
@@ -248,10 +284,32 @@
 			return false;
 		}
 
-		[MonoTODO]
 		public override bool MoveToFirstNamespace (XPathNamespaceScope namespaceScope)
 		{
-			throw new NotImplementedException ();
+			if (NodeType != XPathNodeType.Element)
+				return false;
+
+			XmlElement el = node as XmlElement;
+			if (node.Attributes != null) {
+				do {
+					foreach (XmlAttribute attr in el.Attributes) {
+						if (attr.NamespaceURI == Xmlns) {
+							nsNode = attr;
+							return true;
+						}
+					}
+					if (namespaceScope == XPathNamespaceScope.Local)
+						return false;
+					el = node.ParentNode as XmlElement;
+				} while (el != null);
+			}
+
+			if (namespaceScope == XPathNamespaceScope.All) {
+				nsNode = document;
+				return true;
+			}
+			else
+				return false;
 		}
 
 		public override bool MoveToId (string id)
@@ -264,14 +322,36 @@
 			return true;
 		}
 
-		[MonoTODO]
 		public override bool MoveToNamespace (string name)
 		{
-			throw new NotImplementedException ();
+			if (name == "xml") {
+				nsNode = document;
+				return true;
+			}
+
+			if (NodeType != XPathNodeType.Element)
+				return false;
+
+			XmlElement el = node as XmlElement;
+			if (node.Attributes != null) {
+				do {
+					foreach (XmlAttribute attr in el.Attributes) {
+						if (attr.NamespaceURI == Xmlns && Name == name) {
+							nsNode = attr;
+							return true;
+						}
+					}
+					el = node.ParentNode as XmlElement;
+				} while (el != null);
+			}
+			return false;
 		}
 
 		public override bool MoveToNext ()
 		{
+			if (nsNode != null)
+				return false;
+
 			if (node.NextSibling != null) {
 				if (node.ParentNode != null && node.ParentNode.NodeType == XmlNodeType.Document) {
 					XmlNode n = node.NextSibling;
@@ -299,29 +379,96 @@
 
 		public override bool MoveToNextAttribute ()
 		{
-			if (attributesEnumerator != null && attributesEnumerator.MoveNext ()) {
-				node = attributesEnumerator.Current as XmlAttribute;
-				return true;
+			if (NodeType != XPathNodeType.Attribute)
+				return false;
+
+			// Find current attribute.
+			int pos = 0;
+			XmlElement owner = ((XmlAttribute) node).OwnerElement;
+			int count = owner.Attributes.Count;
+			for(; pos < count; pos++)
+				if (owner.Attributes [pos] == node)
+					break;
+			if (pos == count)
+				return false;	// Where is current attribute? Maybe removed.
+
+			// Find next attribute.
+			for(pos++; pos < count; pos++) {
+				if (owner.Attributes [pos].NamespaceURI != Xmlns) {
+					node = owner.Attributes [pos];
+					nsNode = null;
+					return true;
+				}
 			}
 			return false;
 		}
 
-		[MonoTODO]
 		public override bool MoveToNextNamespace (XPathNamespaceScope namespaceScope)
 		{
-			throw new NotImplementedException ();
+			if (nsNode == document)
+				// Current namespace is "xml", so there should be no more namespace nodes.
+				return false;
+
+			if (nsNode == null)
+				return false;
+
+			// Get current attribute's position.
+			int pos = 0;
+			XmlElement owner = ((XmlAttribute) nsNode).OwnerElement;
+			int count = owner.Attributes.Count;
+			for(; pos < count; pos++)
+				if (owner.Attributes [pos] == nsNode)
+					break;
+			if (pos == count)
+				return false;	// Where is current attribute? Maybe removed.
+
+			// Find next namespace from the same element as current ns node.
+			for(pos++; pos < count; pos++) {
+				if (owner.Attributes [pos].NamespaceURI == Xmlns) {
+					nsNode = owner.Attributes [pos];
+					return true;
+				}
+			}
+
+			// If not found more, then find from ancestors.
+			// But if scope is Local, then it returns false here.
+			if (namespaceScope == XPathNamespaceScope.Local)
+				return false;
+			owner = owner.ParentNode as XmlElement;
+			while (owner != null) {
+				foreach (XmlAttribute attr in owner.Attributes) {
+					if (attr.NamespaceURI == Xmlns) {
+						nsNode = attr;
+						return true;
+					}
+				}
+				owner = owner.ParentNode as XmlElement;
+			}
+
+			if (namespaceScope == XPathNamespaceScope.All) {
+				nsNode = document;
+				return true;
+			}
+			else
+				return false;
 		}
 
 		public override bool MoveToParent ()
 		{
-			if (node.NodeType == XmlNodeType.Attribute) {
+			if (nsNode != null) {
+				nsNode = null;
+				return true;
+			}
+			else if (node.NodeType == XmlNodeType.Attribute) {
 				XmlElement ownerElement = ((XmlAttribute)node).OwnerElement;
 				if (ownerElement != null) {
 					node = ownerElement;
+					nsNode = null;
 					return true;
 				}
 			} else if (node.ParentNode != null) {
 				node = node.ParentNode;
+				nsNode = null;
 				return true;
 			}
 			return false;
@@ -329,6 +476,9 @@
 
 		public override bool MoveToPrevious ()
 		{
+			if (nsNode != null)
+				return false;
+
 			if (node.PreviousSibling != null) {
 				node = node.PreviousSibling;
 				return true;
@@ -339,6 +489,7 @@
 		public override void MoveToRoot ()
 		{
 			node = document;
+			nsNode = null;
 		}
 
 		internal XmlNode Node { get { return node; } }
