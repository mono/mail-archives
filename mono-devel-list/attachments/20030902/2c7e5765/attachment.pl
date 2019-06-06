using System;
using System.Collections;
using System.Collections.Specialized;

	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	public class Test
	{
		public Test()
		{
		}

		public static void Main(String[] args)
		{
			BitVector32 bv = new BitVector32(-1);
			BitVector32.Section sect = BitVector32.CreateSection(1);
			sect = BitVector32.CreateSection(Int16.MaxValue, sect);
			sect = BitVector32.CreateSection(Int16.MaxValue, sect);
			sect = BitVector32.CreateSection(1, sect);
			bv[sect] = 0; 
			if (bv.Data != Int32.MaxValue)
			{
				Console.WriteLine("Error:"+bv.Data);
			}
		}
	}

