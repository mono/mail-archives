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
			try
			{
				BitVector32.Section section = BitVector32.CreateSection(Int16.MaxValue);
				section = BitVector32.CreateSection(Int16.MaxValue,section);
				Console.WriteLine(section);
			}
			catch(Exception e )
			{				
				Console.WriteLine(e);
			}

		}
	}

