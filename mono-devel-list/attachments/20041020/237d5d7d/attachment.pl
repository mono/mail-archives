// TransformTest.cs
// Jon Larimer <jlarimer@gmail.net>

using System;
using System.Security.Cryptography;

public class TransformTest
{
	static void Main(string[] args)
	{
		RijndaelManaged rij = new RijndaelManaged();
			
		rij.KeySize = 128;
		rij.BlockSize = 128;
		rij.Mode = CipherMode.CBC;
		rij.Padding = PaddingMode.None;
		rij.IV = new byte[] { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F };
		rij.Key = new byte[] { 0x0F, 0x0E, 0x0D, 0x0C, 0x0B, 0x0A, 0x09, 0x08, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00 };

		byte[] input = new byte[] { 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF, 0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF };

		// First perform 2 encryptions using TransformBlock() and print the results
		ICryptoTransform encrypt = rij.CreateEncryptor();
		Console.WriteLine("TransformBlock test:");
		TransformBlockTest(input, encrypt);
		Console.WriteLine();

		// With a fresh encryptor, perform 2 encryptions using TransformFinalBlock() and print the results
		encrypt = rij.CreateEncryptor();
		Console.WriteLine("TransformFinalBlock test:");
		TransformFinalBlockTest(input, encrypt);


	}

	static void TransformBlockTest(byte[] input, ICryptoTransform encrypt) {
		byte[] test1 = new byte[input.Length];
		encrypt.TransformBlock(input, 0, input.Length, test1, 0);

		byte[] test2 = new byte[input.Length];
		encrypt.TransformBlock(input, 0, input.Length, test2, 0);

		Console.WriteLine("  First round of CBC:");
		Hexdump(test1);

		Console.WriteLine("  Second round of CBC:");
		Hexdump(test2);
	}

	static void TransformFinalBlockTest(byte[] input, ICryptoTransform encrypt) {
		byte[] test1 = encrypt.TransformFinalBlock(input, 0, input.Length);
		byte[] test2 = encrypt.TransformFinalBlock(input, 0, input.Length);

		Console.WriteLine("  First round of CBC:");
		Hexdump(test1);

		Console.WriteLine("  Second round of CBC:");
		Hexdump(test2);
	}


	static void Hexdump(byte[] data) {
		Console.Write("  ");
		for(int i=0; i<data.Length; i++) {
			Console.Write("{0:X2} ", data[i]);
			if((i+1)%16 == 0) Console.WriteLine("\n  ");
		}
	}



}
