Index: class/Managed.Windows.Forms/System.Windows.Forms/XplatUICarbon.cs
===================================================================
--- class/Managed.Windows.Forms/System.Windows.Forms/XplatUICarbon.cs	(revision 146212)
+++ class/Managed.Windows.Forms/System.Windows.Forms/XplatUICarbon.cs	(working copy)
@@ -792,7 +792,7 @@
 		}
 
 		internal override void AudibleAlert() {
-			throw new NotImplementedException();
+			AlertSoundPlay();
 		}
 
 		internal override void CaretVisible (IntPtr hwnd, bool visible) {
@@ -2369,6 +2369,9 @@
 		[DllImport("/System/Library/Frameworks/Carbon.framework/Versions/Current/Carbon")]
 		extern static short GetMBarHeight ();
 		
+		[DllImport("/System/Library/Frameworks/Carbon.framework/Versions/Current/Carbon")]
+		extern static void AlertSoundPlay ();
+		
 		#region Cursor imports
 		[DllImport("/System/Library/Frameworks/Carbon.framework/Versions/Current/Carbon")]
 		extern static Carbon.HIRect CGDisplayBounds (IntPtr displayID);
