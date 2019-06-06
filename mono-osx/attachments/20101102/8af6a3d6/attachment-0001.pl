>From 970eb78c3639d515ffbdd323636d59fe9f868364 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Tue, 2 Nov 2010 18:37:09 +0200
Subject: [PATCH] Added some DomObject interfaces for WebKit binding.

---
 src/Makefile              |    3 +-
 src/WebKit/DomNodeList.cs |   52 +++
 src/WebKit/Enums.cs       |   53 +++-
 src/webkit.cs             |  982 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 1083 insertions(+), 7 deletions(-)
 create mode 100644 src/WebKit/DomNodeList.cs

diff --git a/src/Makefile b/src/Makefile
index 14f21c3..d47f269 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -40,7 +40,8 @@ MONOMAC_SOURCES = \
 	./AppKit/NSGraphics.cs				\
 	./AppKit/NSMatrix.cs				\
 	./AppKit/NSWindow.cs				\
-	./Growl/Constants.cs
+	./Growl/Constants.cs				\
+	./WebKit/DomNodeList.cs
 
 GENERATOR_SOURCES = \
 	../../maccore/src/generator.cs			\
diff --git a/src/WebKit/DomNodeList.cs b/src/WebKit/DomNodeList.cs
new file mode 100644
index 0000000..2dc5729
--- /dev/null
+++ b/src/WebKit/DomNodeList.cs
@@ -0,0 +1,52 @@
+using System;
+using System.Collections;
+using System.Collections.Generic;
+using MonoMac.CoreFoundation;
+using MonoMac.Foundation;
+using MonoMac.ObjCRuntime;
+
+namespace MonoMac.WebKit {
+	public partial class DomNodeList : IEnumerable<DomNode> {
+		public DomNode this [int index] {
+			get { return GetItem (index); }
+		}
+
+		public IEnumerator<DomNode> GetEnumerator () {
+			return new DomNodeListEnumerator (this);
+		}
+
+		IEnumerator IEnumerable.GetEnumerator () {
+			return new DomNodeListEnumerator (this);
+		}
+
+		class DomNodeListEnumerator : IEnumerator<DomNode> {
+			public DomNodeListEnumerator (DomNodeList list) {
+				_list = list;
+				Reset ();
+			}
+
+			public void Dispose () {
+				_list = null;
+			}
+
+			public DomNode Current {
+				get { return _list [_current]; }
+			}
+
+			object IEnumerator.Current {
+				get { return _list [_current]; }
+			}
+
+			public bool MoveNext () {
+				return ++_current < _list.Length;
+			}
+
+			public void Reset () {
+				_current = -1;
+			}
+
+			DomNodeList _list;
+			int _current;
+		}
+	}
+}
diff --git a/src/WebKit/Enums.cs b/src/WebKit/Enums.cs
index b720e20..1706494 100644
--- a/src/WebKit/Enums.cs
+++ b/src/WebKit/Enums.cs
@@ -1,6 +1,57 @@
 namespace MonoMac.WebKit {
 
+	public enum DomCssRuleType {
+		Unknown = 0,
+		Style = 1,
+		Charset = 2,
+		Import = 3,
+		Media = 4,
+		FontFace = 5,
+		Page = 6,
+		Variables = 7,
+		WebKitKeyFrames = 8,
+		WebKitKeyFrame = 9
+	}
+
+	public enum DomCssValueType {
+		Inherit = 0,
+		PrimitiveValue = 1,
+		ValueList = 2,
+		Custom = 3
+	}
+
+	public enum DomDocumentPosition {
+		Disconnected = 0x01,
+		Preceeding = 0x02,
+		Following = 0x04,
+		Contains = 0x08,
+		ContainedBy = 0x10,
+		ImplementationSpecific = 0x20
+	}
+
+	public enum DomNodeType {
+		Element = 1,
+		Attribute = 2,
+		Text = 3,
+		CData = 4,
+		EntityReference = 5,
+		Entity = 6,
+		ProcessingInstruction = 7,
+		Comment = 8,
+		Document = 9,
+		DocumentType = 10,
+		DocumentFragment = 11,
+		Notation = 12
+	}
+
+	public enum DomRangeCompareHow {
+		StartToStart = 0, 
+		StartToEnd = 1, 
+		EndToEnd = 2, 
+		EndToStart = 3
+	}
+
 	public enum WebCacheModel {
 		DocumentViewer, DocumentBrowser, PrimaryWebBrowser
 	}
-}
\ No newline at end of file
+}
diff --git a/src/webkit.cs b/src/webkit.cs
index 16b530a..8f1bb19 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -10,30 +10,1002 @@ namespace MonoMac.WebKit {
 	interface DomObject {
 	}
 
-	[BaseType (typeof (DomObject), Name="DOMRange")]
-	interface DomRange {
+	/////////////////////////
+	// DomObject subclasses
+
+	[BaseType (typeof (DomObject), Name="DOMAbstractView")]
+	interface DomAbstractView {
+		[Export ("document")]
+		DomDocument Document { get; }
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMCSSRule")]
+	interface DomCssRule {
+		[Export ("type")]
+		DomCssRuleType Type { get; }
+
+		[Export ("cssText")]
+		string CssText { get; }
+
+		[Export ("parentStyleSheet")]
+		DomCssStyleSheet ParentStyleSheet { get;  }
+
+		[Export ("parentRule")]
+		DomCssRule ParentRule { get;  }
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMCSSRuleList")]
+	interface DomCssRuleList {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		DomCssRule GetItem (int index);
 	}
 
 	[BaseType (typeof (DomObject), Name="DOMCSSStyleDeclaration")]
 	interface DomCssStyleDeclaration {
+		[Export ("cssText")]
+		string CssText { get; }
+
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("parentRule")]
+		DomCssRule ParentRule { get;  }
+
+		[Export ("getPropertyValue:")]
+		string GetPropertyValue (string propertyName);
+
+		[Export ("getPropertyCSSValue:")]
+		DomCssValue GetPropertyCssValue (string propertyName);
+
+		[Export ("removeProperty:")]
+		string RemoveProperty (string propertyName);
+
+		[Export ("getPropertyPriority:")]
+		string GetPropertyPriority (string propertyName);
+
+		[Export ("setProperty:value:priority:")]
+		void SetProperty (string propertyName, string value, string priority);
+
+		[Export ("item:")]
+		string GetItem (int index);
+
+		[Export ("getPropertyShorthand:")]
+		string GetPropertyShorthand (string propertyName);
+
+		[Export ("isPropertyImplicit:")]
+		bool IsPropertyImplicit (string propertyName);
 	}
+
+	[BaseType (typeof (DomStyleSheet), Name="DOMCSSStyleSheet")]
+	interface DomCssStyleSheet {
+		[Export ("ownerRule")]
+		DomCssRule OwnerRule { get; }
 	
+		[Export ("cssRules")]
+		DomCssRuleList CssRules { get;  }
+
+		[Export ("rules")]
+		DomCssRuleList Rules { get;  }
+
+		[Export ("insertRule:index:")]
+		uint InsertRule (string rule, uint index);
+
+		[Export ("deleteRule:")]
+		void DeleteRule (uint index);
+
+		[Export ("addRule:style:index:")]
+		int AddRule (string selector, string style, uint index);
+
+		[Export ("removeRule:")]
+		void RemoveRule (uint index);
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMCSSValue")]
+	interface DomCssValue {
+		[Export ("cssText")]
+		string CssText { get; }
+
+		[Export ("cssValueType")]
+		DomCssValueType Type { get; }
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMHTMLCollection")]
+	interface DomHtmlCollection {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		DomNode GetItem (int index);
+
+		[Export ("namedItem:")]
+		DomNode GetNamedItem (string name);
+
+		[Export ("tags:")]
+		DomNodeList GetTags (string name);
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMImplementation")]
+	interface DomImplementation {
+		[Export ("hasFeature:version:")]
+		bool HasFeature (string feature, string version);
+
+		[Export ("createDocumentType:publicId:systemId:")]
+		DomDocumentType CreateDocumentType (string qualifiedName, string publicId, string systemId);
+
+		[Export ("createDocument:qualifiedName:doctype:")]
+		DomDocument CreateDocument (string namespaceURI, string qualifiedName, DomDocumentType doctype);
+
+		[Export ("createCSSStyleSheet:media:")]
+		DomCssStyleSheet CreateCssStyleSheet (string title, string media);
+
+		[Export ("createHTMLDocument:")]
+		DomHtmlDocument CreateHtmlDocument (string title);
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMMediaList")]
+	interface DomMediaList {
+		[Export ("mediaText")]
+		string MediaText { get; set; }
+
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		string GetItem (int index);
+
+		[Export ("deleteMedium:")]
+		void DeleteMedium (string oldMedium);
+
+		[Export ("appendMedium:")]
+		void AppendMedium (string newMedium);
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMNamedNodeMap")]
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
+		DomNode GetItem (int index);
+
+		[Export ("getNamedItemNS:localName:")]
+		DomNode GetNamedItemNS (string namespaceURI, string localName);
+
+		[Export ("setNamedItemNS:")]
+		DomNode SetNamedItemNS (DomNode node);
+
+		[Export ("removeNamedItemNS:localName:")]
+		DomNode RemoveNamedItemNS (string namespaceURI, string localName);
+	}
+
 	[BaseType (typeof (DomObject), Name="DOMNode")]
 	interface DomNode {
+		[Export ("nodeName")]
+		string NodeName { get; }
+
+		[Export ("nodeValue")]
+		string NodeValue { get; }
+
+		[Export ("nodeType")]
+		DomNodeType NodeType { get;  }
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
+		DomDocumentPosition CompareDocumentPosition (DomNode other);
 	}
-	
+
+	[BaseType (typeof (DomObject), Name="DOMNodeList")]
+	interface DomNodeList {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		DomNode GetItem (int index);
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMRange")]
+	interface DomRange {
+		[Export ("startContainer")]
+		DomNode StartContainer { get;  }
+
+		[Export ("startOffset")]
+		int StartOffset { get;  }
+
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
+		void SetStart (DomNode refNode, int offset );
+
+		[Export ("setEnd:offset:")]
+		void SetEnd (DomNode refNode, int offset);
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
+		[Export ("compareBoundaryPoints:sourceRange:")]
+		short CompareBoundaryPoints (DomRangeCompareHow how, DomRange sourceRange);
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
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMStyleSheet")]
+	interface DomStyleSheet {
+		[Export ("type")]
+		string Type { get; }
+
+		[Export ("disabled")]
+		bool Disabled { get; set; }
+
+		[Export ("ownerNode")]
+		DomNode OwnerNode { get;  }
+
+		[Export ("parentStyleSheet")]
+		DomStyleSheet ParentStyleSheet { get;  }
+
+		[Export ("href")]
+		string Href { get;  }
+
+		[Export ("title")]
+		string Title { get;  }
+
+		[Export ("media")]
+		DomMediaList Media { get;  }
+	}
+
+	[BaseType (typeof (DomObject), Name="DOMStyleSheetList")]
+	interface DomStyleSheetList {
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("item:")]
+		DomStyleSheet GetItem (int index);
+	}
+
+	///////////////////////
+	// DomNode subclasses
+
+	[BaseType (typeof (DomNode), Name="DOMAttr")]
+	interface DomAttr {
+		[Export ("name")]
+		string Name { get; }
+
+		[Export ("specified")]
+		bool Specified { get; }
+
+		[Export ("value")]
+		string Value { get; set;  }
+
+		[Export ("ownerElement")]
+		DomElement OwnerElement { get;  }
+
+		[Export ("style")]
+		DomCssStyleDeclaration Style { get;  }
+	}
+
+	[BaseType (typeof (DomNode), Name="DOMCharacterData")]
+	interface DomCharacterData {
+		[Export ("data")]
+		string Data { get; }
+
+		[Export ("length")]
+		uint Length { get; }
+
+		[Export ("substringData:length:")]
+		string SubstringData (uint offset, uint length);
+
+		[Export ("appendData:")]
+		void AppendData (string data);
+
+		[Export ("insertData:data:")]
+		void InsertData (uint offset, string data);
+
+		[Export ("deleteData:length:")]
+		void DeleteData (uint offset, uint length);
+
+		[Export ("replaceData:length:data:")]
+		void ReplaceData (uint offset, uint length, string data);
+	}
+
 	[BaseType (typeof (DomNode), Name="DOMDocument")]
 	interface DomDocument {
+		[Export ("doctype")]
+		DomDocumentType DocumentType { get; }
+
+		[Export ("implementation")]
+		DomImplementation Implementation { get; }
+
+		[Export ("documentElement")]
+		DomElement DocumentElement { get;  }
+
+		[Export ("inputEncoding")]
+		string InputEncoding { get;  }
+
+		[Export ("xmlEncoding")]
+		string XmlEncoding { get;  }
+
+		[Export ("xmlVersion")]
+		string XmlVersion { get;  }
+
+		[Export ("xmlStandalone")]
+		bool XmlStandalone { get; set;  }
+
+		[Export ("documentURI")]
+		string DocumentURI { get; set;  }
+
+		[Export ("defaultView")]
+		DomAbstractView DefaultView { get;  }
+
+		[Export ("styleSheets")]
+		DomStyleSheetList StyleSheets { get;  }
+
+		[Export ("title")]
+		string Title { get; set;  }
+
+		[Export ("referrer")]
+		string Referrer { get;  }
+
+		[Export ("domain")]
+		string Domain { get;  }
+
+		[Export ("URL")]
+		string Url { get;  }
+
+		[Export ("cookie")]
+		string Cookie { get; set;  }
+
+		[Export ("body")]
+		DomHtmlElement body { get; set;  }
+
+		[Export ("images")]
+		DomHtmlCollection images { get;  }
+
+		[Export ("applets")]
+		DomHtmlCollection applets { get;  }
+
+		[Export ("links")]
+		DomHtmlCollection links { get;  }
+
+		[Export ("forms")]
+		DomHtmlCollection forms { get;  }
+
+		[Export ("anchors")]
+		DomHtmlCollection anchors { get;  }
+
+		[Export ("lastModified")]
+		string LastModified { get;  }
+
+		[Export ("charset")]
+		string Charset { get; set;  }
+
+		[Export ("defaultCharset")]
+		string DefaultCharset { get;  }
+
+		[Export ("readyState")]
+		string ReadyState { get;  }
+
+		[Export ("characterSet")]
+		string CharacterSet { get;  }
+
+		[Export ("preferredStylesheetSet")]
+		string PreferredStylesheetSet { get;  }
+
+		[Export ("selectedStylesheetSet")]
+		string SelectedStylesheetSet { get; set;  }
+
+		[Export ("createElement:")]
+		DomElement CreateElement (string tagName);
+
+		[Export ("createDocumentFragment")]
+		DomDocumentFragment CreateDocumentFragment ();
+
+		[Export ("createTextNode:")]
+		DomText CreateTextNode (string data);
+
+		[Export ("createComment:")]
+		DomComment CreateComment (string data);
+
+		[Export ("createCDATASection:")]
+		DomCDataSection CreateCDataSection (string data);
+
+		[Export ("createProcessingInstruction:data:")]
+		DomProcessingInstruction CreateProcessingInstruction (string target, string data);
+
+		[Export ("createAttribute:")]
+		DomAttr CreateAttribute (string name);
+
+		[Export ("createEntityReference:")]
+		DomEntityReference CreateEntityReference (string name);
+
+		[Export ("getElementsByTagName:")]
+		DomNodeList GetElementsByTagName (string tagname);
+
+		[Export ("importNode:deep:")]
+		DomNode ImportNode (DomNode importedNode, bool deep);
+
+		[Export ("createElementNS:qualifiedName:")]
+		DomElement CreateElementNS (string namespaceURI, string qualifiedName);
+
+		[Export ("createAttributeNS:qualifiedName:")]
+		DomAttr CreateAttributeNS (string namespaceURI, string qualifiedName);
+
+		[Export ("getElementsByTagNameNS:localName:")]
+		DomNodeList GetElementsByTagNameNS (string namespaceURI, string localName);
+
+		[Export ("getElementById:")]
+		DomElement GetElementById (string elementId);
+
+		[Export ("adoptNode:")]
+		DomNode AdoptNode (DomNode source);
+
+		// TODO
+		//[Export ("createEvent:")]
+		//DomEvent CreateEvent (string eventType);
+
+		[Export ("createRange")]
+		DomRange CreateRange ();
+
+		// TODO
+		//[Export ("createNodeIterator:whatToShow:filter:expandEntityReferences:")]
+		//DomNodeIterator CreateNodeIterator (DomNode root, unsigned whatToShow, id <DomNodeFilter> filter, bool expandEntityReferences);
+
+		//[Export ("createTreeWalker:whatToShow:filter:expandEntityReferences:")]
+		//DomTreeWalker CreateTreeWalker (DomNode root, unsigned whatToShow, id <DomNodeFilter> filter, bool expandEntityReferences);
+
+		[Export ("getOverrideStyle:pseudoElement:")]
+		DomCssStyleDeclaration GetOverrideStyle (DomElement element, string pseudoElement);
+
+		//[Export ("createExpression:resolver:")]
+		//DomXPathExpression CreateExpression (string expression, id <DomXPathNSResolver> resolver);
+
+		//[Export ("createNSResolver:")]
+		//id <DomXPathNSResolver> CreateNSResolver (DomNode nodeResolver);
+
+		//[Export ("evaluate:contextNode:resolver:type:inResult:")]
+		//DomXPathResult Evaluate (string expression, DomNode contextNode, id <DomXPathNSResolver> resolver, unsigned short type, DomXPathResult inResult);
+
+		[Export ("execCommand:userInterface:value:")]
+		bool ExecCommand (string command, bool userInterface, string value);
+
+		[Export ("execCommand:userInterface:")]
+		bool ExecCommand (string command, bool userInterface);
+
+		[Export ("execCommand:")]
+		bool ExecCommand (string command);
+
+		[Export ("queryCommandEnabled:")]
+		bool QueryCommandEnabled (string command);
+
+		[Export ("queryCommandIndeterm:")]
+		bool QueryCommandIndeterm (string command);
+
+		[Export ("queryCommandState:")]
+		bool QueryCommandState (string command);
+
+		[Export ("queryCommandSupported:")]
+		bool QueryCommandSupported (string command);
+
+		[Export ("queryCommandValue:")]
+		string QueryCommandValue (string command);
+
+		[Export ("getElementsByName:")]
+		DomNodeList GetElementsByName (string elementName);
+
+		[Export ("elementFromPoint:y:")]
+		DomElement ElementFromPoint (int x, int y);
+
+		[Export ("createCSSStyleDeclaration")]
+		DomCssStyleDeclaration CreateCssStyleDeclaration ();
+
+		[Export ("getComputedStyle:pseudoElement:")]
+		DomCssStyleDeclaration GetComputedStyle (DomElement element, string pseudoElement);
+
+		[Export ("getMatchedCSSRules:pseudoElement:")]
+		DomCssRuleList GetMatchedCSSRules (DomElement element, string pseudoElement);
+
+		[Export ("getMatchedCSSRules:pseudoElement:authorOnly:")]
+		DomCssRuleList GetMatchedCSSRules (DomElement element, string pseudoElement, bool authorOnly);
+
+		[Export ("getElementsByClassName:")]
+		DomNodeList GetElementsByClassName (string tagname);
+
+		[Export ("querySelector:")]
+		DomElement QuerySelector (string selectors);
+
+		[Export ("querySelectorAll:")]
+		DomNodeList QuerySelectorAll (string selectors);
+	}
+
+	[BaseType (typeof (DomNode), Name="DOMDocumentFragment")]
+	interface DomDocumentFragment {
+	}
+
+	[BaseType (typeof (DomNode), Name="DOMDocumentType")]
+	interface DomDocumentType {
+		[Export ("name")]
+		string Name { get;  }
+
+		[Export ("entities")]
+		DomNamedNodeMap Entities { get;  }
+
+		[Export ("notations")]
+		DomNamedNodeMap Notations { get;  }
+
+		[Export ("publicId")]
+		string PublicId { get;  }
+
+		[Export ("systemId")]
+		string SystemId { get;  }
+
+		[Export ("internalSubset")]
+		string InternalSubset { get;  }
+
 	}
 	
 	[BaseType (typeof (DomNode), Name="DOMElement")]
 	interface DomElement {
+		[Export ("offsetLeft")]
+		int OffsetLeft { get;  }
+
+		[Export ("offsetTop")]
+		int OffsetTop { get;  }
+
+		[Export ("offsetWidth")]
+		int OffsetWidth { get;  }
+
+		[Export ("offsetHeight")]
+		int OffsetHeight { get;  }
+
+		[Export ("offsetParent")]
+		DomElement OffsetParent { get;  }
+
+		[Export ("clientLeft")]
+		int ClientLeft { get;  }
+
+		[Export ("clientTop")]
+		int ClientTop { get;  }
+
+		[Export ("clientWidth")]
+		int ClientWidth { get;  }
+
+		[Export ("clientHeight")]
+		int ClientHeight { get;  }
+
+		[Export ("scrollLeft")]
+		int ScrollLeft { get; set;  }
+
+		[Export ("scrollTop")]
+		int ScrollTop { get; set;  }
+
+		[Export ("scrollWidth")]
+		int ScrollWidth { get;  }
+
+		[Export ("scrollHeight")]
+		int ScrollHeight { get;  }
+
+		[Export ("firstElementChild")]
+		DomElement FirstElementChild { get;  }
+
+		[Export ("lastElementChild")]
+		DomElement LastElementChild { get;  }
+
+		[Export ("previousElementSibling")]
+		DomElement PreviousElementSibling { get;  }
+
+		[Export ("nextElementSibling")]
+		DomElement NextElementSibling { get;  }
+
+		[Export ("childElementCount")]
+		uint ChildElementCount { get;  }
+
+		[Export ("innerText")]
+		string InnerText { get;  }
+
+		[Export ("getAttribute:")]
+		string GetAttribute (string name);
+
+		[Export ("setAttribute:value:")]
+		void SetAttribute (string name, string value);
+
+		[Export ("removeAttribute:")]
+		void RemoveAttribute (string name);
+
+		[Export ("getAttributeNode:")]
+		DomAttr GetAttributeNode (string name);
+
+		[Export ("setAttributeNode:")]
+		DomAttr SetAttributeNode (DomAttr newAttr);
+
+		[Export ("removeAttributeNode:")]
+		DomAttr RemoveAttributeNode (DomAttr oldAttr);
+
+		[Export ("getElementsByTagName:")]
+		DomNodeList GetElementsByTagName (string name);
+
+		[Export ("getAttributeNS:localName:")]
+		string GetAttributeNS (string namespaceURI, string localName);
+
+		[Export ("setAttributeNS:qualifiedName:value:")]
+		void SetAttributeNS (string namespaceURI, string qualifiedName, string value);
+
+		[Export ("removeAttributeNS:localName:")]
+		void RemoveAttributeNS (string namespaceURI, string localName);
+
+		[Export ("getElementsByTagNameNS:localName:")]
+		DomNodeList GetElementsByTagNameNS (string namespaceURI, string localName);
+
+		[Export ("getAttributeNodeNS:localName:")]
+		DomAttr GetAttributeNodeNS (string namespaceURI, string localName);
+
+		[Export ("setAttributeNodeNS:")]
+		DomAttr SetAttributeNodeNS (DomAttr newAttr);
+
+		[Export ("hasAttribute:")]
+		bool HasAttribute (string name);
+
+		[Export ("hasAttributeNS:localName:")]
+		bool HasAttributeNS (string namespaceURI, string localName);
+
+		[Export ("focus")]
+		void Focus ();
+
+		[Export ("blur")]
+		void Blur ();
+
+		[Export ("scrollIntoView:")]
+		void ScrollIntoView (bool alignWithTop);
+
+		[Export ("contains:")]
+		bool Contains (DomElement element);
+
+		[Export ("scrollIntoViewIfNeeded:")]
+		void ScrollIntoViewIfNeeded (bool centerIfNeeded);
+
+		[Export ("scrollByLines:")]
+		void ScrollByLines (int lines);
+
+		[Export ("scrollByPages:")]
+		void ScrollByPages (int pages);
+
+		[Export ("getElementsByClassName:")]
+		DomNodeList GetElementsByClassName (string name);
+
+		[Export ("querySelector:")]
+		DomElement QuerySelector (string selectors);
+
+		[Export ("querySelectorAll:")]
+		DomNodeList QuerySelectorAll (string selectors);
+	}
+
+	[BaseType (typeof (DomNode), Name="DOMEntityReference")]
+	interface DomEntityReference {
+	}
+
+	[BaseType (typeof (DomNode), Name="DOMProcessingInstruction")]
+	interface DomProcessingInstruction {
+		[Export ("target")]
+		string Target { get; }
+
+		[Export ("data")]
+		string Data { get; set; }
+
+		[Export ("sheet")]
+		DomStyleSheet Sheet { get;  }
+	}
+
+	////////////////////////////////
+	// DomCharacterData subclasses
+
+	[BaseType (typeof (DomCharacterData), Name="DOMText")]
+	interface DomText {
+		[Export("wholeText")]
+		string WholeText { get; }
+
+		[Export ("splitText:")]
+		DomText SplitText (uint offset);
+
+		[Export ("replaceWholeText:")]
+		DomText ReplaceWholeText (string content);
+	}
+
+	[BaseType (typeof (DomCharacterData), Name="DOMComment")]
+	interface DomComment {
+	}
+
+	///////////////////////////
+	// DomText subclasses
+
+	[BaseType (typeof (DomText), Name="DOMCDATASection")]
+	interface DomCDataSection {
 	}
 
-	[BaseType (typeof (DomNode), Name="DOMHTMLElement")]
+	///////////////////////////
+	// DomDocument subclasses
+
+	[BaseType (typeof (DomDocument), Name="DOMHTMLDocument")]
+	interface DomHtmlDocument {
+		[Export ("embeds")]
+		DomHtmlCollection Embeds { get;  }
+
+		[Export ("plugins")]
+		DomHtmlCollection Plugins { get;  }
+
+		[Export ("scripts")]
+		DomHtmlCollection Scripts { get;  }
+
+		[Export ("width")]
+		int Width { get;  }
+
+		[Export ("height")]
+		int Height { get;  }
+
+		[Export ("dir")]
+		string Dir { get; set;  }
+
+		[Export ("designMode")]
+		string DesignMode { get; set;  }
+
+		[Export ("compatMode")]
+		string CompatMode { get;  }
+
+		[Export ("activeElement")]
+		DomElement ActiveElement { get;  }
+
+		[Export ("bgColor")]
+		string BgColor { get; set;  }
+
+		[Export ("fgColor")]
+		string FgColor { get; set;  }
+
+		[Export ("alinkColor")]
+		string ALinkColor { get; set;  }
+
+		[Export ("linkColor")]
+		string LinkColor { get; set;  }
+
+		[Export ("vlinkColor")]
+		string VLinkColor { get; set;  }
+
+		[Export ("open")]
+		void Open ();
+
+		[Export ("close")]
+		void Close ();
+
+		[Export ("write:")]
+		void Write (string text);
+
+		[Export ("writeln:")]
+		void Writeln (string text);
+
+		[Export ("clear")]
+		void Clear ();
+
+		[Export ("captureEvents")]
+		void CaptureEvents ();
+
+		[Export ("releaseEvents")]
+		void ReleaseEvents ();
+
+		[Export ("hasFocus")]
+		bool HasFocus ();
+	}
+
+	//////////////////////////
+	// DomElement subclasses
+
+	[BaseType (typeof (DomElement), Name="DOMHTMLElement")]
 	interface DomHtmlElement {
+		[Export ("idName")]
+		string IdName { get; set;  }
+
+		[Export ("title")]
+		string Title { get; set;  }
+
+		[Export ("lang")]
+		string Lang { get; set;  }
+
+		[Export ("dir")]
+		string Dir { get; set;  }
+
+		[Export ("className")]
+		string ClassName { get; set;  }
+
+		[Export ("tabIndex")]
+		int TabIndex { get; set;  }
+
+		[Export ("innerHTML")]
+		string InnerHTML { get; set;  }
+
+		[Export ("innerText")]
+		string InnerText { get; set;  }
+
+		[Export ("outerHTML")]
+		string OuterHTML { get; set;  }
+
+		[Export ("outerText")]
+		string OuterText { get; set;  }
+
+		[Export ("children")]
+		DomHtmlCollection Children { get;  }
+
+		[Export ("contentEditable")]
+		string ContentEditable { get; set;  }
+
+		[Export ("isContentEditable")]
+		bool IsContentEditable { get;  }
+
+		[Export ("titleDisplayString")]
+		string TitleDisplayString { get;  }
 	}
 
+	//////////////////////////////////////////////////////////////////
+
 	[BaseType (typeof (NSObject))]
 	interface WebArchive {
 		[Export ("initWithMainResource:subresources:subframeArchives:")]
@@ -798,4 +1770,4 @@ namespace MonoMac.WebKit {
 		[Export ("selectSentence:")]
 		void SelectSentence (NSObject sender);
 	}
-}
\ No newline at end of file
+}
-- 
1.7.2

