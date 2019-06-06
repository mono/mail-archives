Index: Math.cs
===================================================================
--- Math.cs	(revision 73696)
+++ Math.cs	(working copy)
@@ -373,27 +373,27 @@
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
+			    throw new NotImplementedException ();
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
+			    throw new NotImplementedException ();
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
 		}
 #endif
 
-		[MethodImplAttribute (MethodImplOptions.InternalCall)]
+        [MethodImplAttribute (MethodImplOptions.InternalCall)]
 		public extern static double Round (double d);
 
 		public static double Round (double value, int digits)
@@ -411,26 +411,25 @@
 #if NET_2_0
 		public static double Round (double value, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
 			if (mode == MidpointRounding.ToEven)
 				return Round (value);
 			if (value > 0)
 				return Floor (value + 0.5);
 			else
 				return Ceiling (value - 0.5);
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
 		}
 
 		[MonoTODO ("Not implemented")]
 		public static double Round (double value, int digits, MidpointRounding mode)
 		{
-			if ((mode != MidpointRounding.ToEven) && (mode != MidpointRounding.AwayFromZero))
-				throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
-
-			if (mode == MidpointRounding.ToEven)
+            if (mode == MidpointRounding.ToEven)
 				return Round (value, digits);
-			throw new NotImplementedException ();
+			if (mode == MidpointRounding.ToEven)
+			    throw new NotImplementedException ();
+
+			throw new ArgumentException ("The value '" + mode + "' is not valid for this usage of the type MidpointRounding.", "mode");
 		}
 
 		public static double Truncate (double d)
@@ -454,7 +453,7 @@
 		}
 #endif
 
-		public static int Sign (decimal value)
+        public static int Sign (decimal value)
 		{
 			if (value > 0) return 1;
 			return (value == 0)? 0: -1;
