<%@ Page Language="C#" %>
<html>
<head>
	<script runat="server">
	private void Page_Load (object sender, EventArgs e)
	{
		if (!IsPostBack){
			dl.SelectedValue = "Two";

			optionsList.Add ("One");
			optionsList.Add ("Two");
			dl.DataSource = optionsList;
			dl.DataBind();
		}
	}
	</script>
</head>
<body>
	<object id="optionsList" runat="server" class="System.Collections.ArrayList" />
	<h3>Test2 : Selecting a value before assigning a datasource.</h3>
	<form id="form" runat="server">
		<asp:DropDownList id="dl" runat="server" />
	</form>
</body>
</html>
