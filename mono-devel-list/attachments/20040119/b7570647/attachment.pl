? regexIgnoreCase.patch
? regexUnified.patch
? regexUnified2.patch
Index: interval.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/interval.cs,v
retrieving revision 1.1
diff -u -r1.1 interval.cs
--- interval.cs	31 Jan 2002 08:00:16 -0000	1.1
+++ interval.cs	19 Jan 2004 15:16:22 -0000
@@ -95,6 +95,14 @@
 			return low <= i && i <= high;
 		}
 
+		public bool Intersects (Interval i) {
+ 			if (IsEmpty || i.IsEmpty)
+ 				return false;
+ 			
+ 			return ((Contains (i.low) && !Contains (i.high)) ||
+				(Contains (i.high) && !Contains (i.low)));
+ 		}	
+
 		public void Merge (Interval i) {
 			if (i.IsEmpty)
 				return;
Index: syntax.cs
===================================================================
RCS file: /mono/mcs/class/System/System.Text.RegularExpressions/syntax.cs,v
retrieving revision 1.1
diff -u -r1.1 syntax.cs
--- syntax.cs	31 Jan 2002 08:00:16 -0000	1.1
+++ syntax.cs	19 Jan 2004 15:16:23 -0000
@@ -779,11 +779,39 @@
 		}
 
 		public void AddCharacter (char c) {
-			intervals.Add (new Interval (c, c));
+			// TODO: this is certainly not the most efficient way of doing things 
+ 			// TODO: but at least it produces correct results. 
+ 			AddRange (c, c);
 		}
 
 		public void AddRange (char lo, char hi) {
-			intervals.Add (new Interval (lo, hi));
+			Interval new_interval = new Interval (lo, hi);
+ 
+ 			// ignore case is on. we must make sure our interval does not
+ 			// use upper case. if it does, we must normalize the upper case
+ 			// characters into lower case. 
+ 			if (ignore) {
+ 				if (upper_case_characters.Intersects (new_interval)) {
+ 					Interval partial_new_interval;
+ 
+ 					if (new_interval.low < upper_case_characters.low) {
+ 						partial_new_interval = new Interval (upper_case_characters.low + distance_between_upper_and_lower_case, 
+ 										     new_interval.high +  distance_between_upper_and_lower_case);
+ 						new_interval.high = upper_case_characters.low - 1;
+ 					}
+ 					else {
+ 						partial_new_interval = new Interval (new_interval.low + distance_between_upper_and_lower_case, 
+ 										     upper_case_characters.high + distance_between_upper_and_lower_case);
+ 						new_interval.low = upper_case_characters.high + 1;
+ 					}
+ 					intervals.Add (partial_new_interval);
+ 				}
+ 				else if (upper_case_characters.Contains (new_interval)) {
+ 					new_interval.high += distance_between_upper_and_lower_case;
+ 					new_interval.low += distance_between_upper_and_lower_case;
+ 				}
+ 			}
+ 			intervals.Add (new_interval);
 		}
 
 		public override void Compile (ICompiler cmp, bool reverse) {
@@ -871,6 +899,8 @@
 				return 3;					// Range
 		}
 
+		private static Interval upper_case_characters = new Interval ((char)65, (char)90);
+ 		private const int distance_between_upper_and_lower_case = 32;
 		private bool negate, ignore;
 		private bool[] pos_cats, neg_cats;
 		private IntervalCollection intervals;
