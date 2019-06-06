Index: PropertyValueCollection.cs
===================================================================
--- PropertyValueCollection.cs	(revision 41947)
+++ PropertyValueCollection.cs	(working copy)
@@ -38,10 +38,12 @@
 	{
 
 		private bool _Mbit;
+		private DirectoryEntry _parent;
 
-		internal PropertyValueCollection():base()
+		internal PropertyValueCollection(DirectoryEntry parent):base()
 		{
 			_Mbit = false;
+			_parent = parent;
 		}
 
 		internal bool Mbit
@@ -136,21 +138,33 @@
 		[MonoTODO]
 		protected override void OnClearComplete ()
 		{
+			if (_parent != null) {
+				_parent.CommitDeferred();
+			}
 		}
 
 		[MonoTODO]
 		protected override void OnInsertComplete (int index, object value)
 		{
+			if (_parent != null) {
+				_parent.CommitDeferred();
+			}
 		}
 
 		[MonoTODO]
 		protected override void OnRemoveComplete (int index, object value)
 		{
+			if (_parent != null) {
+				_parent.CommitDeferred();
+			}
 		}
 
 		[MonoTODO]
 		protected override void OnSetComplete (int index, object oldValue, object newValue)
 		{
+			if (_parent != null) {
+				_parent.CommitDeferred();
+			}
 		}
 
 		public object Value 
@@ -166,7 +180,7 @@
 //					System.Object[] oArray= new System.Object[this.Count];
 //					object[] oArray= new object[this.Count];
 //					Array.Copy((System.Array)List,0,(System.Array)oArray,0,this.Count);
-						Array LArray = Array.CreateInstance( Type.GetType("System.Object"), this.Count );
+						Array LArray = new object[Count];
 						for ( int i = LArray.GetLowerBound(0); i <= LArray.GetUpperBound(0); i++ )
 							LArray.SetValue( List[i], i );
 						return LArray;
