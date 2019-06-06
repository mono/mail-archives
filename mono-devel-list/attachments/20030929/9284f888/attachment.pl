using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace Nunittest
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	[NUnit.Framework.TestFixture] 
	public class DbDataAdapterdTest : NUnit.Framework.Assertion
	{
		static string connectionString = "workstation id=\"ERAND-XP1\";packet size=4096;user id=sa;data source=\"GH-SERVE\";persist security info=False;initial catalog=Northwind";
		static string commandText = "SELECT OrderID, FROM Orders";
		[NUnit.Framework.Test]
		public void TestGetValues()
		{
			SqlConnection myConnection = new SqlConnection(connectionString);
			SqlDataAdapter adapter = new SqlDataAdapter(commandText, myConnection);

			DataTable table = new DataTable();
			adapter.Fill(table);
		}

		
	}
}
