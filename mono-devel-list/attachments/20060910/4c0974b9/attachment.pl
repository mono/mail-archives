using System;

class Program
{
    static void Main(string[] args)
    {
        int domains = args.Length > 0 ? int.Parse(args[0]) : 1;
        int calls = args.Length > 1 ? int.Parse(args[1]) : 1;

		for(int d = 0; d < domains; d++)
		{
			string name = "domain" + d.ToString();
			Console.WriteLine("Creating {0}", name);
			AppDomain domain = AppDomain.CreateDomain(name);
		
			ScreenCounter ctr = (ScreenCounter)
				domain.CreateInstanceAndUnwrap(
					"swf", "ScreenCounter" );
			
			for( int c = 0; c < calls; c++ )
				Console.WriteLine( "Call {0} returned {1}", c, ctr.Count );
		}
	}
}

class ScreenCounter : MarshalByRefObject
{
	public int Count
	{
		get { return System.Windows.Forms.Screen.AllScreens.Length; }
	}
}