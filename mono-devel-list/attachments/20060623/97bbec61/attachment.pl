using System;
using System.Text;

namespace UnicodeByteOrderMarkTest
{
	class UnicodeByteOrderMarkTest
	{
		static void Main(string[] args)
		{
			string s = "Some text";
			UnicodeEncoding littleEndian = new UnicodeEncoding(false, true);
			UnicodeEncoding bigEndian = new UnicodeEncoding(true, true);
			byte[] littleEndianBytes = new byte[littleEndian.GetPreamble().Length + littleEndian.GetByteCount(s)];
			byte[] bigEndianBytes = new byte[bigEndian.GetPreamble().Length + bigEndian.GetByteCount(s)];

			Array.Copy(littleEndian.GetPreamble(), 0, littleEndianBytes, 0, littleEndian.GetPreamble().Length);
			littleEndian.GetBytes(s, 0, s.Length, littleEndianBytes, littleEndian.GetPreamble().Length);
			Array.Copy(bigEndian.GetPreamble(), 0, bigEndianBytes, 0, bigEndian.GetPreamble().Length);
			bigEndian.GetBytes(s, 0, s.Length, bigEndianBytes, bigEndian.GetPreamble().Length);

			Console.WriteLine(littleEndian.GetString(littleEndianBytes).Length.ToString());
			Console.WriteLine(littleEndian.GetString(littleEndianBytes));
			Console.WriteLine(littleEndian.GetString(bigEndianBytes).Length.ToString());
			Console.WriteLine(littleEndian.GetString(bigEndianBytes));

			Console.WriteLine(bigEndian.GetString(littleEndianBytes).Length.ToString());
			Console.WriteLine(bigEndian.GetString(littleEndianBytes));
			Console.WriteLine(bigEndian.GetString(bigEndianBytes).Length.ToString());
			Console.WriteLine(bigEndian.GetString(bigEndianBytes));

			char[] littleEndianChars = new char[littleEndian.GetDecoder().GetCharCount(littleEndianBytes, 0, littleEndianBytes.Length)];
			littleEndian.GetDecoder().GetChars(littleEndianBytes, 0, littleEndianBytes.Length, littleEndianChars, 0);
			Console.WriteLine(new string(littleEndianChars));
			littleEndian.GetDecoder().GetChars(bigEndianBytes, 0, bigEndianBytes.Length, littleEndianChars, 0);
			Console.WriteLine(new string(littleEndianChars));

			char[] bigEndianChars = new char[bigEndian.GetDecoder().GetCharCount(bigEndianBytes, 0, bigEndianBytes.Length)];
			bigEndian.GetDecoder().GetChars(littleEndianBytes, 0, littleEndianBytes.Length, bigEndianChars, 0);
			Console.WriteLine(new string(bigEndianChars));
			bigEndian.GetDecoder().GetChars(bigEndianBytes, 0, bigEndianBytes.Length, bigEndianChars, 0);
			Console.WriteLine(new string(bigEndianChars));
		}
	}
}
