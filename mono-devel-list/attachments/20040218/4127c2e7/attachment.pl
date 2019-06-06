<% @Application Language="C#" %>

<object id='myApplication' class='System.Text.StringBuilder' scope='application' runat='server' />
<object id='mySession' class='System.Text.StringBuilder' scope='session' runat='server' />

<script runat='server'>
void Application_Start(Object sender, EventArgs e) {
	System.Console.WriteLine("Application_Start called.");
	myApplication.Append("Hello");
}

void Session_Start(Object sender, EventArgs e) {
	System.Console.WriteLine("Session_Start called.");
	mySession.Append("Hello");
}
</script>