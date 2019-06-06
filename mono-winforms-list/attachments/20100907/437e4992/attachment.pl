diff --git a/mcs/class/Managed.Windows.Forms/System.Windows.Forms.CarbonInternal/Dnd.cs b/mcs/class/Managed.Windows.Forms/System.Windows.Forms.CarbonInternal/Dnd.cs
index 24e6bb9..3e48c20 100644
--- a/mcs/class/Managed.Windows.Forms/System.Windows.Forms.CarbonInternal/Dnd.cs
+++ b/mcs/class/Managed.Windows.Forms/System.Windows.Forms.CarbonInternal/Dnd.cs
@@ -50,7 +50,7 @@ namespace System.Windows.Forms.CarbonInternal {
 		private static DragTrackingDelegate DragTrackingHandler = new DragTrackingDelegate (TrackingCallback);
 
 		static Dnd () {
-			InstallTrackingHandler (DragTrackingHandler, IntPtr.Zero, IntPtr.Zero);
+			//InstallTrackingHandler (DragTrackingHandler, IntPtr.Zero, IntPtr.Zero);
 		}
 
 		internal Dnd () {