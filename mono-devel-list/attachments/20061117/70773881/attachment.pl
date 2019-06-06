Index: System.Collections/Hashtable.cs
===================================================================
--- System.Collections/Hashtable.cs	(revision 68053)
+++ System.Collections/Hashtable.cs	(working copy)
@@ -575,7 +575,10 @@
 			loadFactor = (float) serializationInfo.GetValue ("LoadFactor", typeof(float));
 			modificationCount = (int) serializationInfo.GetValue ("Version", typeof(int));
 #if NET_2_0
-			equalityComparer = (IEqualityComparer) serializationInfo.GetValue ("KeyComparer", typeof (object));
+			try {
+				equalityComparer = (IEqualityComparer) serializationInfo.GetValue ("KeyComparer", typeof (object));
+			} catch (SerializationException) {
+			}
 			if (equalityComparer == null)
 				comparerRef = (IComparer) serializationInfo.GetValue ("Comparer", typeof (object));
 #else
