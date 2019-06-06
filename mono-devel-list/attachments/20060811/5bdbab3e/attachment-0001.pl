using System;
using System.Diagnostics;

namespace Test {
	class TestClass {
		static void Main() {
			for( int i = 0; i < 3; i++ ) {
			ProcessStartInfo info = new ProcessStartInfo( "/bin/echo",
				"I'm hen-er-y the 8th I am...8" );
	 		info.UseShellExecute = false;
			info.RedirectStandardOutput = true;
			Process process = Process.Start( info );
    		Console.WriteLine( process.StandardOutput.ReadLine() );
			process.WaitForExit();
			}
		}
	}
}
