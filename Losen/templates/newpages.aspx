<%@ Page language="c#" Codebehind="newpages.aspx.cs" AutoEventWireup="false" Inherits="development.templates.newpages" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="development" TagName="SectionHeadPrint"	Src="~/templates/Units/Sec_HeadPrint.ascx"%>
<%@ Register TagPrefix="development" TagName="Links"			Src="~/templates/Units/Links.ascx"%>
<%@ Register TagPrefix="development" TagName="ArticleList"		Src="~/templates/Units/ArticleList.ascx"%>

<development:DefaultFramework ID="defaultframework" runat="server">
	<EPiServer:Content ID="ContentTop" Region="RegionTop" runat="server">
		<development:SectionHeadPrint id="SectionHeadPrint" runat="server"></development:SectionHeadPrint>
	</EPiServer:Content>
	<EPiServer:Content ID="ContentLatestReport" Region="RegionCenter" runat="server" />
	<EPiServer:Content ID="contentBody" Region="RegionBody" runat="server">
		<style>body { background-image: url(/images/bg_list_dot.gif); }</style>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="article">
			<tr>
				<td class="body" valign="top">
					<!-- print_start -->
					<DIV class="subtitle"><%#CurrentPage.Property["HeadDocumentList"]%></DIV>
					<!-- print_end -->

					<development:PageBody id="PageBody" runat="server"></development:PageBody>					
					
					<!-- print_start -->
					<asp:Repeater id=Repeater1 runat="server" datasource="<%#aKeywordList%>">
						<headertemplate>
							<%#resetCount()%>
						</headertemplate>
						<itemtemplate>
							<asp:placeholder id="catlink" runat="server" visible=<%#FindPagesWithKeywordFromMasterCollection( ((KeyWordObject)Container.DataItem).keyword,((KeyWordObject)Container.DataItem).keywordlist )%>>
								<DIV class="catlink">
									<a href="<%#CurrentPage.LinkURL + "#" + getCount(bkeywords)%>"><%#((KeyWordObject)Container.DataItem).keyword%></a><br>
								</div>
							</asp:placeholder>
						</itemtemplate>
					</asp:Repeater>
					
					<asp:Repeater id="Repeater2" runat="server" datasource="<%#aKeywordList%>">
						<headertemplate>
							<%#resetCount()%>
						</headertemplate>
						<itemtemplate>			
							<%#setHeader(((KeyWordObject)Container.DataItem).keyword)%>	
							<episerver:pagelist runat="server" maxcount=<%#CurrentPage["ListingGroupMaxCount"]!=null?CurrentPage["ListingGroupMaxCount"]:10%> datasource="<%#GetPagesWithKeyword(((KeyWordObject)Container.DataItem).keyword,((KeyWordObject)Container.DataItem).keywordlist)%>">
								<headertemplate>
									<DIV class="cattitle">
										<a name="<%#getCount(true)%>"><%#keywordheader%></a><br>
									</div>									
								</headertemplate>
								<itemtemplate>
									<DIV class="link">
										<a href="<%#Container.CurrentPage.LinkURL%>"><%#Container.CurrentPage["PageName"]%></a>
										(<%#((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yy")%>)
									</DIV>							
									<asp:placeholder runat="server" visible=<%#CurrentPage["ListingShowDescription"]!=null?true:false%>>
										<episerver:property PropertyName="MetaDescription" runat="server" ID="Property1" NAME="Property1"/><br>
									</asp:placeholder>
									<br>
								</itemtemplate>
							</episerver:pagelist>
						</itemtemplate>
					</asp:Repeater>										
																		
					<episerver:pagelist runat="server" id="output">
						<itemtemplate>
							<DIV class="link">
								<a href="<%#Container.CurrentPage.LinkURL%>"><%#Container.CurrentPage["PageName"]%></a>
								(<%#((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yy")%>)
							</DIV>							
							<asp:placeholder runat="server" visible=<%#CurrentPage["ListingShowDescription"]!=null?true:false%>>
								<episerver:property PropertyName="MetaDescription" runat="server"/><br>
							</asp:placeholder>
							<br>
						</itemtemplate>
					</episerver:pagelist>	
														
					<!-- print_end -->
				</td>
				<td width="1"><IMG alt="" src="/images/pxl.gif" width="1" height="168"></td>
				<td width="199" height="168" valign="top">
					<development:Links runat="server" id="Links"></development:Links>
				</td>
			</tr>
		</table>
	</EPiServer:Content>
</development:DefaultFramework>
