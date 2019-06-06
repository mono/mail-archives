using System;
using System.Data;
using System.Data.Odbc;

namespace test
{
	public class what {
		[STAThread]
		public static void Main (string [] args) {
			using(IDbConnection dbConnection = new OdbcConnection())
			{
				dbConnection.ConnectionString = "DSN=monotest;UID=suresh;PWD=hello";
				dbConnection.Open();
				while(true)
				{
					MyMethod(dbConnection);
					System.Console.Write(".");
					System.GC.Collect ();
				}
			}
		}

		static void MyMethod(IDbConnection dbConnection)
		{
			try
			{
				IDbCommand dbCommand = dbConnection.CreateCommand();
				dbCommand.CommandText = "select * from testme";
				dbCommand.ExecuteNonQuery();
			}
			catch(Exception exception)
			{
				
				System.Console.WriteLine (exception.ToString());
			}
		}
	}
}
