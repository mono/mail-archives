Index: System/ChangeLog
===================================================================
--- System/ChangeLog	(revision 73984)
+++ System/ChangeLog	(working copy)
@@ -1,3 +1,10 @@
+﻿2007-03-10  Dennis Hayes  <dennisdotnet@yahoo.com>
+
+	* Math.cs: Added Locale.GetText to execptions.
+	Rearranged Rounding with Midpoints to minimize
+	midpoint enum compairs, and slimplfy strucure a
+	bit for adding support for AwayFromZero enum.
+
 2007-03-08  Gert Driesen  <drieseng@users.sourceforge.net>
 
 	* StringComparer.cs: Renamed StringComparer classes and promoted them
Index: System/Math.cs
===================================================================
--- System/Math.cs	(revision 73984)
+++ System/Math.cs	(working copy)
@@ -1,4 +1,4 @@
-//
+﻿//
 // System.Math.cs
 //
 // Authors:
@@ -373,23 +373,26 @@
 		[MonoTODO ("Not implemented")]
 		public static decimal Round (decimal d, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (d);
-			throw new NotImplementedException ();
+			
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+			
+			throw new ArgumentException (Locale.GetText ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding."), "mode");
+
 		}
 
 		[MonoTODO ("Not implemented")]
 		public static decimal Round (decimal d, int decimals, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (d, decimals);
-			throw new NotImplementedException ();
+			
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+			
+			throw new ArgumentException (Locale.GetText ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding."), "mode");
 		}
 #endif
 
@@ -411,26 +414,31 @@
 #if NET_2_0
 		public static double Round (double value, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (value);
-			if (value > 0)
-				return Floor (value + 0.5);
-			else
-				return Ceiling (value - 0.5);
+			
+			if (mode == MidpointRounding.AwayFromZero)
+			{
+				if (value > 0)
+					return Floor (value + 0.5);
+				else
+					return Ceiling (value - 0.5);
+			}
+
+			throw new ArgumentException (Locale.GetText ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding."), "mode");
+
 		}
 
 		[MonoTODO ("Not implemented")]
 		public static double Round (double value, int digits, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (value, digits);
-			throw new NotImplementedException ();
+			
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+			
+			throw new ArgumentException (Locale.GetText ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding."), "mode");
 		}
 
 		public static double Truncate (double d)
@@ -463,7 +471,7 @@
 		public static int Sign (double value)
 		{
 			if (Double.IsNaN (value))
-				throw new ArithmeticException ("NAN");
+				throw new ArithmeticException (Locale.GetText ("NAN"));
 			if (value > 0) return 1;
 			return (value == 0)? 0: -1;
 		}
@@ -471,7 +479,7 @@
 		public static int Sign (float value)
 		{
 			if (Single.IsNaN (value))
-				throw new ArithmeticException ("NAN");
+				throw new ArithmeticException (Locale.GetText ("NAN"));
 			if (value > 0) return 1;
 			return (value == 0)? 0: -1;
 		}
Index: Test/System/MathTest.cs
===================================================================
--- Test/System/MathTest.cs	(revision 73984)
+++ Test/System/MathTest.cs	(working copy)
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
@@ -708,34 +708,206 @@
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
+		AssertEquals(Math.Round(a) + " + Min" + " != 3", Math.Round(a + min), 3M);
+		AssertEquals(Math.Round(a) + " - Min" + " != 2", Math.Round(a - min), 2M);
+		
+		//Test 1.5
+		AssertEquals(Math.Round(b) + " != 1", Math.Round(b), 2M);
+		AssertEquals(Math.Round(b) + " + Min" + " != 2", Math.Round(b + min), 2M);
+		AssertEquals(Math.Round(b) + " - Min" + " != 1", Math.Round(b - min), 1M);
+		
+		//Test 0
+		AssertEquals(Math.Round(c) + " != 0", Math.Round(c), 0M);
+		AssertEquals(Math.Round(c) + " + Min" + " != 0", Math.Round(c + min), 0M);
+		AssertEquals(Math.Round(c) + " - Min" + " != 0", Math.Round(c - min), 0M);
+		
+		//Test -1.5
+		AssertEquals(Math.Round(d) + " != -2", Math.Round(d), -2M);
+		AssertEquals(Math.Round(d) + " + Min" + " != -1", Math.Round(d + min), -1M);
+		AssertEquals(Math.Round(d) + " - Min" + " != -2", Math.Round(d - min), -2M);
+		
+		// Test 2.5
+		AssertEquals(Math.Round(e) + " != 2", Math.Round(e), -2M);
+		AssertEquals(Math.Round(e) + " + Min" + " != -2", Math.Round(e + min), -2M);
+		AssertEquals(Math.Round(e) + " - Min" + " != -3", Math.Round(e - min), -3M);
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
-		double a = 1.5D;
-		double b = 2.5D;
+		double min = 0.000000000000001D;
+		double a = 2.5D;
+		double b = 1.5D;
+		double c = 0.0D;
+		double d = -1.5D;
+		double e = -2.5D;
+		
+		// Test 2.5
+		AssertEquals(Math.Round(a) + " != 2", Math.Round(a), 2D);
+		AssertEquals(Math.Round(a) + " + Min" + " != 3", Math.Round(a + min), 3D);
+		AssertEquals(Math.Round(a) + " - Min" + " != 2", Math.Round(a - min), 2D);
+		
+		//Test 1.5
+		AssertEquals(Math.Round(b) + " != 1", Math.Round(b), 2D);
+		AssertEquals(Math.Round(b) + " + Min" + " != 2", Math.Round(b + min), 2D);
+		AssertEquals(Math.Round(b) + " - Min" + " != 1", Math.Round(b - min), 1D);
+		
+		//Test 0
+		AssertEquals(Math.Round(c) + " != 0", Math.Round(c), 0D);
+		AssertEquals(Math.Round(c) + " + Min" + " != 0", Math.Round(c + min), 0D);
+		AssertEquals(Math.Round(c) + " - Min" + " != 0", Math.Round(c - min), 0D);
+		
+		//Test -1.5
+		AssertEquals(Math.Round(d) + " != -2", Math.Round(d), -2D);
+		AssertEquals(Math.Round(d) + " + Min" + " != -1", Math.Round(d + min), -1D);
+		AssertEquals(Math.Round(d) + " - Min" + " != -2", Math.Round(d - min), -2D);
+		
+		// Test 2.5
+		AssertEquals(Math.Round(e) + " != 2", Math.Round(e), -2D);
+		AssertEquals(Math.Round(e) + " + Min" + " != -2", Math.Round(e + min), -2D);
+		AssertEquals(Math.Round(e) + " - Min" + " != -3", Math.Round(e - min), -3D);
 
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
+		//fails. Should return 2.6, but actualy returns 2.5
+		//AssertEquals("Decmial  NMP Rounding toEven", 2.6D , Math.Round(2.55D, 1));
+
+		
+		AssertEquals ("Should round down", Math.Round(a, 1), 3.4D);
+		AssertEquals ("Should round up", Math.Round(b, 1), 3.5D);
+
+		AssertEquals ("Should round down decmial 15", Math.Round(a, 15), 3.45D);
+		
+		AssertEquals ("Negitive doouble rounded to 1 decimal place failed", Math.Round (-0.123456789, 1), -0.1);
+	}
+
+	[Test, ExpectedException (typeof (ArgumentOutOfRangeException))]
+	public void TestDoubleRoundLowerLimitExecption ()
+	{
+		double a = 3.45D;
+		Math.Round(a, -1);
+	}
+
+	[Test, ExpectedException (typeof (ArgumentOutOfRangeException))]
+	public void TestDecmialRoundUpperLimitExecption ()
+	{
+		double a = 3.45D;
+		Math.Round(a, 16);
+	}	
+	
 #if NET_2_0
+
+	[Test, ExpectedException (typeof (ArgumentException))]
+	public void TestRoundDecimalWithDecimalsBadMidpointEnumExecption ()
+	{
+		Math.Round(2.5M, 1, (MidpointRounding)3);
+	}
+
+	[Test, ExpectedException (typeof (ArgumentException))]
+	public void TestRoundDoubleWithDecimalsBadMidpointEnumExecption ()
+	{
+		Math.Round(2.5D, 1, (MidpointRounding)3);
+	}
+
+	[Test, ExpectedException (typeof (ArgumentException))]
+	public void TestRoundDecimalBadMidpointEnumExecption ()
+	{
+		Math.Round(2.5M, (MidpointRounding)3);
+	}
+
+	[Test, ExpectedException (typeof (ArgumentException))]
+	public void TestRoundDoubleBadMidpointEnumExecption ()
+	{
+		Math.Round(2.5D, (MidpointRounding)3);
+	}
+
+	public void TestDecmialRound3 ()
+	{
+		// Add more tests
+		double min = 0.000000000000001D;
+
+		AssertEquals("Decmial Midpoint Rounding toEven", 2M , Math.Round(2.5M, MidpointRounding.ToEven));
+
+		//Not yet implmented
+		//AssertEquals("Decmial Midpoint Rounding AwayFromZero", 3M , Math.Round(2.5M, MidpointRounding.AwayFromZero));
+	}
+	
+	public void TestDoubleRound3 ()
+	{
+		// Add more tests
+		AssertEquals("Decmial Midpoint Rounding toEven", 2D , Math.Round(2.5D, MidpointRounding.ToEven));
+		AssertEquals("Decmial Midpoint Rounding AwayFromZero", 3D , Math.Round(2.5D, MidpointRounding.AwayFromZero));
+	}
+	
+	public void TestDoubleRound4 ()
+	{
+		// Add more tests
+		
+		//fails, should return 2.6, but returns 2.5. Verified against MS .net
+		//AssertEquals("Decmial Midpoint Rounding toEven", 2.6D , Math.Round(2.55D, 1, MidpointRounding.ToEven));
+		
+		//Not yet implmented
+		//AssertEquals("Decmial Midpoint Rounding AwayFromZero", 2.6D , Math.Round(2.55D, 1, MidpointRounding.AwayFromZero));
+	}
+	
+	public void TestDecmialRound4 ()
+	{
+		// Add more tests
+		double min = 0.000000000000001D;
+
+		AssertEquals("Decmial Midpoint Rounding with decimals toEven", 2.6M , Math.Round(2.55M, 1, MidpointRounding.ToEven));
+		
+		//Not yet implmented
+		//AssertEquals("Decmial Midpoint Rounding with decimals AwayFromZero", 2.6M , Math.Round(2.55M, 1, MidpointRounding.AwayFromZero));
+	
+	}
+	
+	
 	public void TestDoubleTruncate ()
 	{
 		double a = 1.2D;
@@ -773,16 +945,6 @@
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
Index: Test/System/ChangeLog
===================================================================
--- Test/System/ChangeLog	(revision 73984)
+++ Test/System/ChangeLog	(working copy)
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
