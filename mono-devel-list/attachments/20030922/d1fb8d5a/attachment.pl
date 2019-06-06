using System;
using System.Data.SqlClient;
using System.Data;

namespace Test {
	/// <summary>
	/// Summary description for TestCase.
	/// </summary>
	public class TestCase {

		string connectionString = "workstation id=\"ERAND-XP1\";packet size=4096;user id=sa;data source=\"GH-SERVE\";persist security info=False;initial catalog=Eran";
		public TestCase() {
		}
		
		public void test1() {
			SqlConnection myConnection = new SqlConnection(connectionString);
			DataSet s =  new DataSet();
			DataTable t = new DataTable("table1");
			t.Columns.Add("ID", typeof(int));
			t.Columns.Add("NAME", typeof(string));

			s.Tables.Add(t);

			SqlDataAdapter adapter = new SqlDataAdapter("SELECT ID, NAME FROM table1", myConnection);
			adapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {new System.Data.Common.DataTableMapping("Table", "table1", new System.Data.Common.DataColumnMapping[] {new System.Data.Common.DataColumnMapping("ID", "ID"),
																									    new System.Data.Common.DataColumnMapping("NAME", "NAME")})});
																									    
			adapter.Fill(s);
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
