<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Julien Sobrier</title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
    <!--
        var displayElement;
        
        function LoadSection(id,start) {
            var page = 'Thumbails.aspx?ID=' + id + '&START=' + start;
            GetWebRequest(page, 'content');
            
            return false;
        }
        
        function LoadImage(id, group) {
            var page = 'Image.aspx?ID=' + id + '&GROUP=' + group;
            GetWebRequest(page, 'content');
            
            return false;
        }
        
        function GetWebRequest(getPage, HTMLtarget)
        {
            displayElement = $get(HTMLtarget);
            var wRequest =  new Sys.Net.WebRequest(); 
            wRequest.set_url(getPage);  
            wRequest.set_httpVerb("GET");
            wRequest.set_userContext("user's context");
            wRequest.add_completed(OnWebRequestCompleted)
            wRequest.invoke();      
        }
        
        function OnWebRequestCompleted(executor, eventArgs) 
        {
            if (executor.get_responseAvailable()) {  
               // displayElement.innerHTML = "";               
               //if (document.all) {
                  displayElement.innerHTML = executor.get_responseData();
               //}
               //else {   // Firefox
               //   displayElement.textContent = executor.get_responseData();
               //}
           }
            else {
               if (executor.get_timedOut())
               {
                  alert("Timed Out");
               }
               else
               {
                  if (executor.get_aborted())
                        alert("Aborted");
               }
            }
        }

        if (typeof(Sys) !== "undefined") Sys.Application.notifyScriptLoaded();
    -->
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <ajax:ScriptManager ID="ScriptManager1" runat="server" />
        <div>
            <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Height="680">
                <cc1:TabPanel ID="TabPanel1" runat="server">
                    <HeaderTemplate>Home</HeaderTemplate>
                    <ContentTemplate>
                        <h1>Welcome to Julien Sobrier's website</h1>
                        <p>Description goes here</p>
                        <ul>
                            <li>item 1</li>
                            <li>item 2</li>
                        </ul>
                    </ContentTemplate>
                </cc1:TabPanel>
                <cc1:TabPanel ID="TabPanel2" runat="server">
                    <HeaderTemplate>
                        Pictures
                    </HeaderTemplate>
                    <ContentTemplate>
                    <table width="100%">
                    <tr>
                    <td valign="top">
                        <cc1:Accordion ID="Accordion1" runat="server" 
                        ContentCssClass="content" HeaderCssClass="header" 
                        FramesPerSecond="40" TransitionDuration="250" 
                        AutoSize="None" Width="250" DataSourceID="SqlStructure">
                        <HeaderTemplate>
                            <span><%# Eval("titreen") %></span>
                        </HeaderTemplate>
                        <ContentTemplate>
                            <ol>
                                <asp:Label ID="ParentData" runat="server" Text='<%# Eval("no") %>' Visible="false" />
                                <asp:SqlDataSource ID="SqlSons" runat="server" EnableCaching="true"  
                                     ConnectionString='<%$ ConnectionStrings:MySqlServer %>'
                                     ProviderName="MySql.Data.MySqlClient"
                                     SelectCommand="SELECT no, titrefr FROM structure WHERE parent= ?Parent ORDER BY no DESC">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="Parent" DefaultValue="74" Type="Int32" ControlID="ParentData" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlSons">
                                <ItemTemplate>
                                    <li>
                                        <a href="javascript:void(0)" onclick='return LoadSection(<%# Eval("no") %>, 0)'><%# Eval("titrefr") %></a>
                                    </li>
                                </ItemTemplate>
                                </asp:Repeater>
                            </ol>
                        </ContentTemplate>
                      </cc1:Accordion>
                      </td>
                      <td align="center">
                        <div id="content">
                            <h2>Choose a list of pictures on the left pane.</h2>
                        </div>
                      </td>
                      </tr>
                      </table>
                    </ContentTemplate>
                </cc1:TabPanel>
            </cc1:TabContainer>
        </div>

        <asp:SqlDataSource ID="SqlStructure" runat="server" EnableCaching=true 
             SelectCommand="SELECT no, titreen FROM structure WHERE parent = 0 ORDER BY no DESC"/>   
    </form>
</body>
</html>
