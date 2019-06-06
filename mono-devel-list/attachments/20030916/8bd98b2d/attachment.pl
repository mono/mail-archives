using System;
using System.Data.SqlClient;

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
			SqlCommand myCommand = new SqlCommand("SELECT ID, NAME FROM table1", myConnection);

			myConnection.Open();
			SqlDataReader reader = myCommand.ExecuteReader();

			foreach (object o in reader) {
				
				System.Data.Common.DbDataRecord rec = (System.Data.Common.DbDataRecord)o;
				object[] objs = new object[rec.FieldCount];
				
				rec.GetValues(objs); // we get null values in objs
				Console.WriteLine("Values from GetValues(object[] values)");
				Console.WriteLine(objs[0]);
				Console.WriteLine(objs[1]);

				Console.WriteLine("Values from GetValue(int index)");
				Console.WriteLine(rec.GetValue(0));
				Console.WriteLine(rec.GetValue(1));

				
			}
			myConnection.Close();	
		}
	}
}
