Index: PropertyCollection.cs
===================================================================
--- PropertyCollection.cs	(revision 41947)
+++ PropertyCollection.cs	(working copy)
@@ -40,11 +40,17 @@
 	{
 		private ArrayList m_oKeys = new ArrayList();
 		private Hashtable m_oValues = new Hashtable();
+		private DirectoryEntry _parent;
 
-		internal PropertyCollection()
+		internal PropertyCollection(): this(null)
 		{
 		}
 
+		internal PropertyCollection(DirectoryEntry parent)
+		{
+			_parent=parent;
+		}
+
 		public int Count
 		{
 			get{return m_oValues.Count;}
@@ -167,7 +173,7 @@
 				}
 				else
 				{
-					PropertyValueCollection _pValColl=new PropertyValueCollection();
+					PropertyValueCollection _pValColl=new PropertyValueCollection(_parent);
 //					String tstr=new String(propertyName.ToCharArray());
 //					Add((string)tstr.ToLower(), (PropertyValueCollection)_pValColl);
 					Add((string)propertyName.ToLower(), (PropertyValueCollection)_pValColl);
