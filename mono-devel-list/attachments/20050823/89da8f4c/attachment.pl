using System;
using System.IO;
using System.Text;

namespace DetectEncoding
{
	internal class DetectEncoding
	{
		private static void Main(string[] args)
		{
			FileStream fs = new FileStream(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "input.txt"), FileMode.Open, FileAccess.Read, FileShare.Read);
			UTF8Encoding validatedUft8 = new UTF8Encoding(true, true);
			StreamReader sr;

			try
			{
				fs.Position = 0;
				sr = new StreamReader(fs, validatedUft8, true);
				GC.SuppressFinalize(sr);
				try
				{
					Console.WriteLine(sr.ReadToEnd());
				}
				catch (ArgumentException)
				{
					fs.Position = 0;
					sr = new StreamReader(fs, Encoding.Default, true);
					GC.SuppressFinalize(sr);
					Console.WriteLine(sr.ReadToEnd());
				}
				Console.WriteLine(sr.CurrentEncoding.EncodingName);
				Console.ReadLine();
			}
			finally
			{
				fs.Close();
			}
		}
	}
}