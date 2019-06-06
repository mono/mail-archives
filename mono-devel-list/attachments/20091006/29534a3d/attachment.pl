using System;
using System.Collections.Generic;
using System.Net;

namespace Test
{
	public class Class1
	{
		static void Main(string[] args)
		{
			TestPerfOnPreAllocatedDico();
		}

		static void TestPerfOnPreAllocatedDico()
		{
			int count = (int)Math.Pow(10, 8);
			Console.Write("Iterations (def={0:0,0})? ", count);
			string sChoice = Console.ReadLine();
			if (!string.IsNullOrEmpty(sChoice))
				count = int.Parse(sChoice);

			Console.WriteLine("Preallocated int32 Dictionary test");
			// Let's preallocate all our objects first. Is preallocation possible/meaningful for value types (the int32)?
			int intDicoSizeMax = 10000;
			Dictionary<int, int> dicoInt = new Dictionary<int, int>(intDicoSizeMax);
			// Now we run the test.
			DateTime start = DateTime.UtcNow;
			for (int i = 0; i < count; i++)
			{
				int key = (int)((((long)i) * 5 + 11) % intDicoSizeMax);
				dicoInt[key] = i;
			}
			TimeSpan duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Duration for Preallocated int dico (in millisec): " + duration.TotalMilliseconds);

			Console.WriteLine("Preallocated IPAddress Dictionary test");
			// Let's preallocate all our objects first.
			start = DateTime.UtcNow;
			int iPAddressDicoSizeMax = 10000;
			Dictionary<IPAddress, IPAddress> dicoIP = new Dictionary<IPAddress, IPAddress>(iPAddressDicoSizeMax);
			IPAddress[] arrayIP = new IPAddress[iPAddressDicoSizeMax];
			for (int i = 0; i < iPAddressDicoSizeMax; i++)
			{
				arrayIP[i] = new IPAddress(i);
			}
			duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Preallocationd duration (in millisec): " + duration.TotalMilliseconds);
			// Now we run the test.
			start = DateTime.UtcNow;
			for (int i = 0; i < count; i++)
			{
				int index = (int)((((long)i) * 5 + 11) % iPAddressDicoSizeMax);
				IPAddress ip = arrayIP[index];
				dicoIP[ip] = ip;
			}
			duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Duration for Preallocated IP dico (in millisec): " + duration.TotalMilliseconds);
		}

	}
}
