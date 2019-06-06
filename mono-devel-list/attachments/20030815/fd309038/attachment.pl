<%@ Page Language="C#" %>
<%@ Import namespace="System.Data" %>

<html>
 <head>
  <title>HyperLinkColumn test</title>
 </head>
 <body>

  <script language="c#" runat="server">
   private void Page_Load(object sender, System.EventArgs e)
   { 
	DataTable TestTable = new DataTable("TestTable");
	TestTable.Columns.Add("product", typeof(System.String));
	TestTable.Columns.Add("id", typeof(System.String));

	DataRow row = TestTable.NewRow ();
	row["product"] = "Product #1";
	row["id"] = "1";
	TestTable.Rows.Add(row);

	productgrid.DataSource = TestTable;
	productgrid.DataBind ();
   }
  </script>

  <form runat="server" method="post">
   <asp:DataGrid id="productgrid" runat="server" AutoGenerateColumns="false">
    <Columns>
     <asp:BoundColumn DataField="product" HeaderText="Product" />
     <asp:HyperLinkColumn Text="View" DataNavigateUrlField="id" DataNavigateUrlFormatString="target_page.aspx?id={0}" />
    </Columns>
   </asp:DataGrid>
  </form>

 </body>
</html>

