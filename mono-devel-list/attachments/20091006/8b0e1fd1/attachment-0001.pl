using System;
using System.Collections.Generic;
using System.Net;

namespace Test
{
	public class Class1
	{
		static void Main(string[] args)
		{
			TestPerfOnDico();
			TestPerfOnIpAddress();
		}

		static void TestPerfOnIpAddress()
		{
			Console.WriteLine("IPAddress.ToString test");
			long sum = 0;
			int count = (int)Math.Pow(10, 7);
			Console.Write("Iterations (def={0:0,0})? ", count);
			string sChoice = Console.ReadLine();
			if (!string.IsNullOrEmpty(sChoice))
				count = int.Parse(sChoice);

			IPAddress ip;

			for (int i = 0; i < 100; i++)
			{
				ip = new IPAddress(i);
				sum += ip.ToString().Length;
			}
			Console.WriteLine("Dummy: " + sum);
			sum = 0;
			DateTime start = DateTime.UtcNow;
			for (int i = 0; i < count; i++)
			{
				ip = new IPAddress(i);
				sum += ip.ToString().Length;
			}
			TimeSpan duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Total: " + sum);
			Console.WriteLine("Duration: " + duration.TotalMilliseconds);
		}

		static void TestPerfOnDico()
		{
			int count = (int)Math.Pow(10, 8);
			Console.Write("Iterations (def={0:0,0})? ", count);
			string sChoice = Console.ReadLine();
			if (!string.IsNullOrEmpty(sChoice))
				count = int.Parse(sChoice);

			Console.WriteLine("int32 Dictionary test");
			DateTime start = DateTime.UtcNow;
			int intDicoSizeMax = 10000;
			Dictionary<int, int> dicoInt = new Dictionary<int, int>();
			for (int i = 0; i < count; i++)
			{
				int key = (int)((((long)i) * 5 + 11) % intDicoSizeMax);
				dicoInt[key] = i;
			}
			TimeSpan duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Duration for int dico (in millisec): " + duration.TotalMilliseconds);

			Console.WriteLine("IPAddress Dictionary test");
			start = DateTime.UtcNow;
			int iPAddressDicoSizeMax = 10000;
			Dictionary<IPAddress, IPAddress> dicoIP = new Dictionary<IPAddress, IPAddress>();
			for (int i = 0; i < count; i++)
			{
				long key = ((((long)i) * 5 + 11) % iPAddressDicoSizeMax);
				IPAddress ip = new IPAddress(key);
				dicoIP[ip] = ip;
			}
			duration = DateTime.UtcNow.Subtract(start);
			Console.WriteLine("Duration for IP dico (in millisec): " + duration.TotalMilliseconds);
		}
	}
}
