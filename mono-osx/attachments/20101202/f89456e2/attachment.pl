>From 3abf1faac68f22fe5a7a4395536102a8df63286d Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Wed, 1 Dec 2010 18:48:33 +0200
Subject: [PATCH] Added NSUndoManager notification constants.

---
 src/foundation.cs |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/foundation.cs b/src/foundation.cs
index 4458323..8828a7d 100644
--- a/src/foundation.cs
+++ b/src/foundation.cs
@@ -1927,6 +1927,27 @@ namespace MonoMac.Foundation
 
 		[Export ("redoMenuTitleForUndoActionName:")]
 		string RedoMenuTitleForUndoActionName (string name);
+
+		[Field ("NSUndoManagerCheckpointNotification")]
+		NSString CheckpointNotification { get; }
+
+		[Field ("NSUndoManagerDidOpenUndoGroupNotification")]
+		NSString DidOpenUndoGroupNotification { get; }
+
+		[Field ("NSUndoManagerDidRedoChangeNotification")]
+		NSString DidRedoChangeNotification { get; }
+
+		[Field ("NSUndoManagerDidUndoChangeNotification")]
+		NSString DidUndoChangeNotification { get; }
+
+		[Field ("NSUndoManagerWillCloseUndoGroupNotification")]
+		NSString WillCloseUndoGroupNotification { get; }
+
+		[Field ("NSUndoManagerWillRedoChangeNotification")]
+		NSString WillRedoChangeNotification { get; }
+
+		[Field ("NSUndoManagerWillUndoChangeNotification")]
+		NSString WillUndoChangeNotification { get; }
 	}
 	
 	[BaseType (typeof (NSObject), Name="NSURLProtectionSpace")]
-- 
1.7.2

