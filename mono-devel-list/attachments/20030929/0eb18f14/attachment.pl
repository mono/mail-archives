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
	public class DataTabeTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestAcceptChanges()
		{
			DataTable table = new DataTable();
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			table.AcceptChanges();
			DataRow row = table.Rows[0];
			row.Delete();
			table.AcceptChanges();
		}
		
		[NUnit.Framework.Test]
		public void TestClear()
		{
			DataSet set1 = new DataSet();
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			set1.Tables.Add(table);
			table = new DataTable("2");
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			set1.Tables.Add(table);
			DataRelation relation = new DataRelation("rel1", set1.Tables[0].Columns[0], set1.Tables[1].Columns[0]);
			
			set1.Relations.Add(relation);
			try
			{
				set1.Tables[0].Clear(); // should throw an exception
				Fail("An Exception not thrown");
			}
			catch(Exception)
			{
				return;
			}

		}

		public void TestCopy()
		{
			DataTable table = new DataTable();
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			table.AcceptChanges();
			DataRow row = table.Rows[0];
			row.Delete();

			DataTable copyTable = table.Copy();
		}
	}
}
