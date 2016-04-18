<%@ Control Language="c#" AutoEventWireup="false" Codebehind="LetterHead.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.LetterHead" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<table style="width: 100%;">
    <tr>
        <td id="LetterFrom" runat="server">
            <b><episerver:property PropertyName="LangLetterFrom" runat="server" ID="Property1" />:</b>
        </td>
        <td>
            <episerver:property PropertyName="LetterFrom" runat="server" ID="Property7" />
        </td>
    </tr>
    <tr id="LetterTo" runat="server">
        <td>
            <b><episerver:property PropertyName="LangLetterTo" runat="server" ID="Property3" />: </b>
        </td>
        <td>
            <episerver:property PropertyName="LetterTo" runat="server" ID="Property8" />
        </td>
    </tr>
    <tr id="LetterDate" runat="server">
        <td>
            <b><episerver:property PropertyName="LangLetterDate" runat="server" ID="Property2" />:</b>
        </td>
        <td>
            <span><%=DateOfLetter()%></span>
        </td>
    </tr>
    <tr id="LetterOure" runat="server">
        <td>
            <b><episerver:property PropertyName="LangLetterOure" runat="server" ID="Property5" />: </b>
        </td>
        <td>
            <episerver:property PropertyName="LetterOure" runat="server" ID="Property10" />
        </td>
    </tr>
    <tr id="LetterYours" runat="server">
        <td>
            <b><episerver:property PropertyName="LangLetterYours" runat="server" ID="Property6" />: </b>
        </td>
        <td>
            <episerver:property PropertyName="LetterYours" runat="server" ID="Property11" />
        </td>
    </tr>
</table>
