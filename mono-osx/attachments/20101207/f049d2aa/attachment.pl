>From 14e333722b8f334f28df60d7b23d5e84056800c3 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Tue, 7 Dec 2010 15:24:12 +0200
Subject: [PATCH] Fixed NSOutlineView returning types for GetParent() and ItemAtRow() methods.

---
 src/appkit.cs |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/appkit.cs b/src/appkit.cs
index 7f7e035..c390b44 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -5592,10 +5592,10 @@ namespace MonoMac.AppKit {
 		void ReloadItem (NSObject item);
 
 		[Export ("parentForItem:")]
-		NSOutlineView GetParent (NSObject item);
+		NSObject GetParent (NSObject item);
 
 		[Export ("itemAtRow:")]
-		NSOutlineView ItemAtRow (int row);
+		NSObject ItemAtRow (int row);
 
 		[Export ("rowForItem:")]
 		int RowForItem (NSObject item);
-- 
1.7.2

