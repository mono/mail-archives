using System;
using System.Reflection;

namespace SerializeTest
{
	class EntryPoint
	{
		[STAThread]
		static void Main(string[] args)
		{
			if (args.Length != 2) 
			{
				Console.Error.WriteLine("Invalid arguments.");
				Environment.Exit (1);
			}

			Assembly assembly = Assembly.LoadFrom(args[1]);

			AssemblySerializer assemblySerializer = new AssemblySerializer(assembly);
			
			switch (args[0]) 
			{
				case "/serialize":
					assemblySerializer.Serialize();
					break;
				case "/deserialize":
					assemblySerializer.Deserialize();
					break;
				default:
					Console.Error.WriteLine("Unsupported action.");
					Environment.Exit (1);
					return;
			}
		}

	}
}
