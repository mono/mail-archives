Index: RegexBugs.cs
===================================================================
RCS file: /mono/mcs/class/System/Test/System.Text.RegularExpressions/RegexBugs.cs,v
retrieving revision 1.3
diff -u -r1.3 RegexBugs.cs
--- RegexBugs.cs	7 Jan 2004 18:24:11 -0000	1.3
+++ RegexBugs.cs	19 Jan 2004 15:55:03 -0000
@@ -70,5 +70,30 @@
 			AssertEquals ("MEG #12", true, Regex.IsMatch(str, @"(something|dog|)*$"));
 
 		}
+
+                [Test]
+                public void RangeIgnoreCase() // bug 45976
+                {
+                        string str = "AAABBBBAAA" ;
+                        AssertEquals("RIC #01", true, Regex.IsMatch(str, @"[A-F]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #02", true, Regex.IsMatch(str, @"[a-f]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #03", true, Regex.IsMatch(str, @"[A-Fa-f]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #04", true, Regex.IsMatch(str, @"[AB]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #05", true, Regex.IsMatch(str, @"[A-B]+", RegexOptions.IgnoreCase));
+
+                        str = "AaaBBBaAa" ;
+                        AssertEquals("RIC #06", true, Regex.IsMatch(str, @"[A-F]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #07", true, Regex.IsMatch(str, @"[a-f]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #08", true, Regex.IsMatch(str, @"[A-Fa-f]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #09", true, Regex.IsMatch(str, @"[AB]+", RegexOptions.IgnoreCase));
+                        AssertEquals("RIC #10", true, Regex.IsMatch(str, @"[A-B]+", RegexOptions.IgnoreCase));
+
+			str = "Aaa[";
+			AssertEquals("RIC #11", true, Regex.IsMatch(str, @"[A-a]+", RegexOptions.IgnoreCase));
+			
+			str = "Ae";
+			AssertEquals("RIC #12", false, Regex.IsMatch(str, @"[A-a]+", RegexOptions.IgnoreCase));
+
+                }
 	}
 }
