>From a01853c4ef1cb22d3ea80b8d278a72762e7770d1 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 25 Nov 2010 17:04:18 +0200
Subject: [PATCH] Added NullAllowed attribute for some of the DomNode method parameters.

---
 src/webkit.cs |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index c018c2a..ed37055 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -270,7 +271,7 @@ namespace MonoMac.WebKit {
 		bool IsContentEditable { get;  }
 
 		[Export ("insertBefore:refChild:")]
-		DomNode InsertBefore (DomNode newChild, DomNode refChild);
+		DomNode InsertBefore (DomNode newChild, [NullAllowed] DomNode refChild);
 
 		[Export ("replaceChild:oldChild:")]
 		DomNode ReplaceChild (DomNode newChild, DomNode oldChild);
@@ -297,10 +298,10 @@ namespace MonoMac.WebKit {
 		bool HasAttributes { get; }
 
 		[Export ("isSameNode:")]
-		bool IsSameNode (DomNode other);
+		bool IsSameNode ([NullAllowed] DomNode other);
 
 		[Export ("isEqualNode:")]
-		bool IsEqualNode (DomNode other);
+		bool IsEqualNode ([NullAllowed] DomNode other);
 
 		[Export ("lookupPrefix:")]
 		string LookupPrefix (string namespaceURI);
-- 
1.7.2

