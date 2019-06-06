using System;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Runtime.InteropServices;

namespace BlockingAccept
{
    class BlockingAccept
    {
        static Socket socket;
        static IntPtr threadHandle;

        delegate void APCProc(IntPtr dwParam);

        [DllImport("kernel32.dll")]
        static extern uint QueueUserAPC(APCProc pfnAPC, IntPtr hThread, IntPtr dwData);

        [DllImport("kernel32.dll")]
        static extern IntPtr GetCurrentThread();

        [DllImport("kernel32.dll")]
        extern static IntPtr GetCurrentProcess();

        [DllImport("kernel32.dll")]
        extern static bool DuplicateHandle(IntPtr sourceProcessHandle, IntPtr sourceHandle, IntPtr targetProcessHandle, out IntPtr targetHandle, uint desiredAccess, bool inheritHandle, uint dwOptions);

        [DllImport("kernel32.dll")]
        extern static bool CloseHandle(IntPtr handle);

        static void Main(string[] args)
        {
            Thread.BeginThreadAffinity();
            Console.WriteLine("Main thread: " + AppDomain.GetCurrentThreadId());
            socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            socket.Blocking = true;
            socket.Bind(new IPEndPoint(IPAddress.Loopback, 12345));
            socket.Listen(1);
            Thread thread = new Thread(AcceptSocket);
            //thread.IsBackground = true;
            thread.Start();
            Thread.Sleep(1000);
            //Console.WriteLine("before Abort");
            //thread.Abort();
            //Console.WriteLine("after Abort");
            //Thread.Sleep(1000);
            Console.WriteLine("New thread state: " + thread.ThreadState.ToString());
            QueueUserAPC(APCCallback, threadHandle, IntPtr.Zero);
            CloseHandle(threadHandle);
            Thread.Sleep(1000);
            Console.WriteLine("New thread state: " + thread.ThreadState.ToString());
            Thread.EndThreadAffinity();
        }

        static void APCCallback(IntPtr dwParam)
        {
            Console.WriteLine("APCCallback thread: " + AppDomain.GetCurrentThreadId());
        }

        static void AcceptSocket()
        {
            Thread.BeginThreadAffinity();
            Console.WriteLine("New thread: " + AppDomain.GetCurrentThreadId());
            DuplicateHandle(GetCurrentProcess(), GetCurrentThread(), GetCurrentProcess(), out threadHandle, 0, false, 2); 
            Console.WriteLine("before Accept");
            Socket conn = socket.Accept();
            Console.WriteLine("after Accept");
            conn.Close();
            Thread.EndThreadAffinity();
        }
    }
}
