Index: Math.cs
===================================================================
--- Math.cs	(revision 73696)
+++ Math.cs	(working copy)
@@ -1,4 +1,4 @@
-//
+﻿//
 // System.Math.cs
 //
 // Authors:
@@ -373,23 +373,23 @@
 		[MonoTODO ("Not implemented")]
 		public static decimal Round (decimal d, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (d);
-			throw new NotImplementedException ();
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
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
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
 		}
 #endif
 
@@ -411,26 +411,26 @@
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
+			if (mode == MidpointRounding.AwayFromZero){
+				if (value > 0)
+					return Floor (value + 0.5);
+				else
+					return Ceiling (value - 0.5);
+			}
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
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
+			if (mode == MidpointRounding.AwayFromZero)
+				throw new NotImplementedException ();
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
 		}
 
 		public static double Truncate (double d)
