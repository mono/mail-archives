Index: DateTime.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/DateTime.cs,v
retrieving revision 1.96
diff -u -r1.96 DateTime.cs
--- DateTime.cs	19 Aug 2004 03:46:47 -0000	1.96
+++ DateTime.cs	4 Oct 2004 18:31:38 -0000
@@ -726,7 +726,8 @@
 			return ParseExact (s, format, fp, DateTimeStyles.None);
 		}
 
-		internal static int _ParseNumber (string s, int digits,
+		internal static int _ParseNumber (string s, int valuePos,
+						  int digits,
 						  bool leadingzero,
 						  bool sloppy_parsing,
 						  bool next_not_digit,
@@ -739,7 +740,7 @@
 
 			if (!leadingzero) {
 				int real_digits = 0;
-				for (i = 0; i < s.Length && i < digits; i++) {
+				for (i = valuePos; i < s.Length && i < digits + valuePos; i++) {
 					if (!Char.IsDigit (s[i]))
 						break;
 
@@ -749,20 +750,20 @@
 				digits = real_digits;
 			}
 
-			if (s.Length < digits) {
+			if (s.Length - valuePos < digits) {
 				num_parsed = -1;
 				return 0;
 			}
 
-			if (s.Length > digits &&
+			if (s.Length - valuePos > digits &&
 			    next_not_digit &&
-			    Char.IsDigit (s[digits])) {
+			    Char.IsDigit (s[digits + valuePos])) {
 				/* More digits left over */
 				num_parsed = -1;
 				return(0);
 			}
 
-			for (i = 0; i < digits; i++) {
+			for (i = valuePos; i < digits + valuePos; i++) {
 				char c = s[i];
 				if (!Char.IsDigit (c)) {
 					num_parsed = -1;
@@ -776,16 +777,16 @@
 			return number;
 		}
 
-		internal static int _ParseEnum (string s, string[] values, out int num_parsed)
+		internal static int _ParseEnum (string s, int sPos, string[] values, out int num_parsed)
 		{
 			int i;
 
 			for (i = 0; i < values.Length; i++) {
-				if (s.Length < values[i].Length)
+				if (s.Length - sPos < values[i].Length)
 					continue;
 				else if (values [i].Length == 0)
 					continue;
-				String tmp = s.Substring (0, values[i].Length);
+				String tmp = s.Substring (sPos, values[i].Length);
 				if (String.Compare (tmp, values[i], true) == 0) {
 					num_parsed = values[i].Length;
 					return i;
@@ -796,12 +797,12 @@
 			return -1;
 		}
 
-		internal static bool _ParseString (string s, int maxlength, string value, out int num_parsed)
+		internal static bool _ParseString (string s, int sPos, int maxlength, string value, out int num_parsed)
 		{
 			if (maxlength <= 0)
 				maxlength = value.Length;
 
-			if (String.Compare (s, 0, value, 0, maxlength, true, CultureInfo.InvariantCulture) == 0) {
+			if (String.Compare (s, sPos, value, 0, maxlength, true, CultureInfo.InvariantCulture) == 0) {
 				num_parsed = maxlength;
 				return true;
 			}
@@ -810,7 +811,7 @@
 			return false;
 		}
 
-		internal static bool _DoParse (string s, string format, bool exact,
+		private static bool _DoParse (string s, string format, bool exact,
 					       out DateTime result,
 					       DateTimeFormatInfo dfi,
 					       DateTimeStyles style,
@@ -819,6 +820,7 @@
 			bool useutc = false, use_localtime = true;
 			bool use_invariant = false;
 			bool sloppy_parsing = false;
+			int valuePos = 0;
 			if (format.Length == 1)
 				format = _GetStandardPattern (format [0], dfi, out useutc, out use_invariant);
 			else if (!exact && format.IndexOf ("GMT") >= 0)
@@ -827,12 +829,12 @@
 			if ((style & DateTimeStyles.AllowLeadingWhite) != 0) {
 				format = format.TrimStart (null);
 
-				s = s.TrimStart (null);
+				s = s.TrimStart (null); // it could be optimized, but will make little good.
 			}
 
 			if ((style & DateTimeStyles.AllowTrailingWhite) != 0) {
 				format = format.TrimEnd (null);
-				s = s.TrimEnd (null);
+				s = s.TrimEnd (null); // it could be optimized, but will make little good.
 			}
 
 			if (use_invariant)
@@ -841,7 +843,7 @@
 			if ((style & DateTimeStyles.AllowInnerWhite) != 0)
 				sloppy_parsing = true;
 
-			char[] chars = format.ToCharArray ();
+			string chars = format;
 			int len = format.Length, pos = 0, num = 0;
 
 			int day = -1, dayofweek = -1, month = -1, year = -1;
@@ -854,7 +856,7 @@
 			result = new DateTime (0);
 			while (pos+num < len)
 			{
-				if (s.Length == 0)
+				if (s.Length == valuePos)
 					break;
 
 				if (chars[pos] == '\'') {
@@ -863,11 +865,11 @@
 						if (chars[pos+num] == '\'')
 							break;
 
-						if (s.Length == 0)
+						if (valuePos == s.Length)
 							return false;
-						if (s[0] != chars[pos+num])
+						if (s [valuePos] != chars [pos + num])
 							return false;
-						s = s.Substring (1);
+						valuePos++;
 
 						num++;
 					}
@@ -883,11 +885,11 @@
 						if (chars[pos+num] == '"')
 							break;
 
-						if (s.Length == 0)
+						if (valuePos == s.Length)
 							return false;
-						if (s[0] != chars[pos+num])
+						if (s [valuePos] != chars[pos+num])
 							return false;
-						s = s.Substring (1);
+						valuePos++;
 
 						num++;
 					}
@@ -901,10 +903,10 @@
 					if (pos+1 >= len)
 						return false;
 
-					if (s[0] != chars[pos+num])
+					if (s [valuePos] != chars [pos + num])
 						return false;
-					s = s.Substring (1);
-					if (s.Length == 0)
+					valuePos++;
+					if (valuePos == s.Length)
 						return false;
 
 					pos++;
@@ -912,8 +914,8 @@
 				} else if (chars[pos] == '%') {
 					pos++;
 					continue;
-				} else if (Char.IsWhiteSpace (s[0])) {
-					s = s.Substring (1);
+				} else if (Char.IsWhiteSpace (s [valuePos])) {
+					valuePos++;
 
 					if (Char.IsWhiteSpace (chars[pos])) {
 						pos++;
@@ -922,14 +924,14 @@
 
 					if (exact && (style & DateTimeStyles.AllowInnerWhite) == 0)
 						return false;
-					int ws = 0;
+					int ws = valuePos;
 					while (ws < s.Length) {
 						if (Char.IsWhiteSpace (s [ws]))
 							ws++;
 						else
 							break;
 					}
-					s = s.Substring (ws);
+					valuePos = ws;
 				}
 
 
@@ -965,14 +967,14 @@
 					if (day != -1)
 						return false;
 					if (num == 0)
-						day = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						day = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 1)
-						day = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						day = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 2)
-						dayofweek = _ParseEnum (s, dfi.AbbreviatedDayNames, out num_parsed);
+						dayofweek = _ParseEnum (s, valuePos, dfi.AbbreviatedDayNames, out num_parsed);
 					else
 					{
-						dayofweek = _ParseEnum (s, dfi.DayNames, out num_parsed);
+						dayofweek = _ParseEnum (s, valuePos, dfi.DayNames, out num_parsed);
 						num = 3;
 					}
 					break;
@@ -980,14 +982,14 @@
 					if (month != -1)
 						return false;
 					if (num == 0)
-						month = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						month = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 1)
-						month = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						month = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 2)
-						month = _ParseEnum (s, dfi.AbbreviatedMonthNames , out num_parsed) + 1;
+						month = _ParseEnum (s, valuePos, dfi.AbbreviatedMonthNames , out num_parsed) + 1;
 					else
 					{
-						month = _ParseEnum (s, dfi.MonthNames, out num_parsed) + 1;
+						month = _ParseEnum (s, valuePos, dfi.MonthNames, out num_parsed) + 1;
 						num = 3;
 					}
 					break;
@@ -996,14 +998,14 @@
 						return false;
 
 					if (num == 0) {
-						year = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						year = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					} else if (num < 3) {
-						year = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						year = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 					} else {
-						year = _ParseNumber (s, 4, false, sloppy_parsing, next_not_digit, out num_parsed);
-						if ((year >= 1000) && (num_parsed == 4) && (!longYear) && (s.Length > 4)) {
+						year = _ParseNumber (s, valuePos, 4, false, sloppy_parsing, next_not_digit, out num_parsed);
+						if ((year >= 1000) && (num_parsed == 4) && (!longYear) && (s.Length > 4 + valuePos)) {
 							int np = 0;
-							int ly = _ParseNumber (s, 5, false, sloppy_parsing, next_not_digit, out np);
+							int ly = _ParseNumber (s, valuePos, 5, false, sloppy_parsing, next_not_digit, out np);
 							longYear = (ly > 9999);
 						}
 						num = 3;
@@ -1017,10 +1019,10 @@
 					if (hour != -1)
 						return false;
 					if (num == 0)
-						hour = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						hour = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else
 					{
-						hour = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						hour = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						num = 1;
 					}
 
@@ -1034,10 +1036,10 @@
 					if ((hour != -1) || (ampm >= 0))
 						return false;
 					if (num == 0)
-						hour = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						hour = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else
 					{
-						hour = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						hour = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						num = 1;
 					}
 					if (hour >= 24)
@@ -1049,10 +1051,10 @@
 					if (minute != -1)
 						return false;
 					if (num == 0)
-						minute = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						minute = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else
 					{
-						minute = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						minute = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						num = 1;
 					}
 					if (minute >= 60)
@@ -1063,10 +1065,10 @@
 					if (second != -1)
 						return false;
 					if (num == 0)
-						second = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						second = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else
 					{
-						second = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						second = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						num = 1;
 					}
 					if (second >= 60)
@@ -1077,7 +1079,7 @@
 					if (fractionalSeconds != -1)
 						return false;
 					num = Math.Min (num, 6);
-					double decimalNumber = (double) _ParseNumber (s, num+1, true, sloppy_parsing, next_not_digit, out num_parsed);
+					double decimalNumber = (double) _ParseNumber (s, valuePos, num+1, true, sloppy_parsing, next_not_digit, out num_parsed);
 					if (num_parsed == -1)
 						return false;
 
@@ -1089,18 +1091,18 @@
 						return false;
 					if (num == 0)
 					{
-						if (_ParseString (s, 1, dfi.AMDesignator, out num_parsed))
+						if (_ParseString (s, valuePos, 1, dfi.AMDesignator, out num_parsed))
 							ampm = 0;
-						else if (_ParseString (s, 1, dfi.PMDesignator, out num_parsed))
+						else if (_ParseString (s, valuePos, 1, dfi.PMDesignator, out num_parsed))
 							ampm = 1;
 						else
 							return false;
 					}
 					else
 					{
-						if (_ParseString (s, 0, dfi.AMDesignator, out num_parsed))
+						if (_ParseString (s, valuePos, 0, dfi.AMDesignator, out num_parsed))
 							ampm = 0;
-						else if (_ParseString (s, 0, dfi.PMDesignator, out num_parsed))
+						else if (_ParseString (s, valuePos, 0, dfi.PMDesignator, out num_parsed))
 							ampm = 1;
 						else
 							return false;
@@ -1110,29 +1112,29 @@
 				case 'z':
 					if (tzsign != -1)
 						return false;
-					if (s[0] == '+')
+					if (s [valuePos] == '+')
 						tzsign = 0;
-					else if (s[0] == '-')
+					else if (s [valuePos] == '-')
 						tzsign = 1;
 					else
 						return false;
-					s = s.Substring (1);
+					valuePos++;
 					if (num == 0)
-						tzoffset = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffset = _ParseNumber (s, valuePos, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 1)
-						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
+						tzoffset = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, false, out num_parsed);
 					else
 					{
-						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffset = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						if (num_parsed < 0)
 							return false;
-						s = s.Substring (num_parsed);
-						if (Char.IsDigit (s [0]))
+						valuePos += num_parsed;
+						if (Char.IsDigit (s [valuePos]))
 							num_parsed = 0;
-						else if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
+						else if (!_ParseString (s, valuePos, 0, dfi.TimeSeparator, out num_parsed))
 							return false;
-						s = s.Substring (num_parsed);
-						tzoffmin = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
+						valuePos += num_parsed;
+						tzoffmin = _ParseNumber (s, valuePos, 2, true, sloppy_parsing, false, out num_parsed);
 						if (num_parsed < 0)
 							return false;
 						num = 2;
@@ -1147,7 +1149,7 @@
 				// verification. Also, "Z" != "'Z'" under MS.NET
 				// ("'Z'" is just literal; handled above)
 				case 'Z':
-					if (s [0] != 'Z')
+					if (s [valuePos] != 'Z')
 						return false;
 					num = 0;
 					num_parsed = 1;
@@ -1155,7 +1157,7 @@
 					break;
 
 				case ':':
-					if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
+					if (!_ParseString (s, valuePos, 0, dfi.TimeSeparator, out num_parsed))
 						return false;
 					break;
 				case '/':
@@ -1167,14 +1169,14 @@
 					 * behaviour here.  See bug
 					 * 54047.
 					 */
-					if (exact && s [0] != '/')
+					if (exact && s [valuePos] != '/')
 						return false;
 
-					if (_ParseString (s, 0,
+					if (_ParseString (s, valuePos, 0,
 							  dfi.TimeSeparator,
 							  out num_parsed) ||
-					    Char.IsDigit (s[0]) ||
-					    Char.IsLetter (s[0])) {
+					    Char.IsDigit (s [valuePos]) ||
+					    Char.IsLetter (s [valuePos])) {
 						return(false);
 					}
 
@@ -1185,7 +1187,7 @@
 					
 					break;
 				default:
-					if (s[0] != chars[pos]) {
+					if (s [valuePos] != chars[pos]) {
 						// FIXME: It is not sure, but
 						// IsLetter() is introduced 
 						// because we have to reject 
@@ -1193,8 +1195,8 @@
 						// allow "2002$02$25". The same
 						// thing applies to '/' case.
 						if (exact ||
-							Char.IsDigit (s [0]) ||
-							Char.IsLetter (s [0]))
+							Char.IsDigit (s [valuePos]) ||
+							Char.IsLetter (s [valuePos]))
 							return false;
 					}
 					num = 0;
@@ -1205,7 +1207,7 @@
 				if (num_parsed < 0)
 					return false;
 
-				s = s.Substring (num_parsed);
+				valuePos += num_parsed;
 
 				pos = pos + num + 1;
 				num = 0;
@@ -1214,7 +1216,7 @@
 			if (exact && pos < len)
 				return false;
 
-			if (s.Length != 0) // extraneous tail.
+			if (s.Length != valuePos) // extraneous tail.
 				return false;
 
 			if (hour == -1)