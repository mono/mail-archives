using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DecimalSpeed
{
	class Program
	{
		static void Main(string[] args)
		{
			Addition();
			Substraction();
			Multiplication();
			Division();
		}

		private static void Division()
		{
			decimal a = 0, b = 0, c = 0, d = 1;
			DateTime start = DateTime.UtcNow;
			a = 2345.6m;
			b = 0.009432m;
			c = 8.5467m;
			d = a / b / c;
			for (int i = 0; i < 10000000; i++)
				d = a / b / c;
			DateTime stop = DateTime.UtcNow;
			Console.WriteLine("division {0} ms : {1}", (stop - start).TotalMilliseconds, d);
		}

		private static void Multiplication()
		{
			decimal a = 0, b = 0, c = 0, d = 1;
			DateTime start = DateTime.UtcNow;
			a = 2345.6m;
			b = 0.009432m;
			c = 8.5467m;
			d = a * b * c;
			for (int i = 0; i < 10000000; i++)
				d = a * b * c;
			DateTime stop = DateTime.UtcNow;
			Console.WriteLine("multiplication {0} ms : {1}", (stop - start).TotalMilliseconds, d);
		}

		private static void Substraction()
		{
			decimal a = 0, b = 0, c = 0, d = 1;
			DateTime start = DateTime.UtcNow;
			a = 2345.6m;
			b = 0.009432m;
			c = 8.5467m;
			d = a - b - c;
			for (int i = 0; i < 10000000; i++)
				d = a - b - c;
			DateTime stop = DateTime.UtcNow;
			Console.WriteLine("substraction {0} ms : {1}", (stop - start).TotalMilliseconds, d);
		}

		private static void Addition()
		{
			decimal a = 0, b = 0, c = 0, d = 1;
			DateTime start = DateTime.UtcNow;
			a = 2345.6m;
			b = 0.009432m;
			c = 8.5467m;
			d = a + b + c;
			for (int i = 0; i < 10000000; i++)
				d = a + b + c;
			DateTime stop = DateTime.UtcNow;
			Console.WriteLine("addition {0} ms : {1}", (stop - start).TotalMilliseconds, d);
		}
	}
}