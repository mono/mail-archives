Index: System.Runtime.Serialization.Json/TypeMap.cs
===================================================================
--- System.Runtime.Serialization.Json/TypeMap.cs	(revision 147765)
+++ System.Runtime.Serialization.Json/TypeMap.cs	(working copy)
@@ -58,11 +58,9 @@
 			if (atts.Length == 1)
 				return CreateTypeMap (type, (DataContractAttribute) atts [0]);
 
-#if !NET_2_1
 			atts = type.GetCustomAttributes (typeof (SerializableAttribute), false);
 			if (atts.Length == 1)
 				return CreateTypeMap (type, null);
-#endif
 
 			if (IsPrimitiveType (type))
 				return null;
@@ -141,7 +139,7 @@
 				}
 			}
 
-			members.Sort (delegate (TypeMapMember m1, TypeMapMember m2) { return m1.Order - m2.Order; });
+			members.Sort (delegate (TypeMapMember m1, TypeMapMember m2) { return m1.Order != m2.Order ? m1.Order - m2.Order : String.CompareOrdinal (m1.Name, m2.Name); });
 			return new TypeMap (type, dca == null ? null : dca.Name, members.ToArray ());
 		}
 
