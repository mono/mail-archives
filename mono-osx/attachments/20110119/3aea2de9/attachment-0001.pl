diff --git a/src/Foundation/NSUrlConnection.cs b/src/Foundation/NSUrlConnection.cs
index 03fb644..038b005 100644
--- a/src/Foundation/NSUrlConnection.cs
+++ b/src/Foundation/NSUrlConnection.cs
@@ -38,8 +38,8 @@ namespace MonoMac.Foundation {
 			else
 				response = null;
 
-			if (errorStorage != IntPtr.Zero)
-				error = (NSUrlResponse) Runtime.GetNSObject (errorStorage);
+			if (ehandle != IntPtr.Zero)
+				error = (NSError) Runtime.GetNSObject (errorStorage);
 			else
 				error = null;
 			
