Index: ChangeLog
===================================================================
RCS file: /cvs/public/mcs/class/System.Data/System.Data/ChangeLog,v
retrieving revision 1.230
diff -u -r1.230 ChangeLog
--- ChangeLog	23 Jun 2004 05:51:35 -0000	1.230
+++ ChangeLog	27 Jun 2004 15:51:34 -0000
@@ -1,3 +1,8 @@
+2004-06-27  Atsushi Enomoto  <atsushi@ximian.com>
+
+	* XmlDataInferenceLoader.cs : It was not always filling relation
+	  child table information correctly. This fixes bug #60742.
+
 2004-06-23 Umadevi S <sumadevi@novell.com>
 	* UniqueConstraint.cs :changed a ifdef true to ifdef NET_1_1
 
Index: XmlDataInferenceLoader.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Data/System.Data/XmlDataInferenceLoader.cs,v
retrieving revision 1.10
diff -u -r1.10 XmlDataInferenceLoader.cs
--- XmlDataInferenceLoader.cs	20 Jun 2004 18:52:23 -0000	1.10
+++ XmlDataInferenceLoader.cs	27 Jun 2004 15:51:34 -0000
@@ -410,7 +410,16 @@
 				map = new TableMapping (tableName, ns);
 				map.ParentTable = parent;
 				tables.Add (map);
-				if (parent != null)
+			}
+			if (parent != null) {
+				bool shouldAdd = true;
+				foreach (TableMapping child in parent.ChildTables) {
+					if (child.Table.TableName == tableName) {
+						shouldAdd = false;
+						break;
+					}
+				}
+				if (shouldAdd)
 					parent.ChildTables.Add (map);
 			}
 			return map;