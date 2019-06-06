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
	public class DataRowCollectionTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestAdd()
		{
			
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			DataRow r = table.NewRow();

			table.Rows.Add(r);
			
		}
		
		
	}
}
