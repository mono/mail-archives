>From 90b4db415b02af147df90ad2ff2ed9df1d72d6d7 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 18:06:14 +0200
Subject: [PATCH 11/12] Assorted interface fixes for webkit.cs.

---
 src/webkit.cs |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index 02e50b0..ba0fd14 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -69,7 +69,7 @@ namespace MonoMac.WebKit {
 	[BaseType (typeof (DomObject), Name="DOMCSSStyleDeclaration")]
 	interface DomCssStyleDeclaration {
 		[Export ("cssText")]
-		string CssText { get; }
+		string CssText { get; set; }
 
 		[Export ("length")]
 		int Count { get; }
@@ -219,7 +219,7 @@ namespace MonoMac.WebKit {
 		string Name { get; }
 
 		[Export ("nodeValue")]
-		string Value { get; }
+		string Value { get; set; }
 
 		[Export ("nodeType")]
 		DomNodeType NodeType { get;  }
@@ -1804,7 +1804,7 @@ namespace MonoMac.WebKit {
 		bool IsLoading { get; }
 
 		[Export ("elementAtPoint:")]
-		NSDictionary ElementAtPoint (PointF point);
+		NSDictionary GetElementAtPoint (PointF point);
 
 		[Export ("pasteboardTypesForSelection")]
 		NSPasteboard [] PasteboardTypesForSelection { get; }
-- 
1.7.2

