
using System; 
using System.Globalization;
using System.Runtime.CompilerServices;

class Benchmark
{
	private static char[] a = new char[100];
	private static char[] b = new char[100];
	
	public static void Main ()
	{
		long Result01 = 0, Result02 = 0;
		int count = 0;

		long t1 = Environment.TickCount;
		count = TestFunction1 ();
		long t2 = Environment.TickCount;
		Result01 = t2 - t1;

		long t3 = Environment.TickCount;
		count = TestFunction2 ();
		long t4 = Environment.TickCount;
		Result02 = t4 - t3;

		Console.WriteLine (count);
		Console.WriteLine ("Copy using ints: " + Result02 + "ms");
		Console.WriteLine ("Copy using long: " + Result01 + "ms");
		
	}
	
	private unsafe static int TestFunction1 ()
	{		
		for (int x = 0; x < 10000000; x++)
		{
			fixed (char * src = a, dest = b) {
				Test1 (src, dest, 32);
			}
		}
		return 1;
	}
	
	private unsafe static void Test1 (char* src, char* dest, int len)
	{
		while (len >= 4) {
			*((long*)dest) = *((long*)src);
			dest += 4;
			src += 4;

			len -= 4;
		}
	}

	private unsafe static int TestFunction2 ()
	{		
		for (int x = 0; x < 10000000; x++)
		{
			fixed (char * src = a, dest = b) {
				Test2 (src, dest, 32);
			}
		}
		return 1;
	}

	private unsafe static void Test2 (char* src, char* dest, int len)
	{
		while (len >= 4) {
			*((int*)dest) = *((int*)src);
			dest += 2;
			src += 2;
			*((int*)dest) = *((int*)src);
			dest += 2;
			src += 2;

			len -= 4;
		}
	}
}

