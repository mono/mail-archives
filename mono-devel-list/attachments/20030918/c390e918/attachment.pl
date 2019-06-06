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
			DataSet s =  new DataSet();
			DataTable t = new DataTable("table1");
			t.Columns.Add("ID", typeof(int));
			t.Columns.Add("NAME", typeof(string));

			s.Tables.Add(t);
			s.Tables.Add(t);
			
			t = new DataTable("table1");
			t.Columns.Add("ADDRESS");
			s.Tables.Add(t);
			PrintValues(s);
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
