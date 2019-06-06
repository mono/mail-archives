>From 07a1e2da2468cab5404d4c038428a8b54aeeea50 Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 11 Nov 2010 13:20:34 +0200
Subject: [PATCH] Added DomEvent, DomEventListener protocol and DomNode:DomEventTarget protocol implementation.

---
 src/Makefile          |    1 +
 src/WebKit/DomNode.cs |   60 +++++++++++++++++++++++++++++++++++++++++++
 src/WebKit/Enums.cs   |    6 ++++
 src/webkit.cs         |   68 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 src/WebKit/DomNode.cs

diff --git a/src/Makefile b/src/Makefile
index 69ab657..6cb7f74 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -49,6 +49,7 @@ MONOMAC_SOURCES = \
 	./AppKit/NSMatrix.cs				\
 	./AppKit/NSWindow.cs				\
 	./Growl/Constants.cs				\
+	./WebKit/DomNode.cs				\
 	./WebKit/Enumerators.cs				\
 	./WebKit/Indexers.cs
 
diff --git a/src/WebKit/DomNode.cs b/src/WebKit/DomNode.cs
new file mode 100644
index 0000000..943125e
--- /dev/null
+++ b/src/WebKit/DomNode.cs
@@ -0,0 +1,60 @@
+using System;
+using MonoMac.Foundation;
+using MonoMac.ObjCRuntime;
+
+namespace MonoMac.WebKit {
+	public partial class DomNode /* : DomEventTarget */ {
+		static IntPtr selAddEventListener = Selector.GetHandle ("addEventListener:listener:useCapture:");
+		static IntPtr selRemoveEventListener = Selector.GetHandle ("removeEventListener:listener:useCapture:");
+		static IntPtr selDispatchEvent = Selector.GetHandle ("dispatchEvent:");
+
+		[Export ("addEventListener:listener:useCapture:")]
+		public virtual void AddEventListener (string type, NSObject listener, bool useCapture)
+		{
+			if (type == null)
+				throw new ArgumentNullException ("type");
+			if (listener == null)
+				throw new ArgumentNullException ("listener");
+			NSString nstype = new NSString (type);
+
+			if (IsDirectBinding) {
+				MonoMac.ObjCRuntime.Messaging.void_objc_msgSend_IntPtr_IntPtr_Boolean (this.Handle, selAddEventListener, nstype.Handle, listener.Handle, useCapture);
+			} else {
+				MonoMac.ObjCRuntime.Messaging.void_objc_msgSendSuper_IntPtr_IntPtr_Boolean (this.SuperHandle, selAddEventListener, nstype.Handle, listener.Handle, useCapture);
+			}
+
+			nstype.Dispose();
+		}
+
+		[Export ("removeEventListener:listener:useCapture:")]
+		public virtual void RemoveEventListener (string type, NSObject listener, bool useCapture)
+		{
+			if (type == null)
+				throw new ArgumentNullException ("type");
+			if (listener == null)
+				throw new ArgumentNullException ("listener");
+			NSString nstype = new NSString (type);
+
+			if (IsDirectBinding) {
+				MonoMac.ObjCRuntime.Messaging.void_objc_msgSend_IntPtr_IntPtr_Boolean (this.Handle, selRemoveEventListener, nstype.Handle, listener.Handle, useCapture);
+			} else {
+				MonoMac.ObjCRuntime.Messaging.void_objc_msgSendSuper_IntPtr_IntPtr_Boolean (this.SuperHandle, selRemoveEventListener, nstype.Handle, listener.Handle, useCapture);
+			}
+
+			nstype.Dispose();
+		}
+
+		[Export ("dispatchEvent:")]
+		public virtual bool DispatchEvent (DomEvent evt)
+		{
+			if (evt == null)
+				throw new ArgumentNullException ("evt");
+
+			if (IsDirectBinding) {
+				return MonoMac.ObjCRuntime.Messaging.Boolean_objc_msgSend_IntPtr (this.Handle, selDispatchEvent, evt.Handle);
+			} else {
+				return MonoMac.ObjCRuntime.Messaging.Boolean_objc_msgSendSuper_IntPtr (this.SuperHandle, selDispatchEvent, evt.Handle);
+			}
+		}
+	}
+}
diff --git a/src/WebKit/Enums.cs b/src/WebKit/Enums.cs
index 09f6dbc..afd17a3 100644
--- a/src/WebKit/Enums.cs
+++ b/src/WebKit/Enums.cs
@@ -22,6 +22,12 @@ namespace MonoMac.WebKit {
 		Custom = 3
 	}
 
+	public enum DomEventPhase {
+		Capturing = 1,
+		AtTarget = 2,
+		Bubbling = 3
+	}
+
 	[Flags]
 	public enum DomDocumentPosition {
 		Disconnected = 0x01,
diff --git a/src/webkit.cs b/src/webkit.cs
index c14e161..e81154b 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -112,6 +112,74 @@ namespace MonoMac.WebKit {
 		DomCssValueType Type { get; }
 	}
 
+	[BaseType (typeof (DomObject), Name="DOMEvent")]
+	interface DomEvent {
+		[Export ("type")]
+		string Type { get; }
+
+		[Export ("target")]
+		NSObject Target { get;  }
+
+		[Export ("currentTarget")]
+		NSObject CurrentTarget { get;  }
+
+		[Export ("eventPhase")]
+		DomEventPhase EventPhase { get;  }
+
+		[Export ("bubbles")]
+		bool Bubbles { get;  }
+
+		[Export ("cancelable")]
+		bool Cancelable { get;  }
+
+		[Export ("timeStamp")]
+		UInt64 TimeStamp { get;  }
+
+		[Export ("srcElement")]
+		NSObject SourceElement { get;  }
+
+		[Export ("returnValue")]
+		bool ReturnValue { get; set;  }
+
+		[Export ("cancelBubble")]
+		bool CancelBubble { get; set;  }
+
+		[Export ("stopPropagation")]
+		void StopPropagation ();
+
+		[Export ("preventDefault")]
+		void PreventDefault ();
+
+		[Export ("initEvent:canBubbleArg:cancelableArg:")]
+		void InitEvent (string eventTypeArg, bool canBubbleArg, bool cancelableArg);
+	}
+
+	[BaseType (typeof (NSObject), Name="DOMEventListener")]
+	[Model]
+	interface DomEventListener {
+		[Abstract]
+		[Export ("handleEvent:")]
+		void HandleEvent (DomEvent evt);
+	}
+
+/*
+	[BaseType (typeof (NSObject), Name="DOMEventTarget")]
+	[Model]
+	interface DomEventTarget {
+		[Abstract]
+		[Export ("addEventListener:listener:useCapture:")]
+		void AddEventListener (string type, DomEventListener listener, bool useCapture);
+
+		[Abstract]
+		[Export ("removeEventListener:listener:useCapture:")]
+		void RemoveEventListener (string type, DomEventListener listener, bool useCapture);
+
+		[Abstract]
+		[Export ("dispatchEvent:")]
+		bool DispatchEvent (DomEvent evt);
+	}
+*/
+
 	[BaseType (typeof (DomObject), Name="DOMHTMLCollection")]
 	interface DomHtmlCollection {
 		[Export ("length")]
-- 
1.7.2

