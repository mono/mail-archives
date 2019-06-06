Fixes the 'exact' flag not being honored which meant DateTime strings were
matching the wrong patterns.

Fixes handling of milliseconds in _DoParse so it properly captures all provided
digits.

Fixes the 'Z' type format always matching even if no 'Z' was specified.

Fixes ISO 8601 timezones not handling the case where the colon is left out.

Fixes AddMilliseconds to round to the tick, not to the nearest millisecond, as
documented for the method.

Indirectly fixes XmlConvert.ToDateTime's ability to parse milliseconds, as it
uses ParseExact.

- Steven Brown <swbrown@ucsd.edu>


Index: class/corlib/System/DateTime.cs
===================================================================
--- class/corlib/System/DateTime.cs	(revision 2)
+++ class/corlib/System/DateTime.cs	(working copy)
@@ -369,11 +369,11 @@
 
 		public DateTime AddMilliseconds (double ms)
 		{
-			if (((ms + (ms > 0 ? 0.5 : -0.5)) * TimeSpan.TicksPerMillisecond) > long.MaxValue ||
-					((ms + (ms > 0 ? 0.5 : -0.5)) * TimeSpan.TicksPerMillisecond) < long.MinValue) {
+			if ((ms * TimeSpan.TicksPerMillisecond) > long.MaxValue ||
+					(ms * TimeSpan.TicksPerMillisecond) < long.MinValue) {
 				throw new ArgumentOutOfRangeException();
 			}
-			long msticks = (long) (ms += ms > 0 ? 0.5 : -0.5) * TimeSpan.TicksPerMillisecond;
+			long msticks = (long) (ms * TimeSpan.TicksPerMillisecond);
 
 			return AddTicks (msticks);
 		}
@@ -735,7 +735,8 @@
 			int len = format.Length, pos = 0, num = 0;
 
 			int day = -1, dayofweek = -1, month = -1, year = -1;
-			int hour = -1, minute = -1, second = -1, millisecond = -1;
+			int hour = -1, minute = -1, second = -1;
+			double fractionalSeconds = -1;
 			int ampm = -1;
 			int tzsign = -1, tzoffset = -1, tzoffmin = -1;
 			bool next_not_digit;
@@ -958,24 +959,14 @@
 
 					break;
 				case 'f':
-					if (millisecond != -1)
+					if (fractionalSeconds != -1)
 						return false;
 					num = Math.Min (num, 6);
-					millisecond = _ParseNumber (s, num+1, true, sloppy_parsing, next_not_digit, out num_parsed);
+					double decimalNumber = (double) _ParseNumber (s, num+1, true, sloppy_parsing, next_not_digit, out num_parsed);
 					if (num_parsed == -1)
 						return false;
-
-					if (num_parsed != 3) {
-						int k;
-						if (num_parsed > 3) {
-							for (k = num_parsed; k > 3; k--)
-								millisecond /= 10;
-						} else {
-							for (k = num_parsed; k < 3; k++) {
-								millisecond *= 10;
-							}
-						}
-					}
+					else
+						fractionalSeconds = decimalNumber / Math.Pow(10.0, num_parsed);
 					break;
 				case 't':
 					if (ampm != -1)
@@ -1016,14 +1007,16 @@
 						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 					else
 					{
-						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
 						if (num_parsed < 0)
 							return false;
 						s = s.Substring (num_parsed);
-						if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
+						if(Char.IsDigit(s[0]))
+							num_parsed = 0;
+						else if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
 							return false;
 						s = s.Substring (num_parsed);
-						tzoffmin = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffmin = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
 						if (num_parsed < 0)
 							return false;
 						num = 2;
@@ -1035,8 +1028,11 @@
 				// character. Keep it for certificate
 				// verification  right now.
 				case 'Z':
+					if (s[0] != 'Z')
+						return false;
+					num = 0;
+					num_parsed = 1;
 					useutc = true;
-					s = s.Substring (1);
 					break;
 				case ':':
 					if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
@@ -1090,6 +1086,9 @@
 			if (s.Length != 0) // extraneous tail.
 				return false;
 
+			if(exact && (s != "" || pos+num != len))
+				return false;
+
 			if (hour == -1)
 				hour = 0;
 			if (minute == -1)
@@ -1097,8 +1096,8 @@
 
 			if (second == -1)
 				second = 0;
-			if (millisecond == -1)
-				millisecond = 0;
+			if (fractionalSeconds == -1)
+				fractionalSeconds = 0;
 
 			// If no date was given
 			if ((day == -1) && (month == -1) && (year == -1)) {
@@ -1138,7 +1137,8 @@
 			second < 0 || second > 59 )
 				return false;
 
-			result = new DateTime (year, month, day, hour, minute, second, millisecond);
+			result = new DateTime (year, month, day, hour, minute, second, 0);
+			result = result.AddSeconds(fractionalSeconds);
 
 //Console.WriteLine ("**** useutc? {0} format {1} s {2}", useutc, format, s);
 			if ((dayofweek != -1) && (dayofweek != (int) result.DayOfWeek))
