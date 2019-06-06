using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DecimalOperatorRegression
{
	class Program
	{
		static void Main(string[] args)
		{
			Decimal2 three = (Decimal2)3m;
			Decimal2 two = (Decimal2)2m;
			Console.WriteLine(three > two);
		}
	}

	[Serializable]
	public struct Decimal2
	{
		Decimal value;

		private Decimal2(Decimal d)
		{
			value = d;
		}

		public static explicit operator Decimal2(Decimal d)
		{
			Decimal2 result = new Decimal2(d); 
			return result;
		}

		public static implicit operator Decimal(Decimal2 d)
		{ return d.value; }
	}
}