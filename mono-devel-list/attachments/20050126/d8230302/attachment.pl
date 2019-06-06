using System;
using System.Data;
using System.Data.Common;
using Mono.Data.SqliteClient;

public class Test
{
	private const string SELECTALL = "SELECT * FROM employee";
	
	private static DataSet dset;
	private static SqliteDataAdapter sqlda;
	private static SqliteConnection sqlcon;

	public static void Main(string[] args)
	{
		sqlcon = new SqliteConnection("URI=file:sqlitetest.db");
		sqlda = new SqliteDataAdapter(SELECTALL, sqlcon);
		sqlda.Fill(dset);

	}
}
	
