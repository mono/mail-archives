<%@ Page Language="C#" %>
<html>
<head>
	<script runat="server">
	private void Fill(object sender, System.EventArgs e)
	{
			optionsList.Add ("One");
			optionsList.Add ("Two");
			dl.DataSource = optionsList;
			dl.DataBind();
	}
	
	private void Clear(object sender, System.EventArgs e)
	{
			dl.DataSource = null;
			dl.DataBind();
	}
	</script>
</head>
<body>
	<object id="optionsList" runat="server" class="System.Collections.ArrayList" />
	<h3>Test1 : Assigning a null value to DataSource</h3>
	<form id="form" runat="server">
		<asp:Button id="fillButton" runat="server" Text="Fill" OnClick="Fill"/>
		<asp:DataGrid id="dl" runat="server" autopostback="true" />
		<asp:Button id="clearButton" runat="server" Text="Clear" OnClick="Clear"/>
	</form>
</body>
</html>
