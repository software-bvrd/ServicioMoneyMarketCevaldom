<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="aa" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" sizes="180x180" />

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <div class="jumbotron">
        <h1>BVRD</h1>
        <p class="lead">GENERA DE TOKEN CEVALDOM</p>
        <%--<p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>--%>
    </div>
    <div class="form-group">

        <div class="row">
            <asp:Label ID="Label1" runat="server" Text="USUARIO:"></asp:Label>
            <asp:TextBox ID="txtusuario" class="form-control" runat="server">BVRDADM</asp:TextBox>
        </div>

        <div class="row">
            <script>
                //document.getElementById("txtfecha").innerHTML = Date();
            </script>
            <asp:Label ID="Label2" runat="server" Text="FECHA:">Fecha</asp:Label>
            <asp:TextBox ID="txtfecha" class="form-control" runat="server">...</asp:TextBox>
        </div>

        <div class="row">
            <%--<asp:Label ID="Label3" runat="server" Text="CODIGO BVRD:"></asp:Label>--%>
            <asp:TextBox ID="txtcodigo" class="form-control" runat="server">5030</asp:TextBox>
        </div>

        <div class="row">
            <asp:Label ID="Label4" runat="server" Text="TOKEN:"></asp:Label>

            <asp:TextBox ID="txttoken" class="form-control" runat="server"></asp:TextBox>
        </div>

        <div class="row">
            <asp:Button ID="Button1" runat="server" Text="Generar SHA" class="btn btn-primary btn-lg" OnClick="Button1_Click" />
        </div>
    </div>

    <div class="jumbotron">
        <h1>CODIGOS:</h1>
        <p class="lead">CODE0: 9936 	CODE1: 8576 	CODE2:9350 	CODE3:8116 	CODE4:9825 	CODE5:2819 	
                        CODE6:7789	CODE7:9277 	CODE8:8652 	CODE9:2391</p> 
    </div>
        

</asp:Content>
