Index: PropertyValueCollection.cs
===================================================================
--- PropertyValueCollection.cs	(revision 41792)
+++ PropertyValueCollection.cs	(working copy)
@@ -157,25 +157,27 @@
 		{
 			get
 			{
-				if(this.Count==1)
-				{
-					return (object) List[0];
-				}
-				else
-				{
+				switch (Count) {
+					case 0 : 
+						return null;
+					case 1 :
+						return (object) List[0];
+					default :
 //					System.Object[] oArray= new System.Object[this.Count];
 //					object[] oArray= new object[this.Count];
 //					Array.Copy((System.Array)List,0,(System.Array)oArray,0,this.Count);
-					Array LArray = Array.CreateInstance( Type.GetType("System.Object"), this.Count );
-					for ( int i = LArray.GetLowerBound(0); i <= LArray.GetUpperBound(0); i++ )
-						LArray.SetValue( List[i], i );
-					return LArray;
+						Array LArray = Array.CreateInstance( Type.GetType("System.Object"), this.Count );
+						for ( int i = LArray.GetLowerBound(0); i <= LArray.GetUpperBound(0); i++ )
+							LArray.SetValue( List[i], i );
+						return LArray;
 				}
 			}
 			set
 			{
 				List.Clear();
-				Add(value);
+				if (value != null) {
+					Add(value);
+				}
 			}
 		}
 
