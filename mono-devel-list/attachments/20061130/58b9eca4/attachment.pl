Index: System/DateTime.cs
===================================================================
--- System/DateTime.cs	(revision 68721)
+++ System/DateTime.cs	(working copy)
@@ -738,7 +738,7 @@
 				break;
 			}
 			DateTimeFormatInfo info = (DateTimeFormatInfo) provider.GetFormat (typeof(DateTimeFormatInfo));
-			return GetDateTimeFormats (adjustutc, info.GetAllDateTimePatterns (format), info);
+			return GetDateTimeFormats (adjustutc, info.GetAllRawDateTimePatterns (format), info);
 		}
 
 		private string [] GetDateTimeFormats (bool adjustutc, string [] patterns, DateTimeFormatInfo dfi)
@@ -1060,10 +1060,10 @@
 					else if (num == 1)
 						day = _ParseNumber (s, valuePos,0, 2, true, sloppy_parsing, out num_parsed);
 					else if (num == 2)
-						dayofweek = _ParseEnum (s, valuePos, dfi.AbbreviatedDayNames, out num_parsed);
+						dayofweek = _ParseEnum (s, valuePos, dfi.RawAbbreviatedDayNames, out num_parsed);
 					else
 					{
-						dayofweek = _ParseEnum (s, valuePos, dfi.DayNames, out num_parsed);
+						dayofweek = _ParseEnum (s, valuePos, dfi.RawDayNames, out num_parsed);
 						num = 3;
 					}
 					break;
@@ -1075,10 +1075,10 @@
 					else if (num == 1)
 						month = _ParseNumber (s, valuePos, 0, 2, true, sloppy_parsing, out num_parsed);
 					else if (num == 2)
-						month = _ParseEnum (s, valuePos, dfi.AbbreviatedMonthNames , out num_parsed) + 1;
+						month = _ParseEnum (s, valuePos, dfi.RawAbbreviatedMonthNames , out num_parsed) + 1;
 					else
 					{
-						month = _ParseEnum (s, valuePos, dfi.MonthNames, out num_parsed) + 1;
+						month = _ParseEnum (s, valuePos, dfi.RawMonthNames, out num_parsed) + 1;
 						num = 3;
 					}
 					break;
Index: System.Globalization/DateTimeFormatInfo.cs
===================================================================
--- System.Globalization/DateTimeFormatInfo.cs	(revision 68721)
+++ System.Globalization/DateTimeFormatInfo.cs	(working copy)
@@ -227,9 +227,15 @@
 
 		public string[] AbbreviatedDayNames
 		{
+			get { return (string[]) RawAbbreviatedDayNames.Clone (); }
+			set { RawAbbreviatedDayNames = value; }
+		}
+
+		internal string[] RawAbbreviatedDayNames
+		{
 			get
 			{
-				return (string[]) abbreviatedDayNames.Clone();
+				return abbreviatedDayNames;
 			}
 			set
 			{
@@ -242,9 +248,15 @@
 
 		public string[] AbbreviatedMonthNames
 		{
+			get { return (string[]) RawAbbreviatedMonthNames.Clone (); }
+			set { RawAbbreviatedMonthNames = value; }
+		}
+
+		internal string[] RawAbbreviatedMonthNames
+		{
 			get
 			{
-				return (string[]) abbreviatedMonthNames.Clone();
+				return abbreviatedMonthNames;
 			}
 			set
 			{
@@ -257,9 +269,15 @@
 
 		public string[] DayNames
 		{
+			get { return (string[]) RawDayNames.Clone (); }
+			set { RawDayNames = value; }
+		}
+
+		internal string[] RawDayNames
+		{
 			get
 			{
-				return (string[]) dayNames.Clone();
+				return dayNames;
 			}
 			set
 			{
@@ -272,9 +290,14 @@
 
 		public string[] MonthNames
 		{
+			get { return (string[]) RawMonthNames.Clone (); }
+		}
+
+		internal string[] RawMonthNames
+		{
 			get
 			{
-				return (string[]) monthNames.Clone();
+				return monthNames;
 			}
 			set
 			{
@@ -530,13 +553,11 @@
 		}
 		
 		// FIXME: Not complete depending on GetAllDateTimePatterns(char)")]
-		public string[] GetAllDateTimePatterns() 
+		public string[] GetAllDateTimePatterns () 
 		{
-			FillAllDateTimePatterns ();
-			return (string []) all_date_time_patterns.Clone ();
+			return (string[]) GetAllDateTimePatternsInternal ().Clone ();
 		}
 
-
 		// Same as above, but with no cloning, because we know that
 		// clients are friendly
 		internal string [] GetAllDateTimePatternsInternal ()
@@ -554,45 +575,28 @@
 				return;
 			
 			ArrayList al = new ArrayList ();
-			foreach (string s in GetAllDateTimePatterns ('d'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('D'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('g'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('G'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('f'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('F'))
-				al.Add (s);
+			al.AddRange (GetAllRawDateTimePatterns ('d'));
+			al.AddRange (GetAllRawDateTimePatterns ('D'));
+			al.AddRange (GetAllRawDateTimePatterns ('g'));
+			al.AddRange (GetAllRawDateTimePatterns ('G'));
+			al.AddRange (GetAllRawDateTimePatterns ('f'));
+			al.AddRange (GetAllRawDateTimePatterns ('F'));
 			// Yes, that is very meaningless, but that is what MS
 			// is doing (LAMESPEC: Since it is documented that
 			// 'M' and 'm' are equal, they should not cosider
 			// that there is a possibility that 'M' and 'm' are
 			// different.)
-			foreach (string s in GetAllDateTimePatterns ('m'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('M'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('r'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('R'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('s'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('t'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('T'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('u'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('U'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('y'))
-				al.Add (s);
-			foreach (string s in GetAllDateTimePatterns ('Y'))
-				al.Add (s);
+			al.AddRange (GetAllRawDateTimePatterns ('m'));
+			al.AddRange (GetAllRawDateTimePatterns ('M'));
+			al.AddRange (GetAllRawDateTimePatterns ('r'));
+			al.AddRange (GetAllRawDateTimePatterns ('R'));
+			al.AddRange (GetAllRawDateTimePatterns ('s'));
+			al.AddRange (GetAllRawDateTimePatterns ('t'));
+			al.AddRange (GetAllRawDateTimePatterns ('T'));
+			al.AddRange (GetAllRawDateTimePatterns ('u'));
+			al.AddRange (GetAllRawDateTimePatterns ('U'));
+			al.AddRange (GetAllRawDateTimePatterns ('y'));
+			al.AddRange (GetAllRawDateTimePatterns ('Y'));
 
 			// all_date_time_patterns needs to be volatile to prevent
 			// reordering of writes here and still avoid any locking.
@@ -605,25 +609,30 @@
 		//
 		public string[] GetAllDateTimePatterns (char format)
 		{
+			return (string[]) GetAllRawDateTimePatterns (format).Clone ();
+		}
+
+		internal string[] GetAllRawDateTimePatterns (char format)
+		{
 			string [] list;
 			switch (format) {
 			// Date
 			case 'D':
 				if (allLongDatePatterns != null && allLongDatePatterns.Length > 0)
-					return allLongDatePatterns.Clone () as string [];
+					return allLongDatePatterns;
 				return new string [] {LongDatePattern};
 			case 'd':
 				if (allShortDatePatterns != null && allShortDatePatterns.Length > 0)
-					return allShortDatePatterns.Clone () as string [];
+					return allShortDatePatterns;
 				return new string [] {ShortDatePattern};
 			// Time
 			case 'T':
 				if (allLongTimePatterns != null && allLongTimePatterns.Length > 0)
-					return allLongTimePatterns.Clone () as string [];
+					return allLongTimePatterns;
 				return new string [] {LongTimePattern};
 			case 't':
 				if (allShortTimePatterns != null && allShortTimePatterns.Length > 0)
-					return allShortTimePatterns.Clone () as string [];
+					return allShortTimePatterns;
 				return new string [] {ShortTimePattern};
 			// {Short|Long}Date + {Short|Long}Time
 			// FIXME: they should be the agglegation of the
@@ -655,13 +664,13 @@
 			case 'm':
 			case 'M':
 				if (monthDayPatterns != null && monthDayPatterns.Length > 0)
-					return monthDayPatterns.Clone () as string [];
+					return monthDayPatterns;
 				return new string [] {MonthDayPattern};
 			// YearMonth
 			case 'Y':
 			case 'y':
 				if (yearMonthPatterns != null && yearMonthPatterns.Length > 0)
-					return yearMonthPatterns.Clone () as string [];
+					return yearMonthPatterns;
 				return new string [] {YearMonthPattern};
 			// RFC1123
 			case 'r':