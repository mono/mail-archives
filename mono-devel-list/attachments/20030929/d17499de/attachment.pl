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
	public class DataRelationTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestDataRelation()
		{
			DataSet ds = new DataSet();
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			ds.Tables.Add(table);

			table = new DataTable("2");
			table.Columns.Add("name");
			table.Rows.Add(new object[] {"John"});
			table.Rows.Add(new object[] {"Sara"});
			ds.Tables.Add(table);
			
			DataRelation rel = new DataRelation(null, ds.Tables[0].Columns[0], ds.Tables[1].Columns[0]);

			AssertEquals("Relation name not empty string", string.Empty, rel.RelationName);
		}
		
		
	}
}
