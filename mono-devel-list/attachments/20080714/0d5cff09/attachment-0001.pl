Index: OdbcParameter.cs
===================================================================
--- OdbcParameter.cs	(revision 107657)
+++ OdbcParameter.cs	(working copy)
@@ -428,8 +428,6 @@
 			byte [] nativeBytes, buffer;
 
 			switch (_typeMap.OdbcType) {
-			case OdbcType.Binary:
-				throw new NotImplementedException ();
 			case OdbcType.Bit:
 				Marshal.WriteByte (_nativeBuffer, Convert.ToByte (Value));
 				return;
@@ -488,6 +486,7 @@
 				return;
 			case OdbcType.VarBinary:
 			case OdbcType.Image:
+			case OdbcType.Binary:
 				if (Value.GetType ().IsArray &&
 				    Value.GetType ().GetElementType () == typeof (byte)) {
 					Marshal.Copy ( (byte []) Value, 0, _nativeBuffer, ((byte []) Value).Length);

