Index: System.Runtime.Serialization.Json/TypeMap.cs
===================================================================
--- System.Runtime.Serialization.Json/TypeMap.cs	(revision 148098)
+++ System.Runtime.Serialization.Json/TypeMap.cs	(working copy)
@@ -141,7 +141,7 @@
 				}
 			}
 
-			members.Sort (delegate (TypeMapMember m1, TypeMapMember m2) { return m1.Order - m2.Order; });
+			members.Sort (delegate (TypeMapMember m1, TypeMapMember m2) { return m1.Order != m2.Order ? m1.Order - m2.Order : String.CompareOrdinal (m1.Name, m2.Name); });
 			return new TypeMap (type, dca == null ? null : dca.Name, members.ToArray ());
 		}
 
