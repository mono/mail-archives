using System;
using System.Globalization;

public class DecimalTest
{
	public static void Main()
	{
		decimal testDec;

		string goodTest = "123456789.987654321";
		string badTest = "123Hello World!456";
		string curTest = "($1,000.11)";

		Console.WriteLine("TryParse {0,26} {1,6} {2,20}",
				goodTest,
				Decimal.TryParse(goodTest, out testDec).ToString(),
				testDec);
		Console.WriteLine("TryParse {0,26} {1,6} {2,20}",
				badTest,
				Decimal.TryParse(badTest, out testDec).ToString(),
				testDec);
		Console.WriteLine("TryParse {0,26} {1,6} {2,20}",
				curTest,
				Decimal.TryParse(curTest, out testDec).ToString(),
				testDec);
		Console.WriteLine("TryParse {0,26} {1,6} {2,20}",
				"same but NumberStyles.Any",
				Decimal.TryParse(curTest, NumberStyles.Any, null, out testDec).ToString(),
				testDec);
	}
}