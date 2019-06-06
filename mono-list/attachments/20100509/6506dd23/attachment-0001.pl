using System;
using System.Net;
using System.Net.Sockets;
using System.Text;

class Program
{
	static void Main (string[] args)
	{
		if (args.Length < 2) {
			Console.WriteLine ("usage: udpsender <IP-address> <port>");
			return;
		}

		IPEndPoint remoteEndPoint = new IPEndPoint(IPAddress.Parse (args[0]),
							   Convert.ToInt32 (args[1]));

		var s = new Sender(remoteEndPoint);
		s.Send("Hello World!");
	}
}

class Sender
{
	Socket sock;
	IPEndPoint remoteEndPoint;
	
	public Sender(IPEndPoint remoteEndPoint)
	{
		sock = new Socket(AddressFamily.InterNetwork,SocketType.Dgram, ProtocolType.Udp);
		this.remoteEndPoint = remoteEndPoint;
	}

	public void Send(string text)
	{
		byte[] data = Encoding.UTF8.GetBytes(text);
		sock.SendTo(data, remoteEndPoint);
	}
}
