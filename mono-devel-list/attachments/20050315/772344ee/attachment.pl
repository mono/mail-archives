using System;
using System.DirectoryServices;
using NUnit.Framework;

namespace GH_cs_DirectoryServicesTest
{
	[TestFixture]
	public class SimpleTest
	{
		static string LDAPServerConnectionString = "LDAP://xp050/" + "dc=myhosting,dc=example";
		static string LDAPServerUsername = "cn=Manager,dc=myhosting,dc=example";
		static string LDAPServerPassword = "secret";

		[Test]
		public void SizeLimitTest()
		{
			DirectoryEntry de = new DirectoryEntry(LDAPServerConnectionString,
									LDAPServerUsername,
									LDAPServerPassword,
									AuthenticationTypes.ServerBind);
			DirectorySearcher ds = new DirectorySearcher(de);

			Assert.AreEqual(ds.SizeLimit,0);
			
			ds.Filter = "(|(objectClass=person)(objectClass=organizationalUnit))";
			SearchResultCollection results = ds.FindAll();
			Assert.AreEqual(results.Count,12);

			ds.SizeLimit = 3;
			Assert.AreEqual(ds.SizeLimit,3);

			ds.Filter = "(|(objectClass=person)(objectClass=organizationalUnit))";
			results = ds.FindAll();
			Assert.AreEqual(results.Count,3);

			ds.SizeLimit = Int32.MaxValue;
			Assert.AreEqual(ds.SizeLimit,Int32.MaxValue);

			ds.Filter = "(|(objectClass=person)(objectClass=organizationalUnit))";
			results = ds.FindAll();
			Assert.AreEqual(results.Count,12);
		}
	}
}
