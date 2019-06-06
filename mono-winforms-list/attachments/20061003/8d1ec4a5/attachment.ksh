Index: ResXResourceReader.cs
===================================================================
--- ResXResourceReader.cs	(revision 66181)
+++ ResXResourceReader.cs	(working copy)
@@ -220,7 +220,12 @@
 								v = Convert.FromBase64String(val);
 							} else {
 								TypeConverter c = TypeDescriptor.GetConverter (tt);
-								v = c.ConvertFromInvariantString (val);
+								if (c.CanConvertFrom (typeof (string)))
+									v = c.ConvertFromInvariantString (val);
+								else if (c.CanConvertFrom (typeof (byte[])))
+									v = c.ConvertFrom (Convert.FromBase64String (val));
+								else
+									v = val;
 							}
 						} else if ((mt != null) && (mt.Length > 0)) {
 							byte [] data = Convert.FromBase64String (val);
