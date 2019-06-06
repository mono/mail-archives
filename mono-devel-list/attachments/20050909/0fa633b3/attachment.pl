using System;
using System.Data;

public class test
{
	public static void Main ()
	{
		DataTable dt = new DataTable ();
		dt.Columns.Add ("foo", typeof (Version));
		dt.Rows.Add (new object [] {"heh, this is just a string."});
		Console.WriteLine (
			"The value stored nominally as {0} is actually {1}",
				dt.Columns [0].DataType, 
				dt.Rows [0] [dt.Columns [0]].GetType ());
	}
}

