Index: mcs/class/corlib/System/String.cs
===================================================================
--- mcs/class/corlib/System/String.cs	(revision 40956)
+++ mcs/class/corlib/System/String.cs	(working copy)
@@ -1244,7 +1244,12 @@
 
 			return InternalIsInterned (str);
 		}
-	
+#if NET_2_0
+		public static bool IsNullOrEmpty(string value)
+		{
+			return (value==null) || value.Length==0;
+		}
+#endif
 		public static string Join (string separator, string [] value)
 		{
 			if (value == null)
