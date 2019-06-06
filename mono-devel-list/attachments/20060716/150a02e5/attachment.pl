using System;
using System.Text;

namespace CreateStringTest
{
	class CreateStringTest
	{
		unsafe static void Main(string[] args)
		{
			Encoding encoding = Encoding.GetEncoding(28591);
			byte[] bytes = encoding.GetBytes(new string('x', 4096));
			int byteCount = bytes.Length;
			string s;
			DateTime date;

			date = DateTime.Now;
			fixed (byte* bytePtr = bytes)
				for (int i = 0; i < 1000000; i++)
					s = new string((sbyte*) bytePtr, 0, byteCount, encoding);

			Console.WriteLine((long)DateTime.Now.Subtract(date).TotalMilliseconds);
		}
	}
}
