Index: NumberFormatter.cs
===================================================================
--- NumberFormatter.cs	(revision 40962)
+++ NumberFormatter.cs	(working copy)
@@ -19,43 +19,43 @@
 		#region NumberToString
 		public static string NumberToString (string format, sbyte value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, byte value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, ushort value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, short value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, uint value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, int value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, ulong value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, long value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, float value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, double value, NumberFormatInfo nfi)
 		{
-			return NumberToString (format, NumberStore.CreateInstance (value), nfi);
+			return NumberToString (format, new NumberStore (value), nfi);
 		}
 		public static string NumberToString (string format, NumberStore ns, NumberFormatInfo nfi)
 		{
@@ -73,7 +73,7 @@
 			int precision;
 			bool custom;
 
-			if (format == null || format == "")
+			if (format == null || format.Length == 0)
 				format = "G";
 
 			if (nfi == null)
@@ -164,8 +164,7 @@
 			specifier = '\0';
 			custom = false;
 			
-			int length = format.Length;
-			if (length < 1)
+			if (format.Length < 1)
 				return false;
 			
 			specifier = format [0];
@@ -222,46 +221,86 @@
 		#region Basic
 		internal static string FormatCurrency (NumberStore ns, int precision, NumberFormatInfo nfi)
 		{
-			int[] groups = nfi.CurrencyGroupSizes;
-			string groupSeparator = nfi.CurrencyGroupSeparator;
 			precision = (precision >= 0 ? precision : nfi.CurrencyDecimalDigits);
-			StringBuilder sb = new StringBuilder();
-
 			ns.RoundDecimal (precision);
-			if (precision > 0) {
-				sb.Append (nfi.CurrencyDecimalSeparator);
-				sb.Append (ns.GetDecimalString (precision));
-			}
+			StringBuilder sb = new StringBuilder (ns.IntegerDigits * 2 + precision * 2 + 16);
+			bool needNegativeSign = !ns.Positive && !ns.ZeroOnly;
 
-			string intPart = ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1);
-			int index = intPart.Length - 1;
-			int counter = 0;
-			int groupIndex = 0;
-			int groupSize = (groups.Length > 0 ? groups [groupIndex++] : 0);
-			while (index >= 0) {
-				sb.Insert (0, intPart [index --]);
-				counter ++;
-
-				if (index >= 0 && groupSize > 0 && counter % groupSize == 0) {
-					sb.Insert (0, groupSeparator);
-					groupSize = (groupIndex < groups.Length ? groups [groupIndex++] : groupSize);
-					counter = 0;
-				}
-			}
-
-			if (ns.Positive || NumberStore.IsZeroOnly (sb)) {
+			if (!needNegativeSign) {
 				switch (nfi.CurrencyPositivePattern) {
 				case 0:
-					sb.Insert (0, nfi.CurrencySymbol);
+					sb.Append (nfi.CurrencySymbol);
 					break;
+				case 2:
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (" ");
+					break;
+				}
+			} else {
+				switch (nfi.CurrencyNegativePattern) {
+				case 0:
+					sb.Append ('(');
+					sb.Append (nfi.CurrencySymbol);
+					break;
 				case 1:
+					sb.Append (nfi.NegativeSign);
 					sb.Append (nfi.CurrencySymbol);
 					break;
 				case 2:
-					sb.Insert (0, " ");
-					sb.Insert (0, nfi.CurrencySymbol);
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (nfi.NegativeSign);
 					break;
 				case 3:
+					sb.Append (nfi.CurrencySymbol);
+					break;
+				case 4:
+					sb.Append ('(');
+					break;
+				case 5:
+					sb.Append (nfi.NegativeSign);
+					break;
+				case 8:
+					sb.Append (nfi.NegativeSign);
+					break;
+				case 9:
+					sb.Append (nfi.NegativeSign);
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (' ');					
+					break;
+				case 11:
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (' ');
+					break;
+				case 12:
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (' ');
+					sb.Append (nfi.NegativeSign);					
+					break;
+				case 14:
+					sb.Append ('(');
+					sb.Append (nfi.CurrencySymbol);
+					sb.Append (' ');
+					break;
+				case 15:
+					sb.Append ('(');
+					break;
+				}
+			}
+
+			ns.AppendIntegerStringWithGroupSeparator (sb, nfi.CurrencyGroupSizes, nfi.CurrencyGroupSeparator);
+
+			if (precision > 0)
+			{
+				sb.Append (nfi.CurrencyDecimalSeparator);
+				ns.AppendDecimalString (precision, sb);
+			}
+
+			if (!needNegativeSign) {
+				switch (nfi.CurrencyPositivePattern) {
+				case 1:
+					sb.Append (nfi.CurrencySymbol);
+					break;
+				case 3:
 					sb.Append (" ");
 					sb.Append (nfi.CurrencySymbol);
 					break;
@@ -269,29 +308,16 @@
 			} else {
 				switch (nfi.CurrencyNegativePattern) {
 				case 0:
-					sb.Insert (0, nfi.CurrencySymbol);
-					sb.Insert (0, '(');
 					sb.Append (')');
 					break;
-				case 1:
-					sb.Insert (0, nfi.CurrencySymbol);
-					sb.Insert (0, nfi.NegativeSign);
-					break;
-				case 2:
-					sb.Insert (0, nfi.NegativeSign);
-					sb.Insert (0, nfi.CurrencySymbol);
-					break;
 				case 3:
-					sb.Insert (0, nfi.CurrencySymbol);
 					sb.Append (nfi.NegativeSign);
 					break;
 				case 4:
-					sb.Insert (0, '(');
 					sb.Append (nfi.CurrencySymbol);
 					sb.Append (')');
 					break;
 				case 5:
-					sb.Insert (0, nfi.NegativeSign);
 					sb.Append (nfi.CurrencySymbol);
 					break;
 				case 6:
@@ -303,43 +329,26 @@
 					sb.Append (nfi.NegativeSign);
 					break;
 				case 8:
-					sb.Insert (0, nfi.NegativeSign);
 					sb.Append (' ');
 					sb.Append (nfi.CurrencySymbol);
 					break;
-				case 9:
-					sb.Insert (0, ' ');
-					sb.Insert (0, nfi.CurrencySymbol);
-					sb.Insert (0, nfi.NegativeSign);
-					break;
 				case 10:
 					sb.Append (' ');
 					sb.Append (nfi.CurrencySymbol);
 					sb.Append (nfi.NegativeSign);
 					break;
 				case 11:
-					sb.Insert (0, ' ');
-					sb.Insert (0, nfi.CurrencySymbol);
 					sb.Append (nfi.NegativeSign);
 					break;
-				case 12:
-					sb.Insert (0, nfi.NegativeSign);
-					sb.Insert (0, ' ');
-					sb.Insert (0, nfi.CurrencySymbol);
-					break;
 				case 13:
 					sb.Append (nfi.NegativeSign);
 					sb.Append (' ');
 					sb.Append (nfi.CurrencySymbol);
 					break;
 				case 14:
-					sb.Insert (0, ' ');
-					sb.Insert (0, nfi.CurrencySymbol);
-					sb.Insert (0, '(');
 					sb.Append (')');
 					break;
 				case 15:
-					sb.Insert (0, '(');
 					sb.Append (' ');
 					sb.Append (nfi.CurrencySymbol);
 					sb.Append (')');
@@ -355,12 +364,16 @@
 				throw new FormatException ();
 
 			precision = precision > 0 ? precision : 1;
-			StringBuilder sb = new StringBuilder();
-			sb.Append (ns.GetIntegerString (ns.IntegerDigits > precision ? ns.IntegerDigits : precision));
+			precision = ns.IntegerDigits > precision ? ns.IntegerDigits : precision;
 
-			if (!ns.Positive && !NumberStore.IsZeroOnly (sb))
-				sb.Insert (0, nfi.NegativeSign);
+			StringBuilder sb = new StringBuilder (precision + nfi.NegativeSign.Length);
 
+			if (!ns.Positive && !ns.CheckZeroOnlyInteger ()) {
+				sb.Append (nfi.NegativeSign);
+			}
+
+			ns.AppendIntegerString (precision, sb);
+
 			return sb.ToString ();
 		}
 		internal static string FormatFixedPoint (NumberStore ns, int precision, NumberFormatInfo nfi)
@@ -368,130 +381,137 @@
 			precision = precision >= 0 ? precision : nfi.NumberDecimalDigits;
 			ns.RoundDecimal (precision);
 
-			StringBuilder sb = new StringBuilder();
-			sb.Append (ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1));
+			StringBuilder cb = new StringBuilder (ns.IntegerDigits + precision + nfi.NumberDecimalSeparator.Length);
 
+			if (!ns.Positive && !ns.ZeroOnly)
+				cb.Append (nfi.NegativeSign);
+
+			ns.AppendIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1, cb);
+
 			if (precision > 0) {
-				sb.Append (nfi.NumberDecimalSeparator);
-				sb.Append (ns.GetDecimalString (precision));
+				cb.Append (nfi.NumberDecimalSeparator);
+				ns.AppendDecimalString (precision, cb);
 			}
 
-			if (!ns.Positive && !NumberStore.IsZeroOnly (sb))
-				sb.Insert (0, nfi.NegativeSign);
+			return cb.ToString ();
+		}
 
-			return sb.ToString ();
+		internal static string FormatGeneral (NumberStore ns)
+		{
+			return FormatGeneral (ns, -1, NumberFormatInfo.CurrentInfo, true);
 		}
-
+		internal static string FormatGeneral (NumberStore ns, IFormatProvider provider)
+		{
+			return FormatGeneral (ns, -1, NumberFormatInfo.GetInstance (provider), true);
+		}
 		internal static string FormatGeneral (NumberStore ns, int precision, NumberFormatInfo nfi, bool upper)
 		{
 			if (ns.ZeroOnly)
 				return "0";
 
 			precision = precision > 0 ? precision : ns.DefaultPrecision;
-			StringBuilder sb = new StringBuilder();
 
-			int preExponent = 0;
-			NumberStore prens = ns.GetClone ();
-			while (!(prens.DecimalPointPosition == 1 && prens.GetChar (0) != '0')) {
-				if (prens.DecimalPointPosition > 1) {
-					prens.Divide10 (1);
-					preExponent ++;
-				} else {
-					prens.Multiply10 (1);
-					preExponent --;
+			int exponent = 0;
+			bool expMode = (ns.IntegerDigits > precision || ns.DecimalPointPosition <= -4);
+			if (expMode) {
+				while (!(ns.DecimalPointPosition == 1 && ns.GetChar (0) != '0')) {
+					if (ns.DecimalPointPosition > 1) {
+						ns.Divide10 (1);
+						exponent ++;
+					} else {
+						ns.Multiply10 (1);
+						exponent --;
+					}
 				}
 			}
 
-			bool fixedPointMode = preExponent > -5 && preExponent < precision;
-
-			precision = precision < ns.DefaultPrecision + 2 ? precision : ns.DefaultPrecision + 2;
-			precision = precision < 17 ? precision : 17;
-			if (fixedPointMode) {
-				ns.RoundDecimal (precision);
-			} else {
-				ns = prens;
+			precision = precision < ns.DefaultPrecision + 2 ? (precision < 17 ? precision : 17) : ns.DefaultPrecision + 2;
+			StringBuilder cb = new StringBuilder (ns.IntegerDigits + precision + 16);
+			if (expMode) {
 				if (ns.RoundDecimal (precision - 1)) {
 					ns.Divide10 (1);
-					preExponent ++;
+					exponent ++;
 				}
+			} else {
+				ns.RoundDecimal (precision);
 			}
 
 			if (!ns.Positive) {
-				sb.Append (nfi.NegativeSign);
+				cb.Append (nfi.NegativeSign);
 			}
-			sb.Append (ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1));
+
+			ns.AppendIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1, cb);
+
 			if (ns.DecimalDigits > 0) {
-				sb.Append (nfi.NumberDecimalSeparator);
-				sb.Append (ns.GetDecimalString (ns.DecimalDigits));
+				cb.Append (nfi.NumberDecimalSeparator);
+				ns.AppendDecimalString (ns.DecimalDigits, cb);
 			}
 
-			if (!fixedPointMode) {
+			if (expMode) {
 				if (upper)
-					sb.Append ('E');
+					cb.Append ('E');
 				else
-					sb.Append ('e');
+					cb.Append ('e');
 
-				if (preExponent >= 0)
-					sb.Append (nfi.PositiveSign);
+				if (exponent >= 0)
+					cb.Append (nfi.PositiveSign);
 				else {
-					sb.Append (nfi.NegativeSign);
-					preExponent = -preExponent;
+					cb.Append (nfi.NegativeSign);
+					exponent = -exponent;
 				}
 
-				if (preExponent < 10)
-					sb.Append ('0');
-
-				int pos = sb.Length;
-				while (preExponent > 0) {
-					sb.Insert (pos, digitLowerTable [preExponent % 10]);
-					preExponent /= 10;
+				if (exponent == 0) {
+					cb.Append ('0', 2);
+				} else if (exponent < 10) {
+					cb.Append ('0');
+					cb.Append (digitLowerTable [exponent]);
+				} else if (exponent < 100) {
+					cb.Append (digitLowerTable [exponent / 10 % 10]);
+					cb.Append (digitLowerTable [exponent % 10]);
+				} else if (exponent < 1000) {
+					cb.Append (digitLowerTable [exponent / 100 % 10]);
+					cb.Append (digitLowerTable [exponent / 10 % 10]);
+					cb.Append (digitLowerTable [exponent % 10]);
 				}
 			}
 
-			return sb.ToString ();
+			return cb.ToString ();
 		}
 		internal static string FormatNumber (NumberStore ns, int precision, NumberFormatInfo nfi)
 		{
-			int[] groups = nfi.NumberGroupSizes;
-			string groupSeparator = nfi.NumberGroupSeparator;
 			precision = (precision >= 0 ? precision : nfi.NumberDecimalDigits);
-			StringBuilder sb = new StringBuilder();
+			StringBuilder sb = new StringBuilder(ns.IntegerDigits * 3 + precision);
 
 			ns.RoundDecimal (precision);
-			if (precision > 0) {
-				sb.Append (nfi.NumberDecimalSeparator);
-				sb.Append (ns.GetDecimalString (precision));
+			bool needNegativeSign = (!ns.Positive && !ns.ZeroOnly);
+
+			if (needNegativeSign) {
+				switch (nfi.NumberNegativePattern) {
+				case 0:
+					sb.Append ('(');
+					break;
+				case 1:
+					sb.Append (nfi.NegativeSign);
+					break;
+				case 2:
+					sb.Append (nfi.NegativeSign);
+					sb.Append (' ');
+					break;
+				}
 			}
 
-			string intPart = ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1);
-			int index = intPart.Length - 1;
-			int counter = 0;
-			int groupIndex = 0;
-			int groupSize = (groups.Length > 0 ? groups [groupIndex++] : 0);
-			while (index >= 0) {
-				sb.Insert (0, intPart [index --]);
-				counter ++;
+			ns.AppendIntegerStringWithGroupSeparator (sb, nfi.NumberGroupSizes, nfi.NumberGroupSeparator);
 
-				if (index >= 0 && groupSize > 0 && counter % groupSize == 0) {
-					sb.Insert (0, groupSeparator);
-					groupSize = (groupIndex < groups.Length ? groups [groupIndex++] : groupSize);
-					counter = 0;
-				}
+			if (precision > 0) {
+				sb.Append (nfi.NumberDecimalSeparator);
+				ns.AppendDecimalString (precision, sb);
 			}
 
-			if (!ns.Positive && !NumberStore.IsZeroOnly (sb)) {
+			if (needNegativeSign) {
 				switch (nfi.NumberNegativePattern) {
 				case 0:
-					sb.Insert (0, '(');
 					sb.Append (')');
 					break;
-				case 1:
-					sb.Insert (0, nfi.NegativeSign);
-					break;
-				case 2:
-					sb.Insert (0, ' ');
-					sb.Insert (0, nfi.NegativeSign);
-					break;
 				case 3:
 					sb.Append (nfi.NegativeSign);
 					break;
@@ -506,36 +526,40 @@
 		}
 		internal static string FormatPercent (NumberStore ns, int precision, NumberFormatInfo nfi)
 		{
-			int[] groups = nfi.PercentGroupSizes;
-			string groupSeparator = nfi.PercentGroupSeparator;
 			precision = (precision >= 0 ? precision : nfi.PercentDecimalDigits);
-			StringBuilder sb = new StringBuilder();
-
 			ns.Multiply10 (2);
-
 			ns.RoundDecimal (precision);
-			if (precision > 0) {
-				sb.Append (nfi.PercentDecimalSeparator);
-				sb.Append (ns.GetDecimalString (precision));
-			}
+			bool needNegativeSign = (!ns.Positive && !ns.ZeroOnly);
 
-			string intPart = ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1);
-			int index = intPart.Length - 1;
-			int counter = 0;
-			int groupIndex = 0;
-			int groupSize = (groups.Length > 0 ? groups [groupIndex++] : 0);
-			while (index >= 0) {
-				sb.Insert (0, intPart [index --]);
-				counter ++;
+			StringBuilder sb = new StringBuilder(ns.IntegerDigits * 2 + precision + 16);
 
-				if (index >= 0 && groupSize > 0 && counter % groupSize == 0) {
-					sb.Insert (0, groupSeparator);
-					groupSize = (groupIndex < groups.Length ? groups [groupIndex++] : groupSize);
-					counter = 0;
+			if (!needNegativeSign) {
+				if (nfi.PercentPositivePattern == 2) {
+					sb.Append (nfi.PercentSymbol);
 				}
+			} else {
+				switch (nfi.PercentNegativePattern) {
+				case 0:
+					sb.Append (nfi.NegativeSign);
+					break;
+				case 1:
+					sb.Append (nfi.NegativeSign);
+					break;
+				case 2:
+					sb.Append (nfi.NegativeSign);
+					sb.Append (nfi.PercentSymbol);
+					break;
+				}
 			}
 
-			if (ns.Positive || NumberStore.IsZeroOnly (sb)) {
+			ns.AppendIntegerStringWithGroupSeparator (sb, nfi.PercentGroupSizes, nfi.PercentGroupSeparator);
+			
+			if (precision > 0) {
+				sb.Append (nfi.PercentDecimalSeparator);
+				ns.AppendDecimalString (precision, sb);
+			}
+
+			if (!needNegativeSign) {
 				switch (nfi.PercentPositivePattern) {
 				case 0:
 					sb.Append (' ');
@@ -544,25 +568,16 @@
 				case 1:
 					sb.Append (nfi.PercentSymbol);
 					break;
-				case 2:
-					sb.Insert (0, nfi.PercentSymbol);
-					break;
 				}
 			} else {
 				switch (nfi.PercentNegativePattern) {
 				case 0:
 					sb.Append (' ');
 					sb.Append (nfi.PercentSymbol);
-					sb.Insert (0, nfi.NegativeSign);
 					break;
 				case 1:
 					sb.Append (nfi.PercentSymbol);
-					sb.Insert (0, nfi.NegativeSign);
 					break;
-				case 2:
-					sb.Insert (0, nfi.PercentSymbol);
-					sb.Insert (0, nfi.NegativeSign);
-					break;
 				}
 			}
 
@@ -573,27 +588,30 @@
 			if (ns.IsFloatingSource)
 				throw new FormatException ();
 
-			StringBuilder sb = new StringBuilder();
-
 			int intSize = ns.DefaultByteSize;
-			ulong value = ulong.Parse (ns.GetIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1));
+			ulong value = 0;
+			for (int i = 0; i < ns.IntegerDigits; i++) {
+				value *= 10;
+				value += ns.GetDigitByte (i);
+			}
 
 			if (!ns.Positive) {
 				value = (ulong)(Math.Pow (2, intSize * 8)) - value;
 			}
 
 			char[] digits = (upper ? digitUpperTable : digitLowerTable);
+			CharBuffer sb = new CharBuffer (16 + precision + 1);
 
 			while (value > 0) {
-				sb.Insert (0, digits [value % 16]);
+				sb.InsertToFront (digits [value % 16]);
 				value >>= 4;
 			}
 
 			if (sb.Length == 0)
-				sb.Append ('0');
+				sb.InsertToFront ('0');
 
 			if (sb.Length < precision)
-				sb.Insert (0, "0", precision - sb.Length);
+				sb.InsertToFront ('0', precision - sb.Length);
 
 			return sb.ToString ();
 		}
@@ -601,8 +619,75 @@
 		{
 			if (precision < 0)
 				precision = 6;
-			string decimalPart = (precision > 0 ? string.Concat(".", new string ('0', precision)) : "");
-			return FormatCustom (string.Concat ("0", decimalPart , (upper ? "E": "e"), "+000"), ns, nfi);
+
+			if (ns.ZeroOnly) {
+				return string.Concat ("0", precision > 0 ? "." + new string ('0', precision) : "", upper ? "E" : "e", nfi.PositiveSign, "000");
+			}
+
+			int exponent = 0;
+			while (!(ns.DecimalPointPosition == 1 && ns.GetChar (0) != '0')) {
+				if (ns.DecimalPointPosition > 1) {
+					ns.Divide10 (1);
+					exponent ++;
+				} else {
+					ns.Multiply10 (1);
+					exponent --;
+				}
+			}
+
+			if (ns.RoundDecimal (precision)) {
+				ns.Divide10 (1);
+				exponent ++;
+			}
+
+			StringBuilder cb = new StringBuilder (ns.DecimalDigits + 1 + 8);
+
+			if (!ns.Positive) {
+				cb.Append (nfi.NegativeSign);
+			}
+
+			ns.AppendIntegerString (ns.IntegerDigits > 0 ? ns.IntegerDigits : 1, cb);
+
+			if (precision > 0) {
+				cb.Append (nfi.NumberDecimalSeparator);
+				ns.AppendDecimalString (precision, cb);
+			}
+
+			if (upper)
+				cb.Append ('E');
+			else
+				cb.Append ('e');
+
+			if (exponent >= 0)
+				cb.Append (nfi.PositiveSign);
+			else {
+				cb.Append (nfi.NegativeSign);
+				exponent = -exponent;
+			}
+
+			if (exponent == 0) {
+				cb.Append ('0', 3);
+			} else if (exponent < 10) {
+				cb.Append ('0', 2);
+				cb.Append (digitLowerTable [exponent]);
+			} else if (exponent < 100) {
+				cb.Append ('0', 1);
+				cb.Append (digitLowerTable [exponent / 10 % 10]);
+				cb.Append (digitLowerTable [exponent % 10]);
+			} else if (exponent < 1000) {
+				cb.Append (digitLowerTable [exponent / 100 % 10]);
+				cb.Append (digitLowerTable [exponent / 10 % 10]);
+				cb.Append (digitLowerTable [exponent % 10]);
+			/*} else { // exponent range is 0`}324
+				int pos = cb.Length;
+				int count = 3;
+				while (exponent > 0 || --count > 0) {
+					cb.Insert (pos, digitLowerTable [exponent % 10]);
+					exponent /= 10;
+				}*/
+			}
+
+			return cb.ToString ();
 		}
 		#endregion
 
@@ -610,13 +695,15 @@
 		internal static string FormatCustom (string format, NumberStore ns, NumberFormatInfo nfi)
 		{
 			bool p = ns.Positive;
-			format = CustomInfo.GetActiveSection (format,ref p, ns.ZeroOnly);
-			if (format == "") {
+			int offset = 0;
+			int length = 0;
+			CustomInfo.GetActiveSection (format,ref p, ns.ZeroOnly, ref offset, ref length);
+			if (length == 0) {
 				return ns.Positive ? "" : nfi.NegativeSign;
 			}
 			ns.Positive = p;
 
-			CustomInfo info = CustomInfo.Parse (format, nfi);
+			CustomInfo info = CustomInfo.Parse (format, offset, length, nfi);
 #if false
 			Console.WriteLine("Format : {0}",format);
 			Console.WriteLine("DecimalDigits : {0}",info.DecimalDigits);
@@ -633,9 +720,9 @@
 			Console.WriteLine("Percents : {0}",info.Percents);
 			Console.WriteLine("Permilles : {0}",info.Permilles);
 #endif
-			StringBuilder sb_int = new StringBuilder();
-			StringBuilder sb_dec = new StringBuilder();
-			StringBuilder sb_exp = new StringBuilder();
+			StringBuilder sb_int = new StringBuilder(info.IntegerDigits * 2);
+			StringBuilder sb_dec = new StringBuilder(info.DecimalDigits * 2);
+			StringBuilder sb_exp = (info.UseExponent ? new StringBuilder(info.ExponentDigits * 2) : null);
 
 			int diff = 0;
 			if (info.Percents > 0) {
@@ -668,20 +755,18 @@
 					}
 				}
 
-				int exp = diff >= 0 ? diff : -diff;
-				expPositive = -diff >= 0;
-				while (exp > 0) {
-					sb_exp.Insert (0, digitLowerTable [exp % 10]);
-					exp /= 10;
-				}
+				expPositive = diff <= 0;
+				NumberStore.AppendIntegerStringFromUInt32 (sb_exp, (uint)(diff >= 0 ? diff : -diff));
 			} else {
 				ns.RoundDecimal (info.DecimalDigits);
 				if (ns.ZeroOnly)
 					ns.Positive = true;
 			}
 
-			sb_int.Append (ns.GetIntegerString (ns.IntegerDigits));
-			if (sb_int.Length > info.IntegerDigits) {
+			if (info.IntegerDigits != 0 || !ns.CheckZeroOnlyInteger ()) {
+				ns.AppendIntegerString (ns.IntegerDigits, sb_int);
+			}
+			/* if (sb_int.Length > info.IntegerDigits) {
 				int len = 0;
 				while (sb_int.Length > info.IntegerDigits && len < sb_int.Length) {
 					if (sb_int [len] == '0')
@@ -690,16 +775,16 @@
 						break;
 				}
 				sb_int.Remove (0, len);
-			}
-					
-			sb_dec.Append (ns.GetDecimalString (ns.DecimalDigits));
+			} */
 
+			ns.AppendDecimalString (ns.DecimalDigits, sb_dec);
+
 			if (info.UseExponent) {
 				if (info.DecimalDigits <= 0 && info.IntegerDigits <= 0)
 					ns.Positive = true;
 
-				if (sb_int.Length < info.IntegerDigits)
-					sb_int.Insert (0, "0", info.IntegerDigits - sb_int.Length);
+				/*if (sb_int.Length < info.IntegerDigits)
+					sb_int.Insert (0, "0", info.IntegerDigits - sb_int.Length);*/
 
 				while (sb_exp.Length < info.ExponentDigits - info.ExponentTailSharpDigits)
 					sb_exp.Insert (0, "0");
@@ -721,7 +806,7 @@
 			if (sb_dec.Length > info.DecimalDigits)
 				sb_dec.Remove (info.DecimalDigits, sb_dec.Length - info.DecimalDigits);
 
-			return info.Format (format, nfi, ns.Positive, sb_int.ToString (), sb_dec.ToString (), sb_exp.ToString ());
+			return info.Format (format, offset, length, nfi, ns.Positive, sb_int, sb_dec, sb_exp);
 		}
 
 		private class CustomInfo
@@ -741,7 +826,7 @@
 			public int Percents = 0;
 			public int Permilles = 0;
 
-			public static string GetActiveSection (string format, ref bool positive, bool zero)
+			public static void GetActiveSection (string format, ref bool positive, bool zero, ref int offset, ref int length)
 			{
 				int[] lens = new int [3];
 				int index = 0;
@@ -766,44 +851,77 @@
 					}
 				}
 
-				if (index == 0)
-					return format;
+				if (index == 0) {
+					offset = 0;
+					length = format.Length;
+					return;
+				}
 				if (index == 1) {
-					if (positive || zero)
-						return format.Substring (0, lens [0]);
+					if (positive || zero) {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 					if (lens [0] + 1 < format.Length) {
 						positive = true;
-						return format.Substring (lens [0] + 1);
-					} else
-						return format.Substring (0, lens [0]);
+						offset = lens [0] + 1;
+						length = format.Length - offset;
+						return;
+					} else {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 				}
 				if (index == 2) {
-					if (zero)
-						return format.Substring (lens [0] + lens [1] + 2);
-					if (positive)
-						return format.Substring (0, lens [0]);
+					if (zero) {
+						offset = lens [0] + lens [1] + 2;
+						length = format.Length - offset;
+						return;
+					}
+					if (positive) {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 					if (lens [1] > 0) {
 						positive = true;
-						return format.Substring (lens [0] + 1, lens [1]);
-					} else
-						return format.Substring (0, lens [0]);
+						offset = lens [0] + 1;
+						length = lens [1];
+						return;
+					} else {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 				}
 				if (index == 3) {
-					if (zero)
-						return format.Substring (lens [0] + lens [1] + 2, lens [2]);
-					if (positive)
-						return format.Substring (0, lens [0]);
+					if (zero) {
+						offset = lens [0] + lens [1] + 2;
+						length = lens [2];
+						return;
+					}
+					if (positive) {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 					if (lens [1] > 0) {
 						positive = true;
-						return format.Substring (lens [0] + 1, lens [1]);
-					} else
-						return format.Substring (0, lens [0]);
+						offset = lens [0] + 1;
+						length = lens [1];
+						return;
+					} else {
+						offset = 0;
+						length = lens [0];
+						return;
+					}
 				}
 
 				throw new ArgumentException ();
 			}
 
-			public static CustomInfo Parse (string format, NumberFormatInfo nfi)
+			public static CustomInfo Parse (string format, int offset, int length, NumberFormatInfo nfi)
 			{
 				char literal = '\0';
 				bool integerArea = true;
@@ -814,7 +932,7 @@
 				CustomInfo info = new CustomInfo ();
 				int groupSeparatorCounter = 0;
 
-				for (int i = 0; i < format.Length; i++) {
+				for (int i = offset; i - offset < length; i++) {
 					char c = format [i];
 
 					if (c == literal && c != '\0') {
@@ -882,7 +1000,7 @@
 						integerArea = false;
 						decimalArea = false;
 						exponentArea = true;
-						if (i + 1 < format.Length) {
+						if (i + 1 - offset < length) {
 							char nc = format [i + 1];
 							if (nc == '+')
 								info.ExponentNegativeSignOnly = false;
@@ -932,7 +1050,7 @@
 				return info;
 			}
 
-			public string Format (string format, NumberFormatInfo nfi, bool positive, string sb_int, string sb_dec, string sb_exp)
+			public string Format (string format, int offset, int length, NumberFormatInfo nfi, bool positive, StringBuilder sb_int, StringBuilder sb_dec, StringBuilder sb_exp)
 			{
 				StringBuilder sb = new StringBuilder ();
 				char literal = '\0';
@@ -942,12 +1060,39 @@
 				int sb_int_index = 0;
 				int sb_dec_index = 0;
 
-				int[] groups = GetFormattedGroupSizes (sb_int.Length, nfi);
-				int groupIndex = 0;
-				int groupSize = (groups.Length > 0 ? groups [groupIndex++] : -1);
-				int int_counter = 0;
+				int[] groups = nfi.NumberGroupSizes;
+				string groupSeparator = nfi.NumberGroupSeparator;
+				int intLen = 0, total = 0, groupIndex = 0, counter = 0, groupSize = 0, fraction = 0;
+				if (UseGroup && groups.Length > 0) {
+					intLen = sb_int.Length;
+					for (int i = 0; i < groups.Length; i++) {
+						total += groups [i];
+						if (total <= intLen)
+							groupIndex = i;
+					}
+					groupSize = groups [groupIndex];
+					fraction = intLen > total ? intLen - total : 0;
+					if (groupSize == 0) {
+						while (groupIndex >= 0 && groups [groupIndex] == 0)
+							groupIndex --;
+						
+						groupSize = fraction > 0 ? fraction : groups [groupIndex];
+					}
+					if (fraction == 0) {
+						counter = groupSize;
+					} else {
+						groupIndex += fraction / groupSize;
+						counter = fraction % groupSize;
+						if (counter == 0)
+							counter = groupSize;
+						else
+							groupIndex ++;
+					}
+				} else {
+					UseGroup = false;
+				}
 
-				for (int i = 0; i < format.Length; i++) {
+				for (int i = offset; i - offset < length; i++) {
 					char c = format [i];
 
 					if (c == literal && c != '\0') {
@@ -962,7 +1107,7 @@
 					switch (c) {
 					case '\\':
 						i ++;
-						if (i < format.Length)
+						if (i - offset < length)
 							sb.Append (format [i]);
 						continue;
 					case '\'':
@@ -979,11 +1124,11 @@
 							if (IntegerDigits - intSharpCounter < sb_int.Length + sb_int_index || c == '0')
 								while (IntegerDigits - intSharpCounter + sb_int_index < sb_int.Length) {
 									sb.Append (sb_int[ sb_int_index++]);
-									int_counter ++;
-									if (UseGroup && groupSize > 0 && int_counter % groupSize == 0 && sb_int_index < sb_int.Length) {
-										sb.Append (nfi.NumberGroupSeparator);
-										groupSize = (groupIndex < groups.Length ? groups [groupIndex++] : groupSize);
-										int_counter = 0;
+									if (UseGroup && --intLen > 0 && --counter == 0) {
+										sb.Append (groupSeparator);
+										if (--groupIndex < groups.Length && groupIndex >= 0)
+											groupSize = groups [groupIndex];
+										counter = groupSize;
 									}
 								}
 							break;
@@ -1006,7 +1151,7 @@
 						bool flag2 = false;
 						
 						int q;
-						for (q = i + 1; q < format.Length; q++) {
+						for (q = i + 1; q - offset < length; q++) {
 							if (format [q] == '0') {
 								flag2 = true;
 								continue;
@@ -1062,131 +1207,538 @@
 
 				return sb.ToString ();
 			}
-			private int[] GetFormattedGroupSizes (int intLen, NumberFormatInfo nfi)
+		}
+
+		#endregion
+
+		#region Internal Class
+		internal class NumberStore
+		{
+			bool _NaN;
+			bool _infinity;
+			bool _positive;
+			int  _decPointPos;
+			int  _defPrecision;
+			int  _defMaxPrecision;
+			int  _defByteSize;
+
+			byte[] _digits;
+
+			static uint [] IntList = new uint [] {
+				1,
+				10,
+				100,
+				1000,
+				10000,
+				100000,
+				1000000,
+				10000000,
+				100000000,
+				1000000000,
+			};
+
+			static ulong [] ULongList = new ulong [] {
+				1,
+				10,
+				100,
+				1000,
+				10000,
+				100000,
+				1000000,
+				10000000,
+				100000000,
+				1000000000,
+				10000000000,
+				100000000000,
+				1000000000000,
+				10000000000000,
+				100000000000000,
+				1000000000000000,
+				10000000000000000,
+				100000000000000000,
+				1000000000000000000,
+				10000000000000000000,
+			};
+
+			#region Constructors
+			NumberStore (){}
+			public NumberStore (long value)
 			{
-				int[] sizes = new int [intLen];
+				_defByteSize = 8;
+				_defMaxPrecision = _defPrecision = 19;
+				_positive = value >= 0;
 
-				int index = 0;
-				int counter = 0;
-				int[] groups = nfi.NumberGroupSizes;
-				int groupIndex = 0;
-				int groupSize = (groups.Length > 0 ? groups [groupIndex++] : 0);
-				for (int i = 0; i < intLen; i++) {
-					counter ++;
-					if (groupSize > 0 && counter % groupSize == 0) {
-						sizes [index++] = groupSize;
-						groupSize = (groupIndex < groups.Length ? groups [groupIndex++] : groupSize);
-						counter = 0;
-					}
+				if (value == 0) {
+					_digits = new byte []{0};
+					_decPointPos = 1;
+					return;
 				}
+				
+				ulong v = (ulong)(_positive ? value : -value);
 
-				if (counter > 0) {
-					sizes [index++] = counter;
-				}
+				int i = 18, j = 0;
 
-				int[] temp = new int[index];
-				Array.Copy (sizes, 0, temp, 0, index);
-				Array.Reverse (temp);
+				if (v >= 1000000000000000000)
+					i = 18;
+				else if (v >= 100000000000000000)
+					i = 17;
+				else if (v >= 10000000000000000)
+					i = 16;
+				else if (v >= 1000000000000000)
+					i = 15;
+				else if (v >= 100000000000000)
+					i = 14;
+				else if (v >= 10000000000000)
+					i = 13;
+				else if (v >= 1000000000000)
+					i = 12;
+				else if (v >= 100000000000)
+					i = 11;
+				else if (v >= 10000000000)
+					i = 10;
+				else if (v >= 1000000000)
+					i = 9;
+				else if (v >= 100000000)
+					i = 8;
+				else if (v >= 10000000)
+					i = 7;
+				else if (v >= 1000000)
+					i = 6;
+				else if (v >= 100000)
+					i = 5;
+				else if (v >= 10000)
+					i = 4;
+				else if (v >= 1000)
+					i = 3;
+				else if (v >= 100)
+					i = 2;
+				else if (v >= 10)
+					i = 1;
+				else
+					i = 0;
 
-				return temp;
+				_digits = new byte [i + 1];
+				do {
+					ulong n = v / ULongList [i];
+					_digits [j++] = (byte)n;
+					v -= ULongList [i--] * n;
+				} while (i >= 0);
+
+				_decPointPos = _digits.Length;
 			}
-		}
+			public NumberStore (int value)
+			{
+				_defByteSize = 4;
+				_defMaxPrecision = _defPrecision = 10;
+				_positive = value >= 0;
 
-		#endregion
+				if (value == 0) {
+					_digits = new byte []{0};
+					_decPointPos = 1;
+					return;
+				}
+				
+				uint v = (uint)(_positive ? value : -value);
 
-		#region Internal Class
-		internal class NumberStore
-		{
-			protected bool _NaN;
-			protected bool _infinity;
-			protected bool _positive;
-			protected int  _decPointPos;
-			protected int  _defPrecision;
-			protected int  _defMaxPrecision;
-			protected int  _defByteSize;
+				int i = 9, j = 0;
 
-			protected byte[] _digits;
+				if (v >= 1000000000)
+					i = 9;
+				else if (v >= 100000000)
+					i = 8;
+				else if (v >= 10000000)
+					i = 7;
+				else if (v >= 1000000)
+					i = 6;
+				else if (v >= 100000)
+					i = 5;
+				else if (v >= 10000)
+					i = 4;
+				else if (v >= 1000)
+					i = 3;
+				else if (v >= 100)
+					i = 2;
+				else if (v >= 10)
+					i = 1;
+				else
+					i = 0;
 
-			#region Create
-			public static DoubleStore CreateInstance (double value)
-			{
-				return new DoubleStore (value);
+				_digits = new byte [i + 1];
+				do {
+					uint n = v / IntList [i];
+					_digits [j++] = (byte)n;
+					v -= IntList [i--] * n;
+				} while (i >= 0);
+
+				_decPointPos = _digits.Length;
 			}
-			public static SingleStore CreateInstance (float value)
+			public NumberStore (short value) : this ((int)value)
 			{
-				return new SingleStore (value);
+				_defByteSize = 2;
+				_defMaxPrecision = _defPrecision = 5;
 			}
-			public static IntegerStore CreateInstance (long value)
+			public NumberStore (sbyte value) : this ((int)value)
 			{
-				return new IntegerStore (value);
+				_defByteSize = 1;
+				_defMaxPrecision = _defPrecision = 3;
 			}
-			public static IntegerStore CreateInstance (ulong value)
+
+			public NumberStore (ulong value)
 			{
-				return new IntegerStore (value);
+				_defByteSize = 8;
+				_defMaxPrecision = _defPrecision = 20;
+				_positive = true;
+
+				if (value == 0) {
+					_digits = new byte []{0};
+					_decPointPos = 1;
+					return;
+				}
+
+				int i = 19, j = 0;
+
+				if (value >= 10000000000000000000)
+					i = 19;
+				else if (value >= 1000000000000000000)
+					i = 18;
+				else if (value >= 100000000000000000)
+					i = 17;
+				else if (value >= 10000000000000000)
+					i = 16;
+				else if (value >= 1000000000000000)
+					i = 15;
+				else if (value >= 100000000000000)
+					i = 14;
+				else if (value >= 10000000000000)
+					i = 13;
+				else if (value >= 1000000000000)
+					i = 12;
+				else if (value >= 100000000000)
+					i = 11;
+				else if (value >= 10000000000)
+					i = 10;
+				else if (value >= 1000000000)
+					i = 9;
+				else if (value >= 100000000)
+					i = 8;
+				else if (value >= 10000000)
+					i = 7;
+				else if (value >= 1000000)
+					i = 6;
+				else if (value >= 100000)
+					i = 5;
+				else if (value >= 10000)
+					i = 4;
+				else if (value >= 1000)
+					i = 3;
+				else if (value >= 100)
+					i = 2;
+				else if (value >= 10)
+					i = 1;
+				else
+					i = 0;
+
+				_digits = new byte [i + 1];
+				do {
+					ulong n = value / ULongList [i];
+					_digits [j++] = (byte)n;
+					value -= ULongList [i--] * n;
+				} while (i >= 0);
+
+				_decPointPos = _digits.Length;
 			}
-			public static IntegerStore CreateInstance (int value)
+			public NumberStore (uint value)
 			{
-				return new IntegerStore (value);
+				_positive = true;
+				_defByteSize = 4;
+				_defMaxPrecision = _defPrecision = 10;
+
+				if (value == 0) {
+					_digits = new byte []{0};
+					_decPointPos = 1;
+					return;
+				}
+				
+				int i = 9, j = 0;
+
+				if (value >= 1000000000)
+					i = 9;
+				else if (value >= 100000000)
+					i = 8;
+				else if (value >= 10000000)
+					i = 7;
+				else if (value >= 1000000)
+					i = 6;
+				else if (value >= 100000)
+					i = 5;
+				else if (value >= 10000)
+					i = 4;
+				else if (value >= 1000)
+					i = 3;
+				else if (value >= 100)
+					i = 2;
+				else if (value >= 10)
+					i = 1;
+				else
+					i = 0;
+
+				_digits = new byte [i + 1];
+				do {
+					uint n = value / IntList [i];
+					_digits [j++] = (byte)n;
+					value -= IntList [i--] * n;
+				} while (i >= 0);
+
+				_decPointPos = _digits.Length;
 			}
-			public static IntegerStore CreateInstance (uint value)
+			public NumberStore (ushort value) : this ((uint)value)
 			{
-				return new IntegerStore (value);
+				_defByteSize = 2;
+				_defMaxPrecision = _defPrecision = 5;
 			}
-			public static IntegerStore CreateInstance (short value)
+			public NumberStore (byte value) : this ((uint)value)
 			{
-				return new IntegerStore (value);
+				_defByteSize = 1;
+				_defMaxPrecision = _defPrecision = 3;
 			}
-			public static IntegerStore CreateInstance (ushort value)
+
+			public NumberStore(double value)
 			{
-				return new IntegerStore (value);
+				_defPrecision = 15;
+				_defMaxPrecision = _defPrecision + 2;
+
+				if (double.IsNaN (value) || double.IsInfinity (value)) {
+					_NaN = double.IsNaN (value);
+					_infinity = double.IsInfinity (value);
+					_positive = value > 0;
+					return;
+				}
+
+				long bits = BitConverter.DoubleToInt64Bits (value);
+				_positive = (bits >= 0);
+				int e = (int) ((bits >> 52) & 0x7ffL);
+				long m = bits & 0xfffffffffffffL;
+
+				if (e == 0 && m == 0) {
+					_decPointPos = 1;
+					_digits = new byte []{0};
+					_positive = true;
+					return;
+				}
+
+				if (e == 0) {
+					e ++;
+				} else if (e != 0) {
+					m |= (1L << 52);
+				}
+
+				e -= 1075;
+
+				int nsize = 0;
+				while ((m & 1) == 0) {
+					m >>= 1;
+					e ++;
+					nsize ++;
+				}
+
+				long mt = m;
+				int length = 1;
+				byte[] temp = new byte [56];
+				for (int i = temp.Length - 1; i >= 0; i--, length++) {
+					temp [i] = (byte)(mt % 10);
+					mt /= 10;
+					if (mt == 0)
+						break;
+				}
+
+				_decPointPos = temp.Length - 1;
+
+				if (e >= 0) {
+					for (int i = 0; i < e; i++) {
+						if (MultiplyBy (ref temp, ref length, 2)) {
+							_decPointPos ++;
+						}
+					}
+				} else {
+					for (int i = 0; i < -e; i++) {
+						if (MultiplyBy (ref temp, ref length, 5)) {
+							_decPointPos ++;
+						}
+					}
+					_decPointPos += e;
+				}
+
+				int ulvc = 1;
+				ulong ulv = 0;
+				for (int i = 0; i < temp.Length; i++)
+					if (temp [i] != 0) {
+						_decPointPos -= i - 1;
+						_digits = new byte [temp.Length - i];
+						for (int q = i; q < temp.Length; q++) {
+							_digits [q - i] = temp [q];
+							if (ulvc < 20) {
+								ulv = ulv * 10 + temp [q];
+								ulvc ++;
+							}
+						}
+						break;
+					}
+
+				RoundEffectiveDigits (17, true, true);
 			}
-			public static IntegerStore CreateInstance (byte value)
+			public NumberStore(float value)
 			{
-				return new IntegerStore (value);
+				_defPrecision = 7;
+				_defMaxPrecision = _defPrecision + 2;
+
+				if (float.IsNaN (value) || float.IsInfinity (value)) {
+					_NaN = float.IsNaN (value);
+					_infinity = float.IsInfinity (value);
+					_positive = value > 0;
+					return;
+				}
+
+				long bits = BitConverter.DoubleToInt64Bits (value);
+				_positive = (bits >= 0);
+				int e = (int) ((bits >> 52) & 0x7ffL);
+				long m = bits & 0xfffffffffffffL;
+
+				if (e == 0 && m == 0) {
+					_decPointPos = 1;
+					_digits = new byte []{0};
+					_positive = true;
+					return;
+				}
+
+				if (e == 0) {
+					e ++;
+				} else if (e != 0) {
+					m |= (1L << 52);
+				}
+
+				e -= 1075;
+
+				int nsize = 0;
+				while ((m & 1) == 0) {
+					m >>= 1;
+					e ++;
+					nsize ++;
+				}
+
+				long mt = m;
+				int length = 1;
+				byte[] temp = new byte [26];
+				for (int i = temp.Length - 1; i >= 0; i--, length++) {
+					temp [i] = (byte)(mt % 10);
+					mt /= 10;
+					if (mt == 0)
+						break;
+				}
+
+				_decPointPos = temp.Length - 1;
+
+				if (e >= 0) {
+					for (int i = 0; i < e; i++) {
+						if (MultiplyBy (ref temp, ref length, 2)) {
+							_decPointPos ++;
+						}
+					}
+				} else {
+					for (int i = 0; i < -e; i++) {
+						if (MultiplyBy (ref temp, ref length, 5)) {
+							_decPointPos ++;
+						}
+					}
+					_decPointPos += e;
+				}
+
+				int ulvc = 1;
+				ulong ulv = 0;
+				for (int i = 0; i < temp.Length; i++)
+					if (temp [i] != 0) {
+						_decPointPos -= i - 1;
+						_digits = new byte [temp.Length - i];
+						for (int q = i; q < temp.Length; q++) {
+							_digits [q - i] = temp [q];
+							if (ulvc < 20) {
+								ulv = ulv * 10 + temp [q];
+								ulvc ++;
+							}
+						}
+						break;
+					}
+
+				RoundEffectiveDigits (9, true, true);
 			}
-			public static IntegerStore CreateInstance (sbyte value)
+
+			internal bool MultiplyBy (ref byte[] buffer,ref int length, int amount)
 			{
-				return new IntegerStore (value);
+				int mod = 0;
+				int ret;
+				int start = buffer.Length - length - 1;
+				if (start < 0) start = 0;
+
+				for (int i = buffer.Length - 1; i > start; i--) {
+					ret = buffer [i] * amount + mod;
+					mod = ret / 10;
+					buffer [i] = (byte)(ret % 10);
+				}
+
+				if (mod != 0) {
+					length = buffer.Length - start;
+
+					if (start == 0) {
+						buffer [0] = (byte)mod;
+						Array.Copy (buffer, 0, buffer, 1, buffer.Length - 1);
+						buffer [0] = 0;
+						return true;
+					}
+					else {
+						buffer [start] = (byte)mod;
+					}
+				}
+
+				return false;
 			}
 			#endregion
 
 			#region Public Property
-			public virtual bool IsNaN 
+			public bool IsNaN 
 			{
 				get { return _NaN; }
 			}
-			public virtual bool IsInfinity {
+			public bool IsInfinity {
 				get { return _infinity; }
 			}
-			public virtual int DecimalPointPosition {
+			public int DecimalPointPosition {
 				get { return _decPointPos; }
 			}
-			public virtual bool Positive {
+			public bool Positive {
 				get { return _positive; }
 				set { _positive = value;}
 			}
-			public virtual int DefaultPrecision {
+			public int DefaultPrecision {
 				get { return _defPrecision; }
 			}
-			public virtual int DefaultMaxPrecision {
+			public int DefaultMaxPrecision {
 				get { return _defMaxPrecision; }
 			}
-			public virtual int DefaultByteSize {
+			public int DefaultByteSize {
 				get { return _defByteSize; }
 			}
-			public virtual bool HasDecimal {
+			public bool HasDecimal {
 				get { return _digits.Length > _decPointPos; }
 			}
-			public virtual int IntegerDigits {
+			public int IntegerDigits {
 				get { return _decPointPos > 0 ? _decPointPos : 1; }
 			}
-			public virtual int DecimalDigits {
+			public int DecimalDigits {
 				get { return HasDecimal ? _digits.Length - _decPointPos : 0; }
 			}
-			public virtual bool IsFloatingSource {
+			public bool IsFloatingSource {
 				get { return _defPrecision == 15 || _defPrecision == 7; }
 			}
-			public virtual bool ZeroOnly {
+			public bool ZeroOnly {
 				get {
 					for (int i = 0; i < _digits.Length; i++)
 						if (_digits [i] != 0)
@@ -1197,11 +1749,13 @@
 			#endregion
 
 			#region Public Method
-			public virtual bool RoundPos (int pos)
+
+			#region Round
+			public bool RoundPos (int pos)
 			{
 				return RoundPos (pos, true);
 			}
-			public virtual bool RoundPos (int pos, bool carryFive)
+			public bool RoundPos (int pos, bool carryFive)
 			{
 				bool carry = false;
 
@@ -1240,11 +1794,11 @@
 
 				return carry;
 			}
-			public virtual bool RoundDecimal (int decimals)
+			public bool RoundDecimal (int decimals)
 			{
 				return RoundDecimal (decimals, true);
 			}
-			public virtual bool RoundDecimal (int decimals, bool carryFive)
+			public bool RoundDecimal (int decimals, bool carryFive)
 			{
 				bool carry = false;
 
@@ -1282,7 +1836,7 @@
 
 				return carry;
 			}
-			protected virtual void RoundHelper (int index, bool carryFive, ref bool carry)
+			protected void RoundHelper (int index, bool carryFive, ref bool carry)
 			{
 				if (carry) {
 					if (_digits [index] == 9) {
@@ -1296,11 +1850,11 @@
 					carry = true;
 				}
 			}
-			public virtual bool RoundEffectiveDigits (int digits)
+			public bool RoundEffectiveDigits (int digits)
 			{
 				return RoundEffectiveDigits (digits, true, true);
 			}
-			public virtual bool RoundEffectiveDigits (int digits, bool carryFive, bool carryEven)
+			public bool RoundEffectiveDigits (int digits, bool carryFive, bool carryEven)
 			{
 				bool carry = false;
 
@@ -1331,7 +1885,10 @@
 
 				return carry;
 			}
-			public virtual void TrimDecimalEndZeros ()
+			#endregion
+
+			#region Trim
+			public void TrimDecimalEndZeros ()
 			{
 				int len = 0;
 				for (int i = _digits.Length - 1; i >= 0; i --) {
@@ -1346,7 +1903,7 @@
 					_digits = temp;
 				}
 			}
-			public virtual void TrimIntegerStartZeros ()
+			public void TrimIntegerStartZeros ()
 			{
 				if (_decPointPos < 0 && _decPointPos >= _digits.Length)
 					return;
@@ -1374,24 +1931,96 @@
 				}
 			}
 
-			public virtual string GetIntegerString (int minLength)
+			#endregion
+
+			#region Integer
+			public void AppendIntegerString (int minLength, StringBuilder cb)
 			{
-				if (IntegerDigits == 0)
-					return new string ('0', minLength);
+				if (IntegerDigits == 0) {
+					cb.Append ('0', minLength);
+					return;
+				}
+				if (_decPointPos <= 0) {
+					cb.Append ('0', minLength);
+					return;
+				}
 
-				StringBuilder sb = new StringBuilder (IntegerDigits > minLength ? IntegerDigits : minLength);
+				if (_decPointPos < minLength)
+					cb.Append ('0', minLength - _decPointPos);
+
 				for (int i = 0; i < _decPointPos; i++) {
 					if (i < _digits.Length)
-						sb.Append ((char)('0' + _digits [i]));
+						cb.Append ((char)('0' + _digits [i]));
 					else
-						sb.Append ('0');
+						cb.Append ('0');
 				}
-				if (sb.Length < minLength)
-					sb.Insert (0, "0", minLength - sb.Length);
-				return sb.ToString ();
 			}
-			public virtual string GetDecimalString (int precision)
+			public void AppendIntegerStringWithGroupSeparator (StringBuilder sb, int[] groups, string groupSeparator)
 			{
+				if (_decPointPos <= 0) {
+					sb.Append ('0');
+					return;
+				}
+
+				int intLen = IntegerDigits;
+				int total = 0;
+				int groupIndex = 0;
+				for (int i = 0; i < groups.Length; i++) {
+					total += groups [i];
+					if (total <= intLen)
+						groupIndex = i;
+				}
+
+				if (groups.Length > 0 && total > 0) {
+					int counter;
+					int groupSize = groups [groupIndex];
+					int fraction = intLen > total ? intLen - total : 0;
+					if (groupSize == 0) {
+						while (groupIndex >= 0 && groups [groupIndex] == 0)
+							groupIndex --;
+						
+						groupSize = fraction > 0 ? fraction : groups [groupIndex];
+					}
+					if (fraction == 0) {
+						counter = groupSize;
+					} else {
+						groupIndex += fraction / groupSize;
+						counter = fraction % groupSize;
+						if (counter == 0)
+							counter = groupSize;
+						else
+							groupIndex ++;
+					}
+					
+					for (int i = 0; i < _decPointPos; i++) {
+						if (i < _digits.Length) {
+							sb.Append ((char)('0' + _digits [i]));
+						} else {
+							sb.Append ('0');
+						}
+
+						if (i < intLen - 1 && --counter == 0) {
+							sb.Append (groupSeparator);
+							if (--groupIndex < groups.Length && groupIndex >= 0)
+								groupSize = groups [groupIndex];
+							counter = groupSize;
+						}
+					}
+				} else {
+					for (int i = 0; i < _decPointPos; i++) {
+						if (i < _digits.Length) {
+							sb.Append ((char)('0' + _digits [i]));
+						} else {
+							sb.Append ('0');
+						}
+					}
+				}
+			}
+			#endregion
+
+			#region Decimal
+			public string GetDecimalString (int precision)
+			{
 				if (!HasDecimal)
 					return new string ('0', precision);
 
@@ -1408,8 +2037,39 @@
 					sb.Remove (0, precision);
 				return sb.ToString ();
 			}
-			public virtual void Multiply10 (int count)
+
+			public void AppendDecimalString (int precision, StringBuilder cb)
 			{
+				if (!HasDecimal) {
+					cb.Append ('0', precision);
+					return;
+				}
+
+				int i = _decPointPos;
+				for (; i < _digits.Length && i < precision + _decPointPos; i++) {
+					if (i >= 0)
+						cb.Append ((char)('0' + _digits [i]));
+					else
+						cb.Append ('0');
+				}
+
+				i -= _decPointPos;
+				if (i < precision)
+					cb.Append ('0', precision - i);
+			}
+			#endregion
+
+			#region others
+			public bool CheckZeroOnlyInteger ()
+			{
+				for (int i = 0; i < _decPointPos && i < _digits.Length; i++) {
+					if (_digits [i] != 0)
+						return false;
+				}
+				return true;
+			}
+			public void Multiply10 (int count)
+			{
 				if (count <= 0)
 					return;
 
@@ -1417,7 +2077,7 @@
 
 				TrimIntegerStartZeros ();
 			}
-			public virtual void Divide10 (int count)
+			public void Divide10 (int count)
 			{
 				if (count <= 0)
 					return;
@@ -1427,14 +2087,14 @@
 			public override string ToString()
 			{
 				StringBuilder sb = new StringBuilder ();
-				sb.Append (GetIntegerString (IntegerDigits));
+				AppendIntegerString (IntegerDigits, sb);
 				if (HasDecimal) {
 					sb.Append (".");
-					sb.Append (GetDecimalString (DecimalDigits));
+					AppendDecimalString (DecimalDigits, sb);
 				}
 				return sb.ToString ();
 			}
-			public virtual char GetChar (int pos)
+			public char GetChar (int pos)
 			{
 				if (_decPointPos <= 0)
 					pos += _decPointPos - 1;
@@ -1444,8 +2104,18 @@
 				else
 					return (char)('0' + _digits [pos]);
 			}
-			public virtual NumberStore GetClone ()
+			public byte GetDigitByte (int pos)
 			{
+				if (_decPointPos <= 0)
+					pos += _decPointPos - 1;
+				
+				if (pos < 0 || pos >= _digits.Length)
+					return 0;
+				else
+					return _digits [pos];
+			}
+			public NumberStore GetClone ()
+			{
 				NumberStore ns = new NumberStore ();
 
 				ns._decPointPos = this._decPointPos;
@@ -1458,8 +2128,18 @@
 
 				return ns;
 			}
+			public int GetDecimalPointPos ()
+			{
+				return _decPointPos;
+			}
+			public void SetDecimalPointPos (int dp)
+			{
+				_decPointPos = dp;
+			}
 			#endregion
 
+			#endregion
+
 			#region Public Static Method
 			public static bool IsZeroOnly (StringBuilder sb)
 			{
@@ -1468,410 +2148,101 @@
 						return false;
 				return true;
 			}
+			public static void AppendIntegerStringFromUInt32 (StringBuilder sb, uint v)
+			{
+				if (v < 0)
+					throw new ArgumentException ();
+
+				int i = 9;
+
+				if (v >= 1000000000)
+					i = 9;
+				else if (v >= 100000000)
+					i = 8;
+				else if (v >= 10000000)
+					i = 7;
+				else if (v >= 1000000)
+					i = 6;
+				else if (v >= 100000)
+					i = 5;
+				else if (v >= 10000)
+					i = 4;
+				else if (v >= 1000)
+					i = 3;
+				else if (v >= 100)
+					i = 2;
+				else if (v >= 10)
+					i = 1;
+				else
+					i = 0;
+				do {
+					uint n = v / IntList [i];
+					sb.Append (NumberFormatter.digitLowerTable [n]);
+					v -= IntList [i--] * n;
+				} while (i >= 0);
+			}
 			#endregion
 		}
-
-		internal class IntegerStore : NumberStore
+		internal class CharBuffer
 		{
-			public IntegerStore (long value)
-			{
-				_positive = value >= 0;
-				ulong v = (ulong)(_positive ? value : -value);
+			int offset;
+			char[] buffer;
 
-				byte[] temp = new byte [30];
-				int i = temp.Length - 1;
-
-				while (v > 0) {
-					temp [i--] = (byte)(v % 10);
-					v /= 10;
-				}
-
-				if (temp.Length - i - 1 > 0) {
-					_digits = new byte [temp.Length - i - 1];
-					Array.Copy (temp, i + 1, _digits, 0, _digits.Length);
-				} else {
-					_digits = new byte [1];
-				}
-
-				_defByteSize = 8;
-				_defMaxPrecision = _defPrecision = 19;
-				_decPointPos = _digits.Length;
-			}
-			public IntegerStore (int value) : this ((long)value)
+			public CharBuffer (int capacity)
 			{
-				_defByteSize = 4;
-				_defMaxPrecision = _defPrecision = 10;
+				buffer = new char [capacity];
+				offset = capacity;
 			}
-			public IntegerStore (short value) : this ((long)value)
+
+			void AllocateBuffer (int size)
 			{
-				_defByteSize = 2;
-				_defMaxPrecision = _defPrecision = 5;
+				size = size > buffer.Length * 2 ? size : buffer.Length * 2;
+				char[] newBuffer = new char [size];
+				offset += size - buffer.Length;
+				Array.Copy (buffer, 0, newBuffer, size - buffer.Length, buffer.Length);
+				buffer = newBuffer;
 			}
-			public IntegerStore (sbyte value) : this ((long)value)
-			{
-				_defByteSize = 1;
-				_defMaxPrecision = _defPrecision = 3;
-			}
 
-			public IntegerStore (ulong value)
+			void CheckInsert (int length)
 			{
-				_positive = true;
-
-				byte[] temp = new byte [30];
-				int i = temp.Length - 1;
-
-				while (value > 0) {
-					temp [i--] = (byte)(value % 10);
-					value /= 10;
+				if (offset - length < 0) {
+					AllocateBuffer (buffer.Length + length - offset);
 				}
+			}
 
-				if (temp.Length - i - 1 > 0) {
-					_digits = new byte [temp.Length - i - 1];
-					Array.Copy (temp, i + 1, _digits, 0, _digits.Length);
-				} else {
-					_digits = new byte [1];
-				}
-
-				_defByteSize = 8;
-				_defMaxPrecision = _defPrecision = 20;
-				_decPointPos = _digits.Length;
-			}
-			public IntegerStore (uint value) : this ((ulong)value)
+			public void InsertToFront (char c)
 			{
-				_defByteSize = 4;
-				_defMaxPrecision = _defPrecision = 10;
+				CheckInsert (1);
+				buffer [--offset] = c;
 			}
-			public IntegerStore (ushort value) : this ((ulong)value)
+
+			public void InsertToFront (char c, int repeat)
 			{
-				_defByteSize = 2;
-				_defMaxPrecision = _defPrecision = 5;
-			}
-			public IntegerStore (byte value) : this ((ulong)value)
-			{
-				_defByteSize = 1;
-				_defMaxPrecision = _defPrecision = 3;
-			}
-		}
-		internal class DoubleStore : NumberStore
-		{
-			public DoubleStore(double value)
-			{
-				_defPrecision = 15;
-				_defMaxPrecision = _defPrecision + 2;
-
-				if (double.IsNaN (value) || double.IsInfinity (value)) {
-					_NaN = double.IsNaN (value);
-					_infinity = double.IsInfinity (value);
-					_positive = value > 0;
-					return;
+				CheckInsert (repeat);
+				while (repeat-- > 0) {
+					buffer [--offset] = c;
 				}
-
-				long bits = BitConverter.DoubleToInt64Bits (value);
-				_positive = (bits >= 0);
-				int e = (int) ((bits >> 52) & 0x7ffL);
-				long m = bits & 0xfffffffffffffL;
-
-				if (e == 0 && m == 0) {
-					_decPointPos = 1;
-					_digits = new byte []{0};
-					_positive = true;
-					return;
-				}
-
-				bool flag = true;
-				if (e == 0) {
-					flag = false;
-					e ++;
-				} else if (e != 0) {
-					m |= (1L << 52);
-				}
-
-				e -= 1075;
-
-				int nsize = 0;
-				while ((m & 1) == 0) {
-					m >>= 1;
-					e ++;
-					nsize ++;
-				}
-
-				long mt = m;
-				int length = 1;
-				byte[] temp = new byte [56];
-				for (int i = temp.Length - 1; i >= 0; i--, length++) {
-					temp [i] = (byte)(mt % 10);
-					mt /= 10;
-					if (mt == 0)
-						break;
-				}
-
-				_decPointPos = temp.Length - 1;
-
-				if (e >= 0) {
-					for (int i = 0; i < e; i++) {
-						if (MultiplyBy (ref temp, ref length, 2)) {
-							_decPointPos ++;
-						}
-					}
-				} else {
-					for (int i = 0; i < -e; i++) {
-						if (MultiplyBy (ref temp, ref length, 5)) {
-							_decPointPos ++;
-						}
-					}
-					_decPointPos += e;
-				}
-
-				int ulvc = 1;
-				ulong ulv = 0;
-				for (int i = 0; i < temp.Length; i++)
-					if (temp [i] != 0) {
-						_decPointPos -= i - 1;
-						_digits = new byte [temp.Length - i];
-						for (int q = i; q < temp.Length; q++) {
-							_digits [q - i] = temp [q];
-							if (ulvc < 20) {
-								ulv = ulv * 10 + temp [q];
-								ulvc ++;
-							}
-						}
-						break;
-					}
-
-				RoundEffectiveDigits (17, true, true);
 			}
 
-			internal bool MultiplyBy (ref byte[] buffer,ref int length, int amount)
+			public char this [int index] 
 			{
-				int mod = 0;
-				int ret;
-				int start = buffer.Length - length - 1;
-				if (start < 0) start = 0;
-
-				for (int i = buffer.Length - 1; i > start; i--) {
-					ret = buffer [i] * amount + mod;
-					mod = ret / 10;
-					buffer [i] = (byte)(ret % 10);
+				get {
+					return buffer [offset + index];
 				}
-
-				if (mod != 0) {
-					length = buffer.Length - start;
-
-					if (start == 0) {
-						buffer [0] = (byte)mod;
-						Array.Copy (buffer, 0, buffer, 1, buffer.Length - 1);
-						buffer [0] = 0;
-						return true;
-					}
-					else {
-						buffer [start] = (byte)mod;
-					}
-				}
-
-				return false;
 			}
-		}
 
-		internal class SingleStore : NumberStore
-		{
-			public SingleStore(float value)
+			public override string ToString()
 			{
-				_defPrecision = 7;
-				_defMaxPrecision = _defPrecision + 2;
-
-				if (float.IsNaN (value) || float.IsInfinity (value)) {
-					_NaN = float.IsNaN (value);
-					_infinity = float.IsInfinity (value);
-					_positive = value > 0;
-					return;
-				}
-
-				long bits = BitConverter.DoubleToInt64Bits (value);
-				_positive = (bits >= 0);
-				int e = (int) ((bits >> 52) & 0x7ffL);
-				long m = bits & 0xfffffffffffffL;
-
-				if (e == 0 && m == 0) {
-					_decPointPos = 1;
-					_digits = new byte []{0};
-					_positive = true;
-					return;
-				}
-
-				if (e == 0) {
-					e ++;
-				} else if (e != 0) {
-					m |= (1L << 52);
-				}
-
-				e -= 1075;
-
-				int nsize = 0;
-				while ((m & 1) == 0) {
-					m >>= 1;
-					e ++;
-					nsize ++;
-				}
-
-				long mt = m;
-				int length = 1;
-				byte[] temp = new byte [26];
-				for (int i = temp.Length - 1; i >= 0; i--, length++) {
-					temp [i] = (byte)(mt % 10);
-					mt /= 10;
-					if (mt == 0)
-						break;
-				}
-
-				_decPointPos = temp.Length - 1;
-
-				if (e >= 0) {
-					for (int i = 0; i < e; i++) {
-						if (MultiplyBy (ref temp, ref length, 2)) {
-							_decPointPos ++;
-						}
-					}
-				} else {
-					for (int i = 0; i < -e; i++) {
-						if (MultiplyBy (ref temp, ref length, 5)) {
-							_decPointPos ++;
-						}
-					}
-					_decPointPos += e;
-				}
-
-				int ulvc = 1;
-				ulong ulv = 0;
-				for (int i = 0; i < temp.Length; i++)
-					if (temp [i] != 0) {
-						_decPointPos -= i - 1;
-						_digits = new byte [temp.Length - i];
-						for (int q = i; q < temp.Length; q++) {
-							_digits [q - i] = temp [q];
-							if (ulvc < 20) {
-								ulv = ulv * 10 + temp [q];
-								ulvc ++;
-							}
-						}
-						break;
-					}
-
-				RoundEffectiveDigits (9, true, true);
+				if (offset == buffer.Length)
+					return "";
+				
+				return new string (buffer, offset, buffer.Length - offset);
 			}
-			internal bool MultiplyBy (ref byte[] buffer,ref int length, int amount)
-			{
-				int mod = 0;
-				int ret;
-				int start = buffer.Length - length - 1;
-				if (start < 0) start = 0;
 
-				for (int i = buffer.Length - 1; i > start; i--) {
-					ret = buffer [i] * amount + mod;
-					mod = ret / 10;
-					buffer [i] = (byte)(ret % 10);
-				}
-
-				if (mod != 0) {
-					length = buffer.Length - start;
-
-					if (start == 0) {
-						buffer [0] = (byte)mod;
-						Array.Copy (buffer, 0, buffer, 1, buffer.Length - 1);
-						buffer [0] = 0;
-						return true;
-					}
-					else {
-						buffer [start] = (byte)mod;
-					}
-				}
-
-				return false;
+			public int Length {
+				get { return buffer.Length - offset; }
 			}
 		}
-
 		#endregion
 	}
-
-	#region Wrapper
-	class IntegerFormatter
-	{
-		#region NumberToString
-		public static string NumberToString (string format, NumberFormatInfo nfi, short value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, int value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, long value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, sbyte value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, byte value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}		
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, ushort value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, uint value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public static string NumberToString (string format, NumberFormatInfo nfi, ulong value)
-		{
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-		#endregion
-
-		#region Wrapper
-		internal static string FormatDecimal (long value, int precision, int maxLength)
-		{
-			return NumberFormatter.FormatDecimal (NumberFormatter.NumberStore.CreateInstance (value), precision, System.Globalization.CultureInfo.CurrentCulture.NumberFormat);
-		}
-		internal static string FormatGeneral (long value, int precision, NumberFormatInfo nfi, bool upper) 
-		{
-			return NumberFormatter.FormatGeneral (NumberFormatter.NumberStore.CreateInstance (value), precision, System.Globalization.CultureInfo.CurrentCulture.NumberFormat, upper);
-		}
-		
-		internal static string FormatGeneral (long value, int precision, NumberFormatInfo nfi, bool upper, int maxLength) 
-		{
-			return NumberFormatter.FormatGeneral (NumberFormatter.NumberStore.CreateInstance (value), precision, System.Globalization.CultureInfo.CurrentCulture.NumberFormat, upper);
-		}
-		#endregion
-	}
-
-	class FloatingPointFormatter
-	{
-		public FloatingPointFormatter (double p, double p10, int dec_len, int dec_len_min, double p2, double p102, int dec_len2, int dec_len_min2)
-		{
-
-		}
-
-		public string GetStringFrom (string format, NumberFormatInfo nfi, float value)
-		{
-			if (nfi == null) nfi = CultureInfo.CurrentCulture.NumberFormat;
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-
-		public string GetStringFrom (string format, NumberFormatInfo nfi, double value)
-		{
-			if (nfi == null) nfi = CultureInfo.CurrentCulture.NumberFormat;
-			return NumberFormatter.NumberToString (format, value, nfi);
-		}
-	}
-	#endregion
 }
\ No newline at end of file
