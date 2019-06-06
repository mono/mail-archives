Index: Mono.Xml.Xsl.Operations/XslNumber.cs
===================================================================
--- Mono.Xml.Xsl.Operations/XslNumber.cs	(revision 40268)
+++ Mono.Xml.Xsl.Operations/XslNumber.cs	(working copy)
@@ -108,7 +108,7 @@
 			string lang = null;
 			string letterValue = null;
 			char groupingSeparatorChar = '\0';
-			int groupingSize = 0;
+			decimal groupingSize = 0;
 			
 			if (this.format != null)
 				formatStr = this.format.Evaluate (p);
@@ -123,9 +123,13 @@
 				groupingSeparatorChar = this.groupingSeparator.Evaluate (p) [0];
 			
 			if (this.groupingSize != null)
-				groupingSize = int.Parse (this.groupingSize.Evaluate (p), CultureInfo.InvariantCulture);
+				groupingSize = decimal.Parse (this.groupingSize.Evaluate (p), CultureInfo.InvariantCulture);
 			
-			return new XslNumberFormatter (formatStr, lang, letterValue, groupingSeparatorChar, groupingSize);
+			//FIXME: Negative test compliency: .NET throws exception on negative grouping-size
+			if (groupingSize > Int32.MaxValue || groupingSize < 1)
+				groupingSize = 0;
+
+			return new XslNumberFormatter (formatStr, lang, letterValue, groupingSeparatorChar, (int)groupingSize);
 		}
 		
 		string GetFormat (XslTransformProcessor p)
@@ -134,8 +138,9 @@
 			
 			if (this.value != null) {
 				double result = p.EvaluateNumber (this.value);
-				result = (int) ((result - (int) result >= 0.5) ? result + 1 : result);
-				return nf.Format ((int) result);
+				//Do we need to round the result here???
+				//result = (int) ((result - (int) result >= 0.5) ? result + 1 : result); 
+				return nf.Format (result);
 			}
 			
 			switch (this.level) {
@@ -207,7 +212,7 @@
 							return 0;
 					};
 				}
-			} while (true);
+			} while (true);
 		}
 
 		int NumberSingle (XslTransformProcessor p)
@@ -304,12 +309,12 @@
 			}
 			
 			// return the format for a single value, ie, if using Single or Any
-			public string Format (int value)
+			public string Format (double value)
 			{
 				return Format (value, true);
 			}
 
-			public string Format (int value, bool formatContent)
+			public string Format (double value, bool formatContent)
 			{
 				StringBuilder b = new StringBuilder ();
 				if (firstSep != null) b.Append (firstSep);
@@ -379,7 +384,7 @@
 					this.sep = sep;
 				}
 				
-				public abstract void Format (StringBuilder b, int num);
+				public abstract void Format (StringBuilder b, double num);
 					
 				public static FormatItem GetItem (string sep, string item, char gpSep, int gpSize)
 				{
@@ -410,15 +415,15 @@
 					this.uc = uc;
 				}
 				
-				public override void Format (StringBuilder b, int num)
+				public override void Format (StringBuilder b, double num)
 				{
 					alphaSeq (b, num, uc ? ucl : lcl);
 				}
 				
-				static void alphaSeq (StringBuilder b, int n, char [] alphabet) {
+				static void alphaSeq (StringBuilder b, double n, char [] alphabet) {
 					if (n > alphabet.Length)
 						alphaSeq (b, (n-1) / alphabet.Length, alphabet);
-					b.Append (alphabet [(n-1) % alphabet.Length]); 
+					b.Append (alphabet [((int)n-1) % alphabet.Length]); 
 				}
 			}
 			
@@ -435,7 +440,7 @@
 				static readonly int [] decValues =
 				{1000, 900 , 500, 400 , 100, 90  , 50 , 40  , 10 , 9   , 5  , 4   , 1   };
 				
-				public override void Format (StringBuilder b, int num)
+				public override void Format (StringBuilder b, double num)
 				{
 					if (num < 1 || num > 4999) {
 						b.Append (num);
@@ -465,6 +470,7 @@
 				{
 					nfi = new NumberFormatInfo  ();
 					nfi.NumberDecimalDigits = 0;
+					nfi.NumberGroupSizes = new int [] {0};
 					if (gpSep != '\0' && gpSize > 0) {
 						// ignored if either of them doesn't exist.
 						nfi.NumberGroupSeparator = gpSep.ToString ();
@@ -473,7 +479,7 @@
 					decimalSectionLength = len;
 				}
 				
-				public override void Format (StringBuilder b, int num)
+				public override void Format (StringBuilder b, double num)
 				{
 					string number = num.ToString ("N", nfi);
 					int len = decimalSectionLength;