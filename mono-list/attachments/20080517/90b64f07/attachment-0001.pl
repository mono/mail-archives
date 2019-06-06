<%@ Page Language="C#" compilerOptions="/codepage:utf8" Debug="true" ClassName="PruebaODBC" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Data.Odbc" %>
<script runat="server">

    void btnEjecutar_Click(object sender, EventArgs e)
    {
        OdbcConnection oConn;
        OdbcCommand oCommand;
        OdbcDataAdapter oDataAdapter;
        OdbcDataReader oReader;
    
    
        lblPeticionEjecutada.Text = txtPeticionSQL.Text;
        oConn = new OdbcConnection(txtDSN.Text);
        oConn.Open();
        oDataAdapter = new OdbcDataAdapter();
        oCommand = new OdbcCommand(txtPeticionSQL.Text, oConn);
    
        oReader = oCommand.ExecuteReader();
        dgrMysqlVar.DataSource = oReader;
        dgrMysqlVar.DataBind();
    
        oConn.Close();
    }

</script>
<html>
<head>
</head>
<body>
    <form runat="server">
            <table style="WIDTH: 515px; HEIGHT: 102px">
                <tbody>
                    <tr>
                        <td>
                            <p>
                                <asp:Label id="lblDSN" runat="server">DSN de datos:</asp:Label>
                            </p>
                        </td>
                        <td>
                            <asp:TextBox id="txtDSN" runat="server" Width="392px">Driver={MySQL ODBC 3.51 Driver};user=test;password=test;</asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label id="lblPeticion" runat="server">Petición SQL:</asp:Label></td>
                        <td>
                            <p>
                                <asp:TextBox id="txtPeticionSQL" runat="server" Width="394px"></asp:TextBox>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p align="center">
                                <asp:Button id="btnEjecutar" onclick="btnEjecutar_Click" runat="server" Text="Ejecutar"></asp:Button>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        <p>
        </p>
        <p>
            <asp:Label id="lblPeticionEj" runat="server">Resultados para petición:</asp:Label>&nbsp;<asp:Label id="lblPeticionEjecutada" runat="server"></asp:Label> 
        </p>
        <p>
            <asp:DataGrid id="dgrMysqlVar" runat="server" Width="362px" Height="61px"></asp:DataGrid>
        </p>
        <!-- Insert content here -->
    </form>
</body>
</html>
