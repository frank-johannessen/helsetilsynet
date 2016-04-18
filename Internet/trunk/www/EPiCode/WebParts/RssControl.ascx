<%@ Control Language="C#" AutoEventWireup="true" Codebehind="RssControl.ascx.cs" Inherits="EPiCode.WebParts.RssControl" %>
<%@ Register TagPrefix="WebControls" Namespace="EPiServer.WebParts.WebControls" Assembly="EPiServer" %>
<WebControls:RssControl runat="server" ID="RssControl1" ItemCount="5" EnableViewState="false">
    <ChannelTemplate>
        <div>
            <img runat="server" src='<%# Container.Image %>' visible='<%# Container.Image != null %>' />
            <h2><%# ListTitle.Value as string %></h2>
        </div>
    </ChannelTemplate>
    <ItemTemplate>
            <div><h3><a href='<%# Container.Link %>'><%# Container.Title %></a></h3><div><%# Container.Description %></div></div>
            <hr />
    </ItemTemplate>
</WebControls:RssControl>

