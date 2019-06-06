<%@ Page Language="C#" %>
<html>
<head>
	<script runat="server">
	public class NumberMessage
	{
		private string message;
		
		public NumberMessage (string message)
		{
			this.message = message;
		}

		public string Message 
		{
			get { return message; }
		}
	}
	
	private void Page_Load (object sender, EventArgs e)
	{
		if (!IsPostBack){
			optionsList.Add (new NumberMessage ("One"));
			optionsList.Add (new NumberMessage ("Two"));
			list.DataSource = optionsList;
			list.DataBind();
		}
		else
			msg.Text = "Selected option: " + list.SelectedItem.Text + " " + list.SelectedItem.Value;
	}
	</script>
</head>
<body>
	<object id="optionsList" runat="server" class="System.Collections.ArrayList" />
	<h3>Test3 : Using datavaluefield only</h3>
	<form id="form" runat="server">     
		<asp:DropDownList id="list" runat="server" autopostback="true" datavaluefield="Message"/>
		<asp:Label id="msg" runat="server" />
	</form>
</body>
</html>

