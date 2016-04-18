<%@ Control Language="c#" AutoEventWireup="false" Codebehind="FullWidthFramework.ascx.cs" Inherits="development.Frameworks.FullWidthFramework" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="Header"		Src="~/templates/Units/Header.ascx"%>
<%@ Register TagPrefix="development" TagName="Listing"		Src="~/templates/Units/listing.ascx"%>
<%@ Register TagPrefix="development" TagName="LoginStatus"	Src="~/templates/Units/LoginStatus.ascx"%>
<%@ Register TagPrefix="development" TagName="Menu"			Src="~/templates/Units/Menu.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"		Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="PageHeader"	Src="~/templates/Units/PageHeader.ascx"%>
<%@ Register TagPrefix="development" TagName="Quicksearch"	Src="~/templates/Units/QuickSearch.ascx"%>
<%@ Register TagPrefix="development" TagName="RightListing" Src="~/templates/Units/RightListing.ascx"%>
<%@ Register TagPrefix="development" TagName="SiteFooter"	Src="~/templates/Units/SiteFooter.ascx"%>
<html>
	<head>
		<development:header ID="Header1" runat="server"></development:header>
	</head>
	<body bgcolor="#FFFFFF" text="#000000" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
		<form runat="server" id="Default">
			<table width="754" border="0" cellspacing="0" cellpadding="0" align="center" XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
				<tr>
					<td>
						<a href='<%#EPiServer.Global.EPConfig.RootDir%>'><img src="~/images/header.gif" runat="server" border="0" ID="Img5"/></a>
					</td>
				</tr>
				<tr>
					<td>
						<EPiServer:Region ID="fullRegion" runat="server">
						<table width="748" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" class="BrandHead" width="150">
									<development:Menu id="menu" runat="server" />
									<br />
									<development:quicksearch ID="QuickSearch" runat="server"></development:quicksearch>
									<table width="150" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td bgcolor="#CCCCCC" height="1"><img src="~/images/os.gif" width="1" height="1" runat="server" ID="Img2"/></td>
										</tr>
									</table>
								</td>
								<td bgcolor="#cccccc" width="1" valign="top">
									<img src="~/images/os.gif" width="1" height="1" runat="server" ID="Img12"/>
								</td>
								<td>
									<img src="~/images/os.gif" width="10" height="1" runat="server" ID="Img13"/>
								</td>
								<td valign="top" align="left" width="427">
									<EPiServer:Region ID="mainRegion" runat="server">
										<development:PageHeader id=pageheader runat="server" />
										<development:PageBody id=pagebody runat="server" /><br />
										<EPiServer:Region id=addRegion runat="server"></EPiServer:Region>
										<development:listing ID="Listing" runat="server"></development:listing>
									</EPiServer:Region>
								</td>
							</tr>							
						</table>
						</EPiServer:Region>
					</td>
				</tr>
				<tr>
					<td colspan="20" bgcolor="#CCCCCC">
						<development:SiteFooter id="sitefooter" runat="server" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>