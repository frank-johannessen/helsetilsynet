<%@ Import Namespace="EPiServer.Common.Globalization" %>
<%@ Control Language="c#" AutoEventWireup="True" CodeBehind="Expert.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Expert" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ComponentArt" Namespace="EPiServer.Common.ComponentArt.Web.UI" Assembly="EPiServer.Common.ComponentArt.Web.UI" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="../../PagingControl.ascx" %>
<%@ Register TagPrefix="sc" TagName="SaveResultPanel" Src="../../SaveResultPanel.ascx" %>

<script language="javascript" src="Administration.js"></script>

<link rel="stylesheet" type="text/css" href="styles/tabstrip.css" />
<link rel="stylesheet" type="text/css" href="Administration.css" />
<sc:SaveResultPanel ID="saveResultPanel" runat="server" />
<h1><%= GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.Web.Administration.Menu.expert")%></h1>
<div id="expert">
    <div id="tabStrip">
        <ComponentArt:TabStrip ID="tabStripExpert" CssClass="topGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageExpert" runat="server">
            <ItemLooks>
                <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
            </ItemLooks>
            <Tabs>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabExperts">
                </ComponentArt:TabStripTab>
                <ComponentArt:TabStripTab runat="server" ID="tabStripTabQuestions">
                </ComponentArt:TabStripTab>
            </Tabs>
        </ComponentArt:TabStrip>
        <ComponentArt:MultiPage ID="multiPageExpert" CssClass="multiPage" runat="server">
            <ComponentArt:PageView runat="server" ID="pageViewExperts">
                <ComponentArt:TabStrip ID="tabStripExperts" CssClass="subGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageExperts" runat="server">
                    <ItemLooks>
                        <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                        <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
                    </ItemLooks>
                    <Tabs>
                        <ComponentArt:TabStripTab runat="server" Value="applied" ID="tabStripTabAppliedExperts">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab runat="server" Value="active" ID="tabStripTabActiveExperts">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab runat="server" Value="inactive" ID="tabStripTabInactiveExperts">
                        </ComponentArt:TabStripTab>
                    </Tabs>
                </ComponentArt:TabStrip>
                <ComponentArt:MultiPage ID="multiPageExperts" CssClass="multiPage" runat="server">
                </ComponentArt:MultiPage>
            </ComponentArt:PageView>
            <ComponentArt:PageView runat="server" ID="pageViewQuestions">
                <ComponentArt:TabStrip ID="tabStripQuestions" CssClass="subGroup" DefaultItemLookId="DefaultTabLook" DefaultSelectedItemLookId="SelectedTabLook" DefaultDisabledItemLookId="DisabledTabLook" DefaultGroupTabSpacing="0" ImagesBaseUrl="~/EPiServerCommunity/images/tabstrip" MultiPageId="multiPageQuestions" runat="server">
                    <ItemLooks>
                        <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="defaultTab" HoverCssClass="defaultTabHover" />
                        <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="selectedTab"  />
                    </ItemLooks>
                    <Tabs>
                        <ComponentArt:TabStripTab runat="server" Value="new" ID="tabStripTabNewQuestions">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab runat="server" Value="assigned" ID="tabStripTabAssignedQuestions">
                        </ComponentArt:TabStripTab>
                        <ComponentArt:TabStripTab runat="server" Value="published" ID="tabStripTabPublishedQuestions">
                        </ComponentArt:TabStripTab>
                    </Tabs>
                </ComponentArt:TabStrip>
                <ComponentArt:MultiPage ID="multiPageQuestions" CssClass="multiPage" runat="server">
                </ComponentArt:MultiPage>
            </ComponentArt:PageView>
        </ComponentArt:MultiPage>
    </div>
</div>
