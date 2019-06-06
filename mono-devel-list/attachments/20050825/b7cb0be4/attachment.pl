using System;
using System.Text;

namespace DetectEncoding
{
	internal class DetectEncoding
	{
		private static void Main(string[] args)
		{
			Console.WriteLine(Encoding.Default.EncodingName);
			Console.WriteLine(Encoding.Default.WebName);
			Console.WriteLine(Encoding.Default.CodePage);
		}
	}
}