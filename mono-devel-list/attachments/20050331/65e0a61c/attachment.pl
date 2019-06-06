Index: System/String.cs
===================================================================
--- System/String.cs	(revision 42338)
+++ System/String.cs	(working copy)
@@ -779,8 +779,7 @@
 
 		public String ToLower ()
 		{
-			// CurrentCulture can never be invariant or null
-			return InternalToLower (CultureInfo.CurrentCulture);
+			return ToLower (CultureInfo.CurrentCulture);
 		}
 
 		public String ToLower (CultureInfo culture)
@@ -791,7 +790,7 @@
 			if (culture.LCID == 0x007F) { // Invariant
 				return ToLowerInvariant ();
 			}
-			return InternalToLower (culture);
+			return culture.TextInfo.ToLower (this);
 		}
 
 		internal unsafe String ToLowerInvariant ()
@@ -813,8 +812,7 @@
 
 		public String ToUpper ()
 		{
-			// CurrentCulture can never be invariant or null
-			return InternalToUpper (CultureInfo.CurrentCulture);
+			return ToUpper (CultureInfo.CurrentCulture);
 		}
 
 		public String ToUpper (CultureInfo culture)
@@ -825,7 +823,7 @@
 			if (culture.LCID == 0x007F) { // Invariant
 				return ToUpperInvariant ();
 			}
-			return InternalToUpper (culture);
+			return culture.TextInfo.ToUpper (this);
 		}
 
 		internal unsafe String ToUpperInvariant ()
@@ -1723,12 +1721,6 @@
 		private extern String InternalPad (int width, char chr, bool right);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern String InternalToLower (CultureInfo culture);
-
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private extern String InternalToUpper (CultureInfo culture);
-
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
 		internal extern static String InternalAllocateStr (int length);
 
 		[MethodImplAttribute (MethodImplOptions.InternalCall)]
Index: System/Char.cs
===================================================================
--- System/Char.cs	(revision 42338)
+++ System/Char.cs	(working copy)
@@ -490,7 +490,7 @@
 
 		public static char ToLower (char c)
 		{
-			return InternalToLower (c, CultureInfo.CurrentCulture);
+			return ToLower (c, CultureInfo.CurrentCulture);
 		}
 
 		internal static char ToLowerInvariant (char c)
@@ -511,15 +511,12 @@
 			if (culture.LCID == 0x007F) // Invariant
 				return ToLowerInvariant (c);
 
-			return InternalToLower (c, culture);
+			return culture.TextInfo.ToLower (c);
 		}
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private static extern char InternalToLower (char c, CultureInfo culture);
-
 		public static char ToUpper (char c)
 		{
-			return InternalToUpper (c, CultureInfo.CurrentCulture);
+			return ToUpper (c, CultureInfo.CurrentCulture);
 		}
 
 		internal static char ToUpperInvariant (char c)
@@ -540,11 +537,8 @@
 			if (culture.LCID == 0x007F) // Invariant
 				return ToUpperInvariant (c);
 
-			return InternalToUpper (c, culture);
+			return culture.TextInfo.ToUpper (c);
 		}
-
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
-		private static extern char InternalToUpper (char c, CultureInfo culture);
 		
 		public override string ToString ()
 		{
Index: System.Globalization/TextInfo.cs
===================================================================
--- System.Globalization/TextInfo.cs	(revision 42338)
+++ System.Globalization/TextInfo.cs	(working copy)
@@ -36,12 +36,14 @@
 using System.Globalization;
 using System.Runtime.Serialization;
 using System.Runtime.InteropServices;
+using System.Text;
 
 namespace System.Globalization {
 
 	[Serializable]
 	public class TextInfo: IDeserializationCallback
 	{
+		private delegate char CharConverter (char c);
 		
 		[StructLayout (LayoutKind.Sequential)]
 		struct Data {
@@ -51,7 +53,10 @@
 			public int oem;
 			public byte list_sep;
 		}
-		
+
+		CharConverter toLower;
+		CharConverter toUpper;
+
 		int m_win32LangID;
 		int m_nDataItem;
 		bool m_useUserOverride;
@@ -72,6 +77,8 @@
 				this.data = new Data ();
 				this.data.list_sep = (byte) '.';
 			}
+			toLower = new CharConverter (ToLower);
+			toUpper = new CharConverter (ToUpper);
 		}
 
 		public virtual int ANSICodePage
@@ -128,20 +135,7 @@
 		{
 			return (m_win32LangID);
 		}
-
-		public virtual char ToLower(char c)
-		{
-			return Char.ToLower (c);
-		}
 		
-		public virtual string ToLower(string str)
-		{
-			if(str==null) 
-				throw new ArgumentNullException("string is null");
-
-			return str.ToLower (ci);
-		}
-		
 		public override string ToString()
 		{
 			return "TextInfo - " + m_win32LangID;
@@ -173,17 +167,140 @@
 			return s.ToString ();
 		}
 
+		// Only Azeri and Turkish have their own special cases.
+		// Other than them, all languages have common special case
+		// (enumerable enough).
+		public virtual char ToLower (char c)
+		{
+			if (ci == CultureInfo.InvariantCulture)
+				return Char.ToLowerInvariant (c);
+
+			switch ((int) c) {
+			case '\u0049': // Latin uppercase I
+				CultureInfo tmp = ci;
+				while (tmp.Parent != tmp && tmp.Parent != CultureInfo.InvariantCulture)
+					tmp = tmp.Parent;
+				switch (tmp.LCID) {
+				case 44: // Azeri (az)
+				case 31: // Turkish (tr)
+					return '\u0131'; // I becomes dotless i
+				}
+				break;
+			case '\u0130': // I-dotted
+				return '\u0069'; // i
+
+			case '\u01c5': // LATIN CAPITAL LETTER D WITH SMALL LETTER Z WITH CARON
+				return '\u01c6';
+			// \u01c7 -> \u01c9 (LJ) : invariant
+			case '\u01c8': // LATIN CAPITAL LETTER L WITH SMALL LETTER J
+				return '\u01c9';
+			// \u01ca -> \u01cc (NJ) : invariant
+			case '\u01cb': // LATIN CAPITAL LETTER N WITH SMALL LETTER J
+				return '\u01cc';
+			// WITH CARON : invariant
+			// WITH DIAERESIS AND * : invariant
+
+			case '\u01f2': // LATIN CAPITAL LETTER D WITH SMALL LETTER Z
+				return '\u01f3';
+			case '\u03d2':  // ? it is not in ICU
+				return '\u03c5';
+			case '\u03d3':  // ? it is not in ICU
+				return '\u03cd';
+			case '\u03d4':  // ? it is not in ICU
+				return '\u03cb';
+			}
+			return Char.ToLowerInvariant (c);
+		}
+
 		public virtual char ToUpper (char c)
 		{
-			return Char.ToUpper (c, ci);
+			if (ci == CultureInfo.InvariantCulture)
+				return Char.ToUpperInvariant (c);
+
+			switch (c) {
+			case '\u0069': // Latin lowercase i
+				CultureInfo tmp = ci;
+				while (tmp.Parent != tmp && tmp.Parent != CultureInfo.InvariantCulture)
+					tmp = tmp.Parent;
+				switch (tmp.LCID) {
+				case 44: // Azeri (az)
+				case 31: // Turkish (tr)
+					return '\u0130'; // dotted capital I
+				}
+				break;
+			case '\u0131': // dotless i
+				return '\u0049'; // I
+
+			case '\u01c5': // see ToLower()
+				return '\u01c4';
+			case '\u01c8': // see ToLower()
+				return '\u01c7';
+			case '\u01cb': // see ToLower()
+				return '\u01ca';
+			case '\u01f2': // see ToLower()
+				return '\u01f1';
+			case '\u0390': // GREEK SMALL LETTER IOTA WITH DIALYTIKA AND TONOS
+				return '\u03aa'; // it is not in ICU
+			case '\u03b0': // GREEK SMALL LETTER UPSILON WITH DIALYTIKA AND TONOS
+				return '\u03ab'; // it is not in ICU
+			case '\u03d0': // GREEK BETA
+				return '\u0392';
+			case '\u03d1': // GREEK THETA
+				return '\u0398';
+			case '\u03d5': // GREEK PHI
+				return '\u03a6';
+			case '\u03d6': // GREEK PI
+				return '\u03a0';
+			case '\u03f0': // GREEK KAPPA
+				return '\u039a';
+			case '\u03f1': // GREEK RHO
+				return '\u03a1';
+			// am not sure why miscellaneous GREEK symbols are 
+			// not handled here.
+			}
+
+			return Char.ToUpperInvariant (c);
 		}
 
-		public virtual string ToUpper (string str)
+		public virtual string ToLower (string s)
 		{
-			if(str==null)
+			// In ICU (3.2) there are a few cases that one single
+			// character results in multiple characters in e.g.
+			// tr-TR culture. So I tried brute force conversion
+			// test with single character as a string input, but 
+			// there was no such conversion. So I think it just
+			// invokes ToLower(char).
+			return Transliterate (s, toLower);
+		}
+
+		public virtual string ToUpper (string s)
+		{
+			// In ICU (3.2) there is a case that string
+			// is handled beyond per-character conversion, but
+			// it is only lt-LT culture where MS.NET does not
+			// handle any special transliteration. So I keep
+			// ToUpper() just as character conversion.
+			return Transliterate (s, toUpper);
+		}
+
+		private string Transliterate (string s, CharConverter convert)
+		{
+			if (s == null)
 				throw new ArgumentNullException("string is null");
-			
-			return str.ToUpper (ci);
+			StringBuilder sb = null;
+			int start = 0;
+			for (int i = 0; i < s.Length; i++) {
+				if (s [i] != convert (s [i])) {
+					if (sb == null)
+						sb = new StringBuilder (s.Length);
+					sb.Append (s.Substring (start, i - start));
+					sb.Append (convert (s [i]));
+					start = i + 1;
+				}
+			}
+			if (sb != null && start < s.Length)
+				sb.Append (s.Substring (start));
+			return sb == null ? s : sb.ToString ();
 		}
 
 		/* IDeserialization interface */