Index: System/Char.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/Char.cs,v
retrieving revision 1.21
diff -u -r1.21 Char.cs
--- System/Char.cs	12 Sep 2002 22:52:36 -0000	1.21
+++ System/Char.cs	18 Feb 2004 12:07:27 -0000
@@ -102,8 +102,45 @@
 			return IsControl (str[index]);
 		}
 		
-		[MethodImplAttribute(System.Runtime.CompilerServices.MethodImplOptions.InternalCall)]
-		public static extern bool IsDigit (char c);
+		public static bool IsDigit (char c)
+		{
+			int i = (int) c;
+			if (i >= 0x30 && i <= 0x39)
+				return true;
+			if (i < 0x660) // quick check for ASCII range.
+				return false;
+
+			// hereby all ascii characters are evaluated quickly.
+
+			// the largest ranges of digits
+			if (i >= 0xff10 && i <= 0xff19)
+				return true;
+			// after the block above, there is a wide range of non-digits.
+			if (i > 0x1820)
+				return false;
+
+			if (i >= 0x660 && i <= 0x669 || i >= 0x6f0 && i <= 0x6f9)
+				return true;
+			if (i < 0x966)
+				return false;
+			if (i == 0xbe6)
+				return false;
+			if (i >= 0x960 && i <= 0xd6f &&
+				(i & 0xf) > 5 &&
+				((i & 0xf0) == 0x60 || (i & 0xf0) == 0xe0))
+				return true;
+			if (i < 0xe56)
+				return false;
+			return // rest are boring check ;-)
+				i >= 0xe56 && i <= 0xe5f ||
+				i >= 0xed6 && i <= 0xedf ||
+				i >= 0xb66 && i <= 0xb6f ||
+				i >= 0xf20 && i <= 0xf29 ||
+				i >= 0x1040 && i <= 0x1049 ||
+				i >= 0x1369 && i <= 0x1371 ||
+				i >= 0x17e0 && i <= 0x17e9 ||
+				i >= 0x1810 && i <= 0x1819;
+		}
 
 		public static bool IsDigit (string str, int index)
 		{
@@ -197,8 +234,22 @@
 			return IsPunctuation (str[index]);
 		}
 
-		[MethodImplAttribute(System.Runtime.CompilerServices.MethodImplOptions.InternalCall)]
-		public static extern bool IsSeparator (char c);
+		public static bool IsSeparator (char c)
+		{
+			switch (c) {
+			case ' ':
+			case '\xa0':
+			case '\u1680':
+			case '\u2028':
+			case '\u2029':
+			case '\u202f':
+			case '\u3000':
+				return true;
+			default:
+				int i = (int) c;
+				return i >= 0x2000 && i <= 0x200b;
+			}
+		}
 		
 		public static bool IsSeparator (string str, int index)
 		{
@@ -257,8 +308,28 @@
 			return IsUpper (str[index]);
 		}
 
-		[MethodImplAttribute(System.Runtime.CompilerServices.MethodImplOptions.InternalCall)]
-		public static extern bool IsWhiteSpace (char c);
+		public static bool IsWhiteSpace (char c)
+		{
+			switch (c) {
+			case ' ':
+			case '\t':
+			case '\v':
+			case '\r':
+			case '\n':
+			case '\x85':
+			case '\u2028':
+			case '\u2029':
+			// Separator characters.
+			case '\xa0':
+			case '\u1680':
+			case '\u202f':
+			case '\u3000':
+				return true;
+			default:
+				int i = (int) c;
+				return i >= 0x2000 && i <= 0x200b;
+			}
+		}
 		
 		public static bool IsWhiteSpace (string str, int index)
 		{
@@ -287,7 +358,7 @@
 		public static extern char ToLower (char c);
 
 		[MonoTODO]
-		public static char ToLower(char c, CultureInfo culture)
+		public static char ToLower (char c, CultureInfo culture)
 		{
 			throw new NotImplementedException();
 		}
