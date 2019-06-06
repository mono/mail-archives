using System;
using System.Diagnostics;
using System.IO;
using System.Text;

namespace Test
{
	public class Test
	{
		public static int loop;
		public static string s;

		public static void Main(string[] args)
		{
			loop = args.Length > 1 ? int.Parse(args[1]) : 100;
			s = File.OpenText(args[0]).ReadToEnd();

			Do(Encoding.Unicode);
			Do(Encoding.ASCII);
			Do(Encoding.UTF8);
			Do(Encoding.GetEncoding(932));
		}

		public static void Do(Encoding e)
		{
			Stopwatch sw = Stopwatch.StartNew();
			for (int i = 0; i < loop; i++)
				e.GetBytes(s);
			sw.Stop();
			Console.WriteLine(e.GetType().Name + ": " + sw.ElapsedMilliseconds.ToString());
		}
	}
}
