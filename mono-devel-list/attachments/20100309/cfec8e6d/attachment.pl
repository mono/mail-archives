using System;
using System.Threading;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ConsoleApplication6
{
	class Test
	{
		static Test ()
		{
			Console.WriteLine ("TEST CCTOR");
			X.Wait ();
			Console.WriteLine ("TEST CCTOR DONE");
		}

		public int Foo ()
		{
			Console.WriteLine ("TEST FOO");
			return 5;
		}
	}

	class X
	{
		static ManualResetEvent wait_event = new ManualResetEvent (false);

		public static void Wait ()
		{
			wait_event.WaitOne ();
		}

		public int Foo
		{
			get { return new Test ().Foo (); }
		}

		static void Main ()
		{
			X x = new X ();

			Thread a = new Thread (new ThreadStart (delegate {
				new Test ().Foo ();
			}));

			Thread b = new Thread (new ThreadStart (delegate {
				Thread.Sleep (10000);
				wait_event.Set ();
			}));

			a.Start ();
			b.Start ();

			Console.WriteLine ("THREAD STARTED");
			a.Abort ();
			Console.WriteLine ("THREAD ABORTED");

			new Test ().Foo ();
		}
	}
}
