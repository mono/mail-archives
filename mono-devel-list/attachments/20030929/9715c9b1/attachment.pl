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
	public class DataRowTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestAcceptChanges()
		{
			
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			DataRow r = table.NewRow();
			r[0] = "Sara";
			table.Rows.Add(r);
			table.AcceptChanges();

			table.Rows.Remove(r);
			table.AcceptChanges();
			try
			{
				r.AcceptChanges();
				Fail("Exception not thrown in AcceptChanges()");
			}
			catch (RowNotInTableException)
			{
			}
		}
		
		[NUnit.Framework.Test]
		public void TestIsNull()
		{
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			DataRow r = table.NewRow();
			
			table.Rows.Add(r);
			table.AcceptChanges();
			AssertEquals("value is not null", r.IsNull(table.Columns[0]), true);

		}		
	}
}
