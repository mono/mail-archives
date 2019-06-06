Index: DateTime.cs
===================================================================
RCS file: /cvs/public/mcs/class/corlib/System/DateTime.cs,v
retrieving revision 1.80
diff -u -r1.80 DateTime.cs
--- DateTime.cs	8 Jun 2004 18:21:54 -0000	1.80
+++ DateTime.cs	9 Jun 2004 05:07:51 -0000
@@ -398,11 +398,11 @@
 
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
@@ -776,7 +776,8 @@
 			int len = format.Length, pos = 0, num = 0;
 
 			int day = -1, dayofweek = -1, month = -1, year = -1;
-			int hour = -1, minute = -1, second = -1, millisecond = -1;
+			int hour = -1, minute = -1, second = -1;
+			double fractionalSeconds = -1;
 			int ampm = -1;
 			int tzsign = -1, tzoffset = -1, tzoffmin = -1;
 			bool next_not_digit;
@@ -999,24 +1000,15 @@
 
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
@@ -1054,17 +1046,19 @@
 					if (num == 0)
 						tzoffset = _ParseNumber (s, 2, false, sloppy_parsing, next_not_digit, out num_parsed);
 					else if (num == 1)
-						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
 					else
 					{
 						tzoffset = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
 						if (num_parsed < 0)
 							return false;
 						s = s.Substring (num_parsed);
-						if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
+						if (Char.IsDigit (s [0]))
+							num_parsed = 0;
+						else if (!_ParseString (s, 0, dfi.TimeSeparator, out num_parsed))
 							return false;
 						s = s.Substring (num_parsed);
-						tzoffmin = _ParseNumber (s, 2, true, sloppy_parsing, next_not_digit, out num_parsed);
+						tzoffmin = _ParseNumber (s, 2, true, sloppy_parsing, false, out num_parsed);
 						if (num_parsed < 0)
 							return false;
 						num = 2;
@@ -1079,8 +1073,11 @@
 				// verification. Also, "Z" != "'Z'" under MS.NET
 				// ("'Z'" is just literal; handled above)
 				case 'Z':
+					if (s [0] != 'Z')
+						return false;
+					num = 0;
+					num_parsed = 1;
 					useutc = true;
-					s = s.Substring (1);
 					break;
 
 				case ':':
@@ -1139,7 +1136,7 @@
 				num = 0;
 			}
 
-			if (pos < chars.Length)
+			if (exact && pos < len)
 				return false;
 
 			if (s.Length != 0) // extraneous tail.
@@ -1152,8 +1149,8 @@
 
 			if (second == -1)
 				second = 0;
-			if (millisecond == -1)
-				millisecond = 0;
+			if (fractionalSeconds == -1)
+				fractionalSeconds = 0;
 
 			// If no date was given
 			if ((day == -1) && (month == -1) && (year == -1)) {
@@ -1193,7 +1190,8 @@
 			second < 0 || second > 59 )
 				return false;
 
-			result = new DateTime (year, month, day, hour, minute, second, millisecond);
+			result = new DateTime (year, month, day, hour, minute, second, 0);
+			result = result.AddSeconds(fractionalSeconds);
 
 //Console.WriteLine ("**** Parsed as {1} {0} {2}", new object [] {useutc ? "[u]" : "", format, use_localtime ? "[lt]" : ""});
 			if ((dayofweek != -1) && (dayofweek != (int) result.DayOfWeek))
