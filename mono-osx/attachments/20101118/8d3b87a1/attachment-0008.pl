>From ae0ec85ee35d851f57262e1970312f1e8844aa7e Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 16:23:51 +0200
Subject: [PATCH 08/12] Added WebView.ReplaceSelectionWithNode/Text().

---
 src/webkit.cs |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index 34567f2..006a3ac 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -1962,6 +1962,12 @@ namespace MonoMac.WebKit {
 		[Export ("editingDelegate")]
 		NSObject EditingDelegate { get; set; }
 
+		[Export ("replaceSelectionWithNode:")]
+		void ReplaceSelectionWithNode (DomNode node);
+
+		[Export ("replaceSelectionWithText:")]
+		void ReplaceSelectionWithText (string text);
+
 		[Export ("replaceSelectionWithMarkupString:")]
 		void ReplaceSelectionWithMarkupString (string markupString);
 
-- 
1.7.2

