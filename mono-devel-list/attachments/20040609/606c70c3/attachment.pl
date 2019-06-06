using System;
using System.Globalization;
using System.Reflection;

public class EntryPoint
{
	[STAThread]
	static void Main(string[] args)
	{
		AssemblyName a = new AssemblyName ();
		a.Name = "TestAssemblyA";
		a.Version = new Version(1, 5);
		Console.WriteLine ("A: " + a.FullName);

		AssemblyName b = new AssemblyName ();
		b.Name = "TestAssemblyB";
		b.Version = new Version(2, 0);
		b.CultureInfo = CultureInfo.InvariantCulture;
		Console.WriteLine ("B: " + b.FullName);

		Console.WriteLine (Assembly.GetExecutingAssembly ().GetName (false).FullName);
	}
}

