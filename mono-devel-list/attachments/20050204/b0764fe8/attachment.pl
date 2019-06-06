using System;
using System.Threading;
using System.Net;
using System.IO;

namespace ConsoleApplication6
{

	class Class1
	{

		private static void GetURL(string Symbol)
		{

			string sURL = "http://table.finance.yahoo.com/table.csv?s="+Symbol+"&d=1&e=4&f=2005&g=d&a=0&b=15&c=2005&ignore=.csv";

			WebRequest wrGETURL;			
			Stream objStream;
			StreamReader objReader;
			try
			{
				wrGETURL = WebRequest.Create(sURL);
				wrGETURL.Timeout = 8000;

				Console.WriteLine("Trying to get: " + Symbol);
				//objStream = wrGETURL.GetResponse().GetResponseStream();
				WebResponse myResponse = wrGETURL.GetResponse();
				objStream = myResponse.GetResponseStream();
				Console.WriteLine(Symbol +  ": No exception occurred");

				objReader = new StreamReader(objStream);
				string sLine ="";
				sLine = objReader.ReadLine(); //header
				sLine = objReader.ReadLine(); //first line of data
				Console.WriteLine(sLine);

				//close EVERYthing.
				objReader.Close();
				objStream.Close();
				myResponse.Close();
				

			}
			catch(Exception e)
			{
				Console.WriteLine("Exception Occurred: "  + e.Message);
			}

			wrGETURL = null;
			Console.WriteLine();
		}


		[STAThread]
		static void Main(string[] args)
		{

			string[] symbols = new string[10];
			symbols[0] = "Y";
			symbols[1] = "CAT";
			symbols[2] = "ITW";
			symbols[3] = "MKL";
			symbols[4] = "DGII";
			symbols[5] = "ALX";
			symbols[6] = "CME";
			symbols[7] = "SBZ";
			symbols[8] = "GOOG";
			symbols[9] = "MITSY";
			for(int s=0; s<10;s++)
			{  
				GetURL(symbols[s]);
				Thread.Sleep(1000);
			}
			Console.ReadLine();

		}
	}
}