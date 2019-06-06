Index: System.Collections.Generic/ChangeLog
===================================================================
--- System.Collections.Generic/ChangeLog	(revision 60681)
+++ System.Collections.Generic/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-05-14  Kazuki Oikawa  <kazuki@panicode.com>
+
+	* List.cs : implemented Sort(Comparison <T>).
+
 2006-05-08  Atsushi Enomoto  <atsushi@ximian.com>
 
 	* List.cs : use proper comparer in Contains(), IndexOf() and
Index: System.Collections.Generic/List.cs
===================================================================
--- System.Collections.Generic/List.cs	(revision 60681)
+++ System.Collections.Generic/List.cs	(working copy)
@@ -472,12 +472,10 @@
 		{
 			Array.Sort<T> (data, 0, size, comparer);
 		}
-		
-		// Waiting on Array
-		[MonoTODO]
+
 		public void Sort (Comparison <T> comparison)
 		{
-			throw new NotImplementedException ();
+			Array.Sort<T> (data, size, comparison);
 		}
 		
 		public void Sort (int index, int count, IComparer <T> comparer)
Index: System/Array.cs
===================================================================
--- System/Array.cs	(revision 60681)
+++ System/Array.cs	(working copy)
@@ -1439,15 +1439,20 @@
 		{
 			if (array == null)
 				throw new ArgumentNullException ("array");
+			Sort<T> (array, array.Length, comparison);
+		}
+
+		internal static void Sort<T> (T [] array, int length, Comparison<T> comparison)
+		{
 			if (comparison == null)
 				throw new ArgumentNullException ("comparison");
 
-			if (array.Length <= 1)
+			if (length <= 1 || array.Length <= 1)
 				return;
 			
 			try {
 				int low0 = 0;
-				int high0 = array.Length - 1;
+				int high0 = length - 1;
 				qsort<T> (array, low0, high0, comparison);
 			}
 			catch (Exception e) {
Index: System/ChangeLog
===================================================================
--- System/ChangeLog	(revision 60681)
+++ System/ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2006-05-14  Kazuki Oikawa  <kazuki@panicode.com>
+
+	* Array.cs : added internal sort method used
+	  in System.Collections.Generics.List<T>.Sort(Comparison<T>).
+
 2006-05-10  Zoltan Varga  <vargaz@gmail.com>
 
 	* MonoType.cs (GetMethodImpl): Fix a warning.