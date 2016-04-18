<%@ Control Language="c#" AutoEventWireup="false" Codebehind="DocList.ascx.cs" Inherits="Avenir.Templates.Units.Placeable.DocList" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>

<episerver:newslist SortOrder="<%#GetSortOrder()%>"  id="NewsList" PageLinkProperty="DocList" MaxCount="<%#GetCount()%>" runat="server">
    <HeaderTemplate>
	
    </HeaderTemplate>
    <NewsTemplate>
    <br />
        <div class="link">
			    
            <div class="decoratedLink">
                <div class="text">
                    <%# Container.CurrentPage["Link"] != null ? Regex.Replace(Container.CurrentPage.Property["Link"].Value.ToString(),@"</*div\s*>","",RegexOptions.IgnoreCase) : ""%>&nbsp;<%#Container.CurrentPage["DocType"] != null ? "(" +  Container.CurrentPage["DocType"] + ")": ""%>
                </div>  
            </div>              
            <%#Container.CurrentPage["MainIntro"]%>
        </div>
    </NewsTemplate>
    <FooterTemplate>
	
    </FooterTemplate>
</episerver:newslist>
