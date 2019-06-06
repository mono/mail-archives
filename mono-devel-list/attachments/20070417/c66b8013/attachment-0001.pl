using System;
using System.Collections;
using System.Xml;
using System.Configuration;

public class Test
{
	public static void Main ()
	{
		Configuration c = ConfigurationManager.OpenExeConfiguration (
			ConfigurationUserLevel.None);
		ConfigurationSectionCollection col = 
			c.GetSectionGroup ("system.web").Sections;
		foreach (object o in col)
			Console.WriteLine (o.GetType ());
		// it works fine.
		Console.WriteLine (col [0]);
		IEnumerator e = col.GetEnumerator ();
		e.MoveNext ();
		Console.WriteLine (e.Current.GetType ());
	}
}
