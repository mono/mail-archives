using System;
using System.IO;
using System.Globalization;

class CharMicroBenchs
{
	static int CountControlChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsControl (s [i]))
				r++;

		return r;
	}

	static int CountDigitChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsDigit (s [i]))
				r++;

		return r;
	}

	static int CountLetterChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsLetter (s [i]))
				r++;

		return r;
	}

	static int CountLetterOrDigitChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsLetterOrDigit (s [i]))
				r++;

		return r;
	}

	static int CountLowerChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsLower (s [i]))
				r++;

		return r;
	}

	static int CountNumberChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsNumber (s [i]))
				r++;

		return r;
	}

	static int CountPunctuationChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsPunctuation (s [i]))
				r++;

		return r;
	}

	static int CountSeparatorChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsSeparator (s [i]))
				r++;

		return r;
	}

	static int CountSurrogateChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsSurrogate (s [i]))
				r++;

		return r;
	}

	static int CountSymbolChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsSymbol (s [i]))
				r++;

		return r;
	}

	static int CountUpperChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsUpper (s [i]))
				r++;

		return r;
	}

	static int CountWhiteSpaceChars (char [] s)
	{
		int r = 0;

		for (int i = 0; i < s.Length; i++)
			if (Char.IsWhiteSpace (s [i]))
				r++;

		return r;
	}

	static void CountCategories (char [] s, int [] counters, int offset)
	{
		for (int i = 0; i < s.Length; i++) {
			int c = (int)Char.GetUnicodeCategory (s [i]);

			counters [offset + c]++;
		}
	}

	static void RunOnce (char [] s, int [] counters)
	{
		int i = 0;

		counters [i++] = CountControlChars (s);
		counters [i++] = CountDigitChars (s);
		counters [i++] = CountLetterChars (s);
		counters [i++] = CountLetterOrDigitChars (s);
		counters [i++] = CountLowerChars (s);
		counters [i++] = CountNumberChars (s);
		counters [i++] = CountPunctuationChars (s);
		counters [i++] = CountSeparatorChars (s);
		counters [i++] = CountSurrogateChars (s);
		counters [i++] = CountSymbolChars (s);
		counters [i++] = CountUpperChars (s);
		counters [i++] = CountWhiteSpaceChars (s);

		CountCategories (s, counters, i);
	}

	static readonly string [] predicates = new string [] {
		"IsControl",
		"IsDigit",
		"IsLetter",
		"IsLetterOrDigit",
		"IsLower",
		"IsNumber",
		"IsPunctuation",
		"IsSeparator",
		"IsSurrogate",
		"IsSymbol",
		"IsUpper",
		"IsWhiteSpace"
	};

	static void RunNTimes (int n, bool breaking, bool printing, char [] s, int [] counters)
	{
		for (int i = 0; i < n; i++) {
			if (breaking)
				System.Diagnostics.Debugger.Break ();

			RunOnce (s, counters);

			if (!printing)
				continue;

			Console.WriteLine ("Iter {0} finished", i);

			for (int j = 0; j < counters.Length; j++) {
				string label = j < predicates.Length ?
					predicates [j] + "?" :
					((UnicodeCategory) (j - predicates.Length)).ToString () + ":";

				Console.WriteLine ("\t{0} {1} ", label, counters [j]);
				counters [j] = 0;
			}
		}
	}

	static void Main (string [] args) {
		const int n_categories = ((int) UnicodeCategory.OtherNotAssigned) + 1;

		int [] counters = new int [predicates.Length + n_categories];
		int n = 10;
		bool breaking = false;
		bool printing = false;
		char [] s = "Hello, World!".ToCharArray ();

		for (int i = 0; i < args.Length; ) {
			if (args [i] == "--load") {
				using (TextReader r = new StreamReader (args [i + 1]))
					s = r.ReadToEnd ().ToCharArray ();
				i += 2;
			} else if (args [i] == "--repeat") {
				n = int.Parse (args [i + 1]);
				i += 2;
			} else if (args [i] == "--run") {
				RunNTimes (n, breaking, printing, s, counters);
				i++;
			} else if (args [i] == "--print" || args [i] == "--no-print") {
				printing = args [i] == "--print";
				i++;
			} else if (args [i] == "--break" || args [i] == "--no-break") {
				breaking = args [i] == "--break";
				i++;
			} else {
				throw new Exception ("Unrecognized argument " + args [i]);
			}
		}
	}
}
