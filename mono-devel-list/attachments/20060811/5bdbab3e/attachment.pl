using System;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Net.Sockets;

namespace Test {
	class Test {
		static void Main() {
            for( int i = 0; i < 5; i++ ) {
				Thread empty = new Thread( new ThreadStart( StartProcess ) );
				empty.Start();
			}

			Thread.Sleep( -1 );
		}

		static int __processIter = 0;

		static void StartProcess() {
			for( ;; ) {
	            ProcessStartInfo info = new ProcessStartInfo( "/bin/echo",
					"\"I'm hen-er-y the 8th I am..." + Interlocked.Increment( ref __processIter ).ToString() + "\"" );
	            info.UseShellExecute = false;
				info.RedirectStandardOutput = true;
				
				Process process = Process.Start( info );

				Console.WriteLine( process.StandardOutput.ReadLine() );
			
				process.WaitForExit();
				process.Dispose();
			}
		}
	}
}
