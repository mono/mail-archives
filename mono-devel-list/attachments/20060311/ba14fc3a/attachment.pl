using System;

namespace ByteArrayCharArray
{
	internal class ByteArrayCharArray
	{
		private static void Main(string[] args)
		{
			string s = "Some string.";
			char[] cs = s.ToCharArray();
			byte[] bs;
			char[] cs2;

			bs = new byte[cs.Length * 2];
			cs2 = new char[cs.Length];
			GetBytes(cs, 0, cs.Length, bs, 0, false);
			GetChars(bs, 0, bs.Length, cs2, 0, false);
			Console.WriteLine("\"" + new string(cs2) + "\"");

			bs = new byte[cs.Length * 2];
			cs2 = new char[cs.Length];
			GetBytes(cs, 0, cs.Length, bs, 0, true);
			GetChars(bs, 0, bs.Length, cs2, 0, true);
			Console.WriteLine("\"" + new string(cs2) + "\"");

			Console.ReadLine();
		}

		unsafe private static int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, bool bigEndian)
		{
			if (BitConverter.IsLittleEndian != bigEndian)
				Buffer.BlockCopy(bytes, byteIndex, chars, charIndex, byteCount);
			else
			{
				fixed (byte* bytePtr = &bytes[byteIndex])
					fixed (char* charPtr = &chars[charIndex])
					{
						byte* srcPrt;
						byte* lastSrcPrt = bytePtr + byteCount;
						byte* dstPrt = (byte*)charPtr;

						for (srcPrt = bytePtr; srcPrt < lastSrcPrt; srcPrt += 2)
						{
							*(dstPrt++) = srcPrt[1];
							*(dstPrt++) = srcPrt[0];
						}
					}
			}
			return byteCount / 2;
		}

		unsafe private static int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, bool bigEndian)
		{
			int byteCount = charCount * 2;

			if (BitConverter.IsLittleEndian != bigEndian)
				Buffer.BlockCopy(chars, charIndex, bytes, byteIndex, byteCount);
			else
			{
				fixed (char* charPtr = &chars[charIndex])
					fixed (byte* bytePtr = &bytes[byteIndex])
					{
						byte* srcPrt;
						byte* lastSrcPrt = (byte*)charPtr + byteCount;
						byte* dstPrt = bytePtr;

						for (srcPrt = (byte*)charPtr; srcPrt < lastSrcPrt; srcPrt += 2)
						{
							*(dstPrt++) = srcPrt[1];
							*(dstPrt++) = srcPrt[0];
						}
					}
			}
			return byteCount;
		}
	}
}
