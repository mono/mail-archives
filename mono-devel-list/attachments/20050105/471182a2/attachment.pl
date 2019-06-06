Index: List.cs
===================================================================
--- List.cs	(revision 38269)
+++ List.cs	(working copy)
@@ -4,6 +4,7 @@
 // Authors:
 //    Ben Maurer (bmaurer@ximian.com)
 //    Martin Baulig (martin@ximian.com)
+//    Kazuki Oikawa (kazuki@panicode.com)
 //
 // (C) 2004 Novell, Inc.
 //
@@ -48,11 +49,11 @@
 			
 		const int DefaultCapacity = 4;
 		
-		public List ()
+		public List () : this (DefaultCapacity)
 		{
 		}
 		
-		public List (IEnumerable <T> collection)
+		public List (IEnumerable <T> collection) : this()
 		{
 			AddRange (collection);
 		}
@@ -70,25 +71,23 @@
 				Capacity = Math.Max (Capacity * 2, DefaultCapacity);
 			
 			data [size ++] = item;
+			version++;
 		}
 		
 		public void CheckRange (int idx, int count)
 		{
-			if (idx < 0 || count < 0 || idx + count < size)
+			if (idx < 0 || count < 0 || size - idx < count)
 				throw new ArgumentOutOfRangeException ();
 		}
 		
-		[MonoTODO ("PERFORMANCE: fix if it is an IList <T>")]
 		public void AddRange(IEnumerable<T> collection)
 		{
-			foreach (T t in collection)
-				Add (t);
+			InsertRange (size, collection);
 		}
 		
-		[MonoTODO]
 		public IList<T> AsReadOnly ()
 		{
-			throw new NotImplementedException ();
+			return new ReadOnlyList<T> (data);
 		}
 		
 		public int BinarySearch(T item)
@@ -113,6 +112,7 @@
 				return;
 			
 			Array.Clear (data, 0, data.Length);
+			version++;
 		}
 		
 		public bool Contains (T item)
@@ -236,10 +236,18 @@
 			return new Enumerator <T> (this);
 		}
 		
-		[MonoTODO]
 		public List <T> GetRange (int index, int count)
 		{
-			throw new NotImplementedException ();
+			if (index < 0 || count < 0)
+				throw new ArgumentOutOfRangeException ();
+			if (size - index < count)
+				throw new ArgumentException ();
+
+			List<T> list = new List<T> (count);
+			Array.Copy (data, index, list.data, 0, count);
+			list.size = count;
+
+			return list;
 		}
 		
 		public int IndexOf (T item)
@@ -263,24 +271,50 @@
 		
 		void Shift (int start, int delta)
 		{
-			Array.Copy (data, start, data, start + delta, size - start);
+			if (delta == 0) return;
+			if (delta > 0) {
+				Array.Copy (data, start, data, start + delta, size - start);
+			} else {
+				Array.Copy (data, start - delta, data, start, size - start);
+			}
 		}
 		
 		public void Insert (int index, T item)
 		{
-			if ((uint) index < (uint) size)
+			if (index < 0 || index - 1 > size)
 				throw new ArgumentOutOfRangeException ();
 			
+			if (data.Length == size) {
+				Capacity += DefaultCapacity;
+			}
+			
 			Shift (index, 1);
 			size ++;
 			this [index] = item;
-				
+			version++;
 		}
 		[MonoTODO ("Performance for collection")]
 		public void InsertRange (int index, IEnumerable<T> collection)
 		{
-			foreach (T t in collection)
-				Insert (index ++, t);
+			if (collection == null)
+				throw new ArgumentNullException ("collection");
+			if (index < 0 || index > size)
+				throw new ArgumentOutOfRangeException ("index");
+
+			ICollection<T> items = collection as ICollection<T>;
+			if (items == null) {
+				foreach (T t in collection)
+					Insert (index++, t);
+			} else {
+				Capacity += items.Count;
+
+				if (index < size)
+					Array.Copy (data, index, data, index + items.Count, size - index);
+
+				items.CopyTo (data, index);
+				size += items.Count;
+				version++;
+			}
 		}
 		
 		public int LastIndexOf (T item)
@@ -333,6 +367,8 @@
 		{
 			CheckRange (index, count);
 			Shift (index, -count);
+			size -= count;
+			version++;
 		}
 		
 		public void Reverse ()
@@ -343,6 +379,7 @@
 		{
 			CheckRange (index, count);
 			Array.Reverse (data, index, count);
+			version++;
 		}
 		
 		public void Sort ()
@@ -359,6 +396,8 @@
 		public void Sort (Comparison<T> comparison)
 		{
 			throw new NotImplementedException ();
+			// Array.Sort<T> (data, comparison);
+			// version++;
 		}
 		
 		[MonoTODO]
@@ -366,6 +405,8 @@
 		{
 			CheckRange (index, count);
 			throw new NotImplementedException ();
+			// Array.Sort<T> (data, index, count, comparer);
+			// version++;
 		}
 
 		public T [] ToArray ()
@@ -419,10 +460,11 @@
 				if ((uint) index >= (uint) size)
 					throw new IndexOutOfRangeException ();
 				data [index] = value;
+				version++;
 			}
 		}
 		
-#region Interface Crap
+		#region Interface Crap
 		IEnumerator <T> IEnumerable <T>.GetEnumerator()
 		{
 			return GetEnumerator ();
@@ -486,9 +528,9 @@
 			get { return this [index]; }
 			set { this [index] = (T) value; }
 		}
-#endregion
+		#endregion
 		
-		
+		#region Enumerator <T>
 		public struct Enumerator <T> : IEnumerator <T>, IEnumerator, IDisposable {
 			const int NOT_STARTED = -2;
 			
@@ -548,6 +590,80 @@
 			}
 			
 		}
+		#endregion
+
+		#region ReadOnlyList <T>
+		public class ReadOnlyList<T> : IList<T>
+		{
+			IList<T> _list;
+
+			public ReadOnlyList (IList<T> list)
+			{
+				if (list == null)
+					throw new ArgumentNullException ();
+				_list = list;
+			}
+
+			public T this[int index]
+			{
+				get { return _list [index]; }
+				set { throw new NotSupportedException (); }
+			}
+
+			public void Add (T item)
+			{
+				throw new NotSupportedException ();
+			}
+
+			public void Clear ()
+			{
+				throw new NotSupportedException ();
+			}
+
+			public bool Contains (T item)
+			{
+				return _list.Contains (item);
+			}
+
+			public void CopyTo (T[] array, int arrayIndex)
+			{
+				_list.CopyTo (array, arrayIndex);
+			}
+
+			public IEnumerator<T> GetEnumerator ()
+			{
+				return _list.GetEnumerator ();
+			}
+
+			public int IndexOf (T item)
+			{
+				return _list.IndexOf (item);
+			}
+
+			public void Insert (int index, T item)
+			{
+				throw new NotSupportedException ();
+			}
+
+			public bool Remove (T item)
+			{
+				throw new NotSupportedException ();
+			}
+
+			public void RemoveAt (int index)
+			{
+				throw new NotSupportedException ();
+			}
+
+			public int Count {
+				get { return _list.Count; }
+			}
+
+			public bool IsReadOnly {
+				get { return true; }
+			}
+		}
+		#endregion
 	}
 }
 #endif