Index: Char.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/Char.cs,v
retrieving revision 1.21
diff -u -r1.21 Char.cs
--- Char.cs	12 Sep 2002 22:52:36 -0000	1.21
+++ Char.cs	18 Feb 2004 05:46:23 -0000
@@ -197,8 +197,22 @@
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
@@ -257,8 +271,22 @@
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
+				return true;
+			default:
+				return IsSeparator (c);
+			}
+		}
 		
 		public static bool IsWhiteSpace (string str, int index)
 		{