using System;
using System.Data;

public class Test {
  DataRow row = null;
  void PrintRow(string s) {
    try {
      Console.Write("D={0}", row[0]);
    } catch (Exception ex) {
      Console.Write("D=E");
    }
    try {
      Console.Write(", P={0}", row[0, DataRowVersion.Proposed]);
    } catch (Exception ex) {
      Console.Write(", P=E");
    }
    try {
      Console.Write(", C={0}", row[0, DataRowVersion.Current]);
    } catch (Exception ex) {
      Console.Write(", C=E");
    }
    try {
      Console.Write(", O={0}", row[0, DataRowVersion.Original]);
    } catch (Exception ex) {
      Console.Write(", O=E");
    }
    Console.WriteLine(", S={0}, {1}", row.RowState, s);
  }
  
  public Test() {
    DataTable table = new DataTable("Tab");
    table.Columns.Add(new DataColumn("ID", typeof(int)));
    row = table.NewRow();
    PrintRow("row = table.NewRow()");
    row[0] = 1;
    PrintRow("row[0] = 1");
    row.BeginEdit();
    PrintRow("row.BeginEdit()");
    row[0] = 2;
    PrintRow("row[0] = 2");
    row.CancelEdit();
    PrintRow("row.CancelEdit()");
    row.BeginEdit();
    PrintRow("row.BeginEdit()");
    row[0] = 2;
    PrintRow("row[0] = 2");
    row.EndEdit();
    PrintRow("row.EndEdit()");
    table.Rows.Add(row);
    PrintRow("table.Rows.Add(row)");
    table.Rows.Remove(row);
    PrintRow("table.Rows.Remove(row)");
    row[0] = 2;
    PrintRow("row[0] = 2");
    table.Rows.Add(row);
    PrintRow("table.Rows.Add(row)");
    row.BeginEdit();
    PrintRow("row.BeginEdit()");
    row[0] = 3;
    PrintRow("row[0] = 3");
    row.EndEdit();
    PrintRow("row.EndEdit()");
    row.AcceptChanges();
    PrintRow("row.AcceptChanges()");
    row[0] = 4;
    PrintRow("row[0] = 4");
    row.AcceptChanges();
    PrintRow("row.AcceptChanges()");
    row.BeginEdit();
    PrintRow("row.BeginEdit()");
    row[0] = 5;
    PrintRow("row[0] = 5");
    row.EndEdit();
    PrintRow("row.EndEdit()");
    row.BeginEdit();
    PrintRow("row.BeginEdit()");
    row[0] = 6;
    PrintRow("row[0] = 6");
    row.AcceptChanges();
    PrintRow("row.AcceptChanges()");
    row.Delete();
    PrintRow("row.Delete()");
  }
  
  public static void Main() {
    new Test();
  }
}

