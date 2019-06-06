>From 8fbdca04943bdc9a22d2c17c2e7f27b52600e51f Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 16:40:54 +0200
Subject: [PATCH 09/12] Added DomElement.Style, .TagName, minor fixes.

---
 src/webkit.cs |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index 006a3ac..70a533d 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -249,7 +249,7 @@ namespace MonoMac.WebKit {
 		DomDocument OwnerDocument { get;  }
 
 		[Export ("namespaceURI")]
-		string NamespaceURI { get;  }
+		string NamespaceUri { get;  }
 
 		[Export ("prefix")]
 		string Prefix { get; set;  }
@@ -258,7 +258,7 @@ namespace MonoMac.WebKit {
 		string LocalName { get;  }
 
 		[Export ("baseURI")]
-		string BaseURI { get;  }
+		string BaseUri { get;  }
 
 		[Export ("textContent")]
 		string TextContent { get; set;  }
@@ -282,7 +282,7 @@ namespace MonoMac.WebKit {
 		DomNode AppendChild (DomNode newChild);
 
 		[Export ("hasChildNodes")]
-		bool HasChildNodes ();
+		bool HasChildNodes { get; }
 
 		[Export ("cloneNode:")]
 		DomNode CloneNode (bool deep);
@@ -294,7 +294,7 @@ namespace MonoMac.WebKit {
 		bool IsSupported (string feature, string version);
 
 		[Export ("hasAttributes")]
-		bool HasAttributes ();
+		bool HasAttributes { get; }
 
 		[Export ("isSameNode:")]
 		bool IsSameNode (DomNode other);
@@ -753,6 +753,12 @@ namespace MonoMac.WebKit {
 	
 	[BaseType (typeof (DomNode), Name="DOMElement")]
 	interface DomElement {
+		[Export ("tagName")]
+		string TagName { get; }
+
+		[Export ("style")]
+		DomCssStyleDeclaration Style { get;  }
+
 		[Export ("offsetLeft")]
 		int OffsetLeft { get;  }
 
-- 
1.7.2

