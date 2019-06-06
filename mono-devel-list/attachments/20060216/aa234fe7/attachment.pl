Index: String.cs
===================================================================
--- String.cs	(revision 56916)
+++ String.cs	(working copy)
@@ -59,7 +59,7 @@
 
 		public static readonly String Empty = "";
 
-		public static unsafe bool Equals (string a, string b)
+		public static bool Equals (string a, string b)
 		{
 			if ((a as object) == (b as object))
 				return true;
@@ -67,15 +67,52 @@
 			if (a == null || b == null)
 				return false;
 
-			int len = a.length;
+			return a.Equals (b);
+		}
 
-			if (len != b.length)
+		public static bool operator == (String a, String b)
+		{
+			return Equals (a, b);
+		}
+
+		public static bool operator != (String a, String b)
+		{
+			if ((a as object) == (b as object))
 				return false;
 
+			if (a == null)
+				return b != null;
+			if (b == null)
+				return true;
+
+			return a.Inequals (b);
+		}
+
+#if NET_2_0
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
+#endif
+		public override bool Equals (Object obj)
+		{
+			return Equals (obj as String);
+		}
+
+#if NET_2_0
+		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
+#endif
+		public unsafe bool Equals (String value)
+		{
+			if (value == null)
+				return false;
+
+			int len = length;
+
+			if (len != value.length)
+				return false;
+
 			if (len == 0)
 				return true;
 
-			fixed (char * s1 = &a.start_char, s2 = &b.start_char) {
+			fixed (char * s1 = &start_char, s2 = &value.start_char) {
 				// it must be one char, because 0 len is done above
 				if (len < 2)
 					return *s1 == *s2;
@@ -97,30 +134,39 @@
 			}
 		}
 
-		public static bool operator == (String a, String b)
+		unsafe bool Inequals (string value)
 		{
-			return Equals (a, b);
-		}
+			if (value == null)
+				return true;
 
-		public static bool operator != (String a, String b)
-		{
-			return !Equals (a, b);
-		}
+			int len = length;
 
-#if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
-#endif
-		public override bool Equals (Object obj)
-		{
-			return Equals (this, obj as String);
-		}
+			if (len != value.length)
+				return true;
 
-#if NET_2_0
-		[ReliabilityContractAttribute (Consistency.WillNotCorruptState, Cer.MayFail)]
-#endif
-		public bool Equals (String value)
-		{
-			return Equals (this, value);
+			if (len == 0)
+				return false;
+
+			fixed (char * s1 = &start_char, s2 = &value.start_char) {
+				// it must be one char, because 0 len is done above
+				if (len < 2)
+					return *s1 != *s2;
+
+				// check by twos
+				int * sint1 = (int *) s1, sint2 = (int *) s2;
+				int n2 = len >> 1;
+				do {
+					if (*sint1++ != *sint2++)
+						return true;
+				} while (--n2 != 0);
+
+				// nothing left
+				if ((len & 1) == 0)
+					return false;
+
+				// check the last one
+				return *(char *) sint1 != *(char *) sint2;
+			}
 		}
 
 		[IndexerName ("Chars")]