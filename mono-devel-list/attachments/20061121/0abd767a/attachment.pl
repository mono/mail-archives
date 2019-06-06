Index: System/ChangeLog
===================================================================
--- System/ChangeLog	(revision 68265)
+++ System/ChangeLog	(working copy)
@@ -1,3 +1,13 @@
+2006-11-21  Marek Safar  <marek.safar@gmail.com>
+
+	* Environment.cs: Increment corlib version.
+
+	* String.cs: Character based method only.
+	(IndexOf): Performace improvement (1-1.5x faster).
+	(LastIndexOf): Performace improvement (1-1.5x faster).
+	(Replace): Performace improvement (1-5x faster).
+	(IndexOfAny): Performace improvement (1-4x faster).
+
 2006-11-14  Miguel de Icaza  <miguel@novell.com>
 
 	* Array.cs: TODOs will from now on be used to flag information
Index: System/Environment.cs
===================================================================
--- System/Environment.cs	(revision 68265)
+++ System/Environment.cs	(working copy)
@@ -59,7 +59,7 @@
 		 * Changes which are already detected at runtime, like the addition
 		 * of icalls, do not require an increment.
 		 */
-		private const int mono_corlib_version = 54;
+		private const int mono_corlib_version = 55;
 		
 		public enum SpecialFolder
 		{	// TODO: Determine if these windoze style folder identifiers 
Index: System/String.cs
===================================================================
--- System/String.cs	(revision 68265)
+++ System/String.cs	(working copy)
@@ -692,6 +692,64 @@
 			return InternalIndexOfAny (anyOf, startIndex, count);
 		}
 
+		unsafe int InternalIndexOfAny (char[] anyOf, int startIndex, int count)
+		{
+			if (anyOf.Length == 0)
+				return -1;
+
+			if (anyOf.Length == 1)
+				return IndexOfImpl (anyOf [0], startIndex, count);
+
+			int anyOfLength = anyOf.Length;
+			fixed (char* any_ptr = anyOf) {
+				char highest = *any_ptr;
+				char lowest = *any_ptr;
+
+				for (int i = 1; i != anyOfLength; ++i) {
+					if (any_ptr[i] > highest) {
+						highest = any_ptr[i];
+						continue;
+					}
+
+					if (any_ptr[i] < lowest)
+						lowest = any_ptr[i];
+				}
+
+				anyOfLength--;
+
+				fixed (char* start = &start_char) {
+					char* s1_ptr = start + startIndex;
+
+					for (int i = startIndex; i < startIndex + count; ++i) {
+						if (*s1_ptr > highest || *s1_ptr < lowest) {
+							s1_ptr++;
+							continue;
+						}
+
+						// We have always at least 2 characters
+						if (*s1_ptr == *any_ptr || *s1_ptr == any_ptr[1])
+							return i;
+
+						int ii = anyOfLength;
+						while (ii > 2) {
+							if (*s1_ptr == any_ptr[ii] || *s1_ptr == any_ptr[ii - 1])
+								return i;
+
+							ii -= 2;
+						}
+
+						if (ii > 1 && *s1_ptr == any_ptr[2])
+							return i;
+
+						s1_ptr++;
+					}
+				}
+			}
+
+			return -1;
+		}
+
+
 #if NET_2_0
 		public int IndexOf (string value, StringComparison comparison)
 		{
@@ -754,7 +812,10 @@
 
 		public int IndexOf (char value)
 		{
-			return IndexOf (value, 0, this.length);
+			if (this.length == 0)
+				return -1;
+
+			return IndexOfImpl(value, 0, this.length);
 		}
 
 		public int IndexOf (String value)
@@ -786,11 +847,65 @@
 			if ((startIndex == 0 && this.length == 0) || (startIndex == this.length) || (count == 0))
 				return -1;
 
-			for (int pos = startIndex; pos < startIndex + count; pos++) {
-				if (this[pos] == value)
-					return(pos);
+			return IndexOfImpl (value, startIndex, count);
+		}
+
+		unsafe int IndexOfImpl(char value, int startIndex, int count)
+		{
+			fixed (char* start = &start_char) {
+				char* s1_ptr = start + startIndex;
+
+				while (count >= 8) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[1] == value)
+						return startIndex + 1;
+					if (s1_ptr[2] == value)
+						return startIndex + 2;
+					if (s1_ptr[3] == value)
+						return startIndex + 3;
+					if (s1_ptr[4] == value)
+						return startIndex + 4;
+					if (s1_ptr[5] == value)
+						return startIndex + 5;
+					if (s1_ptr[6] == value)
+						return startIndex + 6;
+					if (s1_ptr[7] == value)
+						return startIndex + 7;
+
+					s1_ptr += 8;
+					startIndex += 8;
+					count -= 8;
+				}
+
+				if (count >= 4) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[1] == value)
+						return startIndex + 1;
+					if (s1_ptr[2] == value)
+						return startIndex + 2;
+					if (s1_ptr[3] == value)
+						return startIndex + 3;
+
+					s1_ptr += 4;
+					startIndex += 4;
+					count -= 4;
+				}
+
+				if (count >= 2) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[1] == value)
+						return startIndex + 1;
+
+					s1_ptr += 2;
+					startIndex += 2;
+					count -= 2;
+				}
+
+				return count != 0 && *s1_ptr == value ? startIndex : -1;
 			}
-			return -1;
 		}
 
 		/* But this one is culture-sensitive */
@@ -862,8 +977,8 @@
 		{
 			if (this.length == 0)
 				return -1;
-			else
-				return LastIndexOf (value, this.length - 1, this.length);
+			
+			return LastIndexOfImpl (value, this.length - 1, this.length);
 		}
 
 		public int LastIndexOf (String value)
@@ -904,11 +1019,66 @@
 			if (startIndex - count + 1 < 0)
 				throw new ArgumentOutOfRangeException ("startIndex - count + 1 < 0");
 
-			for(int pos = startIndex; pos > startIndex - count; pos--) {
-				if (this [pos] == value)
-					return pos;
+			return LastIndexOfImpl (value, startIndex, count);
+		}
+
+		/* This method is culture-insensitive */
+		unsafe int LastIndexOfImpl (char value, int startIndex, int count)
+		{
+			fixed (char* start = &start_char) {
+				char* s1_ptr = start + startIndex;
+
+				while (count >= 8) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[-1] == value)
+						return startIndex - 1;
+					if (s1_ptr[-2] == value)
+						return startIndex - 2;
+					if (s1_ptr[-3] == value)
+						return startIndex - 3;
+					if (s1_ptr[-4] == value)
+						return startIndex - 4;
+					if (s1_ptr[-5] == value)
+						return startIndex - 5;
+					if (s1_ptr[-6] == value)
+						return startIndex - 6;
+					if (s1_ptr[-7] == value)
+						return startIndex - 7;
+
+					s1_ptr -= 8;
+					startIndex -= 8;
+					count -= 8;
+				}
+
+				if (count >= 4) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[-1] == value)
+						return startIndex - 1;
+					if (s1_ptr[-2] == value)
+						return startIndex - 2;
+					if (s1_ptr[-3] == value)
+						return startIndex - 3;
+
+					s1_ptr -= 4;
+					startIndex -= 4;
+					count -= 4;
+				}
+
+				if (count >= 2) {
+					if (*s1_ptr == value)
+						return startIndex;
+					if (s1_ptr[-1] == value)
+						return startIndex - 1;
+
+					s1_ptr -= 2;
+					startIndex -= 2;
+					count -= 2;
+				}
+
+				return count != 0 && *s1_ptr == value ? startIndex : -1;
 			}
-			return -1;
 		}
 
 		/* But this one is culture-sensitive */
@@ -1100,7 +1270,14 @@
 		/* This method is culture insensitive */
 		public String Replace (char oldChar, char newChar)
 		{
-			return InternalReplace (oldChar, newChar);
+			if (this.length == 0 || oldChar == newChar)
+				return this;
+
+			int start_pos = IndexOfImpl (oldChar, 0, this.length);
+			if (start_pos == -1)
+				return this;
+			
+			return InternalReplace (oldChar, newChar, start_pos);
 		}
 
 		/* This method is culture sensitive */
@@ -2161,7 +2338,7 @@
 		private extern static string InternalJoin (string separator, string[] value, int sIndex, int count);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern String InternalReplace (char oldChar, char newChar);
+		private extern String InternalReplace (char oldChar, char newChar, int startIndex);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern String InternalReplace (String oldValue, string newValue, CompareInfo comp);
@@ -2175,8 +2352,8 @@
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern String InternalTrim (char[] chars, int typ);
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern int InternalIndexOfAny (char [] arr, int sIndex, int count);
+		//[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		//private extern int InternalIndexOfAny (char [] arr, int sIndex, int count);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern int InternalLastIndexOfAny (char [] anyOf, int sIndex, int count);
