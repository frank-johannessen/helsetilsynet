<%@ Register TagPrefix="development" Namespace="development" Assembly="episerversample" %>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Page language="c#" Codebehind="SiteMap.aspx.cs" AutoEventWireup="false" Inherits="development.SiteMap" %>
<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content id="ContentTop" runat="server" Region="RegionTop">
		<development:SectionHead id="SectionHead" runat="server"></development:SectionHead>
	</EPiServer:Content>
	<EPiServer:Content id="FormContent" runat="server" Region="RegionBody">
		<TABLE cellSpacing="0" cellPadding="0" width="600" border="0">
			<TR>
				<TD colSpan="5">&nbsp;</TD>
			</TR>
			<TR>
				<TD colSpan="5">
					<!-- Print_start -->
					<development:sitemap id=Sitemap1 runat="server" rootpagelink="<%#((EPiServer.PageBase)Page).Configuration.StartPage%>">
					</development:sitemap>
					<!-- Print_end -->
				</TD>
					
			</TR>
		</TABLE>
	</EPiServer:Content>
</development:DefaultFramework>
