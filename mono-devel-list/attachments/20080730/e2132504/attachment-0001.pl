using System;
using System.Globalization;
using System.Runtime.CompilerServices;

class ICallBuilderPerfTest
{
    static void Main()
    {
        DateTime startTime = DateTime.Now;
        DateTime endTime;
        int[] array = new int[0x1000];

        for (int i = 0; i < 0x1000000; i++)
            for (int j = 0; j < 0x1000; j++)
                array[j] = RuntimeHelpers.OffsetToStringData;

        endTime = DateTime.Now;
        Console.WriteLine(((long)endTime.Subtract(startTime).TotalMilliseconds).ToString(CultureInfo.InvariantCulture));
    }
}