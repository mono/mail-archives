Index: mcs/class/System.Core/System/TimeZoneInfo.cs
===================================================================
--- mcs/class/System.Core/System/TimeZoneInfo.cs	(revision 160268)
+++ mcs/class/System.Core/System/TimeZoneInfo.cs	(working copy)
@@ -380,9 +380,22 @@
 			else
 				ParseRegTzi(adjustmentRules, 1, 9999, reg_tzi);
 
-			return CreateCustomTimeZone (id, baseUtcOffset, display_name, standard_name, daylight_name, ValidateRules (adjustmentRules).ToArray ());
+			return CreateCustomTimeZone (id, baseUtcOffset, display_name, standard_name, daylight_name,
+							(AdjustmentRule []) ValidateRules (adjustmentRules).ToArray ());
 		}
 
+		static List<AdjustmentRule> ValidateRules (List<AdjustmentRule> adjustmentRules)
+		{
+			AdjustmentRule prev = null;
+			foreach (AdjustmentRule current in adjustmentRules.ToArray ()) {
+				if (prev != null && prev.DateEnd > current.DateStart) {
+					adjustmentRules.Remove (current);
+				}
+				prev = current;
+			}
+			return adjustmentRules;
+		}
+
 		private static void ParseRegTzi (List<AdjustmentRule> adjustmentRules, int start_year, int end_year, byte [] buffer)
 		{
 			//int standard_bias = BitConverter.ToInt32 (buffer, 4); /* not sure how to handle this */
@@ -895,22 +908,11 @@
 				}
 				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName);
 			} else {
-				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName, daylightDisplayName, ValidateRules (adjustmentRules).ToArray ());
+				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName, daylightDisplayName,
+								(AdjustmentRule []) ValidateRules (adjustmentRules).ToArray ());
 			}
 		}
 
-		static List<AdjustmentRule> ValidateRules (List<AdjustmentRule> adjustmentRules)
-		{
-			AdjustmentRule prev = null;
-			foreach (AdjustmentRule current in adjustmentRules.ToArray ()) {
-				if (prev != null && prev.DateEnd > current.DateStart) {
-					adjustmentRules.Remove (current);
-				}
-				prev = current;
-			}
-			return adjustmentRules;
-		}
-
 		static Dictionary<int, string> ParseAbbreviations (byte [] buffer, int index, int count)
 		{
 			var abbrevs = new Dictionary<int, string> ();
