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
		    try{	
				ld.CopyTo(null,0);	
				Console.WriteLine("Error : ArgumentNullException wasn't thrown");
		    }catch(ArgumentNullException){}
			
			try{
				ld.CopyTo(new int[1],-1);	
				Console.WriteLine("Error : ArgumentOutOfRangeException wasn't thrown");
			}catch(ArgumentOutOfRangeException){}
		}
	}

