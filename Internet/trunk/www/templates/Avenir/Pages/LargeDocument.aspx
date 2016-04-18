<%@ Page Title="" Language="C#" MasterPageFile="~/templates/Avenir/MasterPages/HTMaster.Master"
    AutoEventWireup="true" CodeBehind="LargeDocument.aspx.cs" Inherits="Helsetilsynet.templates.Avenir.Pages.LargeDocument" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Classes.PropertyMappings" %>
<%@ Import Namespace="Helsetilsynet.templates.Avenir.Util" %>

<%@ Register TagPrefix="ht" TagName="LeftMenuLargeDocuments" Src="~/templates/Avenir/Units/Placeable/LargeDocuments/LeftMenuLargeDocuments.ascx" %>
<%@ Register TagPrefix="ht" TagName="MenuOnRootChapter" Src="~/templates/Avenir/Units/Placeable/LargeDocuments/MenuOnRootChapter.ascx" %>
<%@ Register tagPrefix="ht" tagName="GeneratePdf" src="~/templates/Avenir/Units/Placeable/GeneratePDF.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="cphHead">
    <link rel="stylesheet" href="../Styles/large-documents.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#mainMenuSubLevels ul.level3").css('display', 'none');
            $("#mainMenuSubLevels ul.level4").css('display', 'none');
        });
    </script>
</asp:Content>
<asp:Content ID="LeftArea" ContentPlaceHolderID="LeftArea" runat="server">
    <ht:LeftMenuLargeDocuments runat="server" ID="LeftMenuLargeDocuments" />
</asp:Content>
<asp:Content ID="CenterArea" ContentPlaceHolderID="CenterArea" runat="server">
   
    <h1>
        <EPiServer:Property runat="server" PropertyName="PageName" />
    </h1>
    <p class="date"><%= Date %></p>
    <div class="pageUtilities">
     <ht:GeneratePdf runat="server" ID="GeneratePdf"/>
     <p class="email"><a href="http://www.addthis.com/bookmark.php" class="addthis_button"><img src="<%=ResolveUrl("~/Templates/Avenir/images/iconShare.gif")%>" width="16" height="14" alt="" /> Del</a></p>
     </div>
    <div class="large-document-body">
        <EPiServer:Property runat="server" PropertyName="MainBody" />
        <asp:PlaceHolder runat="server" ID="phDocumentTableOfContents">
            <ht:MenuOnRootChapter runat="server" ID="MenuOnRootChapter"/>
        </asp:PlaceHolder>
        <asp:PlaceHolder runat="server" ID="phContentOfBelowDocs" Visible="False">
            <asp:Repeater runat="server" ID="rptBelowDocs">
                <ItemTemplate>
                    <h3><%#(Container.DataItem as PageData).PageName %></h3>
                    <hr/>
                    <%#PropertyHelper.GetPropertyValue<string>(LargeDocumentsPropertyMappings.MainBody, Container.DataItem as PageData) %>
                </ItemTemplate>
            </asp:Repeater>
        </asp:PlaceHolder>
    </div>
    <div style="clear: both"></div>
</asp:Content>
<asp:Content ID="RightArea" ContentPlaceHolderID="RightArea" runat="server">
</asp:Content>
