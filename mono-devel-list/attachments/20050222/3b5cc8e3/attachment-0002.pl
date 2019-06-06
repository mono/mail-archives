Index: CER.cs
===================================================================
--- CER.cs	(revision 41077)
+++ CER.cs	(working copy)
@@ -27,18 +27,18 @@
 //

 #if NET_2_0
-
 using System.Runtime.InteropServices;

 namespace System.Runtime.ConstrainedExecution
 {
+	[CLSCompliant (false)]
 	[Serializable]
 	[ComVisible (false)]
-        public enum CER
-        {
-                MayFail = 1,
-                None = 0,
-                Success = 2
-        }
+	public enum Cer
+	{
+		MayFail = 1,
+		None = 0,
+		Success = 2
+	}
 }
-#endif
+#endif
