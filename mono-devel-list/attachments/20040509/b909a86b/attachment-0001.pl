--- OciDefineHandle.orig	Sun May  9 07:48:31 2004
+++ OciDefineHandle.cs	Sun May  9 07:43:45 2004
@@ -264,7 +264,7 @@
 				byte [] buffer = new byte [Size];
 				Marshal.Copy (Value, buffer, 0, Size);
 
-				return Encoding.UTF8.GetString (buffer);
+				return Encoding.Default.GetString (buffer);
 
 			case OciDataType.Integer:
 				tmp = Marshal.PtrToStringAnsi (Value, Size);
@@ -274,10 +274,14 @@
 			case OciDataType.Number:
 				tmp = Marshal.PtrToStringAnsi (Value, Size);
 				if (tmp != null) {
-				    if (Scale == 0)
-					return Int32.Parse (String.Copy ((string) tmp));
-				    else
-					return Decimal.Parse (String.Copy ((string) tmp));
+					try {
+					    if (Scale == 0)
+						    return Int32.Parse (String.Copy ((string) tmp));
+					    else
+						    return Decimal.Parse (String.Copy ((string) tmp));
+					} catch {
+						return Decimal.Parse (String.Copy ((string) tmp));
+					}	
 				}
 				break;
 			case OciDataType.Float:
