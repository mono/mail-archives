Index: Double.cs
===================================================================
--- Double.cs	(revision 40962)
+++ Double.cs	(working copy)
@@ -416,8 +416,8 @@
 
 		public string ToString (string format, IFormatProvider fp)
 		{
-			NumberFormatInfo nfi = fp != null ? fp.GetFormat (typeof (NumberFormatInfo)) as NumberFormatInfo : null;
-			return DoubleFormatter.NumberToString (format, nfi, m_value);
+			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (fp);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: Single.cs
===================================================================
--- Single.cs	(revision 40962)
+++ Single.cs	(working copy)
@@ -216,10 +216,8 @@
 
 		public string ToString (string format, IFormatProvider provider)
 		{
-			if (provider is CultureInfo)
-				return SingleFormatter.NumberToString (format, ((CultureInfo) provider).NumberFormat, m_value);
-			else
-				return SingleFormatter.NumberToString (format, (NumberFormatInfo) provider, m_value);
+			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// ============= IConvertible Methods ============ //
Index: UInt16.cs
===================================================================
--- UInt16.cs	(revision 40962)
+++ UInt16.cs	(working copy)
@@ -236,12 +236,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return ToString (null, provider);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
@@ -252,12 +252,7 @@
 		public string ToString (string format, IFormatProvider provider)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
-
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-			
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: SByte.cs
===================================================================
--- SByte.cs	(revision 40962)
+++ SByte.cs	(working copy)
@@ -236,12 +236,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return ToString (null, provider);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
@@ -252,12 +252,7 @@
 		public string ToString (string format, IFormatProvider provider)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
-
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== ICovnertible Methods =========== //
Index: Int16.cs
===================================================================
--- Int16.cs	(revision 40962)
+++ Int16.cs	(working copy)
@@ -222,12 +222,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return ToString (null, fp);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
@@ -238,12 +238,7 @@
 		public string ToString (string format, IFormatProvider fp)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance( fp );
-
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-			
-			return IntegerFormatter.NumberToString(format, nfi, m_value);
+			return NumberFormatter.NumberToString(format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: Byte.cs
===================================================================
--- Byte.cs	(revision 40962)
+++ Byte.cs	(working copy)
@@ -244,7 +244,7 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (string format)
@@ -254,18 +254,13 @@
 
 		public string ToString (IFormatProvider provider)
 		{
-			return ToString (null, provider);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format, IFormatProvider provider)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
-
-			// null or empty ("")
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: UInt64.cs
===================================================================
--- UInt64.cs	(revision 40962)
+++ UInt64.cs	(working copy)
@@ -367,12 +367,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return ToString (null, provider);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
@@ -383,12 +383,7 @@
 		public string ToString (string format, IFormatProvider provider)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (provider);
-
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: Int32.cs
===================================================================
--- Int32.cs	(revision 40962)
+++ Int32.cs	(working copy)
@@ -550,12 +550,12 @@
 
 		public override string ToString ()
 		{
-			return IntegerFormatter.FormatGeneral(m_value, 0, null, true);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return ToString (null, fp);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
@@ -566,12 +566,7 @@
 		public string ToString (string format, IFormatProvider fp )
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance( fp );
-			
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: Int64.cs
===================================================================
--- Int64.cs	(revision 40962)
+++ Int64.cs	(working copy)
@@ -453,12 +453,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return ToString (null, fp);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
@@ -469,12 +469,7 @@
 		public string ToString (string format, IFormatProvider fp)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance( fp );
-			
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-			
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
Index: UInt32.cs
===================================================================
--- UInt32.cs	(revision 40962)
+++ UInt32.cs	(working copy)
@@ -452,12 +452,12 @@
 
 		public override string ToString ()
 		{
-			return ToString (null, null);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return ToString (null, fp);
+			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
@@ -468,12 +468,7 @@
 		public string ToString (string format, IFormatProvider fp)
 		{
 			NumberFormatInfo nfi = NumberFormatInfo.GetInstance (fp);
-			
-			// use "G" when format is null or String.Empty
-			if ((format == null) || (format.Length == 0))
-				format = "G";
-			
-			return IntegerFormatter.NumberToString (format, nfi, m_value);
+			return NumberFormatter.NumberToString (format, m_value, nfi);
 		}
 
 		// =========== IConvertible Methods =========== //
