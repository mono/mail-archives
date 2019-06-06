// RemotingClient.cs created with MonoDevelop
// User: mono at 2:51 AM 10/22/2007
//
// To change standard headers go to Edit->Preferences->Coding->Standard Headers
//

using System;
using System.Net;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Http;

namespace remoting
{
        class RemotingClient
        {
                static void Main ()
                {
                        HttpChannel ch = new HttpChannel(0);
                        ChannelServices.RegisterChannel (ch);

                        // This gets the object from the server (a list of ServerObject)

                        Console.WriteLine("Getting instance ...");
                        object remOb = Activator.GetObject(typeof(ServerList),"http://localhost:1122/test.rem");

                        ServerList list = (ServerList)remOb;

                        // These are remote calls that return references to remote


                        Console.WriteLine ("Creating two remote items...");
                        ServerObject item1 = list.NewItem ("Created at server 1");
                        item1.SetValue (111);   // another call made to the remote

                        ServerObject item2 = list.NewItem ("Created at server 2");
                        item2.SetValue (222);
                        Console.WriteLine ();

                        // Two objects created in this client app

                        Console.WriteLine ("Creating two client items...");
                        ServerObject item3 = new ServerObject ("Created at client 1");
                        item3.SetValue (333);
                        ServerObject item4 = new ServerObject ("Created at client 2");
                        item4.SetValue (444);
                        Console.WriteLine ();

                        // Object references passed to the remote list

                        Console.WriteLine ("Adding items...");
                        list.Add (item3);
                        list.Add (item4);
                        Console.WriteLine ();

                        // This sums all values of the ServerObjects in the list. The

                        // makes a remote call to this client to get the value of the
                        // objects created locally

                        Console.WriteLine ("Processing items...");
                        list.ProcessItems ();
                        Console.WriteLine ();

                        // Passing some complex info as parameter and return value

                        Console.WriteLine ("Setting complex data...");
                        ComplexData cd = new ComplexData (AnEnum.d, new object[] {"some",22,"info"});
                        ComplexData res = list.SetComplexData (cd);
                        Console.WriteLine ("This is the result:");
                        res.Dump();
                        Console.WriteLine ();

                        list.Clear();
                        Console.WriteLine ("Done.");

                        ch.StopListening (null);

                }
        }
}
