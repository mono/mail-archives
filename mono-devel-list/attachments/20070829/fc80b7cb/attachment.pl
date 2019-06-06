using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Threading;

namespace exit
{
	class Program
	{
		static void Main(string[] args)
		{
			Process proc = new Process();
			proc.StartInfo = new ProcessStartInfo("false");
			proc.Start();
			while(!proc.HasExited)
				Thread.Sleep(100);
			Console.WriteLine("Exit status of false was {0}", proc.ExitCode); //1

			proc.StartInfo = new ProcessStartInfo("true");
			proc.Start();
			while (!proc.HasExited)
				Thread.Sleep(100);
			Console.WriteLine("Exit status of true was {0}", proc.ExitCode); //0

			proc.StartInfo = new ProcessStartInfo("nant");
			proc.Start(); // should fail if not *.build found
			while (!proc.HasExited)
				Thread.Sleep(100); 
			Console.WriteLine("Exit status of nant was {0}", proc.ExitCode);
		}
	}
}