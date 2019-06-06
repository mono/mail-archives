using System;
using System.Data;
using System.IO;
using System.Collections;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;


namespace DataSetXML
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
			// Create a DataSet with one table containing two columns and 10 rows.
			DataSet ds = new DataSet("myDataSet");
			DataTable t = ds.Tables.Add("Items");
			t.Columns.Add("id", typeof(string));
			t.Columns.Add("Item", typeof(string));

			// Add ten rows.
			DataRow r;
			for(int i = 0; i <10;i++)
			{
				r = t.NewRow();
				r["id"]= "id"+i;
				r["Item"]= "Item" + i;
				t.Rows.Add(r);
			}
			t = ds.Tables.Add("Price");
			t.Columns.Add("id", typeof(string));
			t.Columns.Add("PriceItem", typeof(string));

			// Add ten rows.
			for(int i = 0; i <10;i++)
			{
				r = t.NewRow();
				r["id"]= "id"+i;
				r["PriceItem"]= "Price" + i;
				t.Rows.Add(r);
			}
			
			t = ds.Tables.Add("SanjayItems");                        
			t.Columns.Add("id", typeof(string));                        
			t.Columns.Add("Sanjayid", typeof(string));
                        t.Columns.Add("SanjayItem", typeof(string));
                        // Add ten rows.
                        for(int i = 0; i <10;i++)
                        {                                
				r = t.NewRow();
                                r["id"]= "id"+i;
                                r["Sanjayid"]= "id"+i;
                                r["SanjayItem"]= "Item" + i;
                                t.Rows.Add(r);
                        }                        
			
			t = ds.Tables.Add("SanjayPrice");
                        t.Columns.Add("Sanjayid", typeof(string));
                        t.Columns.Add("SanjayPriceItem", typeof(string));
                        // Add ten rows.
                        for(int i = 0; i <10;i++)
                        {                                
				r = t.NewRow();
                                r["Sanjayid"]= "id"+i;
                                r["SanjayPriceItem"]= "Price" + i;
                                t.Rows.Add(r);
                        }                        
			
			DataRelation relation = ds.Relations.Add(ds.Tables["Items"].Columns["id"], ds.Tables["Price"].Columns["id"]);                
			relation.RelationName = "myRelation";                        
			relation.Nested = true;

                        relation = ds.Relations.Add(ds.Tables["Price"].Columns["id"], ds.Tables["SanjayItems"].Columns["id"]);                        
			relation.RelationName = "SanjayRelation";
                        relation.Nested = true;

			// Display the DataSet contents as XML.
			//Console.WriteLine(ds.GetXml() );
			
			//Display the constraints contained in the ds
			foreach (DataRelation rel in ds.Relations)
			{
				Console.WriteLine(rel.ToString());
				Console.WriteLine(rel.Nested);
				Console.WriteLine(rel.RelationName);
				Console.WriteLine(rel.ChildKeyConstraint.ConstraintName);
				Console.WriteLine(rel.ChildKeyConstraint.AcceptRejectRule);
				Console.WriteLine(rel.ChildKeyConstraint.DeleteRule);
				Console.WriteLine(rel.ChildKeyConstraint.UpdateRule);
				Console.WriteLine(rel.ParentKeyConstraint.ConstraintName);
				Console.WriteLine(rel.ParentKeyConstraint.IsPrimaryKey);
			}

			
			/*IFormatter formatter = new BinaryFormatter();
			Stream stream = new FileStream("MyFile1.txt", FileMode.Create, FileAccess.Write, FileShare.None);
			formatter.Serialize(stream, ds);
			stream.Close();

			formatter = new BinaryFormatter();
			stream = new FileStream("MyFile1.txt", FileMode.Open, FileAccess.Read, FileShare.Read);
			ds = (DataSet) formatter.Deserialize(stream);
			stream.Close(); 
			Console.ReadLine();*/

			ds.WriteXml("xml.txt", XmlWriteMode.WriteSchema);
			Console.ReadLine();
		}
	}
}
