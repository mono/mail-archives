using System.Web;
using System.Web.Services.Protocols;

namespace MyNamespace
{
	public class OptionalDocumentationRequestHandlerFactory : IHttpHandlerFactory
	{
		private class DocumentationForbiddenHandler : IHttpHandler
		{
			public DocumentationForbiddenHandler()
			{
			}

			public void ProcessRequest(HttpContext context)
			{
				throw new HttpException(403, "Forbidden");
			}

			public bool IsReusable
			{
				get
				{
					return true;
				}
			}
		}

		internal static bool EnableDocumentation;

		private WebServiceHandlerFactory webServiceHandlerFactory;

		public OptionalDocumentationRequestHandlerFactory()
		{
			webServiceHandlerFactory = new WebServiceHandlerFactory();
		}

		public IHttpHandler GetHandler(HttpContext context, string verb, string url, string filePath)
		{
			string pathInfo = context.Request.PathInfo;

			if (!EnableDocumentation && verb == "GET" && (pathInfo == null || pathInfo.Length == 0))
				return new DocumentationForbiddenHandler();

			return webServiceHandlerFactory.GetHandler(context, verb, url, filePath);
		}

		public void ReleaseHandler(IHttpHandler handler)
		{
			if (!(handler is DocumentationForbiddenHandler))
				webServiceHandlerFactory.ReleaseHandler(handler);
		}
	}
}
