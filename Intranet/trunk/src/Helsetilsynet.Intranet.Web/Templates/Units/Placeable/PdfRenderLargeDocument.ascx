<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PdfRenderLargeDocument.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.PdfRenderLargeDocument" %>


    <h1 class="frontpage-header"><%= RequestedLargeDocument.PageName%></h1>
    <div class="frontpage-content">
        <p><%= RequestedLargeDocument.MainIntro%></p>    
    </div>
    
    
        <EPiServer:PageTree PageLink="<%# RequestedLargeDocument.PageLink %>" ID="ptLargeDocumentToc" runat="server" ExpandAll="True" NumberOfLevels="10" ShowRootPage="False" >
            <HeaderTemplate>
                <div class="largeDocumentToc" style="page-break-before:always; page-break-after:always">
                <h2>Innholdsfortegnelse</h2>
            </HeaderTemplate>
            <IndentTemplate>
                <ul class="table-of-contents">
            </IndentTemplate>
            <ItemTemplate>
                <%-- NOTE: The A tag below should NOT have a HREF attribute!!! --%>
                <li  class="<%# GetLevel(Container.DataItem) %>"><a id='<%# string.Format("TOCEntry_{0}_ID", ++ItemCounter) %>'><span class="chapter-number"><%# GetLargeDocumentChapterNumber(Container.DataItem) %></span> <%# GetLargeDocumentChapterPageNameWithoutChapterNumber(Container.DataItem) %></a></li>
            </ItemTemplate>
            <UnindentTemplate>
                </ul>
            </UnindentTemplate>    
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </EPiServer:PageTree> 
    <EPiServer:PageTree PageLink="<%# RequestedLargeDocument.PageLink %>" ID="ptLargeDocumentPdf" runat="server" ExpandAll="True" NumberOfLevels="10" ShowRootPage="False" >
        <HeaderTemplate><div class="pdf-body" style="page-break-inside : avoid"></HeaderTemplate>
        <ItemTemplate>
                
                <h2 id='<%# string.Format("TOCEntry_{0}_Target_ID", ++TargetCounter) %>' class="pdf-heading <%# GetLevel(Container.DataItem) %>">
                    <%# GetLargeDocumentChapterNumber(Container.DataItem) %> <%# GetLargeDocumentChapterPageNameWithoutChapterNumber(Container.DataItem) %>
                </h2>
                
                <p class="pdf-text level<%# GetLargeDocumentChapterLevel(Container.DataItem) %>" style="page-break-inside : avoid">
                    <%# ((MakingWaves.Helsetilsynet.Intranet.Web.Model.LargeDocumentChapter)Container.DataItem).MainBody %>
                </p>

                
        </ItemTemplate>
        <FooterTemplate></div></FooterTemplate>
    </EPiServer:PageTree> 
