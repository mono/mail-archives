Index: MathTest.cs
===================================================================
--- MathTest.cs	(revision 73984)
+++ MathTest.cs	(working copy)
@@ -1,8 +1,8 @@
-// MathTest.cs
+﻿// MathTest.cs
 //
 // Jon Guymon (guymon@slackworks.com)
 // Pedro Martínez Juliá (yoros@wanadoo.es)
-//
+// Dennis Hayes (dennisdotnet@yahoo.com)
 // (C) 2002 Jon Guymon
 // Copyright (C) 2003 Pedro Martínez Juliá <yoros@wanadoo.es>
 // Copyright (C) 2004 Novell (http://www.novell.com)
@@ -26,7 +26,7 @@
 
 	static double x = 0.1234;
 	static double y = 12.345;
-
+#region AbsTest
 	public void TestDecimalAbs() {
 		decimal a = -9.0M;
 
@@ -38,7 +38,6 @@
 		Assert(Decimal.One == Math.Abs(Decimal.MinusOne));
 	}
 
-
 	public void TestDoubleAbs() {
 		double a = -9.0D;
 		Assert(9.0D == Math.Abs(a));
@@ -117,6 +116,7 @@
 		}
 		Assert(Int16.MaxValue == Math.Abs(Int16.MaxValue));
 	}
+#endregion
 
 	public void TestAcos() {
 		double a = Math.Acos(x);
@@ -708,33 +708,91 @@
 	}
 
 	public void TestDecimalRound() {
-		decimal a = 1.5M;
-		decimal b = 2.5M;
+		decimal min = 0.0000000000000000000000000001M;
+		decimal a = 2.5M;
+		decimal b = 1.5M;
+		decimal c = 0M;
+		decimal d = -1.5M;
+		decimal e = -2.5M;
 
-		Assert(Math.Round(a) + " != 2", Math.Round(a) == 2);
-		Assert(Math.Round(b) + " != 2", Math.Round(b) == 2);
-		Assert(Decimal.MaxValue == Math.Round(Decimal.MaxValue));
-		Assert(Decimal.MinValue == Math.Round(Decimal.MinValue));
+		// Test 2.5
+		AssertEquals(Math.Round(a) + " != 2", Math.Round(a), 2M);
+		AssertEquals(Math.Round(a) + " + Min" + " != 2", Math.Round(a + min), 3M);
+		AssertEquals(Math.Round(a) + " - Min" + " != 2", Math.Round(a - min), 2M);
+		
+		//Test 1.5
+		AssertEquals(Math.Round(b) + " != 1", Math.Round(b), 2M);
+		AssertEquals(Math.Round(b) + " + Min" + " != 1", Math.Round(b + min), 2M);
+		AssertEquals(Math.Round(b) + " - Min" + " != 2", Math.Round(b - min), 1M);
+		
+		//Test 0
+		AssertEquals(Math.Round(c) + " != 0", Math.Round(c), 0M);
+		AssertEquals(Math.Round(c) + " + Min" + " != 0", Math.Round(c + min), 0M);
+		AssertEquals(Math.Round(c) + " - Min" + " != 0", Math.Round(c - min), 0M);
+		
+		//Test -1.5
+		AssertEquals(Math.Round(d) + " != -2", Math.Round(d), -2M);
+		AssertEquals(Math.Round(d) + " + Min" + " != -2", Math.Round(d + min), -1M);
+		AssertEquals(Math.Round(d) + " - Min" + " != -1", Math.Round(d - min), -2M);
+		
+		// Test 2.5
+		AssertEquals(Math.Round(e) + " != 2", Math.Round(e), -2M);
+		AssertEquals(Math.Round(e) + " + Min" + " != 2", Math.Round(e + min), -2M);
+		AssertEquals(Math.Round(e) + " - Min" + " != 2", Math.Round(e - min), -3M);
+		
+		AssertEquals("Round Decimal Max Value Failed", Decimal.MaxValue, Math.Round(Decimal.MaxValue));
+		AssertEquals("Round Decimal Min Value Failed", Decimal.MinValue, Math.Round(Decimal.MinValue));
 	}
 
 	public void TestDecimalRound2() {
+		decimal min = 0.0000000000000000000000000001M;
 		decimal a = 3.45M;
-		decimal b = 3.46M;
+		AssertEquals ("Should round down decmial 0", Math.Round(a, 0), 3M);
+		// Demos bug 60227 & 63902 should return 3.45, not 3.45000000000...
+		// AssertEquals ("Should round down decmial 28", Math.Round(a, 28), 3.45M);
 
 		AssertEquals ("Should round down", Math.Round(a, 1), 3.4M);
-		AssertEquals ("Should round up", Math.Round(b, 1), 3.5M);
+		AssertEquals ("Should round up", Math.Round(a +  min, 1), 3.5M);
+		
 	}
+		
+	
+	[Test, ExpectedException (typeof (ArgumentOutOfRangeException))]
+	public void TestRoundDecimalsLowerLimitExecption ()
+	{
+		decimal a = 3.45M;
+		Math.Round(a, -1);
+	}
 
+	[Test, ExpectedException (typeof (ArgumentOutOfRangeException))]
+	public void TestRoundDecimalsUpperLimitExecption ()
+	{
+		decimal a = 3.45M;
+		Math.Round(a, 29);
+	}
+
 	public void TestDoubleRound() {
 		double a = 1.5D;
 		double b = 2.5D;
+		double min = 0.0D;
 
 		AssertEquals ("Should round up", Math.Round(a), 2D);
 		AssertEquals ("Should round down", Math.Round(b), 2D);
-		Assert(Double.MaxValue == Math.Round(Double.MaxValue));
-		Assert(Double.MinValue == Math.Round(Double.MinValue));
+		
+		AssertEquals("Rounding Max Value failed", Double.MaxValue, Math.Round(Double.MaxValue));
+		AssertEquals("Rounding Min Value failed", Double.MinValue, Math.Round(Double.MinValue));
 	}
 
+	public void TestDoubleRound2() {
+		double a = 3.45D;
+		double b = 3.46D;
+
+		AssertEquals ("Should round down", Math.Round(a, 1), 3.4D);
+		AssertEquals ("Should round up", Math.Round(b, 1), 3.5D);
+
+		AssertEquals (Math.Round (-0.123456789, 1), -0.1);
+	}
+	
 #if NET_2_0
 	public void TestDoubleTruncate ()
 	{
@@ -773,16 +831,6 @@
 	}
 #endif
 
-	public void TestDoubleRound2() {
-		double a = 3.45D;
-		double b = 3.46D;
-
-		AssertEquals ("Should round down", Math.Round(a, 1), 3.4D);
-		AssertEquals ("Should round up", Math.Round(b, 1), 3.5D);
-
-		AssertEquals (Math.Round (-0.123456789, 1), -0.1);
-	}
-	
 	public void TestDecimalSign() {
 		decimal a = -5M;
 		decimal b = 5M;
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 73984)
+++ ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+﻿2007-03-09  Dennis Hayes  <dennisdotnet@yahoo.com>
+
+	* MathTest.cd. Replaced some Asserts with AssertEquals.
+	Added more tests for Rounding(decimal). Added tests for bugs
+	60227 and 63902 (rounding 3.45 to 3.450000), these are commented
+	out, as they are old bugs not likely to be fixed soon.
+
 2007-03-08  Gert Driesen  <drieseng@users.sourceforge.net>
 
 	* StringComparerTest.cs: Added tests for bug #80928. Added binary
