#define perf

using System;

public class MyClass
{
	public static void Main()
	{
#if perf
long start = DateTime.Now.Ticks;
for (int x = 0; x < 100; x++) { // configure with your environment.
#else
		int total = 0;
#endif
		// It would be nice if you also limit them for ASCII range, the
		// most frequently used character ranges.
		for (int i = 0; i < 65536; i++)
//			if (Char.IsWhiteSpace ((char) i))
//			if (Char.IsSeparator ((char) i))
			if (Char.IsDigit ((char) i))
//			if (Char.IsNumber ((char) i))
#if perf
;
#else
			{
				Console.WriteLine (i.ToString ("x"));
				total++;
			}
#endif
#if perf
}
long end = DateTime.Now.Ticks;
		Console.WriteLine (end - start);
#else
		Console.WriteLine ("total found " + total + " chars.");
#endif
	}
}

