Index: System.Windows.Forms/ListView.cs
===================================================================
--- System.Windows.Forms/ListView.cs	(revision 85451)
+++ System.Windows.Forms/ListView.cs	(working copy)
@@ -4907,6 +4907,7 @@
 			void CollectionChanged (bool sort)
 			{
 				if (owner != null) {
+					owner.AdjustItemsPositionArray (list.Count);
 					if (sort)
 						owner.Sort (false);
 