using System;
using System.Globalization;
using System.IO;
using System.Text;

public class Test
{
	public static void Main (string [] args)
	{
		string txt = new StreamReader ("sample.txt").ReadToEnd ();

		for (int i = 0; i < 8; i++)
			txt += txt;
		Console.WriteLine ("string size is " + txt.Length);

		StringBuilder sb = new StringBuilder ();
		sb.Append (txt);
		sb.Append ("A");
		string txt2 = sb.ToString ();

		CompareInfo ci = new CultureInfo ("en-US").CompareInfo;
		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		Console.WriteLine (GC.GetTotalMemory (false));

//for (int i = 1; i < txt.Length; i++)
//if (ci.Compare (txt, 0, i, txt, 0, i) != 0)
//	throw new Exception ("At " + i);

		ci.Compare (txt, txt2, CompareOptions.IgnoreSymbols); // dummy
		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		DateTime start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			if (ci.Compare (txt, txt2, CompareOptions.Ordinal) == 0)
				throw new Exception (ci.Compare (txt, txt).ToString ());
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));

		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			if (ci.Compare (txt, txt2, CompareOptions.None) == 0)
				throw new Exception ();
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));

		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			ci.Compare (txt, txt2, CompareOptions.StringSort);
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));

		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			ci.Compare (txt, txt2, CompareOptions.IgnoreCase);
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));

		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			ci.Compare (txt, txt2, CompareOptions.IgnoreSymbols);
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));

		GC.Collect (0); GC.Collect (1); GC.Collect (2);
		start = DateTime.Now;
//		for (int i = 0; i < 20; i++)
			ci.Compare (txt, txt2, CompareOptions.IgnoreKanaType);
		Console.WriteLine ((DateTime.Now.Ticks - start.Ticks) + " / " + GC.GetTotalMemory (false));
	}
}


