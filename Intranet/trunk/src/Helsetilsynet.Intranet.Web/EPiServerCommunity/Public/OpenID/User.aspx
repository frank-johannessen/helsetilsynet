<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="EPiServer.Community.Web.Administration.Public.OpenID.User" %>
<%@ Register Assembly="DotNetOpenAuth" Namespace="DotNetOpenAuth.OpenId.Provider" TagPrefix="openid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <openid:IdentityEndpoint ID="IdentityEndpoint20" runat="server" ProviderEndpointUrl="~/EPiServerCommunity/Public/OpenID/Provider.ashx" 
        XrdsUrl="~/EPiServerCommunity/Public/OpenID/user_xrds.aspx" ProviderVersion="V20" 
		AutoNormalizeRequest="true" OnNormalizeUri="IdentityEndpoint20_NormalizeUri" />
	<!-- and for backward compatibility with OpenID 1.x RPs... -->
	<openid:IdentityEndpoint ID="IdentityEndpoint11" runat="server" ProviderEndpointUrl="~/EPiServerCommunity/Public/OpenID/Provider.ashx"
		ProviderVersion="V11" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        User Provider Page<br />
        This is the public OpenID user page
    </div>
    </form>
</body>
</html>
