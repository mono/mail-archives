diff --git a/src/appkit.cs b/src/appkit.cs
index 1be01d1..7a71d2f 100755
--- a/src/appkit.cs
+++ b/src/appkit.cs
@@ -3173,7 +3173,8 @@ namespace MonoMac.AppKit {
 
 	}	
 	
-	[BaseType (typeof (NSControl), Delegates=new string [] {"WeakDelegate"}, Events=new Type [] {typeof (NSDatePickerCellDelegate)})]
+	//[BaseType (typeof (NSControl), Delegates=new string [] {"WeakDelegate"}, Events=new Type [] {typeof (NSDatePickerCellDelegate)})]
+	[BaseType (typeof (NSControl))]
 	interface NSDatePicker {
 		[Export ("initWithFrame:")]
 		IntPtr Constructor (RectangleF frameRect);
@@ -3193,7 +3194,10 @@ namespace MonoMac.AppKit {
 
 		[Export ("backgroundColor")]
 		NSColor BackgroundColor { get; set; }
-
+		
+		[Export ("cell")]
+		NSDatePickerCell Cell { get; set; }
+		
 		[Export ("textColor")]
 		NSColor TextColor { get; set; }
 
@@ -3231,7 +3235,8 @@ namespace MonoMac.AppKit {
 		NSDatePickerCellDelegate Delegate { get; set; }
 	}
 
-	[BaseType (typeof (NSActionCell), Delegates=new string [] {"WeakDelegate"}, Events=new Type [] {typeof (NSDatePickerCellDelegate)})]
+	//[BaseType (typeof (NSActionCell), Delegates=new string [] {"WeakDelegate"}, Events=new Type [] {typeof (NSDatePickerCellDelegate)})]
+	[BaseType (typeof (NSActionCell))]
 	interface NSDatePickerCell {
 		[Export ("initTextCell:")]
 		IntPtr Constructor (string aString);
