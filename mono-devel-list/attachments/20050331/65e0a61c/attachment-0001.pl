using System;
using System.Globalization;

public class Test
{
public static void Main ()
{
	char [] inv = new char [65536];
	for (int i = 0; i < 65536; i++)
		inv [i] = Char.ToLower ((char) i, CultureInfo.InvariantCulture);

	for (int i = 0; i < 32768; i++) {
		CultureInfo ci = null;
		try {
			ci = new CultureInfo (i);
		} catch (Exception) {
			continue;
		}
		Console.Write ("Culture {0} {1} : ", i, ci.Name);
		TextInfo ti = ci.TextInfo;
		for (int c = 0; c < 65536; c++) {
			if (ti.ToLower ((char) c) != inv [c])
				Console.Write ("{0:x}({1:x}) ", c, (int) ti.ToLower ((char) c));
		}
		Console.WriteLine ();
	}
}
}
