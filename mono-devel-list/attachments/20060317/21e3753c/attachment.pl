Index: String.cs
===================================================================
--- String.cs	(revision 58071)
+++ String.cs	(working copy)
@@ -153,6 +153,46 @@
 			return TypeCode.String;
 		}
 
+		private unsafe static void CharCopy (char* source, char* destination, int count)
+		{
+			// Copy 32 byte at a time (unroll the loop)
+			while (count >= 16) {
+				((int*) destination)[0] = ((int*) source)[0];
+				((int*) destination)[1] = ((int*) source)[1];
+				((int*) destination)[2] = ((int*) source)[2];
+				((int*) destination)[3] = ((int*) source)[3];
+				((int*) destination)[4] = ((int*) source)[4];
+				((int*) destination)[5] = ((int*) source)[5];
+				((int*) destination)[6] = ((int*) source)[6];
+				((int*) destination)[7] = ((int*) source)[7];
+				destination += 16;
+				source += 16;
+				count -= 16;
+			}
+
+			// Copy 8 byte at a time.
+			while (count >= 4) {
+				((int*) destination)[0] = ((int*) source)[0];
+				((int*) destination)[1] = ((int*) source)[1];
+				destination += 4;
+				source += 4;
+				count -= 4;
+			}
+
+			if (count >= 2) {
+				((int*) destination)[0] = ((int*) source)[0];
+				destination += 2;
+				source += 2;
+				count -= 2;
+			}
+
+			if (count == 1) {
+				*destination = *source;
+				//dest += 1;
+				//src += 1;
+			}
+		}
+
 		public void CopyTo (int sourceIndex, char[] destination, int destinationIndex, int count)
 		{
 			// LAMESPEC: should I null-terminate?
@@ -169,7 +209,12 @@
 			if (destinationIndex > destination.Length - count)
 				throw new ArgumentOutOfRangeException ("destinationIndex + count > destination.Length");
 
-			InternalCopyTo (sourceIndex, destination, destinationIndex, count);
+			//InternalCopyTo (sourceIndex, destination, destinationIndex, count);
+			unsafe {
+				fixed (char* source = &start_char, dest = destination) {
+					CharCopy (source + sourceIndex, dest + destinationIndex, count);
+				}
+			}
 		}
 
 		public char[] ToCharArray ()
@@ -177,7 +222,7 @@
 			return ToCharArray (0, length);
 		}
 
-		public char[] ToCharArray (int startIndex, int length)
+		public unsafe char[] ToCharArray (int startIndex, int length)
 		{
 			if (startIndex < 0)
 				throw new ArgumentOutOfRangeException ("startIndex", "< 0"); 
@@ -187,13 +232,21 @@
 			if (startIndex > this.length - length)
 				throw new ArgumentOutOfRangeException ("startIndex + length > this.length"); 
 
+			if (length == 0)
+				return empty_char_array;
+
 			char[] tmp = new char [length];
 
-			InternalCopyTo (startIndex, tmp, 0, length);
+			//InternalCopyTo (startIndex, tmp, 0, length);
+			fixed (char* source = &start_char, dest = tmp) {
+				CharCopy (source, dest, length);
+			}
 
 			return tmp;
 		}
 
+		static char [] empty_char_array = new char [0];
+
 		public String [] Split (params char [] separator)
 		{
 			return Split (separator, Int32.MaxValue);
@@ -216,6 +269,166 @@
 			return InternalSplit (separator, count);
 		}
 
+		/*
+		public unsafe String [] Split (params char [] separator)
+		{
+			if (length == 0)
+				return new String[0];
+
+			int start = 0;
+			int found = 0;
+			fixed (char* source = &start_char) {
+				char* sourcePtr = source;
+				if (separator == null || separator.Length == 0) {
+					for (; start < length; start++) {
+						if (Char.IsWhiteSpace (*sourcePtr)) {
+							found++;
+						}
+						sourcePtr++;
+					}
+					return SplitUp (found);
+				}
+				else {
+					fixed (char* test = separator) {
+						for (; start < length; start++) {
+							for (int x = 0; x < separator.Length; x++) {
+								if (*sourcePtr == test[x]) {
+									found++;
+									break;
+								}
+							}
+							sourcePtr++;
+						}
+					}
+					return SplitUp (separator, found);
+				}
+			}
+		}
+
+		public unsafe String[] Split (char[] separator, int count)
+		{
+			if (count < 0)
+				throw new ArgumentOutOfRangeException ("count");
+
+			if (count == 0)
+				return new String[0];
+
+			if (count == 1)
+				return new String[1] { this };
+
+			if (length == 0)
+				return new String[0];
+
+			int start = 0;
+			int found = 0;
+			fixed (char* source = &start_char) {
+				char* sourcePtr = source;
+				if (separator == null || separator.Length == 0) {
+					for (; start < length; start++) {
+						if (Char.IsWhiteSpace (*sourcePtr)) {
+							found++;
+							if (found == count)
+								return SplitUp (separator, found);
+						}
+						sourcePtr++;
+					}
+					return SplitUp (found);
+				}
+				else {
+					fixed (char* test = separator) {
+						for (; start < length; start++) {
+							for (int x = 0; x < separator.Length; x++) {
+								if (*sourcePtr == test[x]) {
+									found++;
+									if (found == count)
+										return SplitUp (separator, found);
+									break;
+								}
+							}
+							sourcePtr++;
+						}
+					}
+					return SplitUp (separator, found);
+				}
+			}
+		}
+
+		// Performs the Splitup of a String with a known number of parts that splits at default whitespaces
+		private unsafe String[] SplitUp (int found)
+		{
+			if (found == 0 || found == 1)
+				return new String[1] { this };
+			
+			fixed (char* source = &start_char) {
+				char* sourcePtr = source;
+
+				String[] ret = new String[found];
+
+				int counter = 0;
+				char* startPtr = source;
+				for (; counter < found; counter++) {
+					if (Char.IsWhiteSpace (*sourcePtr)) {
+						int newLen = (int)(sourcePtr - startPtr) - 1;
+						if (newLen > 0) {
+							String tmp = InternalAllocateStr (newLen);
+							fixed (char* dest = tmp) {
+								CharCopy (startPtr, dest, newLen);
+							}
+							startPtr = sourcePtr;
+							ret[counter] = tmp;
+						}
+						else if (newLen == 0) {
+							ret[counter] = String.Empty;
+						}
+					}
+					sourcePtr++;
+				}
+				return ret;
+			}
+		}
+
+		// Performs the Splitup of a String with a known number of parts that splits using a char separator array
+		private unsafe String[] SplitUp (char[] separator, int found)
+		{
+			if (found == 0 || found == 1)
+				return new String[1] { this };
+			
+			fixed (char* source = &start_char) {
+				char* sourcePtr = source;
+
+				String[] ret = new String[found];
+
+				int counter = 0;
+				sourcePtr = source;
+				char* startPtr = source;
+				fixed (char* test = separator) {
+					for (; counter < found; counter++) {
+						for (int x = 0; x < separator.Length; x++) {
+							if (*sourcePtr == test[x]) {
+								int newLen = (int)(sourcePtr - startPtr) - 1;
+								if (newLen > 0) {
+									String tmp = InternalAllocateStr (newLen);
+									fixed (char* dest = tmp) {
+										CharCopy (startPtr, dest, newLen);
+									}
+									startPtr = sourcePtr;
+									ret[counter] = tmp;
+									break;
+								}
+								else {
+									ret[counter] = String.Empty;
+									break;
+								}
+							}
+						}
+						sourcePtr++;
+					}
+				}
+				return ret;
+			}
+		}
+		*/
+
 #if NET_2_0
 		[ComVisible (false)]
 		[MonoTODO]
@@ -411,6 +624,69 @@
 			return InternalTrim (trimChars, 2);
 		}
 
+		unsafe string InternalTrim (char [] trimChars, int type)
+		{
+			int start = 0;
+			int end = length;
+			fixed (char* source = &start_char) {
+				char* sourcePtr = source;
+				if (trimChars == WhiteChars) {
+					if (type != 2)
+						for (; start < length; start++) {
+							if (!Char.IsWhiteSpace (*sourcePtr))
+								break;
+							sourcePtr++;
+						}
+					sourcePtr = source + end - 1;
+					if (type != 1)
+						for (; end > start; end--) {
+							if (!Char.IsWhiteSpace (*sourcePtr))
+								break;
+							sourcePtr--;
+						}
+				} else {
+				fixed (char* test = trimChars) {
+					if (type != 2) {
+						for (; start < length; start++) {
+							for (int x = 0; x < trimChars.Length; x++) {
+								if (*sourcePtr == test[x])
+									goto ContinueStart;
+							}
+							goto FoundStart;
+							ContinueStart:
+							sourcePtr++;
+						}
+					}
+					FoundStart:
+					sourcePtr = source + end - 1;
+					if (type != 1) {
+						for (; end > start; end--) {
+							for (int x = 0; x < trimChars.Length; x++) {
+								if (*sourcePtr == test[x]) {
+									goto ContinueEnd;
+								}
+							}
+							goto FoundEnd;
+							ContinueEnd:
+							sourcePtr--;
+						}
+					}
+				}
+				}
+				FoundEnd:
+				int newLen = end - start;
+				if (length == newLen)
+					return this;
+
+				string tmp = InternalAllocateStr (newLen);
+				InternalStrcpy (tmp, 0, this, start, newLen);
+				//fixed (char* destination = tmp) {
+				//	CharCopy (source + start, destination, newLen);
+				//}
+				return tmp;
+			}
+		}
+
 		public static int Compare (String strA, String strB)
 		{
 			return Compare (strA, strB, false, CultureInfo.CurrentCulture);
@@ -689,6 +965,27 @@
 			return InternalIndexOfAny (anyOf, startIndex, count);
 		}
 
+		/*
+		unsafe int InternalIndexOfAny (char [] anyOf, int startIndex, int count)
+		{
+			int target = startIndex + count;
+			fixed (char* test = &start_char, testChars = anyOf) {
+				char* testPtr = test;
+				char* testChar, targetChar = testChars + anyOf.Length;
+				for (int pos = startIndex; pos < target; pos++) {
+					testChar = testChars;
+					for (; testChar < targetChar;) {
+						if (*testPtr == *testChar)
+							return pos;
+						testChar++;
+					}
+					testPtr++;
+				}
+			}
+			return -1;
+		}
+		*/
+
 		public int IndexOf (char value)
 		{
 			return IndexOf (value, 0, this.length);
@@ -710,7 +1007,7 @@
 		}
 
 		/* This method is culture-insensitive */
-		public int IndexOf (char value, int startIndex, int count)
+		public unsafe int IndexOf (char value, int startIndex, int count)
 		{
 			if (startIndex < 0)
 				throw new ArgumentOutOfRangeException ("startIndex", "< 0");
@@ -722,12 +1019,22 @@
 
 			if ((startIndex == 0 && this.length == 0) || (startIndex == this.length) || (count == 0))
 				return -1;
-
 			for (int pos = startIndex; pos < startIndex + count; pos++) {
 				if (this[pos] == value)
 					return(pos);
 			}
 			return -1;
+/*
+			fixed (char* test = &start_char) {
+				char* testPtr = test + startIndex;
+				for (int pos = startIndex; pos < startIndex + count; pos++) {
+					if (*testPtr == value)
+						return pos;
+					testPtr++;
+				}
+			}
+			return -1;
+*/
 		}
 
 		/* But this one is culture-sensitive */
@@ -933,6 +1240,38 @@
 			return InternalPad (totalWidth, paddingChar, true);
 		}
 
+		/*
+		// It is still buggy
+		unsafe string InternalPad (int totalWidth, char paddingChar, bool right)
+		{
+			if (right) {
+				int fillCount = totalWidth - this.length;
+				string tmp = InternalAllocateStr (totalWidth);
+				fixed (char * source = &start_char, dest = tmp) {
+					CharCopy (source, dest, this.length);
+					char * destPtr = dest + fillCount, target = dest + totalWidth;
+					for (; destPtr < target;) {
+						*destPtr = paddingChar;
+						destPtr++;
+					}
+				}
+				return tmp;
+			} else {
+				int fillCount = totalWidth - this.length;
+				string tmp = InternalAllocateStr (totalWidth);
+				fixed (char * source = &start_char, dest = tmp) {
+					CharCopy (source, dest + fillCount, this.length);
+					char * destPtr = dest, target = dest + fillCount;
+					for (; destPtr < target;) {
+						*destPtr = paddingChar;
+						destPtr++;
+					}
+				}
+				return tmp;
+			}
+		}
+		*/
+
 		public bool StartsWith (String value)
 		{
 			return StartsWith (value, false, CultureInfo.CurrentCulture);
@@ -994,9 +1333,33 @@
 		}
 
 		/* This method is culture insensitive */
-		public String Replace (char oldChar, char newChar)
+		public unsafe String Replace (char oldChar, char newChar)
 		{
 			return InternalReplace (oldChar, newChar);
+/*
+			// Check if we have chars that need to be relaced
+			// If we haven't don't create a new string object
+			fixed (char* source = &start_char) {
+				for (int x = 0; x < length; x++) {
+					if (source[x] == oldChar) {
+						string tmp = InternalAllocateStr (length);
+//						InternalStrcpy (tmp, 0, this, 0, x);
+						fixed (char* dest = tmp) {
+							CharCopy (source, dest, x);
+							dest[x] = newChar;
+							for (x++; x < length; x++) {
+								if (source[x] == oldChar)
+									dest[x] = newChar;
+								else
+									dest[x] = source[x];
+							}
+						}
+						return tmp;
+					}
+				}
+			}
+			return this;
+*/
 		}
 
 		/* This method is culture sensitive */
@@ -1565,6 +1928,73 @@
 			return InternalJoin (separator, value, startIndex, count);
 		}
 
+		/*
+		public unsafe static string InternalJoin (string separator, string[] value, int startIndex, int count)
+		{
+			if (value == null)
+				throw new ArgumentNullException ("value");
+
+			if (startIndex < 0 || count < 0)
+				throw new ArgumentOutOfRangeException ();
+
+			if (startIndex + count > value.Length)
+				throw new ArgumentOutOfRangeException ();
+
+			if (separator == null)
+				separator = String.Empty;
+			//if (startIndex == value.Length)
+			//	return String.Empty;
+
+			string current;
+			int length = separator.length * (count - 1);
+			for (int pos = startIndex; pos != startIndex + count; pos++) {
+				current = value [pos];
+				if (current != null)
+					length += current.length;
+		
+				//if (pos < startIndex + count - 1)
+				//	length += separator.length;
+				//length += separator.length;
+			}
+			//length += separator.length * count;
+			//return null;
+			
+			if (length == 0)
+				return String.Empty;
+
+			String tmp = InternalAllocateStr (length);
+			//dest = mono_string_chars(ret);
+			int destpos = 0;
+			int max = startIndex + count - 1;
+
+			fixed (char * dest = tmp, sep = separator) {
+				//MemCopy (s1 + startIndex, s2, newLen);
+	
+				for (int pos = startIndex; pos != max; pos++) {
+					current = value [pos];
+					if (current != null) {
+						if (current.length > 0)
+							fixed (char * source = current) {
+								CharCopy (source, dest + destpos, current.length);
+								destpos += current.length;
+							}
+					}
+					CharCopy (sep, dest + destpos, separator.length);
+					destpos += separator.length;
+				}
+				current = value [max];
+				if (current != null) {
+					if (current.length > 0)
+						fixed (char * source = current) {
+							CharCopy (source, dest + destpos, current.length);
+						}
+				}
+			}
+		
+			return tmp;
+		}
+		*/
+
 		bool IConvertible.ToBoolean (IFormatProvider provider)
 		{
 			return Convert.ToBoolean (this, provider);
@@ -1984,8 +2414,8 @@
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern String[] InternalSplit (char[] separator, int count);
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern String InternalTrim (char[] chars, int typ);
+//		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+//		private extern String InternalTrim (char[] chars, int typ);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		private extern int InternalIndexOfAny (char [] arr, int sIndex, int count);
