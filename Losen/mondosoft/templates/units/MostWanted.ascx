<%@ Control Language="c#" AutoEventWireup="false" CodeBehind="MostWanted.ascx.cs" Inherits="Mondosoft.EPiServerIntegration.Templates.Units.MostWanted" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>

<div style="margin-bottom:10px;margin-top:10px;">
<img style="float:left; margin-right:5px;" src="/mondosoft/images/logo.gif" />
<div style="padding:0px;">
<episerver:translate Text="/mondosoft/mostwanted/text" runat="server"></episerver:Translate>
</div>
<hr />
<style>
.page
{
margin-bottom:5px;
}
</style>
<asp:repeater id="LinkList" runat="server">
	<ItemTemplate>
		<div class="page">
			<a href="<%#DataBinder.Eval(Container.DataItem, "Url")%>" title='<%#DataBinder.Eval(Container.DataItem, "Url")%>'><%#DataBinder.Eval(Container.DataItem, "EPiServerTitle")=="" ? DataBinder.Eval(Container.DataItem, "Url") : DataBinder.Eval(Container.DataItem, "EPiServerTitle")%></a>
			(<%#DataBinder.Eval(Container.DataItem, "Count")%>)
		</div>
	</ItemTemplate>
</asp:repeater>
</div>