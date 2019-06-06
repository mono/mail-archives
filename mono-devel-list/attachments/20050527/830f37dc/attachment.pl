Index: XmlCustomFormatter.cs
===================================================================
--- XmlCustomFormatter.cs	(revision 45046)
+++ XmlCustomFormatter.cs	(working copy)
@@ -211,8 +211,8 @@
 				case "unsignedByte": return XmlConvert.ToByte (value);
 				case "char": return (char)XmlConvert.ToInt32 (value);
 				case "dateTime": return XmlConvert.ToDateTime (value);
-				case "date": return DateTime.ParseExact (value, "yyyy-MM-dd", null);
-				case "time": return DateTime.ParseExact (value, "HH:mm:ss.fffffffzzz", null);
+				case "date": return ToDate (value);
+				case "time": return ToTime (value);
 				case "decimal": return XmlConvert.ToDecimal (value);
 				case "double": return XmlConvert.ToDouble (value);
 				case "short": return XmlConvert.ToInt16 (value);
@@ -280,8 +280,8 @@
 				case "unsignedByte": return "byte.Parse (" + value + ", CultureInfo.InvariantCulture)";
 				case "char": return "(char)Int32.Parse (" + value + ", CultureInfo.InvariantCulture)";
 				case "dateTime": return "XmlConvert.ToDateTime (" + value + ")";
-				case "date": return "DateTime.ParseExact (" + value + ", \"yyyy-MM-dd\", CultureInfo.InvariantCulture)";
-				case "time": return "DateTime.ParseExact (" + value + ", \"HH:mm:ss.fffffffzzz\", CultureInfo.InvariantCulture)";
+				case "date": return "XmlConvert.ToDateTime (" + value + ")";
+				case "time": return "XmlConvert.ToDateTime (" + value + ")";
 				case "decimal": return "Decimal.Parse (" + value + ", CultureInfo.InvariantCulture)";
 				case "double": return "XmlConvert.ToDouble (" + value + ")";
 				case "short": return "Int16.Parse (" + value + ", CultureInfo.InvariantCulture)";

