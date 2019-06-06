Index: driver.cs
===================================================================
--- driver.cs	(revision 47877)
+++ driver.cs	(working copy)
@@ -1374,10 +1374,10 @@
 			bool parsing_options = true;
 
 			try {
-				encoding = Encoding.GetEncoding (28591);
+				encoding = Encoding.GetEncoding (CultureInfo.CurrentCulture.TextInfo.ANSICodePage);
 			} catch {
 				Console.WriteLine ("Error: could not load encoding 28591, trying 1252");
-				encoding = Encoding.GetEncoding (1252);
+				encoding = Encoding.UTF8;
 			}
 			
 			references = new ArrayList ();