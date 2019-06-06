Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 47945)
+++ corlib.dll.sources	(working copy)
@@ -8,6 +8,14 @@
 Microsoft.Win32/Win32RegistryApi.cs
 Microsoft.Win32/Win32ResultCode.cs
 Microsoft.Win32.SafeHandles/SafeFileHandle.cs
+Mono.Globalization.Unicode/CodePointIndexer.cs
+Mono.Globalization.Unicode/MSCompatUnicodeTable.cs
+Mono.Globalization.Unicode/MSCompatUnicodeTableUtil.cs
+Mono.Globalization.Unicode/SimpleCollator.cs
+Mono.Globalization.Unicode/SortKey.cs
+Mono.Globalization.Unicode/SortKeyBuffer.cs
+Mono.Globalization.Unicode/Normalization.cs
+Mono.Globalization.Unicode/NormalizationTableUtil.cs
 Mono/Runtime.cs
 Mono.Math/BigInteger.cs
 Mono.Math.Prime/ConfidenceFactor.cs
@@ -303,7 +311,6 @@
 System.Globalization/NumberFormatInfo.cs
 System.Globalization/NumberStyles.cs
 System.Globalization/RegionInfo.cs
-System.Globalization/SortKey.cs
 System.Globalization/StringInfo.cs
 System.Globalization/TaiwanCalendar.cs
 System.Globalization/TextElementEnumerator.cs
Index: System/String.cs
===================================================================
--- System/String.cs	(revision 47945)
+++ System/String.cs	(working copy)
@@ -38,6 +38,7 @@
 #if NET_2_0
 using System.Runtime.ConstrainedExecution;
 using System.Runtime.InteropServices;
+using Mono.Globalization.Unicode;
 #endif
 
 namespace System
@@ -714,6 +715,44 @@
 			return (value == null) || (value.Length == 0);
 		}
 
+		public string Normalize ()
+		{
+			return Normalize (NormalizationForm.FormC);
+		}
+
+		public string Normalize (NormalizationForm form)
+		{
+			switch (form) {
+			default:
+				return Normalization.Normalize (this, 0);
+			case NormalizationForm.FormD:
+				return Normalization.Normalize (this, 1);
+			case NormalizationForm.FormKC:
+				return Normalization.Normalize (this, 2);
+			case NormalizationForm.FormKD:
+				return Normalization.Normalize (this, 3);
+			}
+		}
+
+		public bool IsNormalized ()
+		{
+			return IsNormalized (NormalizationForm.FormC);
+		}
+
+		public bool IsNormalized (NormalizationForm form)
+		{
+			switch (form) {
+			default:
+				return Normalization.IsNormalized (this, 0);
+			case NormalizationForm.FormD:
+				return Normalization.IsNormalized (this, 1);
+			case NormalizationForm.FormKC:
+				return Normalization.IsNormalized (this, 2);
+			case NormalizationForm.FormKD:
+				return Normalization.IsNormalized (this, 3);
+			}
+		}
+
 		public string Remove (int startIndex)
 		{
 			if (startIndex < 0)