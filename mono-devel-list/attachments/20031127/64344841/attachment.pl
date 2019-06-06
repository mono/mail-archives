Index: mcs/class/Mono.Data.SqliteClient/Mono.Data.SqliteClient/SqliteDataReader.cs
===================================================================
RCS file: /mono/mcs/class/Mono.Data.SqliteClient/Mono.Data.SqliteClient/SqliteDataReader.cs,v
retrieving revision 1.3
diff -u -r1.3 SqliteDataReader.cs
--- mcs/class/Mono.Data.SqliteClient/Mono.Data.SqliteClient/SqliteDataReader.cs	26 Jul 2003 17:53:52 -0000	1.3
+++ mcs/class/Mono.Data.SqliteClient/Mono.Data.SqliteClient/SqliteDataReader.cs	27 Nov 2003 13:21:01 -0000
@@ -195,7 +195,7 @@
                                 for (int i = 0; i < argc; i++) {
                                         string col = new String (colnames[i]);
                                         columns.Add (col);
-                                        column_names[col.ToLower ()] = i++;
+                                        column_names[col.ToLower ()] = i;
                                 }
                         }
 
