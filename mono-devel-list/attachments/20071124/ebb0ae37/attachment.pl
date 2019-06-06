Index: Int16.cs
===================================================================
--- Int16.cs	(revision 90250)
+++ Int16.cs	(working copy)
@@ -241,12 +241,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
Index: UInt64.cs
===================================================================
--- UInt64.cs	(revision 90250)
+++ UInt64.cs	(working copy)
@@ -383,12 +383,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
Index: SByte.cs
===================================================================
--- SByte.cs	(revision 90250)
+++ SByte.cs	(working copy)
@@ -245,12 +245,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
Index: UInt16.cs
===================================================================
--- UInt16.cs	(revision 90250)
+++ UInt16.cs	(working copy)
@@ -142,12 +142,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider provider)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format)
Index: Byte.cs
===================================================================
--- Byte.cs	(revision 90250)
+++ Byte.cs	(working copy)
@@ -144,7 +144,7 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (string format)
@@ -154,7 +154,7 @@
 
 		public string ToString (IFormatProvider provider)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), provider);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), provider);
 		}
 
 		public string ToString (string format, IFormatProvider provider)
Index: Int32.cs
===================================================================
--- Int32.cs	(revision 90250)
+++ Int32.cs	(working copy)
@@ -625,12 +625,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
Index: NumberFormatter.cs
===================================================================
--- NumberFormatter.cs	(revision 90250)
+++ NumberFormatter.cs	(working copy)
@@ -417,6 +417,14 @@
 
 			return sb.ToString ();
 		}
+		internal static string FormatDecimal (NumberStore ns)
+		{
+			return FormatDecimal (ns, -1, NumberFormatInfo.CurrentInfo);
+		}
+		internal static string FormatDecimal (NumberStore ns, IFormatProvider provider)
+		{
+			return FormatDecimal (ns, -1, NumberFormatInfo.GetInstance (provider));
+		}
 		internal static string FormatDecimal (NumberStore ns, int precision, NumberFormatInfo nfi)
 		{
 			if (ns.IsFloatingSource || ns.IsDecimalSource)
Index: Int64.cs
===================================================================
--- Int64.cs	(revision 90250)
+++ Int64.cs	(working copy)
@@ -498,12 +498,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
Index: UInt32.cs
===================================================================
--- UInt32.cs	(revision 90250)
+++ UInt32.cs	(working copy)
@@ -460,12 +460,12 @@
 
 		public override string ToString ()
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value));
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value));
 		}
 
 		public string ToString (IFormatProvider fp)
 		{
-			return NumberFormatter.FormatGeneral (new NumberFormatter.NumberStore (m_value), fp);
+			return NumberFormatter.FormatDecimal (new NumberFormatter.NumberStore (m_value), fp);
 		}
 
 		public string ToString (string format)
