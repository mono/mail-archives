Index: System/DateTime.cs
===================================================================
--- System/DateTime.cs	(revision 49519)
+++ System/DateTime.cs	(working copy)
@@ -228,20 +228,8 @@
 		/// </summary>
 		/// 
 		public DateTime (long newticks)
-			// `local' must default to false here to avoid
-			// a recursion loop.
-			: this (false, newticks) {}
-
-		internal DateTime (bool local, long newticks)
 		{
 			ticks = new TimeSpan (newticks);
-			if (local) {
-				TimeZone tz = TimeZone.CurrentTimeZone;
-
-				TimeSpan utcoffset = tz.GetUtcOffset (this);
-
-				ticks = ticks + utcoffset;
-			}
 			if (ticks.Ticks < MinValue.Ticks || ticks.Ticks > MaxValue.Ticks)
 			    throw new ArgumentOutOfRangeException ();
 		}
@@ -381,7 +369,7 @@
 		{
 			get	
 			{
-				return new DateTime (true, GetNow ());
+				return new DateTime (GetNow ()).ToLocalTime ();
 			}
 		}
 
@@ -569,7 +557,7 @@
 			if (fileTime < 0)
 				throw new ArgumentOutOfRangeException ("fileTime", "< 0");
 
-			return new DateTime (true, w32file_epoch + fileTime);
+			return new DateTime (w32file_epoch + fileTime).ToLocalTime ();
 		}
 
 #if NET_1_1
@@ -578,7 +566,7 @@
 			if (fileTime < 0)
 				throw new ArgumentOutOfRangeException ("fileTime", "< 0");
 
-			return new DateTime (false, w32file_epoch + fileTime);
+			return new DateTime (w32file_epoch + fileTime);
 		}
 #endif
 
@@ -1314,7 +1304,9 @@
 
 			long newticks = (result.ticks - utcoffset).Ticks;
 
-			result = new DateTime (use_localtime, newticks);
+			result = new DateTime (newticks);
+			if (use_localtime)
+				result = result.ToLocalTime ();
 
 			return true;
 		}
