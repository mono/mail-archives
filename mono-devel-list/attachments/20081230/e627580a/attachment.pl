using System;
using System.Threading;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace BackgroundThread
{
    class BackgroundThread
    {
        static void Main(string[] args)
        {
            Thread loopBlockThread = new Thread(LoopBlock);
            loopBlockThread.IsBackground = true;
            loopBlockThread.Start();

            Thread waitBlockThread = new Thread(WaitBlock);
            waitBlockThread.IsBackground = true;
            waitBlockThread.Start();

            Thread.Sleep(2000);
        }

        static void LoopBlock()
        {
            RuntimeHelpers.PrepareConstrainedRegions();
            try
            {
                while (true)
                {
                }
            }
            finally
            {
                Console.WriteLine("LoopBlock finally");
            }
        }

        static void WaitBlock()
        {
            RuntimeHelpers.PrepareConstrainedRegions();
            try
            {
                ManualResetEvent waitHandle = new ManualResetEvent(false);
                waitHandle.WaitOne();
            }
            finally
            {
                Console.WriteLine("WaitBlock finally");
            }
        }
    }
}
