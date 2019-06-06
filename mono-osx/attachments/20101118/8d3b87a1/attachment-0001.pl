>From 8795efbf2892e40520f405b9787dcbc921720953 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 16:04:00 +0200
Subject: [PATCH 07/12] Added WebView.SetSelectedDomRange().

---
 src/webkit.cs |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/webkit.cs b/src/webkit.cs
index bc6d1cd..34567f2 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -1925,6 +1925,9 @@ namespace MonoMac.WebKit {
 		[Export ("toggleSmartInsertDelete:")]
 		void ToggleSmartInsertDelete (NSObject sender);
 
+		[Export ("setSelectedDOMRange:affinity:")]
+		void SetSelectedDomRange (DomRange range, NSSelectionAffinity affinity);
+
 		[Export ("selectedDOMRange")]
 		DomRange SelectedDomRange { get; }
 
-- 
1.7.2

