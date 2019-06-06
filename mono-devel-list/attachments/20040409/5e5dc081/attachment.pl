--- mcs/class/System.Data.OracleClient/System.Data.OracleClient.Oci/OciDefineHandle.cs	Sat Apr  3 17:19:03 2004
+++ mcs-my/class/System.Data.OracleClient/System.Data.OracleClient.Oci/OciDefineHandle.cs	Thu Apr  8 11:38:14 2004
@@ -110,6 +110,9 @@
 				definedSize = -1;
 				DefineLob (position, definedType);
 				return;
+            case OciDataType.Raw:
+                DefineRaw( position);
+                return;
 			default:
 				DefineChar (position); // HANDLE ALL OTHERS AS CHAR FOR NOW
 				return;
@@ -205,6 +208,32 @@
 			}
 		}
 
+        void DefineRaw( int position)
+        {
+        	ociType = OciDataType.Raw;
+			
+			value = Marshal.AllocHGlobal (definedSize);
+
+			int status = 0;
+
+			status = OciCalls.OCIDefineByPos (Parent,
+						out handle,
+						ErrorHandle,
+						position + 1,
+						value,
+						definedSize * 2,
+						ociType,
+						ref indicator,
+						ref rlenp,
+						IntPtr.Zero,
+						0);
+
+			if (status != 0) {
+				OciErrorInfo info = ErrorHandle.HandleError ();
+				throw new OracleException (info.ErrorCode, info.ErrorMessage);
+			}
+        }
+
 		protected override void Dispose (bool disposing) 
 		{
 			if (!disposed) {
@@ -259,6 +288,12 @@
 				break;
 			case OciDataType.Date:
 				return UnpackDate ();
+            case OciDataType.Raw:
+                byte[] raw_buffer = new byte [Size];
+
+                Marshal.Copy (Value, raw_buffer, 0, Size);
+
+                return raw_buffer;
 			}
 
 			return DBNull.Value;
