using System;
using System.Data;
using System.Data.Common;
using Npgsql;

public class Test
{
	private const string SELECTALL = "SELECT * FROM employee";
	private const string INSERT = "INSERT INTO employee (firstname, lastname, salary) VALUES (:first,:last,:salary)";
	
	private static DataSet dset;
	private static NpgsqlDataAdapter sqlda;
	private static NpgsqlConnection sqlcon;
	private static NpgsqlCommand insert;

	public static void Main(string[] args)
	{
		sqlcon = new NpgsqlConnection("Server=127.0.0.1;User ID=nperez;Database=foo;");
		sqlda = new NpgsqlDataAdapter(SELECTALL, sqlcon);
		dset = new DataSet();

		insert = sqlcon.CreateCommand();
		insert.CommandText = INSERT;
		insert.Parameters.Add(new NpgsqlParameter("first", DbType.String));
		insert.Parameters.Add(new NpgsqlParameter("last", DbType.String));
		insert.Parameters.Add(new NpgsqlParameter("salary", DbType.Int32));
		sqlda.InsertCommand = insert;

		sqlda.Fill(dset);
		DataRow newtwo = dset.Tables[0].NewRow();
		newtwo[0] = "Jack";
		newtwo[1] = "Black";
		newtwo[2] = 10000;
		dset.Tables[0].Rows.Add(newtwo);
		sqlda.Update(dset);
	}
}

