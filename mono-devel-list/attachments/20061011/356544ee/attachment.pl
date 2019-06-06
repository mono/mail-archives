using System;
using System.Text;
using System.IO;

class CreateEncodingData
{
	private static string path = @"c:\st\out\";
	
	public static void Main ()
	{
		byte[] bytes = new byte[256];
		for (int i = 0; i < 256; i++)
			bytes[i] = (byte)i;
		
		char[] chars = new char[65536];
		for (int i = 0; i < 65536; i++)
			chars[i] = (char)i;
		
		EncodingInfo[] encodings = Encoding.GetEncodings();
		Console.WriteLine ("Encoding count: " +  encodings.Length);
		
		foreach (EncodingInfo info in encodings)
		{
			Encoding e = Encoding.GetEncoding(info.CodePage);
			Console.Write ("Encoding: " + e.CodePage + " (" + e.WebName + ";" + info.DisplayName + ")");
			
			if (e.IsSingleByte)
			{
				Console.WriteLine (" - single byte");
				//byte unusedbyte = (e.GetBytes(new char[] { (char)30000 }))[0];
				
				Stream s = new FileStream (Path.Combine(path, e.CodePage + ".bin"), FileMode.Create);
				
				
				char[] dataChars = e.GetChars(bytes);
				byte[] temp = Encoding.Unicode.GetBytes(dataChars);
				s.Write(temp, 0, temp.Length);
				
				byte[] dataBytes = e.GetBytes(chars);
				
//				for (int i = 0; i < dataBytes.Length; i++)
//					if (dataBytes[i] == unusedbyte)
//						dataBytes[i] = 0;
				
				s.Write(dataBytes, 0, dataBytes.Length);
			}
			else
			{
				Console.WriteLine ();
			}
		}
	}
}
