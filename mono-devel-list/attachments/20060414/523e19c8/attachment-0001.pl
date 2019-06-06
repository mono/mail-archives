Index: corlib.dll.sources
===================================================================
--- corlib.dll.sources	(revision 59393)
+++ corlib.dll.sources	(working copy)
@@ -16,6 +16,8 @@
 Mono.Globalization.Unicode/SimpleCollator.cs
 Mono.Globalization.Unicode/SortKey.cs
 Mono.Globalization.Unicode/SortKeyBuffer.cs
+Mono.Globalization.Unicode/Normalization.cs
+Mono.Globalization.Unicode/NormalizationTableUtil.cs
 Mono/Runtime.cs
 Mono.Math/BigInteger.cs
 Mono.Math.Prime/ConfidenceFactor.cs
Index: System/String.cs
===================================================================
--- System/String.cs	(revision 59393)
+++ System/String.cs	(working copy)
@@ -39,6 +39,7 @@
 using System.Collections.Generic;
 using System.Runtime.ConstrainedExecution;
 using System.Runtime.InteropServices;
+using Mono.Globalization.Unicode;
 #endif
 
 namespace System
@@ -951,6 +952,44 @@
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