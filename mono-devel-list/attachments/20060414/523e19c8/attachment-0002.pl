#warning Use option -codepage:65001
using System;
using System.Globalization;
using System.Text;

public class TestClass
{
	public static void Main ()
	{
		foreach (string name in Enum.GetNames (typeof (NormalizationForm))) {
			NormalizationForm f = (NormalizationForm) Enum.Parse (typeof (NormalizationForm), name);
			Console.WriteLine ("==== normalization form " + f, f);
			Test("一〇〇〇〇", f);
			Test("0", f);
			Test("０", f);
			Test("\u3042", f);
			Test("\u3042\u0300", f);
			Test("A", f);
			Test("a", f);
			Test("Ａ", f);
			Test("\u2159", f);
			Test("1/6", f);
			Test("1\u20446", f);
			Test("ダイヴ", f);
			Test("タ゛イウ゛", f);
			Test("ﾀﾞｲｳﾞ", f);
			Test("\u01E3", f);
			Test("\uFDFA", f);
		}
	}

	static void Test (string s, NormalizationForm f)
	{
		Console.Write (s.IsNormalized (f));
		Console.Write (" : ");
		string norm = s.Normalize (f);
		Console.Write (norm + "(");
		foreach (char c in norm)
			Console.Write ("{0:x} ", (int) c);
		Console.WriteLine (")");
	}
}
