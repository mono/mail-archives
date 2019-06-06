diff --git a/src/Makefile b/src/Makefile
index 2d4e291..d4f2b8b 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -119,4 +119,4 @@ clean:
 all: MonoMac.dll
 
 update: MonoMac.dll
-	cp monomac.dll ~/.config/MonoDevelop/addins/MonoDevelop.MonoMac.2.4.0.7/MonoMac.dll
+	cp monomac.dll ~/.config/MonoDevelop/addins/MonoDevelop.MonoMac.2.4.0.8/MonoMac.dll
diff --git a/src/appkit.cs b/src/appkit.cs
index 7f7e035..a14a89f 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -2863,7 +2863,7 @@ namespace MonoMac.AppKit {
 		int IndexOfItem (NSComboBox comboBox, string value);
 	}
 	
-	[BaseType (typeof (NSView))]
+    [BaseType (typeof (NSView),Delegates=new string [] { "Delegate" }, Events=new Type [] { typeof (NSControlDelegate)})]
 	interface NSControl {
 		[Export ("initWithFrame:")]
 		IntPtr Constructor (RectangleF frameRect);
@@ -2956,7 +2956,13 @@ namespace MonoMac.AppKit {
 
 		[Export ("continuous")]
 		bool Continuous { [Bind ("isContinuous")]get; set; }
-
+		
+		[Export ("delegate"), NullAllowed]
+        NSObject WeakDelegate { get; set; }
+       
+        [Wrap ("WeakDelegate")]
+        NSControlDelegate Delegate { get; set; }
+		
 		[Export ("enabled")]
 		bool Enabled { [Bind ("isEnabled")]get; set; }
 
@@ -2997,6 +3003,19 @@ namespace MonoMac.AppKit {
 		bool RefusesFirstResponder { get; set; }
 	}
 
+    [BaseType (typeof (NSObject))]
+    [Model]
+    interface NSControlDelegate {
+        [Export ("controlTextDidBeginEditing:"), EventArgs ("NSNotification")]
+        void ControlTextDidBeginEditing (NSNotification notification);
+
+        [Export ("controlTextDidEndEditing:"), EventArgs ("NSNotification")]
+        void ControlTextDidEndEditing (NSNotification notification);
+
+        [Export ("controlTextDidChange:"), EventArgs ("NSNotification")]
+        void ControlTextDidChange (NSNotification notification);
+    }
+	
 	[BaseType (typeof (NSObject))]
 	interface NSController {
 		[Export ("objectDidBeginEditing:")]
@@ -4780,7 +4799,7 @@ namespace MonoMac.AppKit {
 	[BaseType (typeof (NSObject))]
 	interface NSMenu {
 		[Export ("initWithTitle:")]
-		IntPtr NSObject (string aTitle);
+		IntPtr Constructor (string aTitle);
 
 		[Export ("popUpContextMenu:withEvent:forView:")]
 		void PopUpContextMenu (NSMenu menu, NSEvent theEvent, NSView view);
