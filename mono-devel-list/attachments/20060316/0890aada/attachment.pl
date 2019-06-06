using System;
using System.Globalization;
using System.Text;

namespace UnicodeEncodingPerformance
{
	internal class UnicodeEncodingPerformance
	{
		private static void Main(string[] args)
		{
			Console.WriteLine("length, conversion, endian: time");
			Convert(1, 10000000);
			Convert(4, 10000000);
			Convert(1024, 100000);
			Convert(1048576, 100);
		}

		private static void Convert(int length, int count)
		{
			Convert(length, count, true);
			Convert(length, count, false);
		}
		
		private static void Convert(int length, int count, bool sameEndian)
		{
			UnicodeEncoding encoding;
			int byteCount;
			string s;
			char[] c;
			byte[] b;
			DateTime startTime;

			encoding = new UnicodeEncoding(BitConverter.IsLittleEndian ^ sameEndian, false);
			byteCount = length * 2;
			s = new string('x', length);
			c = new char[length];
			s.CopyTo(0, c, 0, length);
			b = new byte[byteCount];

			startTime = DateTime.Now;
			for (int index = 0; index < count; index++)
				encoding.GetBytes(s, 0, length, b, 0);
			WriteResult(length, "string to byte[]", sameEndian, startTime, DateTime.Now);

			startTime = DateTime.Now;
			for (int index = 0; index < count; index++)
				encoding.GetBytes(c, 0, length, b, 0);
			WriteResult(length, "char[] to byte[]", sameEndian, startTime, DateTime.Now);
		
			startTime = DateTime.Now;
			for (int index = 0; index < count; index++)
				encoding.GetChars(b, 0, byteCount, c, 0);
			WriteResult(length, "byte[] to char[]", sameEndian, startTime, DateTime.Now);
		}

		private static void WriteResult(int length, string args, bool sameEndian, DateTime startTime, DateTime endTime)
		{
			Console.WriteLine(length.ToString(CultureInfo.InvariantCulture) + ", " + args + ", " + (sameEndian ? "same" : "diff") + ": " + ((long)endTime.Subtract(startTime).TotalMilliseconds).ToString(CultureInfo.InvariantCulture));
		}
	}
}
