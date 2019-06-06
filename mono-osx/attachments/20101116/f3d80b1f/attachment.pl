>From 7c4f7c7d6b0caa0ab0ea3f309b5c526ab4f84825 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Tue, 16 Nov 2010 17:47:06 +0200
Subject: [PATCH] Added IDomEventTarget interface for DomNode.

---
 src/Makefile                  |    4 +++-
 src/WebKit/DomNode.cs         |    2 +-
 src/WebKit/IDomEventTarget.cs |   14 ++++++++++++++
 src/webkit.cs                 |    6 +++---
 4 files changed, 21 insertions(+), 5 deletions(-)
 create mode 100644 src/WebKit/IDomEventTarget.cs

diff --git a/src/Makefile b/src/Makefile
index 23e6782..a40a40a 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -26,7 +26,8 @@ CORE_SOURCES =					\
 	./ObjCRuntime/Selector.cs			\
 	./QTKit/Defs.cs					\
 	./QTKit/Enums.cs				\
-	./WebKit/Enums.cs
+	./WebKit/Enums.cs				\
+	./WebKit/IDomEventTarget.cs
 
 # Sources that are not part of CORE_SOURCES or the generated templates
 MONOMAC_SOURCES = \
@@ -52,6 +53,7 @@ MONOMAC_SOURCES = \
 	./Growl/Constants.cs				\
 	./WebKit/DomNode.cs				\
 	./WebKit/Enumerators.cs				\
+	./WebKit/IDomEventTarget.cs			\
 	./WebKit/Indexers.cs
 
 GENERATOR_SOURCES = \
diff --git a/src/WebKit/DomNode.cs b/src/WebKit/DomNode.cs
index 1a71b85..5f97ac3 100644
--- a/src/WebKit/DomNode.cs
+++ b/src/WebKit/DomNode.cs
@@ -35,7 +35,7 @@ namespace MonoMac.WebKit {
 	
 	public delegate void DomEventListenerHandler (object sender, DomEventArgs args);
 	
-	public partial class DomNode {
+	public partial class DomNode : IDomEventTarget {
 
 		internal class DomNodeEventProxy : DomEventListener {
 			DomEventListenerHandler handler;
diff --git a/src/WebKit/IDomEventTarget.cs b/src/WebKit/IDomEventTarget.cs
new file mode 100644
index 0000000..9859859
--- /dev/null
+++ b/src/WebKit/IDomEventTarget.cs
@@ -0,0 +1,14 @@
+using MonoMac.Foundation;
+
+namespace MonoMac.WebKit {
+#if COREBUILD
+	public interface DomEventListener {}
+	public interface DomEvent {}
+#endif
+
+	public interface IDomEventTarget {
+		void AddEventListener (string type, DomEventListener listener, bool useCapture);
+		void RemoveEventListener (string type, DomEventListener listener, bool useCapture);
+		bool DispatchEvent (DomEvent evt);
+	}
+}
diff --git a/src/webkit.cs b/src/webkit.cs
index 5fed1b9..bfec558 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -896,10 +896,10 @@ namespace MonoMac.WebKit {
 		string Type { get; }
 
 		[Export ("target")]
-		NSObject Target { get;  }
+		IDomEventTarget Target { get;  }
 
 		[Export ("currentTarget")]
-		NSObject CurrentTarget { get;  }
+		IDomEventTarget CurrentTarget { get;  }
 
 		[Export ("eventPhase")]
 		DomEventPhase EventPhase { get;  }
@@ -914,7 +914,7 @@ namespace MonoMac.WebKit {
 		UInt64 TimeStamp { get;  }
 
 		[Export ("srcElement")]
-		NSObject SourceElement { get;  }
+		IDomEventTarget SourceElement { get;  }
 
 		[Export ("returnValue")]
 		bool ReturnValue { get; set;  }
-- 
1.7.2

