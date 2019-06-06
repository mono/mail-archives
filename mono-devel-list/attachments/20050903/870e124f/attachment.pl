using System;
using System.Net;

namespace Majestic12
{
	/// <summary>
	/// Mono Dns Resolve bug test: an unhandled exception is triggered 
	/// when DNS name could not be resolved (using async DNS resolutions)
	/// </summary>
	class MonoDnsBug
	{

		public void GlobalExceptionHandler(object sender, UnhandledExceptionEventArgs args)
		{
			Exception oEx=(Exception) args.ExceptionObject;

			Console.WriteLine("BUG -- UNHANDLED EXCEPTION: "+oEx.ToString());
		}

		[STAThread]
		static void Main(string[] args)
		{
			MonoDnsBug oM=new MonoDnsBug();
			oM.Start();

			Console.ReadLine();
		}

		public void Start()
		{
			AppDomain oCurDomain = AppDomain.CurrentDomain;
			oCurDomain.UnhandledException+=new UnhandledExceptionEventHandler(GlobalExceptionHandler);

			// this domain name is non-existant 
			ResolveDNS("fv7ov41hycwpjyec3p.cywater.com");
		}


		private void ResolveDNS(string sDomainName)
		{
			try
			{
				Console.WriteLine("About to start resolving {0}",sDomainName);
				Dns.BeginResolve(sDomainName,new AsyncCallback(AsyncDNSResolved),null);
			}
			catch(Exception oEx)
			{
				Console.WriteLine("ResolveDNS() exception: "+oEx.ToString());
			}

		}

		// callback we get from DNS resolver
		private void AsyncDNSResolved(IAsyncResult oAR)
		{

			try
			{
				IPHostEntry oIP=Dns.EndResolve(oAR);

				Console.WriteLine("Domain name was successfully resolved!");
			}
			catch(Exception oEx)
			{
				Console.WriteLine("AsyncDNSResolved() exception: "+oEx.ToString());
			}
		}

	}
}
