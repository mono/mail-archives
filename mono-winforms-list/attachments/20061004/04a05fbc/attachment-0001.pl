Index: Test/System.Resources/WriterTest.cs
===================================================================
--- Test/System.Resources/WriterTest.cs	(revision 66185)
+++ Test/System.Resources/WriterTest.cs	(working copy)
@@ -7,9 +7,12 @@
 
 using System;
 using System.Collections;
+using System.ComponentModel;
 using System.Drawing;
+using System.Globalization;
 using System.IO;
 using System.Resources;
+using System.Text;
 using NUnit.Framework;
 
 namespace MonoTests.System.Resources
@@ -33,6 +36,16 @@
                         w.AddResource ("ByteArray2", (object) new byte[] {15, 16, 17});
                         w.AddResource ("IntArray", new int[] {1012, 1013, 1014});
                         w.AddResource ("StringArray", new string[] {"hello", "world"});
+                        w.AddResource ("Image", new Bitmap (1, 1));
+                        w.AddResource ("StrType", new MyStrType ("hello"));
+                        w.AddResource ("BinType", new MyBinType ("world"));
+
+                        try {
+                                w.AddResource ("NonSerType", new MyNonSerializableType ());
+                                Assert.Fail ("#0");
+                        } catch (InvalidOperationException) {
+                        }
+
                         w.Generate ();
                         w.Close ();
 
@@ -53,8 +66,141 @@
                         Assert.AreEqual (16, ((byte[]) h["ByteArray2"])[1], "#8");
                         Assert.AreEqual (1013, ((int[]) h["IntArray"])[1], "#9");
                         Assert.AreEqual ("world", ((string[]) h["StringArray"])[1], "#10");
+                        Assert.AreEqual (typeof (Bitmap), h["Image"].GetType (), "#11");
+                        Assert.AreEqual ("hello", ((MyStrType) h["StrType"]).Value, "#12");
+                        Assert.AreEqual ("world", ((MyBinType) h["BinType"]).Value, "#13");
 
                         File.Delete (fileName);
                 }
         }
+
+        [Serializable]
+        [TypeConverter(typeof(MyStrTypeConverter))]
+	public class MyStrType
+	{
+                public string Value;
+
+		public MyStrType (string s)
+		{
+                        Value = s;
+		}
+	}
+
+        public class MyStrTypeConverter : TypeConverter
+        {
+                public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
+                {
+                        if (destinationType == typeof(string)) 
+                                return true;
+                        return base.CanConvertTo (context, destinationType);
+                }
+
+                public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
+                {
+                        if (sourceType == typeof(string)) 
+                                return true;
+                        return base.CanConvertFrom (context, sourceType);
+                }
+
+                public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
+                {
+                        if (destinationType == typeof(string)) 
+                                return ((MyStrType) value).Value;
+                        return base.ConvertTo (context, culture, value, destinationType);
+                }
+
+                public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
+                {
+                        if (value.GetType() == typeof(string))
+                                return new MyStrType((string) value);
+                        return base.ConvertFrom (context, culture, value);
+                }
+
+        }
+
+
+        [Serializable]
+        [TypeConverter(typeof(MyBinTypeConverter))]
+	public class MyBinType
+	{
+                public string Value;
+
+		public MyBinType (string s)
+		{
+                        Value = s;
+		}
+	}
+
+        public class MyBinTypeConverter : TypeConverter
+        {
+                public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
+                {
+                        if (destinationType == typeof(byte[])) 
+                                return true;
+                        return base.CanConvertTo (context, destinationType);
+                }
+
+                public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
+                {
+                        if (sourceType == typeof(byte[])) 
+                                return true;
+                        return base.CanConvertFrom (context, sourceType);
+                }
+
+                public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
+                {
+                        if (destinationType == typeof(byte[])) 
+                                return Encoding.Default.GetBytes (((MyBinType) value).Value);
+                        return base.ConvertTo (context, culture, value, destinationType);
+                }
+
+                public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
+                {
+                        if (value.GetType() == typeof(byte[]))
+                                return new MyBinType (Encoding.Default.GetString ((byte[]) value));
+                        return base.ConvertFrom (context, culture, value);
+                }
+
+        }
+
+
+        [TypeConverter(typeof(MyNonSerializableTypeConverter))]
+	public class MyNonSerializableType
+	{
+		public MyNonSerializableType ()
+		{
+		}
+	}
+
+        public class MyNonSerializableTypeConverter : TypeConverter
+        {
+                public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
+                {
+                        if (destinationType == typeof(byte[])) 
+                                return true;
+                        return base.CanConvertTo (context, destinationType);
+                }
+
+                public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
+                {
+                        if (sourceType == typeof(byte[])) 
+                                return true;
+                        return base.CanConvertFrom (context, sourceType);
+                }
+
+                public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
+                {
+                        if (destinationType == typeof(byte[])) 
+                                return new byte[] {0, 1, 2, 3};
+                        return base.ConvertTo (context, culture, value, destinationType);
+                }
+
+                public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
+                {
+                        if (value.GetType() == typeof(byte[]))
+                                return new MyNonSerializableType();
+                        return base.ConvertFrom (context, culture, value);
+                }
+
+        }
 }
Index: Test/System.Resources/compat_1_1.resx
===================================================================
--- Test/System.Resources/compat_1_1.resx	(revision 66185)
+++ Test/System.Resources/compat_1_1.resx	(working copy)
@@ -78,4 +78,16 @@
   <data name="StringArray" mimetype="application/x-microsoft.net.object.binary.base64">
     <value>AAEAAAD/////AQAAAAAAAAARAQAAAAIAAAAGAgAAAAVoZWxsbwYDAAAABXdvcmxkCw==</value>
   </data>
+  <data name="InvalidMimeType" mimetype="foo">
+    <value>AAEAAAD/////AQAAAAAAAAARAQAAAAIAAAAGAgAAAAVoZWxsbwYDAAAABXdvcmxkCw==</value>
+  </data>
+  <data name="Image" type="System.Drawing.Bitmap, System.Drawing, Version=1.0.5000.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" mimetype="application/x-microsoft.net.object.bytearray.base64">
+    <value>
+	iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8
+	YQUAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAAtJREFUGFdjYAAC
+	AAAFAAGq1chRAAAAAElFTkSuQmCCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	AAAAAAAAAAAAAAAAAAAAAA==
+    </value>
+  </data>
 </root>
Index: Test/System.Resources/compat_2_0.resx
===================================================================
--- Test/System.Resources/compat_2_0.resx	(revision 66185)
+++ Test/System.Resources/compat_2_0.resx	(working copy)
@@ -97,4 +97,16 @@
   <data name="StringArray" mimetype="application/x-microsoft.net.object.binary.base64">
     <value>AAEAAAD/////AQAAAAAAAAARAQAAAAIAAAAGAgAAAAVoZWxsbwYDAAAABXdvcmxkCw==</value>
   </data>
+  <data name="InvalidMimeType" mimetype="foo">
+    <value>AAEAAAD/////AQAAAAAAAAARAQAAAAIAAAAGAgAAAAVoZWxsbwYDAAAABXdvcmxkCw==</value>
+  </data>
+  <data name="Image" type="System.Drawing.Bitmap, System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" mimetype="application/x-microsoft.net.object.bytearray.base64">
+    <value>
+	iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8
+	YQUAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAAtJREFUGFdjYAAC
+	AAAFAAGq1chRAAAAAElFTkSuQmCCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+	AAAAAAAAAAAAAAAAAAAAAA==
+    </value>
+  </data>
 </root>
Index: Test/System.Resources/ChangeLog
===================================================================
--- Test/System.Resources/ChangeLog	(revision 66185)
+++ Test/System.Resources/ChangeLog	(working copy)
@@ -1,3 +1,12 @@
+2006-10-03  Robert Jordan  <robertj@gmx.net>
+
+	* compat_2_0.resx, compat_1_1.resx: Added an Image element to test the
+	type converter. Added InvalidMimeType, an element with an invalid mimetype
+	attribute.
+	* CompatTest.cs: Added assert for InvalidMimeType and Image element.
+	Fixed test for the 2.0 profile.
+	* WriterTest.cs: Added type converter tests.
+	
 2006-01-14  Robert Jordan  <robertj@gmx.net>
 
 	* compat_2_0.resx: Added a CDATA element as a test for bug #77253.
Index: Test/System.Resources/CompatTest.cs
===================================================================
--- Test/System.Resources/CompatTest.cs	(revision 66185)
+++ Test/System.Resources/CompatTest.cs	(working copy)
@@ -38,6 +38,9 @@
                                 Assert.AreEqual (16, ((byte[]) h["ByteArray2"])[1], fileName + "#8");
                                 Assert.AreEqual (1013, ((int[]) h["IntArray"])[1], fileName + "#9");
                                 Assert.AreEqual ("world", ((string[]) h["StringArray"])[1], fileName + "#10");
+                                Assert.IsNull (h["InvalidMimeType"]);
+                                Assert.IsNotNull (h["Image"], fileName + "#11");
+                                Assert.AreEqual (typeof (Bitmap), h["Image"].GetType (), fileName + "#12");
                         }
                 }
 
@@ -45,7 +48,14 @@
                 public void TestReader ()
                 {
                         Helper.TestReader ("Test/System.Resources/compat_1_1.resx");
+                }
+
+#if NET_2_0
+                [Test]
+                public void TestReader_2_0 ()
+                {
                         Helper.TestReader ("Test/System.Resources/compat_2_0.resx");
                 }
+#endif
         }
 }
