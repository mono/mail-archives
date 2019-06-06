using System;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace BlockingAccept
{
    class BlockingAccept
    {
        static Socket socket;

        static void Main(string[] args)
        {
            socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            socket.Blocking = true;
            socket.Bind(new IPEndPoint(IPAddress.Loopback, 12345));
            socket.Listen(1);
            Thread thread = new Thread(AcceptSocket);
            //thread.IsBackground = true;
            thread.Start();
            Thread.Sleep(1000);
            Console.WriteLine("before Abort");
            thread.Abort();
            Console.WriteLine("after Abort");
            Thread.Sleep(1000);
            Console.WriteLine(thread.ThreadState.ToString());            
        }

        static void AcceptSocket()
        {
            Console.WriteLine("before Accept");
            Socket conn = socket.Accept();
            Console.WriteLine("after Accept");
            conn.Close();
        }
    }
}
