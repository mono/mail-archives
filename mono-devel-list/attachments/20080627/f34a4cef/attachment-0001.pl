using System;
using System.Net;
using System.Net.Sockets;
using System.Collections.Generic;

public class Server
{
  static void Main()
  {
    Socket ms = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
    ms.Blocking = false;
    ms.Bind(new IPEndPoint(IPAddress.Any,5656));
    ms.Listen(10);
    Console.WriteLine("Waiting for incoming connection");
    List<Socket> readList = new List<Socket>();
    List<Socket> errorList = new List<Socket>();
    readList.Add(ms);

    //comment out the line below to make osx behave like linux.
    errorList.Add(ms);

    Socket.Select(readList,null,errorList,-1);
    if (readList.Count>0)
      Console.WriteLine("read event");  //this happens on linux
    else
      Console.WriteLine("no read event");   //this happens on osx
  }
}


