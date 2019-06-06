using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

class Program
{
	static void Main (string[] args)
	{
		if (args.Length < 2) {
			Console.WriteLine ("usage: udpreceiver <IP-address> <port>");
			return;
		}

		IPEndPoint localEndPoint = new IPEndPoint(IPAddress.Parse (args[0]),
							   Convert.ToInt32 (args[1]));
		
		var r = new Receiver (localEndPoint);
		for (;;)
			Console.WriteLine ("Received: {0}", r.Receive ());

	}
}

class Receiver
{
	Socket sock;
	
	public Receiver(IPEndPoint endPoint)
	{
		sock = new Socket(AddressFamily.InterNetwork,SocketType.Dgram, ProtocolType.Udp);
		sock.Bind (endPoint);
	}

	public string Receive()
	{
		EndPoint clientEndPoint = new IPEndPoint(IPAddress.Any, 0);
		byte[] data = new byte[1024];
		int count = sock.ReceiveFrom(data, ref clientEndPoint);
		return Encoding.UTF8.GetString(data, 0, count);
	}
}
