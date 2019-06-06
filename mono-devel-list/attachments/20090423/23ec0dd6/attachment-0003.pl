using System;
using System.IO;
using System.Threading;
using arton.MnGainer;

public class Test
{
	public static void Main ()
	{
		var gc = new GainerControl ();
		gc.Open ("COM3");
		gc.Configure (1);
		gc.LED (true);
		Thread.Sleep (3000);
		gc.LED (false);
		gc.Dispose ();
	}
}
