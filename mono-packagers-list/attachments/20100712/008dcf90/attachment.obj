Index: mcs/class/System.Core/System/TimeZoneInfo.cs
===================================================================
--- mcs/class/System.Core/System/TimeZoneInfo.cs	(revision 160268)
+++ mcs/class/System.Core/System/TimeZoneInfo.cs	(revision 160269)
@@ -895,7 +895,8 @@
 				}
 				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName);
 			} else {
-				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName, daylightDisplayName, ValidateRules (adjustmentRules).ToArray ());
+				return CreateCustomTimeZone (id, baseUtcOffset, id, standardDisplayName, daylightDisplayName,
+								(AdjustmentRule []) ValidateRules (adjustmentRules).ToArray ());
 			}
 		}
 
