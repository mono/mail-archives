Index: System.Xml.XPath/DefaultContext.cs
===================================================================
--- System.Xml.XPath/DefaultContext.cs	(revision 45578)
+++ System.Xml.XPath/DefaultContext.cs	(working copy)
@@ -119,8 +119,11 @@
 			// Return string in roundtrip format (currently it
 			// rather breaks things, so we don't use it until
 			// System.Double gets fixed.)
-//			return ((double) d).ToString ("R", System.Globalization.NumberFormatInfo.InvariantInfo);
+#if TARGET_JVM
+			return d.ToString ("R", System.Globalization.NumberFormatInfo.InvariantInfo);
+#else
 			return ((double) d).ToString (System.Globalization.NumberFormatInfo.InvariantInfo);
+#endif
 		}
 
 		public static double ToNumber (object arg)
