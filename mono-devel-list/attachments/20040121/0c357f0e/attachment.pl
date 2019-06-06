using System;

namespace BadRefTest
{

public class CtorInc
{
	static int x, y;

	static int IncByRef(ref int i) { return ++i; }

	public CtorInc() { IncByRef(ref x); ++y; }

	public static void Results(int total)
	{
		Console.WriteLine("CtorInc test {0}: x == {1}, y == {2}",
				x == y && x == total? "passed": "failed", x, y);
	}
}

public class Runner
{
	public static void Main()
	{
		int i = 0;
		for (; i < 5; i++)
		{
			CtorInc t = new CtorInc();
		}
		CtorInc.Results(i);
	}

}

//===========================================================================
}

