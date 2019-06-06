using System.Data;

public class TestTable : DataTable
{
	public TestTable( System.String name ):
		base( name )
	{
		// Create a string column
		NameColumn = new DataColumn();
		NameColumn.ColumnName = "Name";
		NameColumn.DataType = typeof(System.String);
		NameColumn.ReadOnly = true;
		NameColumn.Unique = true;
		
		// Create a version column
		VersionColumn = new DataColumn();
		VersionColumn.ColumnName = "Version";
		VersionColumn.DataType = typeof(System.Version);
		VersionColumn.ReadOnly = false;
		VersionColumn.Unique = false;
		
		this.Columns.Add( NameColumn );
		this.Columns.Add( VersionColumn );
	}
		
	public DataColumn NameColumn;
	public DataColumn VersionColumn;
}

public class ApplicationEntryPoint 
{
	public static System.Int32 Main( System.String [] args )
	{
		_WriteOutDataSet();
		_ReadInDataSet();

		return 0;
	}
	
	private static DataSet _CreateDataSet( out TestTable table )
	{
		// Create a dataset and table
		DataSet dataSet = new DataSet();
		table = new TestTable("Test");
		
		// Add the table to the dataset
		dataSet.Tables.Add( table );

		return dataSet;
	}

	private static void _WriteOutDataSet()
	{
		TestTable table;
		DataSet dataSet = _CreateDataSet( out table );

		// Add a row
		DataRow row = table.NewRow();
		row[ table.NameColumn ] = "FooApp";
		row[ table.VersionColumn ] = new System.Version( 1, 2, 3, 4);
		table.Rows.Add( row );

		// Write the dataset to disk
		System.IO.FileStream fs = new System.IO.FileStream(
				"table.xml", 
				System.IO.FileMode.Create,
				System.IO.FileAccess.Write );
		dataSet.WriteXml( fs, System.Data.XmlWriteMode.IgnoreSchema );
		fs.Close();
	}

	private static void _ReadInDataSet()
	{
		TestTable notused;
		DataSet dataSet = _CreateDataSet( out notused );

		// Read the dataset from disk
		System.IO.FileStream fs = new System.IO.FileStream(
				"table.xml", 
				System.IO.FileMode.Open,
				System.IO.FileAccess.Read);
		dataSet.ReadXml( fs, System.Data.XmlReadMode.IgnoreSchema );
		fs.Close();

		// For each table in the DataSet, print the row values.
		foreach (DataTable table in dataSet.Tables)
		{
			foreach (DataRow row in table.Rows)
			{
				foreach (DataColumn column in table.Columns)
				{
					System.Console.WriteLine("{0}: {1} = {2}", table.TableName, column.ColumnName, row[column]);
				}
			}
		}
		   
	}
}
