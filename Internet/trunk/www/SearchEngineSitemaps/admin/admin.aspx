<%@ Page Language="C#" CodeBehind="admin.aspx.cs" AutoEventWireup="false" Inherits="SearchEngineSitemaps.admin.admin" %>

<%@ Register TagPrefix="EPiUIWebControls" Namespace="EPiServer.UI.WebControls" Assembly="EPiServer.UI" %>
<asp:content id="headcontent" contentplaceholderid="HeaderContentRegion" runat="server">
    <style type="text/css">
        ul
        {
            padding-left: 30px;
        }
        ul li
        {
            list-style-type: decimal;
        }
    </style>
</asp:content>
<asp:content id="full" contentplaceholderid="FullRegion" runat="server">
<div class="epi-contentContainer epi-padding">
    <h1><EPiServer:Translate runat="server" Text="/admin/editpagetypefield/typesearchenginesitemaps.propertysearchenginesitemaps" /></h1>
 <EPiUIWebControls:TabStrip runat="server" id="ActionTab" autopostback="False" targetid="TabView">
        <EPiUIWebControls:Tab Text="Register" runat="server" ID="Tab1"
            sticky="True" />
        <EPiUIWebControls:Tab Text="Settings" runat="server" ID="Tab2"
            sticky="True" />
    </EPiUIWebControls:TabStrip>
<asp:panel id="TabView" runat="server">
				
				<asp:Panel ID="Register" Runat="server">
					<p class="EP-systemInfo">
						<EPiServer:Translate Text="#reginfo" runat="server" /></p>
					<br />
					<p class="EP-systemInfo">
							<%# getParts() %>
					</p>
				
				</asp:Panel>
				<asp:Panel ID="Settings" Runat="server">
					<p class="EP-systemInfo">
						<table border="0">
						<tr>
							<td width="100"><EPiServer:Translate Text="#cacheinterval" runat="server" /></td>
							<td width="460">
								<asp:DropDownList Width="120" ID="cacheInterval" Runat="server" EnableViewState="True" />
								<asp:Button ID="resetCache" Runat="server" Translate="#resetcache" />
							</td>
						</tr>
						</table>
						
						<asp:Button ID="save" Runat="server" Translate="#save" />
					</p>
				</asp:Panel>
			</asp:panel>
</div>
</asp:content>
