? string.diff
Index: String.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/String.cs,v
retrieving revision 1.89
diff -u -r1.89 String.cs
--- String.cs	11 Apr 2003 09:50:00 -0000	1.89
+++ String.cs	9 May 2003 18:29:49 -0000
@@ -18,6 +18,7 @@
 namespace System {
 	[Serializable]
 	public sealed class String : IConvertible, IComparable, ICloneable, IEnumerable {
+		[NonSerialized]
 		private int length;
 
 		private const int COMPARE_CASE = 0;
