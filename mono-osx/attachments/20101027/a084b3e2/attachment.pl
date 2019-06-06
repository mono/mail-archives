diff --git a/src/webkit.cs b/src/webkit.cs
index 16b530a..9496cab 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -10,21 +10,239 @@ namespace MonoMac.WebKit {
 	interface DomObject {
 	}
 
-	[BaseType (typeof (DomObject), Name="DOMRange")]
+	[BaseType (typeof (DomObject))]
 	interface DomRange {
+		[Export ("endContainer")]
+		DomNode EndContainer { get;  }
+
+		[Export ("endOffset")]
+		int EndOffset { get;  }
+
+		[Export ("collapsed")]
+		bool Collapsed { get;  }
+
+		[Export ("commonAncestorContainer")]
+		DomNode CommonAncestorContainer { get;  }
+
+		[Export ("text")]
+		string Text { get;  }
+
+		[Export ("setStart:offset:")]
+		void SetStartOffset (DomNode refNode, int offset );
+
+		[Export ("setEnd:offset:")]
+		void SetEndOffset (DomNode refNode, int offset);
+
+		[Export ("setStartBefore:")]
+		void SetStartBefore (DomNode refNode);
+
+		[Export ("setStartAfter:")]
+		void SetStartAfter (DomNode refNode);
+
+		[Export ("setEndBefore:")]
+		void SetEndBefore (DomNode refNode);
+
+		[Export ("setEndAfter:")]
+		void SetEndAfter (DomNode refNode);
+
+		[Export ("collapse:")]
+		void Collapse (bool toStart);
+
+		[Export ("selectNode:")]
+		void SelectNode (DomNode refNode);
+
+		[Export ("selectNodeContents:")]
+		void SelectNodeContents (DomNode refNode);
+
+		// Deprecated in WebKit >= 3.0
+		//[Export ("compareBoundaryPoints:sourceRange:")]
+		//short CompareBoundaryPoints (unsigned short how, DomRange sourceRange);
+
+		[Export ("deleteContents")]
+		void DeleteContents ();
+
+		[Export ("extractContents")]
+		DomDocumentFragment ExtractContents ();
+
+		[Export ("cloneContents")]
+		DomDocumentFragment CloneContents ();
+
+		[Export ("insertNode:")]
+		void InsertNode (DomNode newNode);
+
+		[Export ("surroundContents:")]
+		void SurroundContents (DomNode newParent);
+
+		[Export ("cloneRange")]
+		DomRange CloneRange ();
+
+		[Export ("toString")]
+		string ToString ();
+
+		[Export ("detach")]
+		void Detach ();
+
+		[Export ("createContextualFragment:")]
+		DomDocumentFragment CreateContextualFragment (string html);
+
+		[Export ("intersectsNode:")]
+		bool IntersectsNode (DomNode refNode);
+
+		[Export ("compareNode:")]
+		short CompareNode (DomNode refNode);
+
+		[Export ("comparePoint:offset:")]
+		short ComparePoint (DomNode refNode, int offset);
+
+		[Export ("isPointInRange:offset:")]
+		bool IsPointInRange (DomNode refNode, int offset);
 	}
 
 	[BaseType (typeof (DomObject), Name="DOMCSSStyleDeclaration")]
 	interface DomCssStyleDeclaration {
 	}
-	
-	[BaseType (typeof (DomObject), Name="DOMNode")]
+
+	[BaseType (typeof (DomObject))]
 	interface DomNode {
+		// TODO: setup a enum for node type
+		[Export ("nodeType")]
+		ushort NodeType { get;  }
+
+		[Export ("parentNode")]
+		DomNode ParentNode { get;  }
+
+		[Export ("childNodes")]
+		DomNodeList ChildNodes { get;  }
+
+		[Export ("firstChild")]
+		DomNode FirstChild { get;  }
+
+		[Export ("lastChild")]
+		DomNode LastChild { get;  }
+
+		[Export ("previousSibling")]
+		DomNode PreviousSibling { get;  }
+
+		[Export ("nextSibling")]
+		DomNode NextSibling { get;  }
+
+		[Export ("attributes")]
+		DomNamedNodeMap Attributes { get;  }
+
+		[Export ("ownerDocument")]
+		DomDocument OwnerDocument { get;  }
+
+		[Export ("namespaceURI")]
+		string NamespaceURI { get;  }
+
+		[Export ("prefix")]
+		string Prefix { get; set;  }
+
+		[Export ("localName")]
+		string LocalName { get;  }
+
+		[Export ("baseURI")]
+		string BaseURI { get;  }
+
+		[Export ("textContent")]
+		string TextContent { get; set;  }
+
+		[Export ("parentElement")]
+		DomElement ParentElement { get;  }
+
+		[Export ("isContentEditable")]
+		bool IsContentEditable { get;  }
+
+		[Export ("insertBefore:refChild:")]
+		DomNode InsertBefore (DomNode newChild, DomNode refChild);
+
+		[Export ("replaceChild:oldChild:")]
+		DomNode ReplaceChild (DomNode newChild, DomNode oldChild);
+
+		[Export ("removeChild:")]
+		DomNode RemoveChild (DomNode oldChild);
+
+		[Export ("appendChild:")]
+		DomNode AppendChild (DomNode newChild);
+
+		[Export ("hasChildNodes")]
+		bool HasChildNodes ();
+
+		[Export ("cloneNode:")]
+		DomNode CloneNode (bool deep);
+
+		[Export ("normalize")]
+		void Normalize ();
+
+		[Export ("isSupported:version:")]
+		bool IsSupported (string feature, string version);
+
+		[Export ("hasAttributes")]
+		bool HasAttributes ();
+
+		[Export ("isSameNode:")]
+		bool IsSameNode (DomNode other);
+
+		[Export ("isEqualNode:")]
+		bool IsEqualNode (DomNode other);
+
+		[Export ("lookupPrefix:")]
+		string LookupPrefix (string namespaceURI);
+
+		[Export ("isDefaultNamespace:")]
+		bool IsDefaultNamespace (string namespaceURI);
+
+		[Export ("lookupNamespaceURI:")]
+		string LookupNamespace (string prefix);
+
+		[Export ("compareDocumentPosition")]
+		ushort CompareDocumentPosition (DomNode other);
+	}
+
+	[BaseType (typeof (DomObject))]
+	interface DomNodeList {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		DomNode Item (uint index);
+	}
+
+	[BaseType (typeof (DomObject))]
+	interface DomNamedNodeMap {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("getNamedItem:")]
+		DomNode GetNamedItem (string name);
+
+		[Export ("setNamedItem:")]
+		DomNode SetNamedItem (DomNode node);
+
+		[Export ("removeNamedItem:")]
+		DomNode RemoveNamedItem (string name);
+
+		[Export ("item:")]
+		DomNode Item (uint index);
+
+		[Export ("getNamedItemNS:localName:")]
+		DomNode GetNamedItemNS (string namespaceURI, string localName);
+
+		[Export ("setNamedItemNS:")]
+		DomNode SetNamedItemNS (DomNode node);
+
+		[Export ("removeNamedItemNS:localName:")]
+		DomNode RemoveNamedItemNS (string namespaceURI, string localName);
+
 	}
 	
 	[BaseType (typeof (DomNode), Name="DOMDocument")]
 	interface DomDocument {
 	}
+
+	[BaseType (typeof (DomNode))]
+	interface DomDocumentFragment {
+	}
 	
 	[BaseType (typeof (DomNode), Name="DOMElement")]
 	interface DomElement {
