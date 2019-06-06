using System;
using System.Data;

namespace Test
{
	public class Test
	{
		public static void Main(string[] args)
		{
			DataTable dt = CreateDataTable();
			DataView dv = new DataView(dt);
			dt.Columns[1].DefaultValue = "default";

			dt.Rows.Add(new object[] {99});
			dt.Rows[1].Delete();
			dt.Rows[2].BeginEdit();
			dt.Rows[2][1] = "aaa";
			
			// Set row state filter
			dv.RowStateFilter=DataViewRowState.CurrentRows ;		
			DataRowView drv = dv[0];
			// Inspect row version
			Console.WriteLine(drv.RowVersion);

			// Set row state filer
			dv.RowStateFilter=DataViewRowState.Deleted ;
			//Inspect row version - changes !!!
			Console.WriteLine(drv.RowVersion);
			Console.WriteLine(dv[0] == drv);
		}

		public static DataTable CreateDataTable()
		{     
			System.Data.DataTable dtParent = new System.Data.DataTable("Parent");

			dtParent.Columns.Add("ParentId",typeof(int));
			dtParent.Columns.Add("String1",typeof(string));
			dtParent.Columns.Add("String2",typeof(string));

			dtParent.Columns.Add("ParentDateTime",typeof(DateTime));
			dtParent.Columns.Add("ParentDouble",typeof(double));
			dtParent.Columns.Add("ParentBool",typeof(bool));

			dtParent.Rows.Add(new object[] {1,"1-String1","1-String2",new DateTime(2005,1,1,0,0,0,0),1.534,true});
			dtParent.Rows.Add(new object[] {2,"2-String1","2-String2",new DateTime(2004,1,1,0,0,0,1),-1.534,true});
			dtParent.Rows.Add(new object[] {3,"3-String1","3-String2",new DateTime(2003,1,1,0,0,1,0),double.MinValue*10000,false});
			dtParent.Rows.Add(new object[] {4,"4-String1","4-String2",new DateTime(2002,1,1,0,1,0,0),double.MaxValue/10000,true});
			dtParent.Rows.Add(new object[] {5,"5-String1","5-String2",new DateTime(2001,1,1,1,0,0,0),0.755,true});
			dtParent.Rows.Add(new object[] {6,"6-String1","6-String2",new DateTime(2000,1,1,0,0,0,0),0.001,false});
			dtParent.AcceptChanges();
			return dtParent;

		}
	}
}
