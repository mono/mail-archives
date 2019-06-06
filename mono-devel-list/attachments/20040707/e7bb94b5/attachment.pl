Index: DataContainer.cs
===================================================================
RCS file: /cvs/public/mcs/class/System.Data/System.Data.Common/DataContainer.cs,v
retrieving revision 1.6
diff -u -r1.6 DataContainer.cs
--- DataContainer.cs	18 Jun 2004 10:33:17 -0000	1.6
+++ DataContainer.cs	6 Jul 2004 21:59:21 -0000
@@ -1098,8 +1098,8 @@
 			{
 				// if exception thrown, it should be caught 
 				// in the  caller method
-				base.SetValue(index,record.GetDateTime(field));
-				base.SetItemFromDataRecord(index,record,field);
+				if (!CheckAndSetNull(index,record,field))
+				    base.SetValue(index,record.GetDateTime(field));
 			}
 
 			internal override int CompareValues(int index1, int index2)
