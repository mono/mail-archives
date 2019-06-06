using System;
using System.Data;

public class Test
{
	public static void Main ()
	{
		DateTime start = DateTime.Now;
		DataTable dt = new DataTable ("table1");
		dt.Columns.Add ("col1");
		dt.Columns.Add ("col2");
		dt.Columns.Add ("col3");
		for (int i = 0; i < 5000; i++)
			dt.Rows.Add (new object [] {"a", "b", "c"});
		Console.WriteLine ("{0}, {1}",
			DateTime.Now - start, DateTime.Now.Ticks - start.Ticks);
	}
}

