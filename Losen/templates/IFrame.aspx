<%@ Page language="c#" Codebehind="IFrame.aspx.cs" AutoEventWireup="false" Inherits="development.Templates.IFrame" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<development:DefaultFramework ID="DefaultMode" runat="server">
	<episerver:content region="RegionBody" runat="server">
			<iframe frameborder="0" scrolling="no" style="border: 0px; padding-left: 3px; margin: 0px;" width="<%#CurrentPage["Width"]%>" height="<%#CurrentPage["Height"]%>" src="<%#MakeSSLCompatibleURL(CurrentPage["FrameURL"].ToString())%>" noscroll marginwidth="0" marginheight="0"></iframe>				
	</episerver:content>
</development:DefaultFramework>

