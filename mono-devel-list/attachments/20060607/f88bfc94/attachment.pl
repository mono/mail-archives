using System;
using System.Globalization;
using System.Text;

namespace UnicodeEncodingPerformance
{
	internal class UnicodeEncodingPerformance
	{
		private static Encoding encoding;

		private static void Main(string[] args)
		{
			encoding = Encoding.GetEncoding(1252);
			Console.WriteLine("length, conversion: time");
			Convert(1, 10000000);
			Convert(4, 10000000);
			Convert(1024, 1000000);
			Convert(1048576, 1000);
		}

		private static void Convert(int length, int count)
		{
			string s;
			char[] c;
			byte[] b;
			DateTime startTime;

			s = new string('x', length);
			c = new char[length];
			s.CopyTo(0, c, 0, length);
			b = new byte[length];

			startTime = DateTime.Now;
			for (int index = 0; index < count; index++)
				encoding.GetString(b);
			WriteResult(length, "byte[]", startTime, DateTime.Now);

			startTime = DateTime.Now;
			for (int index = 0; index < count; index++)
				encoding.GetString(b, 0, length);
			WriteResult(length, "byte[] int int", startTime, DateTime.Now);
		}

		private static void WriteResult(int length, string args, DateTime startTime, DateTime endTime)
		{
			Console.WriteLine(length.ToString(CultureInfo.InvariantCulture) + ", " + args + ": " + ((long)endTime.Subtract(startTime).TotalMilliseconds).ToString(CultureInfo.InvariantCulture));
		}
	}
}
