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
			if (bv[Int32.MinValue] != false)
			{
				Console.WriteLine("Error:"+bv[Int32.MinValue]);
			}
		}
	}

