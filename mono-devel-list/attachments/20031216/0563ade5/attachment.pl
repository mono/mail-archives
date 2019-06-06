using System;
using System.Data;
using System.Data.SqlClient;

namespace EjemploSqlCommand
{
	/// <summary>
	/// Summary description for Class1.
	/// </summary>
	class Class1
	{
		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main(string[] args)
		{
			Console.WriteLine("(1) Todos (2) Uno");
			string sel = Console.ReadLine();

			switch( sel )
			{
				case "1":
					BuscaProducto();
					break;
				case "2":
					Console.WriteLine("IdCategoria:");
					int nProd = Convert.ToInt32(Console.ReadLine());
					BuscaCategoria(nProd);
					break;
			}
			Console.WriteLine("Presiona...");
			Console.ReadLine();
		}

		static public void BuscaProducto()
		{
			string  strPrecio = "-1";
			SqlConnection sqlConn = new SqlConnection();
			try
			{
				SqlCommand sqlComm = new SqlCommand();			

				sqlConn.ConnectionString = "server=192.168.0.1;uid=sa;pwd=;database=Northwind";
				sqlConn.Open();

				sqlComm.Connection = sqlConn;

				sqlComm.CommandText = "SELECT ProductName, CategoryID FROM Products";

				SqlDataReader sqlReader;
				sqlReader = sqlComm.ExecuteReader();
				while( sqlReader.Read() )
				{
					Console.WriteLine("Producto:" + sqlReader.GetString(0) );
					
					BuscaCategoria( sqlReader.GetInt32(1) );
				}

				sqlConn.Close();
			}
			catch( Exception ex )
			{
				//Si ocurrió un error entonces regresa un precio inválido
				Console.WriteLine("EXCEPCION:" + ex.Message);
				//dPrecio = -1.0;
			}
				//EFV
			finally
			{
				if( sqlConn.State == System.Data.ConnectionState.Open )
					sqlConn.Close ();
			}
			
		}

		static public void BuscaCategoria(int nIdProducto )
		{
			string  strPrecio = "-1";
			SqlConnection sqlConn = new SqlConnection();
			try
			{
				SqlCommand sqlComm = new SqlCommand();			

				sqlConn.ConnectionString = "server=192.168.0.1;uid=sa;pwd=;database=Northwind";
				sqlConn.Open();

/*				Console.WriteLine("IdProducto:");
				int nIdProducto = Convert.ToInt32(Console.ReadLine());
				Console.WriteLine("IdCaracteristica:");
				int nIdCaracteristica = Convert.ToInt32(Console.ReadLine());
*/
				sqlComm.Connection = sqlConn;

				sqlComm.CommandText = "SELECT CategoryName FROM Categories " + 
					"WHERE CategoryID = @IdProducto ";
					//"AND ClaveCaracteristica = @IdCaracteristica";

				sqlComm.Parameters.Add( "@IdProducto"      , nIdProducto );
				//sqlComm.Parameters.Add( "@IdCaracteristica", 1 );

				SqlDataReader sqlReader;
				sqlReader = sqlComm.ExecuteReader();
				sqlReader.Read();

				strPrecio = Convert.ToString( sqlReader.GetValue( 0 ) );

				Console.WriteLine("Categoria:"+strPrecio);
				sqlConn.Close();
			}
			catch( Exception ex )
			{
				//Si ocurrió un error entonces regresa un precio inválido
				Console.WriteLine("EXCEPCION:" + ex.Message);
				//dPrecio = -1.0;
			}
				//EFV
			finally
			{
				if( sqlConn.State == System.Data.ConnectionState.Open )
					sqlConn.Close ();
			}

		}

	}
}
