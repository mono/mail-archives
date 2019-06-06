using System;
using System.IO;
using Mono.Security.X509;

namespace Test
{
	public class X509ChainTestCase
	{
		public static void Main (string[] args)
		{
			Stream caStream = File.OpenRead ("ca_test.der.crt");
			byte[] caData = new byte[caStream.Length];
			caStream.Read (caData, 0, caData.Length);
			X509Certificate ca = new X509Certificate (caData);

			Stream certStream = File.OpenRead ("test_tls_client.der.crt");
			byte[] certData = new byte[certStream.Length];
			certStream.Read (certData, 0, certData.Length);
			X509Certificate cert = new X509Certificate (certData);

			//X509StoreManager.CurrentUser.TrustedRoot.Certificates.Add (ca);

			X509Chain chain = new X509Chain ();
			chain.TrustAnchors.Add (ca);

			Console.WriteLine ("result: {0}; status: {1}", chain.Build (cert).ToString (), chain.Status);
		}
	}
}
