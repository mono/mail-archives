// project created on 10/3/2006 at 4:08 PM
using System;

namespace Resx
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			try
			{
				
				System.Resources.ResXResourceWriter writer = new System.Resources.ResXResourceWriter("Test.resx");
				writer.AddResource("TEST", new System.Drawing.Bitmap("WebReferenceItem.png"));
				writer.Generate();
				writer.Close();
				Console.WriteLine("Generated the resx file");
				
				System.Resources.ResXResourceReader reader = new System.Resources.ResXResourceReader("Test.resx");
				reader.Close();
				Console.WriteLine("Read the generated the resx file");
			}
			catch (Exception e)
			{
				Console.WriteLine("\r\nEXCEPTION!!!!\r\n{0}", e.Message);
			}
		}
	}
}