Additional tests for System.DateTime.  With mcs-DateTime-fixes3-swb.patch
applied, there are still two tests added here that fail:

MonoTests.System.DateTimeTest.Milliseconds: Fails due to Parse not handling ISO
8601 styles.  Previously wouldn't have failed, but that was due to another bug
('exact' not being honored).  XmlConvert handles these styles correctly.

MonoTests.System.DateTimeTest.ParseNotExact: Fails due to Parse calling
ParseExact internally, which is obviously wrong.

- Steven Brown <swbrown@ucsd.edu>


Index: class/corlib/Test/System/DateTimeTest.cs
===================================================================
--- class/corlib/Test/System/DateTimeTest.cs	(revision 2)
+++ class/corlib/Test/System/DateTimeTest.cs	(working copy)
@@ -646,6 +646,50 @@
 	}
 
 	[Test]
+	public void Milliseconds()
+	{
+		AssertEquals("DateTime with milliseconds", 632211389411234567, DateTime.Parse("2004-05-26T03:29:01.1234567-07:00").Ticks);
+	}
+
+	[Test]
+	public void ParseNotExact()
+	{
+		AssertEquals("DateTime.Parse not exact", 632211389410000000, DateTime.Parse("2004-05-26T03:29:01-07:00 foo").Ticks);
+	}
+
+	[Test]
+	[ExpectedException(typeof(FormatException))]
+	public void ParseExactIsExact()
+	{
+		DateTime.ParseExact("2004-05-26T03:29:01-07:00 foo", "yyyy-MM-ddTHH:mm:sszzz", null);
+	}
+
+	[Test]
+	[ExpectedException(typeof(FormatException))]
+	public void ParseExactDoesNotEatZ()
+	{
+		DateTime.ParseExact("2004-05-26T03:29:01", "yyyy-MM-ddTHH:mm:ssZ", null);
+	}
+
+	[Test]
+	public void ParseExactMilliseconds()
+	{
+		AssertEquals("DateTime.ParseExact with milliseconds", 632211389411234567, DateTime.ParseExact("2004-05-26T03:29:01.1234567-07:00", "yyyy-MM-ddTHH:mm:ss.fffffffzzz", null).Ticks);
+	}
+
+	[Test]
+	public void NoColonTimeZone()
+	{
+		AssertEquals("DateTime with colon-less timezone", true, DateTime.Parse("2004-05-26T03:29:01-0700").Ticks != DateTime.Parse("2004-05-26T03:29:01-0800").Ticks);
+	}
+
+	[Test]
+	public void WithColonTimeZone()
+	{
+		AssertEquals("DateTime with colon tiemzone", true, DateTime.Parse("2004-05-26T03:29:01-07:00").Ticks != DateTime.Parse("2004-05-26T03:29:01-08:00").Ticks);
+	}
+
+	[Test]
 	public void MaxValueYear () // bug52075
 	{
 		AssertEquals ("#01", "9999", DateTime.MaxValue.Year.ToString ());
