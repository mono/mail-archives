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
			// create a DataSet with two tables
			DataSet myDataSet = new DataSet();

			// create Customer table
			DataTable t = new DataTable( "Customers" );
			t.Columns.Add( "customerId", typeof(int)    ).AutoIncrement = true;
			t.Columns.Add( "name",       typeof(string) );
			t.Columns.Add( "id",       typeof(int) );
			t.PrimaryKey = new DataColumn[] { t.Columns["customerId"] };

			// create Orders table
			DataTable t2 = new DataTable( "Orders" );
			t2.Columns.Add( "orderId",    typeof(int)    ).AutoIncrement = true;
			t2.Columns.Add( "customerId", typeof(int)    );
			t2.Columns.Add( "amount",     typeof(double) );
			t2.PrimaryKey = new DataColumn[] { t2.Columns["orderId"] };

			myDataSet.Tables.AddRange( new DataTable[] {t, t2 } );

			// remove all tables
			// check if table can be removed and then
			// remove it, cannot use a foreach when
			// removing items from a collection
			while( myDataSet.Tables.Count > 0 ) {
				DataTable table = myDataSet.Tables[0];
				if( myDataSet.Tables.CanRemove( table ) ) {
					myDataSet.Tables.Remove( table );
				}
			}

			Console.WriteLine( "myDataSet has {0} tables", myDataSet.Tables.Count );
			
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
