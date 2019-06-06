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
index 7f7e035..57359cf 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -2956,7 +2956,7 @@ namespace MonoMac.AppKit {
 
 		[Export ("continuous")]
 		bool Continuous { [Bind ("isContinuous")]get; set; }
-
+		
 		[Export ("enabled")]
 		bool Enabled { [Bind ("isEnabled")]get; set; }
 
@@ -4780,7 +4780,7 @@ namespace MonoMac.AppKit {
 	[BaseType (typeof (NSObject))]
 	interface NSMenu {
 		[Export ("initWithTitle:")]
-		IntPtr NSObject (string aTitle);
+		IntPtr Constructor (string aTitle);
 
 		[Export ("popUpContextMenu:withEvent:forView:")]
 		void PopUpContextMenu (NSMenu menu, NSEvent theEvent, NSView view);
@@ -6516,7 +6516,8 @@ namespace MonoMac.AppKit {
 		bool DoCommandBySelector (NSControl control, NSTextView textView, Selector commandSelector);
 
 		[Export ("control:textView:completions:forPartialWordRange:indexOfSelectedItem:"), EventArgs ("NSControlTextFilter"), DefaultValue (null)]
-		string [] FilterCompletions (NSControl control, NSTextView textView, string [] words, NSRange charRange, int index);
+		//string [] FilterCompletions (NSControl control, NSTextView textView, string [] words, NSRange charRange, int index);
+		NSArray FilterCompletions (NSControl control, NSTextView textView, NSArray words, NSRange charRange, int index) ;
 	}
 
 	[BaseType (typeof (NSObject))]
@@ -10346,6 +10347,7 @@ namespace MonoMac.AppKit {
 
 		[Export ("textDidChange:"), EventArgs ("NSNotification")]
 		void TextDidChange (NSNotification notification);
+		
 	}
 
 	[BaseType (typeof (NSCell))]
@@ -10552,7 +10554,17 @@ namespace MonoMac.AppKit {
 		bool DoCommandBySelector (NSControl control, NSTextView textView, Selector commandSelector);
 
 		[Export ("control:textView:completions:forPartialWordRange:indexOfSelectedItem:"), EventArgs ("NSControlTextFilter"), DefaultValue (null)]
-		string [] FilterCompletions (NSControl control, NSTextView textView, string [] words, NSRange charRange, int index);
+		//string [] FilterCompletions (NSControl control, NSTextView textView, string [] words, NSRange charRange, int index);
+		NSArray FilterCompletions (NSControl control, NSTextView textView, NSArray words, NSRange charRange, int index) ;
+		
+       	[Export ("controlTextDidBeginEditing:"), EventArgs ("NSNotification")]
+        void ControlTextDidBeginEditing (NSNotification notification);
+
+        [Export ("controlTextDidEndEditing:"), EventArgs ("NSNotification")]
+        void ControlTextDidEndEditing (NSNotification notification);
+
+        [Export ("controlTextDidChange:"), EventArgs ("NSNotification")]
+        void ControlTextDidChange (NSNotification notification);		
 	}
 	
 	[BaseType (typeof (NSActionCell))]
@@ -10970,7 +10982,7 @@ namespace MonoMac.AppKit {
 		// Completion support
 		//
 		[Export ("complete:")]
-		void Complete (NSObject sender);
+		void Complete ([NullAllowed] NSObject sender);
 
 		[Export ("rangeForUserCompletion")]
 		NSRange RangeForUserCompletion ();
