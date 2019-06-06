Index: ListBox.cs
===================================================================
--- ListBox.cs	(revision 44453)
+++ ListBox.cs	(working copy)
@@ -1984,7 +1984,7 @@
 
 			public virtual void Insert (int index,  object item)
 			{
-				if (index < 0 || index >= Count)
+				if (index < 0 || index > Count)
 					throw new ArgumentOutOfRangeException ("Index of out range");
 					
 				int idx;