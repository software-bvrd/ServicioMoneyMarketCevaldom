<%@ Page Title="SISTEMA DE GENERACION DE TOKEN" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="aa" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" sizes="180x180" />

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <div class="jumbotron">
        <h1>BVRD</h1>
        <p class="lead">GENERACION DE TOKEN CEVALDOM</p>
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

</asp:Content>
