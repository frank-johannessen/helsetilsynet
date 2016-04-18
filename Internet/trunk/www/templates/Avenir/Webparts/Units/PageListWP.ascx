<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageListWP.ascx.cs" Inherits="Avenir.Templates.KB.Webparts.Units.PageListWP" %>


<h2><%=ListTitle%></h2>

<EPiServer:PageList ID="lstPages" runat="server">
    <HeaderTemplate>       
            <ul class="newslist">        
    </HeaderTemplate>

    <ItemTemplate>
        <li>
          
            <%#GetFormattedDate(Container.CurrentPage)%>
             <h2><EPiServer:Property ID="Property1" PropertyName="PageLink" ToolTip="<%#Container.CurrentPage.PageName %>" runat="server" /></h2>
        </li>
    </ItemTemplate>
    <FooterTemplate>
               <li id="Li1" visible="<%#!String.IsNullOrEmpty(SeeMoreText)%>" runat="server">
                <%#GetContainerLink()%>
               </li>
            </ul>

    </FooterTemplate>   
</EPiServer:PageList>
