<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenIDConfirm.aspx.cs" Inherits="EPiServer.Community.Web.Administration.OpenIDConfirm" %>
<%@ Register Src="~/EPiServerCommunity/Public/OpenID/ProfileFields.ascx" TagName="ProfileFields" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p><asp:Label ID="siteRequestLabel" runat="server" Text="A site has asked to authenticate that you own the identifier below." />
		    You should only do this if you wish to log in to the site given by the Realm.</p>
	    <p>This site <asp:Label ID="relyingPartyVerificationResultLabel" runat="server" Font-Bold="True"
		    Text="failed" /> verification. </p>
	    <table>
		    <tr>
			    <td>Identifier: </td>
			    <td><asp:Label runat="server" ID='identityUrlLabel' /> </td>
		    </tr>
		    <tr>
			    <td>Realm: </td>
			    <td><asp:Label runat="server" ID='realmLabel' /> </td>
		    </tr>
	    </table>
	    <p>Allow this to proceed? </p>
	    <uc1:ProfileFields ID="profileFields" runat="server" Visible="false" />
	    <asp:Button ID="yes_button" OnClick="Yes_Click" Text="  yes  " runat="Server" />
	    <asp:Button ID="no_button" OnClick="No_Click" Text="  no  " runat="Server" />
    </div>
    </form>
</body>
</html>
