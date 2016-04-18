<%@ Register TagPrefix="development" TagName="LoginStatus" Src="LoginStatus.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="RightListing.ascx.cs" Inherits="development.UserControls.RightListing" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<episerver:newslist id="NewsList" PageLinkProperty="RightListingContainer" runat="server">
	<HEADERTEMPLATE>
		<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ededf3" border="0">
			<TBODY>
				<TR>
					<TD width="15" height="20"><IMG id="Img5" alt="" src="~/images/os.gif" width="15" runat="server"></TD>
					<TD class="NewsListingText"><SPAN class="ListHeads"><%#Container.CurrentPage.PageName.ToUpper()%></SPAN></TD>
				</TR>
	</HEADERTEMPLATE>
	<NEWSTEMPLATE>
		<TR>
			<TD width="15" height="20"><IMG id="Img6" src="~/images/os.gif" alt="" width="15" runat="server"></TD>
			<TD class="NewsListingText">
				<episerver:property id="Property2" runat="server" NAME="Property1" PropertyName="PageLink"></episerver:property></TD>
		</TR>
	</NEWSTEMPLATE>
	<FOOTERTEMPLATE></TBODY></TABLE></FOOTERTEMPLATE>
</episerver:newslist>
