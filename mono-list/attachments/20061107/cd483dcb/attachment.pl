using System.Web;
using System.Web.Services.Discovery;

namespace MyNamespace
{
	public class OptionalDiscoveryRequestHandler : IHttpHandler
	{
		internal static bool EnableDiscovery;

		public OptionalDiscoveryRequestHandler()
		{
		}

		public void ProcessRequest(HttpContext context)
		{
			if (!EnableDiscovery)
				throw new HttpException(403, "Forbidden");

			new DiscoveryRequestHandler().ProcessRequest(context);
		}

		public bool IsReusable
		{
			get
			{
				return true;
			}
		}
	}
}
