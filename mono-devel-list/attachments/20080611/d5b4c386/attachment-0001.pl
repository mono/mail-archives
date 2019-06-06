/* The Computer Benchmarks Game
 * http://shootout.alioth.debian.org/
 *
 * contributed by Isaac Gouy
 * modified by Antti Lankila for generics
 * modified by A.Nahr for performance and throwing unneccesary stuff out
 */

using System;
using System.IO;
using System.Collections.Generic;
using System.Text;

public class program
{
	public static void Main (string[] args)
	{
		string line;
		StreamReader source = new StreamReader (Console.OpenStandardInput ());
		StringBuilder input = new StringBuilder (10240);

		while ((line = source.ReadLine ()) != null)
		{
			if (line[0] == '>' && line.Substring (1, 5) == "THREE")
				break;
		}

		while ((line = source.ReadLine ()) != null)
		{
			char c = line[0];
			if (c == '>')
				break;
			if (c != ';')
				input.Append (line);
		}

		KNucleotide kn = new KNucleotide (input.ToString ().ToUpperInvariant ());
		input = null;
		kn.WriteFrequencies (1);
		kn.WriteFrequencies (2);

		kn.WriteCount ("GGT");
		kn.WriteCount ("GGTA");
		kn.WriteCount ("GGTATT");
		kn.WriteCount ("GGTATTTTAATT");
		kn.WriteCount ("GGTATTTTAATTTATAGT");
	}
}

public class KNucleotide
{
	private Dictionary<string, int> frequencies = new Dictionary<string, int> ();
	private string sequence;

	public KNucleotide (string s)
	{
		sequence = s;
	}

	public void WriteFrequencies (int nucleotideLength)
	{
		GenerateFrequencies (nucleotideLength);

		List<KeyValuePair<string, int>> items = new List<KeyValuePair<string, int>> (frequencies);
		items.Sort (SortByFrequencyAndCode);

		int sum = sequence.Length - nucleotideLength + 1;
		foreach (KeyValuePair<string, int> each in items)
		{
			double percent = each.Value * 100.0 / sum;
			Console.WriteLine ("{0} {1:f3}", each.Key, percent);
		}
		Console.WriteLine ();
	}

	public void WriteCount (string nucleotideFragment)
	{
		GenerateFrequencies (nucleotideFragment.Length);

		int count = 0;
		if (frequencies.ContainsKey (nucleotideFragment))
			count = frequencies[nucleotideFragment];
		Console.WriteLine ("{0}\t{1}", count, nucleotideFragment);
	}

	private void GenerateFrequencies (int length)
	{
		frequencies.Clear ();
		for (int frame = 0; frame < length; frame++)
			KFrequency (frame, length);
	}

	private unsafe void KFrequency (int readingFrame, int k)
	{
		String knucleo = pre[k];
		fixed (char* target = knucleo, source = sequence)
		{
			int n = sequence.Length - k + 1;

			for (int i = readingFrame; i < n; i += k)
			{
				for (int j = 0; j < k; j++)
					target[j] = source[i + j];

				int value;
				bool isOld = frequencies.TryGetValue (knucleo, out value);
				if (isOld)
					frequencies[knucleo] = value + 1;
				else
					frequencies[new String (target, 0, k)] = 1;
			}
		}
	}

	private String[] pre = {
	"", ".", "..", "...", "....", "", "......", "", "", "", "", "", "............", "", "", "", "", "", ".................."};

	int SortByFrequencyAndCode (KeyValuePair<string, int> item1, KeyValuePair<string, int> item2)
	{
		int comparison = item2.Value.CompareTo (item1.Value);
		if (comparison == 0) return item1.Key.CompareTo (item2.Key);
		else return comparison;
	}
}
