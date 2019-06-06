using System;
using System.Globalization;
using System.Runtime.InteropServices;

class ICallBuilderPerfTest
{
    static void Main()
    {
        DateTime startTime = DateTime.Now;
        DateTime endTime;
        byte[] array = new byte[0x1000];

        for (int i = 0; i < 0x100000; i++)
            for (int j = 0; j < 0x1000; j++)
                Marshal.UnsafeAddrOfPinnedArrayElement(array, j);

        endTime = DateTime.Now;
        Console.WriteLine(((long)endTime.Subtract(startTime).TotalMilliseconds).ToString(CultureInfo.InvariantCulture));
    }
}
