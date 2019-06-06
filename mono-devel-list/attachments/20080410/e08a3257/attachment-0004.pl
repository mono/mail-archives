// RemotingServer.cs created with MonoDevelop
// User: mono at 2:53 AM 10/22/2007
//
// To change standard headers go to Edit->Preferences->Coding->Standard Headers
//
using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;

namespace remoting
{
        class RemotingServer
        {
                static int Main ()
                {
                        Console.WriteLine("Starting Server");
                        HttpChannel ch = new HttpChannel(1122);
                        ChannelServices.RegisterChannel (ch);

                        ServerList ser = new ServerList();
                        RemotingServices.Marshal(ser,"test.rem");

                        Console.WriteLine("Server Running ...");
                        Console.ReadLine();

                        ch.StopListening (null);

                        return 0;
                }
        }
}
