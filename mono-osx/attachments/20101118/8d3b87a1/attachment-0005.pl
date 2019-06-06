>From c1955b936f769c0cc64a776e1b2a4f52b0c52a9c Mon Sep 17 00:00:00 2001
From: Alex Shulgin <alexander.shulgin@yessoftware.com>
Date: Thu, 18 Nov 2010 18:44:13 +0200
Subject: [PATCH 12/12] Added DomUIEvent, DomKeyboardEvent and DomMouseEvent.

---
 src/WebKit/Enums.cs |    6 +++
 src/webkit.cs       |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/src/WebKit/Enums.cs b/src/WebKit/Enums.cs
index 3bc3ec2..bc24efc 100644
--- a/src/WebKit/Enums.cs
+++ b/src/WebKit/Enums.cs
@@ -32,6 +32,12 @@ namespace MonoMac.WebKit {
 		ImplementationSpecific = 0x20
 	}
 
+	public enum DomMouseButton {
+		Left = 0,
+		Middle = 1,
+		Right = 2
+	}
+
 	public enum DomNodeType {
 		Element = 1,
 		Attribute = 2,
diff --git a/src/webkit.cs b/src/webkit.cs
index ba0fd14..309be69 100644
--- a/src/webkit.cs
+++ b/src/webkit.cs
@@ -938,6 +938,132 @@ namespace MonoMac.WebKit {
 		void InitEvent (string eventTypeArg, bool canBubbleArg, bool cancelableArg);
 	}
 
+	[BaseType (typeof (DomEvent), Name="DOMUIEvent")]
+	interface DomUIEvent {
+		[Export ("view")]
+		DomAbstractView View { get; }
+
+		[Export ("detail")]
+		int Detail { get; }
+
+		[Export ("keyCode")]
+		int KeyCode { get;  }
+
+		[Export ("charCode")]
+		int CharCode { get;  }
+
+		[Export ("layerX")]
+		int LayerX { get;  }
+
+		[Export ("layerY")]
+		int LayerY { get;  }
+
+		[Export ("pageX")]
+		int PageX { get;  }
+
+		[Export ("pageY")]
+		int PageY { get;  }
+
+		[Export ("which")]
+		int Which { get;  }
+
+		[Export ("initUIEvent:canBubble:cancelable:view:detail:")]
+		void InitUIEvent (string eventTypeArg, bool canBubble, bool cancelable, DomAbstractView view, int detail);
+	}
+
+	[BaseType (typeof (DomUIEvent), Name="DOMKeyboardEvent")]
+	interface DomKeyboardEvent {
+		[Export ("keyIdentifier")]
+		string KeyIdentifier { get; }
+
+		[Export ("keyLocation")]
+		uint KeyLocation { get; }
+
+		[Export ("ctrlKey")]
+		bool CtrlKey { get;  }
+
+		[Export ("shiftKey")]
+		bool ShiftKey { get;  }
+
+		[Export ("altKey")]
+		bool AltKey { get;  }
+
+		[Export ("metaKey")]
+		bool MetaKey { get;  }
+
+		[Export ("altGraphKey")]
+		bool AltGraphKey { get;  }
+
+		[Export ("keyCode")]
+		int KeyCode { get;  }
+
+		[Export ("charCode")]
+		int CharCode { get;  }
+
+		[Export ("getModifierState:")]
+		bool GetModifierState (string keyIdentifierArg);
+
+		[Export ("initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:keyLocation:ctrlKey:altKey:shiftKey:metaKey:altGraphKey:")]
+		void InitKeyboardEvent (string eventTypeArg, bool canBubble, bool cancelable, DomAbstractView view, string keyIdentifier, uint keyLocation, bool ctrlKey, bool altKey, bool shiftKey, bool metaKey, bool altGraphKey);
+
+		[Export ("initKeyboardEvent:canBubble:cancelable:view:keyIdentifier:keyLocation:ctrlKey:altKey:shiftKey:metaKey:")]
+		void InitKeyboardEvent (string eventTypeArg, bool canBubble, bool cancelable, DomAbstractView view, string keyIdentifier, uint keyLocation, bool ctrlKey, bool altKey, bool shiftKey, bool metaKey);
+	}
+
+	[BaseType (typeof (DomUIEvent), Name="DOMMouseEvent")]
+	interface DomMouseEvent {
+		[Export ("screenX")]
+		int ScreenX { get;  }
+
+		[Export ("screenY")]
+		int ScreenY { get;  }
+
+		[Export ("clientX")]
+		int ClientX { get;  }
+
+		[Export ("clientY")]
+		int ClientY { get;  }
+
+		[Export ("ctrlKey")]
+		bool CtrlKey { get;  }
+
+		[Export ("shiftKey")]
+		bool ShiftKey { get;  }
+
+		[Export ("altKey")]
+		bool AltKey { get;  }
+
+		[Export ("metaKey")]
+		bool MetaKey { get;  }
+
+		[Export ("button")]
+		DomMouseButton Button { get;  }
+
+		[Export ("relatedTarget")]
+		NSObject RelatedTarget { get;  }
+
+		[Export ("offsetX")]
+		int OffsetX { get;  }
+
+		[Export ("offsetY")]
+		int OffsetY { get;  }
+
+		[Export ("x")]
+		int X { get;  }
+
+		[Export ("y")]
+		int Y { get;  }
+
+		[Export ("fromElement")]
+		DomNode FromElement { get;  }
+
+		[Export ("toElement")]
+		DomNode ToElement { get;  }
+
+		[Export ("initMouseEvent:canBubble:cancelable:view:detail:screenX:screenY:clientX:clientY:ctrlKey:altKey:shiftKey:metaKey:button:relatedTarget:")]
+		void InitMouseEvent (string eventTypeArg, bool canBubble, bool cancelable, DomAbstractView view, int detail, int screenX, int screenY, int clientX, int clientY, bool ctrlKey, bool altKey, bool shiftKey, bool metaKey, DomMouseButton button, NSObject relatedTarget);
+	}
+
 	[BaseType (typeof (NSObject), Name="DOMEventListener")]
 	[Model]
 	interface DomEventListener {
-- 
1.7.2

