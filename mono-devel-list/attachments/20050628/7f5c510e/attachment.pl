Index: ChangeLog
===================================================================
--- ChangeLog	(revision 46665)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2005-06-28  Elliott Draper  <el@eldiablo.co.uk>
+
+	* Activator.cs: This implements the generic Activator.CreateInstance<T>()
+	function for NET_2_0. It's full signature is:
+		public static T CreateInstance<T>();
+
 2005-06-28  Lluis Sanchez Gual  <lluis@novell.com>
 
 	* Decimal.cs: Renamed internal fields for the sake of serialization
Index: Activator.cs
===================================================================
--- Activator.cs	(revision 46665)
+++ Activator.cs	(working copy)
@@ -149,6 +149,14 @@
 			return (obj != null) ? new ObjectHandle (obj) : null;
 		}
 
+#if NET_2_0
+		public static T CreateInstance<T>()
+		{
+			Type type = typeof(T);
+			return (T)CreateInstance(type);
+		}
+#endif
+
 		public static object CreateInstance (Type type)
 		{
 			return CreateInstance (type, false);
