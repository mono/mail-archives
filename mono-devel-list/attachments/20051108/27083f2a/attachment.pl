Index: Type.cs
===================================================================
--- Type.cs	(revision 52652)
+++ Type.cs	(working copy)
@@ -1241,20 +1241,7 @@
 		}
 
 		internal object[] GetPseudoCustomAttributes () {
-			int count = 0;
-
-			if (IsSerializable)
-				count ++;
-
-			if (count == 0)
-				return null;
-			object[] attrs = new object [count];
-			count = 0;
-
-			if (IsSerializable)
-				attrs [count ++] = new SerializableAttribute ();
-
-			return attrs;
+			return null;
 		}			
 
 #endif