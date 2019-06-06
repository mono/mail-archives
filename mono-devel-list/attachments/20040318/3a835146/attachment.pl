using System;
using System.IO;
using System.Web;
using System.Web.Hosting;

namespace saw
{
	public class MyExeHost : MarshalByRefObject 
	{
		public void ProcessRequest(String page) 
		{
			StreamWriter writer = new StreamWriter(page + ".html");
			SimpleWorkerRequest request = new SimpleWorkerRequest(page, null, writer);
			Console.WriteLine("GetAppPath(): {0}", request.GetAppPath());
			Console.WriteLine("GetAppPathTranslated(): {0}", request.GetAppPathTranslated());
			Console.WriteLine("GetFilePath(): {0}", request.GetFilePath());
			Console.WriteLine("GetFilePathTranslated(): {0}", request.GetFilePathTranslated());
			Console.WriteLine("request.MapPath(\"/virdir/file\"): {0}", request.MapPath("/virdir/file"));
			Console.WriteLine("request.MapPath(\"/virdir\"): {0}", request.MapPath("/virdir"));
			//Console.WriteLine("request.MapPath(\"file\"): {0}", request.MapPath("file"));
			HttpRuntime.ProcessRequest(request);
			writer.Close();
		}

		public static void Main(String[] arguments) 
		{
			Console.WriteLine(Directory.GetCurrentDirectory());
			MyExeHost host
				= (MyExeHost)ApplicationHost.CreateApplicationHost(
					typeof(MyExeHost),
					"/virdir",
					Directory.GetCurrentDirectory());
			foreach (String page in arguments) 
			{
				host.ProcessRequest(page);
			}
		}
	}
}
