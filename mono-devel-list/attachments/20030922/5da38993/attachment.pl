using System;
using System.Data.SqlClient;
using System.Data;

namespace Test {
	/// <summary>
	/// Summary description for TestCase.
	/// </summary>
	public class TestCase {

		public TestCase() {
		}
		
		public void test1() 
		{
			DataSet d = new DataSet();
			DataTable t = new DataTable( "Parents" );
			d.Tables.Add(t);
			t.Columns.Add("parentId", typeof(int)).AutoIncrement = true;
			t.Columns.Add("name", typeof(string));
			t.PrimaryKey = new DataColumn[] { t.Columns[0] };
			
			t = new DataTable("Child");
			d.Tables.Add(t);
			t.Columns.Add( "parentId", typeof(int)).AutoIncrement = true;
			t.Columns.Add( "name", typeof(string));
			d.Relations.Add(d.Tables[0].Columns[0], d.Tables[1].Columns[0]);
		}
	}
}
