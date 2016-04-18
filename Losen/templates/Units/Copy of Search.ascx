<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Search.ascx.cs" Inherits="development.templates.Units.Search" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="development" TagName="SectionHead"		Src="~/templates/Units/Sec_Head.ascx"%>
<%@ Register TagPrefix="development" TagName="LeftMenu"		Src="~/templates/Units/LeftMenu.ascx"%>
<%@ Register TagPrefix="development" TagName="Quicksearch"	Src="~/templates/Units/QuickSearch.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<tr valign="top" class="header">
	<td width="180">
		<!-- Logo -->
		<table width="180" height="168" border="0" cellspacing="0" cellpadding="0" class="ident">
			<tr>
				<td width="180" valign="top">
					<a href="<%=EPiServer.Global.EPConfig.RootDir%>"><img src="/images/helsetilsynet-logo.gif" alt="" width="180" height="50" border="0"></a><br>
					<DIV class="slogan"><episerver:property PropertyName="Logotext" runat="server" ID="Property4" /><BR>
					</DIV>
				</td>
			</tr>
			<tr>
				<td valign="bottom"><br>
				</td>
			</tr>
		</table>
	</td>
	<td width="400" class="article">
		<!-- Page content top -->
		<table width="100%" height="168" border="0" cellspacing="0" cellpadding="0" class="search"
			XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
			<tr>
				<td class="search" valign="top">
					<TABLE border="0" cellspacing="0" cellpadding="0">
						<TR>
							<TD valign="top">
								<asp:TextBox ID="SearchQuery" TabIndex="1" Runat="server" Text="" cssClass="input" OnTextChanged="SearchQuery_TextChanged" />
								<asp:TextBox ID="Query2" TabIndex="1" Runat="server" Text="" Visible="False" />
							</TD>
							<TD valign="top">
								<asp:ImageButton cssClass="submit" AlternateText="Søk" ImageUrl="" Runat="server" ID="SearchButton"
									OnClick="SearchButton_Click" />
							</TD>
						</TR>
						<TR>
							<TD valign="top">
								<asp:dropdownlist id="DropDownList1" cssClass="section" runat="server">
									<asp:ListItem text="" Value="" />
								</asp:dropdownlist>
								<!--
								<asp:dropdownlist id="KeyWordDropdownlist" cssClass="section" runat="server">
									<asp:ListItem text="Søk basert på emneord" Value="0" />
								</asp:dropdownlist>
								-->
								<episerver:pagelist id="Listing1" runat="server" PageLink='<%# EPiServer.Global.EPConfig.StartPage %>'>
									<ITEMTEMPLATE>
										<%# MakeSectionDropdown((string)Container.CurrentPage.VisibleInMenu.ToString(), (string)Container.CurrentPage.PageName.ToString(), Container.CurrentPage.PageLink)%>
									</ITEMTEMPLATE>
								</episerver:pagelist><!-- , Container.CurrentPage.VisibleInMenu   Lage ny funksjon -->
							</TD>
							<TD valign="top"></TD>
						</TR>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td valign="bottom" class="options">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr valign="top">
							<td colspan="2" class="subtitle"><episerver:property PropertyName="SearchType" runat="server" ID="Property3" /><br>
							</td>
							<td colspan="2" class="subtitle"><episerver:property PropertyName="SearchSort" runat="server" ID="Property1" /><br>
							</td>
						</tr>
						<tr valign="top">
							<td width="20"><asp:CheckBox onCheckedChanged="Tilsyn_Checked" Runat="server" ID="Tilsyn" /></td>
							<td width="175" class="option"><episerver:property PropertyName="Tilsynsrapport" runat="server" ID="Property2" /></td>
							<td width="20"><asp:CheckBox onCheckedChanged="title_Checked" Runat="server" ID="title" /></td>
							<td class="option"><episerver:property PropertyName="SearchDisplayTitle" runat="server" ID="Property5" /></td>
						</tr>
						<tr valign="top">
							<td><asp:CheckBox onCheckedChanged="News_Checked" Runat="server" ID="News" /></td>
							<td class="option"><episerver:property PropertyName="SearchNews" runat="server" ID="Property6" /></td>
							<td><asp:CheckBox onCheckedChanged="SortDate_Checked" Runat="server" ID="SortDate" /></td>
							<td class="option"><episerver:property PropertyName="SearchSortOnHit" runat="server" ID="Property7" /></td>
						</tr>
						<tr valign="top">
							<td colspan="4" class="subtitle">
								&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
	<td width="1" class="vr"><IMG src="/images/pxl.gif" width="1" alt="" height="168"></td>
	<td width="199" height="168">
		<!-- Simple search -->
		<development:Quicksearch id="search" runat="server" />
	</td>
</tr>
<tr valign="top">
	<td>
		<!-- Left menu -->
		<development:LeftMenu id="LeftMenu" runat="server" />
	</td>
	<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="results">
			<tr>
				<td XmlNs:EPiServer="http://schemas.episerver.com/WebControls">
					<div id="SearchHelp" style="DISPLAY:none" runat="server"></div>
					<div id="Message" style="DISPLAY:none" runat="server"></div>

					<!-- Mid column help text -->
					<table border="0" cellpadding="0" cellspacing="0" runat="server" class="content" id="HelpTextTable">
						<tr>
							<td valign="bottom">
								<div style="margin: -16px 15px 0px 15px;"><%# ((EPiServer.PageBase)Page).CurrentPage["SearchHelpMidColumn"] %></div>
							</td>
						</tr>
					</table>
					
					
					<EPiServer:FileTree runat="server" ID="Filetree1" rootpath="/upload/" expansionmode="Manual" filenamepattern="*.*">
						<DirectoryTemplate>
							<%#GetDirName(Container.Name)%>
						</DirectoryTemplate>
						<FileTemplate></FileTemplate>
					</EPiServer:FileTree>
					
					<!-- Note: PageLink is the default start page for search, used if MainContainer is empty -->
					<!-- print_start -->

					<episerver:PageSearch  
								Runat="server" 
								EnableViewState="False"
								ID="SearchResults"
								SearchQuery='<%# Query2.Text %>'
								SearchFiles='True'
								OnlyWholeWords='False'
								MaxCount="100"
								MainScope='<%#GetMainScope()%>'
								MainCatalog='<%# ((EPiServer.PageBase)Page).CurrentPage["MainCatalog"] %>'>
								
						<HeaderTemplate>
							<table border="0" cellpadding="0" cellspacing="0">
								<TBODY>
									<tr>
										<td valign="top" class="title">
											<%#HitString()%>
										</td>
									</tr>
								<tr>
										<td valign="bottom" class="content">
						</HeaderTemplate>
						<ItemTemplate>
							<%#SortDate.Checked?AddToPageList(Container.CurrentPage):""%>
							<asp:PlaceHolder Runat="server" Visible="<%#!SortDate.Checked%>">
								<DIV class="link">
									<%#Container.CurrentPage.PageTypeID == 94 ? Regex.Replace(Container.CurrentPage.Property["Link"].Value.ToString(),@"</*p\s*>","",RegexOptions.IgnoreCase) : "<a href=\"" + Container.CurrentPage.LinkURL + "\">" + Container.CurrentPage["PageName"]+ "</a>"%>
									&nbsp;(<%#((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yyyy")%>)<br>
									<%#title.Checked ||Container.CurrentPage.PageTypeID == 94 ? "" : Container.CurrentPage["MetaDescription"] %> 
									
									<%#Container.CurrentPage.PageTypeID == 94 && Container.CurrentPage["DocType"] != null ? "(" + Container.CurrentPage["DocType"] + ")" : ""%>
								</DIV>
							</asp:PlaceHolder>
						</ItemTemplate>
						<FileTemplate>
							<%#SortDate.Checked?AddToPageList(Container.CurrentPage):""%>
							<asp:PlaceHolder Runat="server" Visible="<%#!SortDate.Checked%>" ID="Placeholder2">
								<DIV class="link">
									<IMG src='<%#Container.CurrentPage["IconPath"]%>' alt=""> <A target=_blank href='<%#Container.CurrentPage["PageLinkURL"]%>'>
										<%#StrLength(Container.CurrentPage["PageName"].ToString())%>
									</A>&nbsp;(<%#FileDate(Container.CurrentPage["PageChanged"].ToString())%>)
								</DIV>
							</asp:PlaceHolder>
						</FileTemplate>
						<FooterTemplate>
				</td>
			</tr>
		</table>
		</FOOTERTEMPLATE>
		<NoMatchesTemplate>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" class="title"><%#SearchHitResult()%></td>
				</tr>
			</table>
		</NoMatchesTemplate></episerver:PageSearch> 
		
		<!-- SPESIELL BEHANDLING OG UTLISTING VED SORTERING PÅ DATO -->
		<asp:PlaceHolder Runat="server" Visible=<%#SortDate.Checked==true%> ID="Placeholder1">
			<hr>
			<table border="0" cellpadding="0" cellspacing="0">
				<TBODY>
					<tr>
						<td valign="top" class="content">
							<episerver:pagelist runat="server" maxcount="100" datasource="<%#getSortedCollection()%>" ID="Pagelist1">
								<itemtemplate>
									<DIV class="link">
										<asp:placeholder Runat="server" Visible=<%#Container.CurrentPage["PageStartPublish"]!=null?true:false%>>
											<%#Container.CurrentPage.PageTypeID == 94 ? Regex.Replace(Container.CurrentPage.Property["Link"].Value.ToString(),@"</*p\s*>","",RegexOptions.IgnoreCase) : "<a href=\"" + Container.CurrentPage.LinkURL + "\">" + Container.CurrentPage["PageName"]+ "</a>"%>
											&nbsp;(<%#Container.CurrentPage.Property["PageStartPublish"]!=null?((DateTime) Container.CurrentPage.Property["PageStartPublish"].Value).ToString("dd.MM.yyyy"):""%>)<br>
											<%#title.Checked ||Container.CurrentPage.PageTypeID == 94 ? "" : Container.CurrentPage["MetaDescription"] %> 
											<%#Container.CurrentPage.PageTypeID == 94 && Container.CurrentPage["DocType"] != null ? "(" + Container.CurrentPage["DocType"] + ")" : ""%>
										</asp:placeholder>
										<asp:placeholder Runat="server" Visible=<%#Container.CurrentPage["PageStartPublish"]==null?true:false%>>
											<IMG src='<%#Container.CurrentPage["IconPath"]%>' alt=""> <A target=_blank href='<%#Container.CurrentPage["PageLinkURL"]%>'>
												<%#StrLength(Container.CurrentPage["PageName"].ToString())%>
											</A>&nbsp;(<%#FileDate(Container.CurrentPage["PageChanged"].ToString())%>)
										</asp:placeholder>
									</DIV>
								</itemtemplate>
							</episerver:pagelist>
						</td>
					</tr>
				</tbody>
			</table>
		</asp:PlaceHolder>		
		
		<!-- print_end -->
	</td>
</tr>
</TBODY></TABLE></TD>
<td width="1" class="vr"><IMG src="/images/pxl.gif" alt="" width="1" height="168"></td>
<td width="199" class="article" valign="top">
	<IMG src="/images/pxl.gif" width="1" alt="" height="3" border="0"><br>
	<div class="body"><span class="title"><%# ((EPiServer.PageBase)Page).CurrentPage["SearchHelpTitle"] %></span>
	</div>
	<div class="body"><%# ((EPiServer.PageBase)Page).CurrentPage["SearchHelp"] %></div>
</td>
</TR>
