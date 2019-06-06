--- mcs/class/corlib/System.Globalization/HebrewCalendar.cs
+++ mcs/class/corlib/System.Globalization/HebrewCalendar.cs
@@ -389,7 +389,7 @@
 	/// <remarks>
 	/// <para>
 	/// In .NET the month counting starts with the Hebrew month Tishri.
-	/// Calendrical Calculations starts with the month Tisan. So we must
+	/// Calendrical Calculations starts with the month Nisan. So we must
 	/// map here.
 	/// </para>
 	/// </remarks>
@@ -456,9 +456,7 @@
 	public override int GetDaysInMonth(int year, int month, int era) {
 		M_CheckYME(year, month, ref era);
 		int ccmonth = M_CCMonth(month, year); 
-		int rd1 = CCHebrewCalendar.fixed_from_dmy(1, ccmonth, year);
-		int rd2 = CCHebrewCalendar.fixed_from_dmy(1, ccmonth+1, year);
-		return rd2 - rd1;
+		return CCHebrewCalendar.last_day_of_month(ccmonth, year);
 	}
 
 	/// <summary>