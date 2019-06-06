Index: ChangeLog
===================================================================
--- ChangeLog	(revision 68478)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2006-11-26  Marek Safar  <marek.safar@gmail.com>
+
+	* String.cs: Character based method only.
+	(IndexOf, LastIndexOf, Replace, IndexOfNay): Performace improvement.
+
 2006-11-22  Miguel de Icaza  <miguel@novell.com>
 
 	* DateTime.cs: A small performance hit, we store the actual time
Index: String.cs
===================================================================
--- String.cs	(revision 68478)
+++ String.cs	(working copy)
@@ -663,6 +663,8 @@
 		{
 			if (anyOf == null)
 				throw new ArgumentNullException ("anyOf");
+			if (this.length == 0)
+				return -1;
 
 			return InternalIndexOfAny (anyOf, 0, this.length);
 		}
@@ -692,6 +694,57 @@
 			return InternalIndexOfAny (anyOf, startIndex, count);
 		}
 
+		unsafe int InternalIndexOfAny (char[] anyOf, int startIndex, int count)
+		{
+			if (anyOf.Length == 0)
+				return -1;
+
+			if (anyOf.Length == 1)
+				return IndexOfImpl(anyOf[0], startIndex, count);
+
+			fixed (char* any = anyOf) {
+				int highest = *any;
+				int lowest = *any;
+
+				char* end_any_ptr = any + anyOf.Length;
+				char* any_ptr = any;
+				while (++any_ptr != end_any_ptr) {
+					if (*any_ptr > highest) {
+						highest = *any_ptr;
+						continue;
+					}
+
+					if (*any_ptr < lowest)
+						lowest = *any_ptr;
+				}
+
+				fixed (char* start = &start_char) {
+					char* ptr = start + startIndex;
+					char* end_ptr = ptr + count;
+
+					while (ptr != end_ptr) {
+						if (*ptr > highest || *ptr < lowest) {
+							ptr++;
+							continue;
+						}
+
+						if (*ptr == *any)
+							return (int)(ptr - start);
+
+						any_ptr = any;
+						while (++any_ptr != end_any_ptr) {
+							if (*ptr == *any_ptr)
+								return (int)(ptr - start);
+						}
+
+						ptr++;
+					}
+				}
+			}
+			return -1;
+		}
+
+
 #if NET_2_0
 		public int IndexOf (string value, StringComparison comparison)
 		{
@@ -754,7 +807,10 @@
 
 		public int IndexOf (char value)
 		{
-			return IndexOf (value, 0, this.length);
+			if (this.length == 0)
+				return -1;
+
+			return IndexOfImpl (value, 0, this.length);
 		}
 
 		public int IndexOf (String value)
@@ -786,11 +842,48 @@
 			if ((startIndex == 0 && this.length == 0) || (startIndex == this.length) || (count == 0))
 				return -1;
 
-			for (int pos = startIndex; pos < startIndex + count; pos++) {
-				if (this[pos] == value)
-					return(pos);
+			return IndexOfImpl (value, startIndex, count);
+		}
+
+		unsafe int IndexOfImpl (char value, int startIndex, int count)
+		{
+			// It helps JIT to optimize comparison
+			int value_32 = (int)value;
+
+			fixed (char* start = &start_char) {
+				char* ptr = start + startIndex;
+				char* end_ptr = ptr + (count >> 3 << 3);
+
+				while (ptr != end_ptr) {
+					if (*ptr == value_32)
+						return (int)(ptr - start);
+					if (ptr[1] == value_32)
+						return (int)(ptr - start + 1);
+					if (ptr[2] == value_32)
+						return (int)(ptr - start + 2);
+					if (ptr[3] == value_32)
+						return (int)(ptr - start + 3);
+					if (ptr[4] == value_32)
+						return (int)(ptr - start + 4);
+					if (ptr[5] == value_32)
+						return (int)(ptr - start + 5);
+					if (ptr[6] == value_32)
+						return (int)(ptr - start + 6);
+					if (ptr[7] == value_32)
+						return (int)(ptr - start + 7);
+
+					ptr += 8;
+				}
+
+				end_ptr += count & 0x07;
+				while (ptr != end_ptr) {
+					if (*ptr == value_32)
+						return (int)(ptr - start);
+
+					ptr++;
+				}
+				return -1;
 			}
-			return -1;
 		}
 
 		/* But this one is culture-sensitive */
@@ -862,8 +955,8 @@
 		{
 			if (this.length == 0)
 				return -1;
-			else
-				return LastIndexOf (value, this.length - 1, this.length);
+			
+			return LastIndexOfImpl (value, this.length - 1, this.length);
 		}
 
 		public int LastIndexOf (String value)
@@ -904,11 +997,49 @@
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
+			// It helps JIT to optimize comparison
+			int value_32 = (int)value;
+
+			fixed (char* start = &start_char) {
+				char* ptr = start + startIndex;
+				char* end_ptr = ptr - (count >> 3 << 3);
+
+				while (ptr != end_ptr) {
+					if (*ptr == value_32)
+						return (int)(ptr - start);
+					if (ptr[-1] == value_32)
+						return (int)(ptr - start) - 1;
+					if (ptr[-2] == value_32)
+						return (int)(ptr - start) - 2;
+					if (ptr[-3] == value_32)
+						return (int)(ptr - start) - 3;
+					if (ptr[-4] == value_32)
+						return (int)(ptr - start) - 4;
+					if (ptr[-5] == value_32)
+						return (int)(ptr - start) - 5;
+					if (ptr[-6] == value_32)
+						return (int)(ptr - start) - 6;
+					if (ptr[-7] == value_32)
+						return (int)(ptr - start) - 7;
+
+					ptr -= 8;
+				}
+
+				end_ptr -= count & 0x07;
+				while (ptr != end_ptr) {
+					if (*ptr == value_32)
+						return (int)(ptr - start);
+
+					ptr--;
+				}
+				return -1;
 			}
-			return -1;
 		}
 
 		/* But this one is culture-sensitive */
@@ -1098,9 +1229,38 @@
 		}
 
 		/* This method is culture insensitive */
-		public String Replace (char oldChar, char newChar)
+		public unsafe String Replace (char oldChar, char newChar)
 		{
-			return InternalReplace (oldChar, newChar);
+			if (this.length == 0 || oldChar == newChar)
+				return this;
+
+			int start_pos = IndexOfImpl (oldChar, 0, this.length);
+			if (start_pos == -1)
+				return this;
+
+			if (start_pos < 4)
+				start_pos = 0;
+
+			string tmp = InternalAllocateStr(length);
+			fixed (char* dest = tmp, src = &start_char) {
+				if (start_pos != 0)
+					memcpy((byte*)dest, (byte*)src, start_pos * 2);
+
+				char* end_ptr = dest + length;
+				char* dest_ptr = dest + start_pos;
+				char* src_ptr = src + start_pos;
+
+				while (dest_ptr != end_ptr) {
+					if (*src_ptr == oldChar)
+						*dest_ptr = newChar;
+					else
+						*dest_ptr = *src_ptr;
+
+					++src_ptr;
+					++dest_ptr;
+				}
+			}
+			return tmp;
 		}
 
 		/* This method is culture sensitive */
@@ -2160,8 +2320,8 @@
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern static string InternalJoin (string separator, string[] value, int sIndex, int count);
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern String InternalReplace (char oldChar, char newChar);
+		//[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		//private extern String InternalReplace (char oldChar, char newChar, int startIndex);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern String InternalReplace (String oldValue, string newValue, CompareInfo comp);
@@ -2175,8 +2335,8 @@
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern String InternalTrim (char[] chars, int typ);
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern int InternalIndexOfAny (char [] arr, int sIndex, int count);
+		//[MethodImplAttribute (MethodImplOptions.InternalCall)]
+		//private extern int InternalIndexOfAny (char [] arr, int sIndex, int count);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern int InternalLastIndexOfAny (char [] anyOf, int sIndex, int count);
