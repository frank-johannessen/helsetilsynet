<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ActivityFeed.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.ActivityFeed" %>
<ow:ActivityFeed ID="ActivityFeed1" runat="server" PageSize="3">
    <Template>
        <ow:UpdatesPlaceHolder runat="server" />
        <button data-bind="command: loadNextPage">Vis mer...</button>
    </Template>
    <UpdateTemplate runat="server">
        <li>
            <ow:UpdateContentPlaceHolder runat="server"/>
        </li>
    </UpdateTemplate>
    <UpdateContentTemplates>
        <ow:UpdateContentTemplate runat="server" ContentType="articleUpdate">
            <a data-bind="attr:{href: content().url}" class="doc-link">
                <img data-bind="attr:{src: content().thumbnailUrl, alt: content().title}" />
                <span class="h3"><strong data-bind="text: content().updateType"></strong> ARTIKKEL</span>
                <span class="p" data-bind="text: content().title"></span>
                <span class="p" data-bind="text: content().shortIntro"></span>
            </a>
        </ow:UpdateContentTemplate>
        
        <ow:UpdateContentTemplate runat="server" ContentType="documentUpdate">
            <a data-bind="attr:{href: content().url}" class="doc-link">
                <img src="/Templates/styles/images/communitydefaults/stort_dokument_icon.jpg" alt="TEST" /> 
                <span class="h3"><strong data-bind="text: content().updateType"></strong> DOKUMENT</span>
                <span class="p" data-bind="text: content().title"></span>
            </a>
        </ow:UpdateContentTemplate>

        <ow:UpdateContentTemplate  runat="server" ContentType="blogEntryUpdate">
            <a data-bind="attr:{href: content().url}" class="doc-link">
                <img data-bind="attr:{src: content().icon, alt: content().title}" /> 
                <span class="h3" data-bind="text: content().author"></span>
                <span class="p" data-bind="text: content().title"></span>
                <span class="p" data-bind="html: content().summary"></span>
            </a>
        </ow:UpdateContentTemplate>

        <ow:UpdateContentTemplate runat="server" ContentType="calendarUpdate">
            <a data-bind="attr:{href: content().link}" class="doc-link">
                <img data-bind="attr:{src: content().icon, alt: content().title}" />
                <span class="h3">NY KALENDERHENDELSE</span> 
                <span class="p" data-bind="text: content().title"></span>
                <span class="p">Startdato: <span data-bind="text: content().startTime"></span></span>
            </a>
        </ow:UpdateContentTemplate>

        <ow:UpdateContentTemplate runat="server" ContentType="clubUpdate">
            <a data-bind="attr:{href: content().url}" class="doc-link">
                <img data-bind="attr:{src: content().icon, alt: content().title}" />
                <span class="h3">NYTT PROSJEKTROM</span>
                <span class="p" data-bind="text: content().title"></span>
                <span class="p" data-bind="text: content().description"></span>
            </a>
        </ow:UpdateContentTemplate>

        <ow:UpdateContentTemplate runat="server" ContentType="pageCommentUpdate">
            <a data-bind="attr:{href: content().url}" class="doc-link">
                <img data-bind="attr:{src: content().icon, alt: content().title}" />
                <span class="h3" data-bind="text: content().author"></span>
                <span class="p">har kommentert på <span data-bind="text: content().title"></span></span>
                <span class="p" data-bind="text: content().commentSummary"></span>
            </a>
        </ow:UpdateContentTemplate>
    </UpdateContentTemplates>
</ow:ActivityFeed>
