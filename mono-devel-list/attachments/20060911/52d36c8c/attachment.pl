Index: class/corlib/System/ChangeLog
===================================================================
--- class/corlib/System/ChangeLog	(revision 65254)
+++ class/corlib/System/ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2006-09-11  Michael Schurter <michael@synthesyssolutions.com>
+
+	* Decimal.cs (TryParse) [NET_2_0]: Added TryParse methods.
+
 2006-09-05  Raja R Harinath  <rharinath@novell.com>
 
 	* DateTime.cs (Today) [NET_2_0]: Set kind to Local.
Index: class/corlib/System/Decimal.cs
===================================================================
--- class/corlib/System/Decimal.cs	(revision 65254)
+++ class/corlib/System/Decimal.cs	(working copy)
@@ -699,252 +699,295 @@
             return Parse(s, NumberStyles.Number, provider);
         }
 
-        private static string stripStyles(string s, NumberStyles style, NumberFormatInfo nfi, 
-            out int decPos, out bool isNegative, out bool expFlag, out int exp)
-        {
-            string invalidChar = Locale.GetText ("Invalid character at position ");
-            string invalidExponent = Locale.GetText ("Invalid exponent");
-            isNegative = false;
-            expFlag = false;
-            exp = 0;
-            decPos = -1;
+	public static Decimal Parse (string s, NumberStyles style, IFormatProvider provider) 
+	{
+		Exception exc;
+		decimal result;
+			
+		if (!Parse (s, style, provider, false, out result, out exc))
+			throw exc;
 
-            bool hasSign = false;
-            bool hasOpeningParentheses = false;
-            bool hasDecimalPoint = false;
-            bool allowedLeadingWhiteSpace = ((style & NumberStyles.AllowLeadingWhite) != 0);
-            bool allowedTrailingWhiteSpace = ((style & NumberStyles.AllowTrailingWhite) != 0);
-            bool allowedLeadingSign = ((style & NumberStyles.AllowLeadingSign) != 0);
-            bool allowedTrailingSign = ((style & NumberStyles.AllowTrailingSign) != 0);
-            bool allowedParentheses = ((style & NumberStyles.AllowParentheses) != 0);
-            bool allowedThousands = ((style & NumberStyles.AllowThousands) != 0);
-            bool allowedDecimalPoint = ((style & NumberStyles.AllowDecimalPoint) != 0);
-            bool allowedExponent = ((style & NumberStyles.AllowExponent) != 0);
+		return result;
+	}
 
-            /* get rid of currency symbol */
-            bool hasCurrency = false;
-            if ((style & NumberStyles.AllowCurrencySymbol) != 0)
+	internal static bool Parse (string s, NumberStyles style, IFormatProvider provider, bool tryParse, out decimal result, out Exception exc)
+	{
+		result = 0;
+		exc = null;
+
+		if (s == null) {
+			if (!tryParse)
+				throw new ArgumentNullException ("s");
+			return false;
+		}
+
+		NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
+		
+		string invalidChar = Locale.GetText ("Invalid character at position ");
+        string invalidExponent = Locale.GetText ("Invalid exponent");
+        bool isNegative = false;
+        bool expFlag = false;
+        int exp = 0;
+        int decPos = -1;
+
+        bool hasSign = false;
+        bool hasOpeningParentheses = false;
+        bool hasDecimalPoint = false;
+        bool allowedLeadingWhiteSpace = ((style & NumberStyles.AllowLeadingWhite) != 0);
+        bool allowedTrailingWhiteSpace = ((style & NumberStyles.AllowTrailingWhite) != 0);
+        bool allowedLeadingSign = ((style & NumberStyles.AllowLeadingSign) != 0);
+        bool allowedTrailingSign = ((style & NumberStyles.AllowTrailingSign) != 0);
+        bool allowedParentheses = ((style & NumberStyles.AllowParentheses) != 0);
+        bool allowedThousands = ((style & NumberStyles.AllowThousands) != 0);
+        bool allowedDecimalPoint = ((style & NumberStyles.AllowDecimalPoint) != 0);
+        bool allowedExponent = ((style & NumberStyles.AllowExponent) != 0);
+
+        /* get rid of currency symbol */
+        bool hasCurrency = false;
+        if ((style & NumberStyles.AllowCurrencySymbol) != 0)
+        {
+            int index = s.IndexOf(nfi.CurrencySymbol);
+            if (index >= 0) 
             {
-                int index = s.IndexOf(nfi.CurrencySymbol);
-                if (index >= 0) 
-                {
-                    s = s.Remove(index, nfi.CurrencySymbol.Length);
-                    hasCurrency = true;
-                }
+                s = s.Remove(index, nfi.CurrencySymbol.Length);
+                hasCurrency = true;
             }
+        }
 
-            string decimalSep = (hasCurrency) ? nfi.CurrencyDecimalSeparator : nfi.NumberDecimalSeparator;
-            string groupSep = (hasCurrency) ? nfi.CurrencyGroupSeparator : nfi.NumberGroupSeparator;
+        string decimalSep = (hasCurrency) ? nfi.CurrencyDecimalSeparator : nfi.NumberDecimalSeparator;
+        string groupSep = (hasCurrency) ? nfi.CurrencyGroupSeparator : nfi.NumberGroupSeparator;
 
-            int pos = 0;
-            int len = s.Length;
+        int pos = 0;
+        int len = s.Length;
 
-            StringBuilder sb = new StringBuilder(len);
+        StringBuilder sb = new StringBuilder(len);
 
-            // leading
-            while (pos < len) 
+        // leading
+        while (pos < len) 
+        {
+            char ch = s[pos];
+            if (Char.IsDigit(ch)) 
             {
-                char ch = s[pos];
-                if (Char.IsDigit(ch)) 
+                break; // end of leading
+            }
+            else if (allowedLeadingWhiteSpace && Char.IsWhiteSpace(ch)) 
+            {
+                pos++;
+            }
+            else if (allowedParentheses && ch == '(' && !hasSign && !hasOpeningParentheses) 
+            {
+                hasOpeningParentheses = true;
+                hasSign = true;
+                isNegative = true;
+                pos++;
+            }
+            else if (allowedLeadingSign && ch == nfi.NegativeSign[0] && !hasSign) 
+            {
+                int slen = nfi.NegativeSign.Length;
+                if (slen == 1 || s.IndexOf(nfi.NegativeSign, pos, slen) == pos) 
                 {
-                    break; // end of leading
-                }
-                else if (allowedLeadingWhiteSpace && Char.IsWhiteSpace(ch)) 
-                {
-                    pos++;
-                }
-                else if (allowedParentheses && ch == '(' && !hasSign && !hasOpeningParentheses) 
-                {
-                    hasOpeningParentheses = true;
                     hasSign = true;
                     isNegative = true;
-                    pos++;
+                    pos += slen;
                 }
-                else if (allowedLeadingSign && ch == nfi.NegativeSign[0] && !hasSign) 
+            }
+            else if (allowedLeadingSign && ch == nfi.PositiveSign[0] && !hasSign) 
+            {
+                int slen = nfi.PositiveSign.Length;
+                if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
                 {
-                    int slen = nfi.NegativeSign.Length;
-                    if (slen == 1 || s.IndexOf(nfi.NegativeSign, pos, slen) == pos) 
-                    {
-                        hasSign = true;
-                        isNegative = true;
-                        pos += slen;
-                    }
+                    hasSign = true;
+                    pos += slen;
                 }
-                else if (allowedLeadingSign && ch == nfi.PositiveSign[0] && !hasSign) 
+            }
+            else if (allowedDecimalPoint && ch == decimalSep[0])
+            {
+                int slen = decimalSep.Length;
+                if (slen != 1 && s.IndexOf(decimalSep, pos, slen) != pos) 
                 {
-                    int slen = nfi.PositiveSign.Length;
-                    if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
-                    {
-                        hasSign = true;
-                        pos += slen;
-                    }
+                	if (!tryParse)
+	                    throw new FormatException(invalidChar + pos);
+	                return false;
                 }
-                else if (allowedDecimalPoint && ch == decimalSep[0])
-                {
-                    int slen = decimalSep.Length;
-                    if (slen != 1 && s.IndexOf(decimalSep, pos, slen) != pos) 
-                    {
-                        throw new FormatException(invalidChar + pos);
-                    }
-                    break;
-                }
-                else
-                {
-                    throw new FormatException(invalidChar + pos);
-                }
+                break;
             }
+            else
+            {
+            	if (!tryParse)
+	                throw new FormatException(invalidChar + pos);
+	            return false;
+            }
+        }
 
-            if (pos == len)
-		throw new FormatException(Locale.GetText ("No digits found"));
+        if (pos == len) {
+        	if (!tryParse)
+				throw new FormatException(Locale.GetText ("No digits found"));
+			return false;		
+		}
 
-            // digits 
-            while (pos < len)
+        // digits 
+        while (pos < len)
+        {
+            char ch = s[pos];
+            if (Char.IsDigit(ch)) 
             {
-                char ch = s[pos];
-                if (Char.IsDigit(ch)) 
+                sb.Append(ch);
+                pos++;
+            }
+            else if (allowedThousands && ch == groupSep[0]) 
+            {
+                int slen = groupSep.Length;
+                if (slen != 1 && s.IndexOf(groupSep, pos, slen) != pos) 
                 {
-                    sb.Append(ch);
-                    pos++;
+                	if (!tryParse)
+	                    throw new FormatException(invalidChar + pos);
+	                return false;
                 }
-                else if (allowedThousands && ch == groupSep[0]) 
+                pos += slen;
+            }
+            else if (allowedDecimalPoint && ch == decimalSep[0] && !hasDecimalPoint)
+            {
+                int slen = decimalSep.Length;
+                if (slen == 1 || s.IndexOf(decimalSep, pos, slen) == pos) 
                 {
-                    int slen = groupSep.Length;
-                    if (slen != 1 && s.IndexOf(groupSep, pos, slen) != pos) 
-                    {
-                        throw new FormatException(invalidChar + pos);
-                    }
+                    decPos = sb.Length;
+                    hasDecimalPoint = true;
                     pos += slen;
                 }
-                else if (allowedDecimalPoint && ch == decimalSep[0] && !hasDecimalPoint)
-                {
-                    int slen = decimalSep.Length;
-                    if (slen == 1 || s.IndexOf(decimalSep, pos, slen) == pos) 
-                    {
-                        decPos = sb.Length;
-                        hasDecimalPoint = true;
-                        pos += slen;
-                    }
-                }
-                else
-                {
-                    break;
-                }
             }
+            else
+            {
+                break;
+            }
+        }
 
-            // exponent
-            if (pos < len)
+        // exponent
+        if (pos < len)
+        {
+            char ch = s[pos];
+            if (allowedExponent && Char.ToUpperInvariant (ch) == 'E')
             {
-                char ch = s[pos];
-                if (allowedExponent && Char.ToUpperInvariant (ch) == 'E')
+                expFlag = true;
+                pos++;
+                if (pos >= len)
+                	if (!tryParse)
+	                	throw new FormatException(invalidExponent);
+	                else
+	                	return false;
+
+                ch = s[pos];
+                bool isNegativeExp = false;
+                if (ch == nfi.PositiveSign[0])
                 {
-                    expFlag = true;
-                    pos++; if (pos >= len) throw new FormatException(invalidExponent);
-                    ch = s[pos];
-                    bool isNegativeExp = false;
-                    if (ch == nfi.PositiveSign[0])
+                    int slen = nfi.PositiveSign.Length;
+                    if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
                     {
-                        int slen = nfi.PositiveSign.Length;
-                        if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
-                        {
-                            pos += slen;  if (pos >= len) throw new FormatException(invalidExponent);
-                        }
+                        pos += slen;
+                        if (pos >= len)
+                        	if (!tryParse)
+	                        	throw new FormatException(invalidExponent);
+	                        else
+	                        	return false;
                     }
-                    else if (ch == nfi.NegativeSign[0])
-                    {
-                        int slen = nfi.NegativeSign.Length;
-                        if (slen == 1 || s.IndexOf(nfi.NegativeSign, pos, slen) == pos) 
-                        {
-                            pos += slen; if (pos >= len) throw new FormatException(invalidExponent);
-                            isNegativeExp = true;
-                        }
-                    }
-                    ch = s[pos];
-                    if (!Char.IsDigit(ch)) throw new FormatException(invalidExponent);
-                    exp = ch - '0';
-                    pos++;
-                    while (pos < len && Char.IsDigit(s[pos])) 
-                    {
-                        exp *= 10;
-                        exp += s[pos] - '0';
-                        pos++;
-                    }
-                    if (isNegativeExp) exp *= -1;
                 }
-            }
-
-            // trailing
-            while (pos < len)
-            {
-                char ch = s[pos];
-                if (allowedTrailingWhiteSpace && Char.IsWhiteSpace(ch)) 
+                else if (ch == nfi.NegativeSign[0])
                 {
-                    pos++;
-                }
-                else if (allowedParentheses && ch == ')' && hasOpeningParentheses) 
-                {
-                    hasOpeningParentheses = false;
-                    pos++;
-                }
-                else if (allowedTrailingSign && ch == nfi.NegativeSign[0] && !hasSign) 
-                {
                     int slen = nfi.NegativeSign.Length;
                     if (slen == 1 || s.IndexOf(nfi.NegativeSign, pos, slen) == pos) 
                     {
-                        hasSign = true;
-                        isNegative = true;
                         pos += slen;
+                        if (pos >= len)
+                        	if (!tryParse)
+	                        	throw new FormatException(invalidExponent);
+	                        else
+	                        	return false;
+
+                        isNegativeExp = true;
                     }
                 }
-                else if (allowedTrailingSign && ch == nfi.PositiveSign[0] && !hasSign) 
+                ch = s[pos];
+                if (!Char.IsDigit(ch)) 
+                	if (!tryParse)
+	                	throw new FormatException(invalidExponent);
+	                else
+	                	return false;
+
+                exp = ch - '0';
+                pos++;
+                while (pos < len && Char.IsDigit(s[pos])) 
                 {
-                    int slen = nfi.PositiveSign.Length;
-                    if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
-                    {
-                        hasSign = true;
-                        pos += slen;
-                    }
+                    exp *= 10;
+                    exp += s[pos] - '0';
+                    pos++;
                 }
-                else
+                if (isNegativeExp) exp *= -1;
+            }
+        }
+
+        // trailing
+        while (pos < len)
+        {
+            char ch = s[pos];
+            if (allowedTrailingWhiteSpace && Char.IsWhiteSpace(ch)) 
+            {
+                pos++;
+            }
+            else if (allowedParentheses && ch == ')' && hasOpeningParentheses) 
+            {
+                hasOpeningParentheses = false;
+                pos++;
+            }
+            else if (allowedTrailingSign && ch == nfi.NegativeSign[0] && !hasSign) 
+            {
+                int slen = nfi.NegativeSign.Length;
+                if (slen == 1 || s.IndexOf(nfi.NegativeSign, pos, slen) == pos) 
                 {
-                    throw new FormatException(invalidChar + pos);
+                    hasSign = true;
+                    isNegative = true;
+                    pos += slen;
                 }
             }
-
-            if (hasOpeningParentheses) throw new FormatException (
-		    Locale.GetText ("Closing Parentheses not found"));
-	    
-            if (!hasDecimalPoint) decPos = sb.Length;
-
-            return sb.ToString();
+            else if (allowedTrailingSign && ch == nfi.PositiveSign[0] && !hasSign) 
+            {
+                int slen = nfi.PositiveSign.Length;
+                if (slen == 1 || s.IndexOf(nfi.PositiveSign, pos, slen) == pos) 
+                {
+                    hasSign = true;
+                    pos += slen;
+                }
+            }
+            else
+            {
+            	if (!tryParse)
+	                throw new FormatException(invalidChar + pos);
+	           	return false;
+            }
         }
 
-	public static Decimal Parse (string s, NumberStyles style, IFormatProvider provider) 
-	{
-		if (s == null)
-			throw new ArgumentNullException ("s");
+        if (hasOpeningParentheses)
+        	if (!tryParse)
+	        	throw new FormatException (Locale.GetText ("Closing Parentheses not found"));
+	        else
+	        	return false;
+    
+        if (!hasDecimalPoint) decPos = sb.Length;
 
-		NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
+        s = sb.ToString();
 
-		int iDecPos, exp;
-		bool isNegative, expFlag;
-		s = stripStyles(s, style, nfi, out iDecPos, out isNegative, out expFlag, out exp);
-
-		if (iDecPos < 0)
+		if (decPos < 0)
 			throw new Exception (Locale.GetText ("Error in System.Decimal.Parse"));
 
 		// first we remove leading 0
-		int len = s.Length;
 		int i = 0;
-		while ((i < iDecPos) && (s [i] == '0'))
+		while ((i < decPos) && (s [i] == '0'))
 			i++;
 		if ((i > 1) && (len > 1)) {
 			s = s.Substring (i, len - i);
-			iDecPos -= i;
+			decPos -= i;
 		}
 
 		// first 0. may not be here but is part of the maximum length
-		int max = ((iDecPos == 0) ? 27 : 28);
-		len = s.Length;
+		int max = ((decPos == 0) ? 27 : 28);
 		if (len >= max + 1) {
 			// number lower than MaxValue (base-less) can have better precision
 			if (String.Compare (s, 0, "79228162514264337593543950335", 0, max + 1,
@@ -954,7 +997,7 @@
 		}
 
 		// then we trunc the string
-		if ((len > max) && (iDecPos < len)) {
+		if ((len > max) && (decPos < len)) {
 			int round = (s [max] - '0');
 			s = s.Substring (0, max);
 
@@ -986,29 +1029,56 @@
 					}
 				}
 				if ((p == -1) && (array [0] == '0')) {
-					iDecPos++;
-					s = "1".PadRight (iDecPos, '0');
+					decPos++;
+					s = "1".PadRight (decPos, '0');
 				}
 				else
 					s = new String (array);
 			}
 		}
 
-		Decimal result;
 		// always work in positive (rounding issues)
-		if (string2decimal (out result, s, (uint)iDecPos, 0) != 0)
-			throw new OverflowException ();
+		if (string2decimal (out result, s, (uint)decPos, 0) != 0)
+			if (!tryParse)
+				throw new OverflowException ();
+			else
+				return false;
 
 		if (expFlag) {
 			if (decimalSetExponent (ref result, exp) != 0)
-				throw new OverflowException ();
+				if (!tryParse)
+					throw new OverflowException ();
+				else
+					return false;
 		}
 
 		if (isNegative)
 			result.flags ^= SIGN_FLAG;
-		return result;
+		return true;
         }
 
+#if NET_2_0
+	public static bool TryParse (string s,
+				     NumberStyles style,
+				     IFormatProvider provider,
+				     out decimal result)
+	{
+		Exception exc;
+		if (!Parse (s, style, provider, true, out result, out exc)) {
+			result = 0;
+			return false;
+		}
+
+		return true;
+	}
+
+	public static bool TryParse (string s, out decimal result)
+	{
+		// Parameter s is interpreted using the NumberStyles.Number style.
+		return TryParse (s, NumberStyles.Number, null, out result);
+	}
+#endif
+
 	public TypeCode GetTypeCode ()
 	{
 	    return TypeCode.Decimal;