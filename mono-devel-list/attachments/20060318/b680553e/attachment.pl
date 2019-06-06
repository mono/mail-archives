using System;

class Test
{
	static Char[] CharA = new char[20000];
	static Char[] CharB = new char[20000];

	public static void Main ()
	{
		PerformTest (0, 0, 0, 100000000);
		PerformTest (0, 0, 1, 100000000);
		PerformTest (0, 0, 100, 100000000);
		PerformTest (0, 0, 10000, 1000000);
		Console.WriteLine ();
		PerformTest (1, 0, 0, 100000000);
		PerformTest (1, 0, 1, 100000000);
		PerformTest (1, 0, 100, 100000000);
		PerformTest (1, 0, 10000, 1000000);
		Console.WriteLine ();
		PerformTest (1, 1, 0, 100000000);
		PerformTest (1, 1, 1, 100000000);
		PerformTest (1, 1, 100, 100000000);
		PerformTest (1, 1, 10000, 1000000);
		Console.WriteLine ();
		PerformTest (0, 1, 0, 100000000);
		PerformTest (0, 1, 1, 100000000);
		PerformTest (0, 1, 100, 100000000);
		PerformTest (0, 1, 10000, 1000000);

		Console.WriteLine (CharB[50] + CharA[50]);
	}

	private static void PerformTest (int sourceStart, int destinationStart, int length, int iters)
	{
		iters = iters / 10;
		long t1 = Environment.TickCount;
		for (int x = 0; x < iters; x++)
		{
			SpeedTest1.CopyTo (CharA, sourceStart, CharB, destinationStart, length);
		}
		long t2 = Environment.TickCount;

		long t3 = Environment.TickCount;
		for (int x = 0; x < iters; x++)
		{
			SpeedTest2.CopyTo (CharA, sourceStart, CharB, destinationStart, length);
		}
		long t4 = Environment.TickCount;

		long t5 = Environment.TickCount;
		for (int x = 0; x < iters; x++)
		{
			SpeedTest3.CopyTo (CharA, sourceStart, CharB, destinationStart, length);
		}
		long t6 = Environment.TickCount;

		long t7 = Environment.TickCount;
		for (int x = 0; x < iters; x++)
		{
			SpeedTest4.CopyTo (CharA, sourceStart, CharB, destinationStart, length);
		}
		long t8 = Environment.TickCount;

		Console.WriteLine ("Test: Length: {0}, Source: {1}, Dest: {2}", length, sourceStart, destinationStart);
		Console.WriteLine ("  memcopy      : {0}", t2 - t1);
		Console.WriteLine ("  CharCopy     : {0}", t4 - t3);
		Console.WriteLine ("  CC autoalign : {0}", t6 - t5);
		Console.WriteLine ("  CC aligned   : {0}", t8 - t7);
	}

}

public class SpeedTest1
{
	public static void CopyTo (char[] sourcedata, int sourceIndex, char[] destination, int destinationIndex, int count)
	{
		unsafe
		{
			fixed (char* source = sourcedata, dest = destination)
			{
				memcpy ((byte*)(source + sourceIndex), (byte*)(dest + destinationIndex), count * 2);
			}
		}
	}

	internal static unsafe void memcpy4 (byte* dest, byte* src, int size)
	{
		/*while (size >= 32) {
			// using long is better than int and slower than double
			// FIXME: enable this only on correct alignment or on platforms
			// that can tolerate unaligned reads/writes of doubles
			((double*)dest) [0] = ((double*)src) [0];
			((double*)dest) [1] = ((double*)src) [1];
			((double*)dest) [2] = ((double*)src) [2];
			((double*)dest) [3] = ((double*)src) [3];
			dest += 32;
			src += 32;
			size -= 32;
		}*/
		while (size >= 16)
		{
			((int*)dest)[0] = ((int*)src)[0];
			((int*)dest)[1] = ((int*)src)[1];
			((int*)dest)[2] = ((int*)src)[2];
			((int*)dest)[3] = ((int*)src)[3];
			dest += 16;
			src += 16;
			size -= 16;
		}
		while (size >= 4)
		{
			((int*)dest)[0] = ((int*)src)[0];
			dest += 4;
			src += 4;
			size -= 4;
		}
		while (size > 0)
		{
			((byte*)dest)[0] = ((byte*)src)[0];
			dest += 1;
			src += 1;
			--size;
		}
	}
	static unsafe void memcpy2 (byte* dest, byte* src, int size)
	{
		while (size >= 8)
		{
			((short*)dest)[0] = ((short*)src)[0];
			((short*)dest)[1] = ((short*)src)[1];
			((short*)dest)[2] = ((short*)src)[2];
			((short*)dest)[3] = ((short*)src)[3];
			dest += 8;
			src += 8;
			size -= 8;
		}
		while (size >= 2)
		{
			((short*)dest)[0] = ((short*)src)[0];
			dest += 2;
			src += 2;
			size -= 2;
		}
		if (size > 0)
			((byte*)dest)[0] = ((byte*)src)[0];
	}
	static unsafe void memcpy1 (byte* dest, byte* src, int size)
	{
		while (size >= 8)
		{
			((byte*)dest)[0] = ((byte*)src)[0];
			((byte*)dest)[1] = ((byte*)src)[1];
			((byte*)dest)[2] = ((byte*)src)[2];
			((byte*)dest)[3] = ((byte*)src)[3];
			((byte*)dest)[4] = ((byte*)src)[4];
			((byte*)dest)[5] = ((byte*)src)[5];
			((byte*)dest)[6] = ((byte*)src)[6];
			((byte*)dest)[7] = ((byte*)src)[7];
			dest += 8;
			src += 8;
			size -= 8;
		}
		while (size >= 2)
		{
			((byte*)dest)[0] = ((byte*)src)[0];
			((byte*)dest)[1] = ((byte*)src)[1];
			dest += 2;
			src += 2;
			size -= 2;
		}
		if (size > 0)
			((byte*)dest)[0] = ((byte*)src)[0];
	}
	static unsafe void memcpy (byte* dest, byte* src, int size)
	{
		// FIXME: if pointers are not aligned, try to align them
		// so a faster routine can be used. Handle the case where
		// the pointers can't be reduced to have the same alignment
		// (just ignore the issue on x86?)
		if ((((int)dest | (int)src) & 3) != 0)
		{
			if (((int)dest & 1) != 0 && ((int)src & 1) != 0 && size >= 1)
			{
				dest[0] = src[0];
				++dest;
				++src;
				--size;
			}
			if (((int)dest & 2) != 0 && ((int)src & 2) != 0 && size >= 2)
			{
				((short*)dest)[0] = ((short*)src)[0];
				dest += 2;
				src += 2;
				size -= 2;
			}
			if ((((int)dest | (int)src) & 1) != 0)
			{
				memcpy1 (dest, src, size);
				return;
			}
			if ((((int)dest | (int)src) & 2) != 0)
			{
				memcpy2 (dest, src, size);
				return;
			}
		}
		memcpy4 (dest, src, size);
	}

}

public class SpeedTest2
{
	public static void CopyTo (char[] sourcedata, int sourceIndex, char[] destination, int destinationIndex, int count)
	{
		unsafe
		{
			fixed (char* source = sourcedata, dest = destination)
			{
				CharCopy (source + sourceIndex, dest + destinationIndex, count);
			}
		}
	}

	private unsafe static void CharCopy (char* source, char* destination, int count)
	{
		// Copy 32 byte at a time (unroll the loop)
		while (count >= 16)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			((int*)destination)[2] = ((int*)source)[2];
			((int*)destination)[3] = ((int*)source)[3];
			((int*)destination)[4] = ((int*)source)[4];
			((int*)destination)[5] = ((int*)source)[5];
			((int*)destination)[6] = ((int*)source)[6];
			((int*)destination)[7] = ((int*)source)[7];
			destination += 16;
			source += 16;
			count -= 16;
		}

		// Copy 8 byte at a time.
		while (count >= 4)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			destination += 4;
			source += 4;
			count -= 4;
		}

		if (count >= 2)
		{
			((int*)destination)[0] = ((int*)source)[0];
			destination += 2;
			source += 2;
			count -= 2;
		}

		if (count == 1)
		{
			*destination = *source;
		}
	}
}

public class SpeedTest3
{
	public static void CopyTo (char[] sourcedata, int sourceIndex, char[] destination, int destinationIndex, int count)
	{
		unsafe
		{
			fixed (char* source = sourcedata, dest = destination)
			{
				CharCopy (source + sourceIndex, dest + destinationIndex, count);
			}
		}
	}

	private unsafe static void CharCopy (char* source, char* destination, int count)
	{
		//Check the alignment and call the apropriate copyloop
		if ((((int)destination | (int)source) & 2) == 2)
		{
			//Try to align
			if (((int)destination & 2) == ((int)source & 2) && count >= 1)
			{
				destination[0] = source[0];
				destination++;
				source++;
				count--;
			}
		}

		// Copy 32 byte at a time (unroll the loop) with 2 chars per copy
		while (count >= 16)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			((int*)destination)[2] = ((int*)source)[2];
			((int*)destination)[3] = ((int*)source)[3];
			((int*)destination)[4] = ((int*)source)[4];
			((int*)destination)[5] = ((int*)source)[5];
			((int*)destination)[6] = ((int*)source)[6];
			((int*)destination)[7] = ((int*)source)[7];
			destination += 16;
			source += 16;
			count -= 16;
		}

		// Copy 8 byte at a time.
		while (count >= 4)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			destination += 4;
			source += 4;
			count -= 4;
		}

		if (count >= 2)
		{
			((int*)destination)[0] = ((int*)source)[0];
			destination += 2;
			source += 2;
			count -= 2;
		}

		if (count == 1)
		{
			destination[0] = source[0];
		}
	}
}


public class SpeedTest4
{
	public static void CopyTo (char[] sourcedata, int sourceIndex, char[] destination, int destinationIndex, int count)
	{
		unsafe
		{
			fixed (char* source = sourcedata, dest = destination)
			{
				CharCopy (source + sourceIndex, dest + destinationIndex, count);
			}
		}
	}

	private unsafe static void CharCopy (char* source, char* destination, int count)
	{
		//Check the alignment and call the apropriate copyloop
		if ((((int)destination | (int)source) & 2) == 2)
		{
			//Try to align
			if (((int)destination & 2) == ((int)source & 2) && count >= 1)
			{
				destination[0] = source[0];
				destination++;
				source++;
				count--;
				// Test if the alignment is now correct
				if ((((int)destination | (int)source) & 2) == 0)
					goto CharCopy2;
			}
			//Copy by single char
			//On x86 CharCopy2 works perfectly here, do other architectures really need CharCopy1?
			goto CharCopy1;
		}

	CharCopy2:
		// Copy 32 byte at a time (unroll the loop) with 2 chars per copy
		while (count >= 16)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			((int*)destination)[2] = ((int*)source)[2];
			((int*)destination)[3] = ((int*)source)[3];
			((int*)destination)[4] = ((int*)source)[4];
			((int*)destination)[5] = ((int*)source)[5];
			((int*)destination)[6] = ((int*)source)[6];
			((int*)destination)[7] = ((int*)source)[7];
			destination += 16;
			source += 16;
			count -= 16;
		}

		// Copy 8 byte at a time.
		while (count >= 4)
		{
			((int*)destination)[0] = ((int*)source)[0];
			((int*)destination)[1] = ((int*)source)[1];
			destination += 4;
			source += 4;
			count -= 4;
		}

		if (count >= 2)
		{
			((int*)destination)[0] = ((int*)source)[0];
			destination += 2;
			source += 2;
			count -= 2;
		}

		if (count == 1)
		{
			destination[0] = source[0];
		}
		return;

	CharCopy1:
		// Copy 32 byte at a time (unroll the loop) with 1 char per copy
		while (count >= 16)
		{
			destination[00] = source[00];
			destination[01] = source[01];
			destination[02] = source[02];
			destination[03] = source[03];
			destination[04] = source[04];
			destination[05] = source[05];
			destination[06] = source[06];
			destination[07] = source[07];
			destination[08] = source[08];
			destination[09] = source[09];
			destination[10] = source[10];
			destination[11] = source[11];
			destination[12] = source[12];
			destination[13] = source[13];
			destination[14] = source[14];
			destination[15] = source[15];
			destination += 16;
			source += 16;
			count -= 16;
		}

		// Copy 8 byte at a time.
		while (count >= 4)
		{
			destination[0] = source[0];
			destination[1] = source[1];
			destination[2] = source[2];
			destination[3] = source[3];
			destination += 4;
			source += 4;
			count -= 4;
		}

		if (count >= 2)
		{
			destination[0] = source[0];
			destination[1] = source[1];
			destination += 2;
			source += 2;
			count -= 2;
		}

		if (count == 1)
		{
			destination[0] = source[0];
		}
	}
}
