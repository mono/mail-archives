Index: System/TimeZone.cs
===================================================================
--- System/TimeZone.cs	(revision 49638)
+++ System/TimeZone.cs	(working copy)
@@ -108,27 +108,33 @@
 
 		public virtual DateTime ToLocalTime (DateTime time)
 		{
-//			return time + GetUtcOffset (time);
-			TimeSpan offset = GetUtcOffset (time);
-
-			if (offset.Ticks > 0) {
-				if (DateTime.MaxValue - offset < time)
+			DaylightTime dlt = GetDaylightChanges (time.Year);
+			TimeSpan utcOffset = GetUtcOffset (time);
+			if (utcOffset.Ticks > 0) {
+				if (DateTime.MaxValue - utcOffset < time)
 					return DateTime.MaxValue;
-			} else if (offset.Ticks < 0) {
-				// MS.NET fails to check validity here 
-				// - it may throw ArgumentOutOfRangeException
-				/*
-				if (DateTime.MinValue - offset > this)
-					return DateTime.MinValue;
-				*/
+			//} else if (utcOffset.Ticks < 0) {
+			//	LAMESPEC: MS.NET fails to check validity here
+			//	it may throw ArgumentOutOfRangeException.
 			}
-			
-			DateTime lt = new DateTime (time.Ticks + offset.Ticks);
-			TimeSpan ltoffset = GetUtcOffset (lt);
-			if (ltoffset != offset)
-				lt = lt.Add (ltoffset.Subtract (offset));
 
-			return lt;
+			DateTime local = time.Add (utcOffset);
+			if (dlt.Delta.Ticks == 0)
+				return local;
+
+			// FIXME: check all of the combination of
+			//	- basis: local-based or UTC-based
+			//	- hemisphere: Northern or Southern
+			//	- offset: positive or negative
+
+			// PST should work fine here.
+			if (local < dlt.End && dlt.End.Subtract (dlt.Delta) <= local)
+				return local;
+			if (local >= dlt.Start && dlt.Start.Add (dlt.Delta) > local)
+				return local.Subtract (dlt.Delta);
+
+			TimeSpan localOffset = GetUtcOffset (local);
+			return time.Add (localOffset);
 		}
 
 		public virtual DateTime ToUniversalTime (DateTime time)
