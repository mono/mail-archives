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
	public class DataRelationCollectionTest : NUnit.Framework.Assertion
	{
		
		[NUnit.Framework.Test]
		public void TestAdd1()
		{
			DataSet ds = new DataSet();
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			table.Columns.Add("id");
			table.Columns.Add("address");
			ds.Tables.Add(table);

			table = new DataTable("2");
			table.Columns.Add("name");
			table.Columns.Add("id");
			table.Columns.Add("address");
			ds.Tables.Add(table);

			DataRelation r = new DataRelation(null, ds.Tables[0].Columns[0], ds.Tables[1].Columns[0]);
			ds.Relations.Add(r);
			AssertEquals("Reltion name is wrong", r.RelationName, "Relation1");

			r = new DataRelation(null, ds.Tables[0].Columns[1], ds.Tables[1].Columns[1]);
			ds.Relations.Add(r);
			AssertEquals("Reltion name is wrong", r.RelationName, "Relation2");
			
			ds.Relations.Remove(r);

			r = new DataRelation(null, ds.Tables[0].Columns[2], ds.Tables[1].Columns[2]);
			ds.Relations.Add(r);
			AssertEquals("Reltion name is wrong", r.RelationName, "Relation2");
		}

		[NUnit.Framework.Test]
		public void TestAdd2()
		{
			DataSet ds = new DataSet();
			DataTable table = new DataTable("1");
			table.Columns.Add("name");
			table.Columns.Add("id");
			table.Columns.Add("address");
			ds.Tables.Add(table);

			table = new DataTable("2");
			table.Columns.Add("name");
			table.Columns.Add("id");
			table.Columns.Add("address");
			ds.Tables.Add(table);

			DataRelation r = new DataRelation(null, ds.Tables[0].Columns[0], ds.Tables[1].Columns[0]);
			ds.Relations.Add(r);
			AssertEquals("Wrong value in Reltions.Count", ds.Relations.Count, 1);

			
		}
		
			
	}
}
