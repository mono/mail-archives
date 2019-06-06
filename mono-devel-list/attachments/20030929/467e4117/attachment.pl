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
	public class UniqueConstraintTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestAssertConstraint()
		{
			DataSet ds = new DataSet();
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			table.PrimaryKey = new DataColumn[] {table.Columns[0]};
			ds.Tables.Add(table);

			DataRow r = table.NewRow();
			try
			{
				table.Rows.Add(r);
				Fail("Exception not thrown if PK values are missing");
			}
			catch (System.Data.NoNullAllowedException)
			{
			}
		}
		
		
	}
}
