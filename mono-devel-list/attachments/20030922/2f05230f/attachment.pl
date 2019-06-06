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
		
		public void test1() {
			DataSet d = new DataSet();
			DataTable t = new DataTable( "Customers" );
			d.Tables.Add(t);
			t.Columns.Add( "customerId", typeof(int)    ).AutoIncrement = true;
			t.Columns.Add( "name",       typeof(string) );
			UniqueConstraint uc = new UniqueConstraint(new DataColumn[] {t.Columns["customerId"]}, false);
			t.Constraints.Add(uc);
			t.Rows.Add(new object[] { 1, "lala"}); 
			t.Rows.Add(new object[] { 1, "baba"}); 
			
		}

		private void PrintValues(DataSet ds) {
			Console.WriteLine("DataSet - " + ds.DataSetName);
			for (int i = 0; i < ds.Tables.Count; i++) {
				DataTable t = ds.Tables[i];
				Console.WriteLine("TableName: " + t.TableName);
				for(int j = 0; j < t.Rows.Count; j++) {
					DataRow r = t.Rows[j];
					for(int k = 0; k < t.Columns.Count; k++) {
						DataColumn c = t.Columns[k];
						Console.Write("\t " + r[c] );
					}
					Console.WriteLine();
				}
			}
		}
	}
}
