using System;
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
			ListDictionary ld= new ListDictionary();
		    try
			{	
				ld.Remove(null);
		
		    }
			catch(ArgumentNullException e)
			{
				Console.WriteLine(e);
			}
		}
	}

