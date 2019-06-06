Index: Test/System.Collections.Specialized/NameValueCollectionTest.cs
===================================================================
--- Test/System.Collections.Specialized/NameValueCollectionTest.cs	(revision 75811)
+++ Test/System.Collections.Specialized/NameValueCollectionTest.cs	(working copy)
@@ -292,6 +292,21 @@
 			NameValueCollection c = new NameValueCollection ();
 			c.CopyTo (a, 0);
 		}
+		
+		[Test]
+#if NET_2_0
+		[ExpectedException (typeof (InvalidCastException))]
+#else		
+		[ExpectedException (typeof (ArrayTypeMismatchException))]
+#endif
+		public void CopyTo_WrongTypeArray ()
+		{
+			Array a = Array.CreateInstance (typeof (DateTime), 3);
+			NameValueCollection c = new NameValueCollection ();
+			for (int i = 0; i < 3; i++)
+				c.Add(i.ToString(), i.ToString());
+			c.CopyTo(a, 0);
+		}
 
 		[Test]
 		public void Remove () 
@@ -323,8 +338,30 @@
 				AssertEquals ("Remove-3-Count", 0, c.Count);
 			}
 		}
+		[Test]
 #if NET_2_0
+		[ExpectedException (typeof (ArgumentNullException))]
+#else
+		[ExpectedException (typeof (NullReferenceException))]
+#endif		
+		public void Constructor_Null_NVC ()
+		{
+			NameValueCollection nvc = new NameValueCollection((NameValueCollection)null);
+		}
+		
 		[Test]
+#if NET_2_0
+		[ExpectedException (typeof (ArgumentNullException))]
+#else
+		[ExpectedException (typeof (NullReferenceException))]
+#endif		
+		public void Constructor_Capacity_Null_NVC ()
+		{
+			NameValueCollection nvc = new NameValueCollection(10, (NameValueCollection)null);
+		}
+
+#if NET_2_0
+		[Test]
 		public void Constructor_IEqualityComparer ()
 		{
 			NameValueCollection coll = new NameValueCollection (new EqualityComparer ());
Index: System.Collections.Specialized/NameValueCollection.cs
===================================================================
--- System.Collections.Specialized/NameValueCollection.cs	(revision 75811)
+++ System.Collections.Specialized/NameValueCollection.cs	(working copy)
@@ -64,10 +64,15 @@
 		/// TODO: uncomment constructor below after it will be possible to compile NameValueCollection and
 		/// NameObjectCollectionBase to the same assembly 
 		
-		public NameValueCollection( NameValueCollection col ) : base(col.HashCodeProvider,col.Comparer)
+		public NameValueCollection( NameValueCollection col ) : base((col == null) ? null : col.HashCodeProvider,
+				                                             (col == null) ? null : col.Comparer)
 		{
 			if (col==null)
+#if NET_2_0
 				throw new ArgumentNullException ("col");
+#else
+				throw new NullReferenceException();
+#endif				
 			Add(col);
 		}
 
@@ -93,7 +98,8 @@
 		/// NameObjectCollectionBase to the same assembly 
 		
 		public NameValueCollection( int capacity, NameValueCollection col )
-			: base(capacity, col.HashCodeProvider, col.Comparer)
+			: base(capacity, (col == null) ? null : col.HashCodeProvider, 
+					(col == null) ? null : col.Comparer)
 		{
 			Add(col);			
 		}
@@ -263,7 +269,17 @@
 
 			if (cachedAll==null)
 				RefreshCachedAll();
+#if NET_2_0
+			try {
+#endif			
 			cachedAll.CopyTo(dest, index);
+#if NET_2_0
+		        }
+		        catch (ArrayTypeMismatchException e)  
+		        {
+		        	throw new InvalidCastException();
+		        }
+#endif		        
 		}
 
 		private void RefreshCachedAll()
