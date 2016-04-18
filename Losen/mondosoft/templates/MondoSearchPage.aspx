<%@ Page language="c#" Codebehind="MondoSearchPage.aspx.cs" AutoEventWireup="false" Inherits="Mondosoft.EPiServerIntegration.Templates.MondoSearchPage" %>
<%@ Register TagPrefix="MondoSearch" Namespace="Mondosoft.MondoSearch" Assembly="MsmSearch,Version=1.0.0.2,Culture=neutral,PublicKeyToken=beb56c6686670998" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="development" TagName="DefaultFramework"	Src="~/templates/Frameworks/DefaultFramework.ascx"%>
<%@ Register TagPrefix="development" TagName="PageBody"			Src="~/templates/Units/PageBody.ascx"%>
<%@ Register TagPrefix="Mondosoft" Namespace="Mondosoft.EPiServerIntegration.WebControls" Assembly="Mondosoft.EPiServerIntegration" %>
<development:DefaultFramework ID="DefaultFramework" runat="server">		
	<EPiServer:Content Region="mainRegion" runat="server">
		<meta name="robots" content="noindex,nofollow"/><!--We need to exclude this page but can not reach the HEAD-section. that is why the meta-tag is in the BODY-section. -->
		<development:PageBody runat="server" />
		
		
		    <%-- Script used for alternatives --%>
    <% if(MondoSearch.Summary.Alternatives>0){ %>
    <SCRIPT LANGUAGE="JavaScript" type="text/Javascript">
      <!--
      function AltClck(mystring,re){
        origstr=document.getElementById('<%#Query.ClientID%>').value;
        origstr=origstr.replace(/ $/,"")+' ';
        if(origstr.search(re)==-1){
        origstr+=mystring+' ';
        } else {
        origstr=origstr.replace(re," ");
        }
        document.getElementById('<%#Query.ClientID%>').value=origstr;
      }
      //-->
    </SCRIPT>
    <% } %>
		      <%-- Search Engine declaration --%>
      <Mondosoft:Search id="MondoSearch" runat="Server"
							Navigation-CategoriesPerPage='<%#CurrentPage["CategoriesPerPage"] == null ? 5 : (int)CurrentPage["CategoriesPerPage"]%>'
							Navigation-ResultsPerCategory='<%#CurrentPage["ResultsPerCategory"] == null ? 3 : (int)CurrentPage["ResultsPerCategory"]%>' 
							Navigation-ResultsPerPage='<%#CurrentPage["ResultsPerPage"] == null ? 20 : (int)CurrentPage["ResultsPerPage"]%>'
							Resources-SiteName="Web Site"
							ResultSettings-MaxLengthOfTitle="60"
							EPiServerSecurityFilter="True"
							EPiServerSecurityRenderCheck="False"
							EPiServerSecurityShowMessage="False"
							EPiServerSecurityUnidentifiedHasAccess="True"
		>
        <MondoSearch:SearchOption Enabled="True" Value="<%# Query.Text %>" RequestParameter="quicksearchquery" Name="SearchQuery"/>
        <MondoSearch:SearchOption Enabled="True" Name="StemmingOn" Value='<%#CurrentPage["StemmingOn"] == null ? true : (bool)CurrentPage["StemmingOn"]%>' />
        <MondoSearch:SearchOption Enabled="True" Name="SearchTypeOption" Value='<%#CurrentPage["SearchTypeOption"] == null ? "Or" : (string)CurrentPage["SearchTypeOption"]%>' />
        <MondoSearch:SearchOption Enabled="True" Name="OnTheFlyAuthorization" Value="False" />
        <MondoSearch:SearchOption Enabled="True" Name="ExtraArgs" Value="" />
        <MondoSearch:SearchOption Enabled="True" Name="FixedCatOrder" Value="False" />
        <MondoSearch:SearchOption Enabled="True" Name="HighlightOn" Value="False" />
        <MondoSearch:SearchOption Enabled="True" Name="ModeDescription" Value="2" />
        <MondoSearch:SearchOption Enabled="True" Name="ModeTitle" Value="7" />
        <MondoSearch:SearchOption Enabled="True" Name="PhoneticsOn" Value='<%#CurrentPage["PhoneticsOn"] == null ? "DEFAULT" : (string)CurrentPage["PhoneticsOn"]%>' />
        <MondoSearch:SearchOption Enabled="True" Name="SearchExcludeQuery" Value="" />
        <MondoSearch:SearchOption Enabled="True" Name="SortByDateOn" Value='<%#CurrentPage["SortByDateOn"] == null ? true : (bool)CurrentPage["SortByDateOn"]%>' />
        <MondoSearch:SearchOption Enabled="True" Name="StatOn" Value="DEFAULT" />
        <MondoSearch:SearchOption Enabled="True" Name="SynonymsOn" Value="DEFAULT" />
        <MondoSearch:SearchOption Enabled="True" Name="UniqueDescription" Value="True" />
        <MondoSearch:SearchOption Enabled="True" Name="UniqueTitle" Value="True" />
        <MondoSearch:SearchOption Enabled="True" Name="WildCardOn" Value="False" />
        <MondoSearch:SearchOption Enabled="True" Name="UseCategories" Value='<%#CurrentPage["UseCategories"] == null ? false : (bool)CurrentPage["UseCategories"]%>' />
        <MondoSearch:MQLSetting Enabled="True" Name="AdditionalMQL" Value='<%#CurrentPage["AdditionalMQL"] == null ? "" : (string)CurrentPage["AdditionalMQL"]%>' />
        <MondoSearch:CategoryFilter Enabled="True" Value='<%#CategoryList.Items%>' RequestParameter="Category"/>
        <MondoSearch:CultureFilter Enabled="True" Value='<%#CultureList.Items%>'/>
      </Mondosoft:Search>
      
      <%-- Default hidden submit button in top, to make sure that a new search is the default behavior when Enter is pressed --%>            
      <asp:ImageButton id="DefaultSubmitButton" onclick=MondoSearch.EventHandlerNewSearchImageClick runat="server" BorderStyle=None ImageUrl="img/trans.gif" WIDTH="1" HEIGHT="1"/>

      <%-- INSERT HEADER HTML HERE --%>
      
      <%-- Result panel --%>
      <asp:panel id=ResultsPanel runat="server" Visible="<%# MondoSearch.Summary.HasResults %>">
        <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
          <%-- Headline --%>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490">
              <asp:Label id="Label7" Font-Size="Small" Font-Bold="True" Font-Names="Arial" Runat="server">
                <%# MondoSearch.GetText("RTEXT.HEADLINE")%>
              </asp:Label><BR>
              <IMG alt="" src="img/line.gif" width="490"></TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490"><%-- Summary box --%>
              <TABLE cellSpacing="0" cellPadding="0" border="0">
                <%-- Search Words --%>
                <% if(MondoSearch.Summary.SearchWords!=0){ %>
                <TR>
                  <TD>
                    <asp:Label id="Label5" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.SEARCH_HELP")%>&nbsp;
                    </asp:Label></TD>
                  <TD>
                    <asp:Repeater id=Repeater1 Runat="server" DataMember="SearchWords" DataSource="<%#MondoSearch.SearchResults%>">
                      <ItemTemplate>
                        <asp:Label ID="Label6" Runat="server" Font-Names="Arial" Font-Bold="True" ForeColor='<%# ((bool)DataBinder.Eval(Container.DataItem,"Ignored"))? System.Drawing.Color.FromName("#666666"):System.Drawing.Color.FromName("#000000")%>' Font-Size="X-Small">
                          <%# DataBinder.Eval(Container.DataItem,"Word")%>
                        </asp:Label>
                      </ItemTemplate>
                    </asp:Repeater></TD>
                </TR>
                <% } %>
                <%-- Ignored Words --%>
                <% if(MondoSearch.Summary.IgnoredWords>0){ %>
                <TR>
                  <TD valign="top">
                    <asp:Label id="Label2" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.IGNORE_HELP")%>&nbsp;
                    </asp:Label></TD>
                  <% if(MondoSearch.Summary.IgnoredWordLanguages>1){ %> <!-- Multi language ignored words -->
                  <TD>
                    <asp:Repeater id=MultiLanguageIgnored Runat="server" DataMember="SearchWords" DataSource="<%#MondoSearch.SearchResults%>">
                      <ItemTemplate>
                        <asp:Panel ID="MultiLanguagePanel" Runat="server" Visible='<%#(bool)(((IList)DataBinder.Eval(Container.DataItem,"relSearchWordsIgnoredWords")).Count>0)%>'>
                          <asp:Label ID="Label3" Runat="server" Font-Names="Arial" Font-Bold="True" Font-Size="X-Small"
                            ForeColor="#666666">
                            <%# DataBinder.Eval(Container.DataItem,"Word") %>
                          </asp:Label>
                          <asp:Repeater ID="MultiLanguageIgnoredFlags" Runat="server" DataSource='<%# DataBinder.Eval(Container.DataItem,"relSearchWordsIgnoredWords")%>'>
                            <ItemTemplate>
                              <IMG src='img/<%#DataBinder.Eval(Container.DataItem,"CultureName")%>.gif' alt='<%#DataBinder.Eval(Container.DataItem,"CultureUIName")%>'>
                            </ItemTemplate>
                          </asp:Repeater>
                        </asp:Panel>
                      </ItemTemplate>
                    </asp:Repeater>
                  </TD>
                  <% } else {%>
                  <TD>
                    <asp:Repeater id=OneLanguageIgnored Runat="server" DataMember="IgnoredWords" DataSource="<%#MondoSearch.SearchResults%>">
                      <ItemTemplate>
                        <asp:Label ID="Label4" Runat="server" Font-Names="Arial" Font-Bold="True" Font-Size="X-Small"
                          ForeColor="#666666">
                          <%# DataBinder.Eval(Container.DataItem,"SearchWord") %>
                        </asp:Label>&nbsp;
                      </ItemTemplate>
                    </asp:Repeater>&nbsp;
                  </TD>
                  <% } %>
                </TR>
                <% } %>
                <% if(MondoSearch.Summary.PagesFound>0){ %>
                <%-- Categories Found --%>
                <TR>
                  <TD>
                    <asp:Label id="CategoriesFoundLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.HELP_CAT_HEAD")%>&nbsp;
                    </asp:Label></TD>
                  <TD>
                    <asp:Label id="CategoriesFoundTextLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server"
                      Font-Bold="True">
                      <%# (MondoSearch.Summary.CategoriesFound==1)?MondoSearch.GetText("RTEXT.ONE_CATEGORY"):MondoSearch.GetText("RTEXT.NUM_CATEGORY")%>
                    </asp:Label></TD>
                </TR>
                <% } %>
                <%-- Pages Found --%>
                <TR>
                  <TD>
                    <asp:Label id="PagesFoundLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.FOUND_HELP")%>&nbsp;
                    </asp:Label></TD>
                  <TD>
                    <asp:Label id="PagesFoundTextLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server" Font-Bold="True" Visible='<%#MondoSearch.Summary.PagesFound>0%>'>
                      <%# (MondoSearch.Summary.PagesFound==1)?MondoSearch.GetText("RTEXT.ONE_PAGE"):MondoSearch.GetText("RTEXT.NUM_PAGE")%>
                    </asp:Label>
                    <asp:Label Font-Size="X-Small" Font-Names="Arial" Runat="server" ForeColor="#FF0000" Font-Bold="True" Visible='<%#MondoSearch.Summary.PagesFound==0%>' ID="Label1" NAME="Label1">
                      <%# MondoSearch.GetText("RTEXT.NOTHING_HELP")%>
                    </asp:Label></TD>
                </TR>
                <%-- Languages Found --%>
                <%if(MondoSearch.Summary.LanguagesFound>1){%>
                <TR>
                  <TD valign="top">
                    <asp:Label id="LanguagesLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.HELP_LANG_HEAD")%>&nbsp;
                    </asp:Label></TD>
                  <TD>
                    <asp:DataList id=Repeater2 Runat="server" RepeatColumns=8 RepeatDirection=Horizontal DataMember="LanguageSummary" DataSource="<%# MondoSearch.SearchResults %>">
                      <ItemTemplate>
                        <asp:ImageButton Runat="server" ID="LangLink" OnCommand="MondoSearch.EventHandlerLinkButtonItemCommand" CommandName="CULTURE" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"CultureName") %>' AlternateText='<%# MondoSearch.GetTextLanguage("RTEXT.HELP_LANG_ALT",Container.DataItem) %>' ImageUrl='<%# "img/"+ DataBinder.Eval(Container.DataItem,"CultureName").ToString()+".gif" %>'></asp:ImageButton>
                         <asp:Label Runat="Server" ID="LangValue" Font-Size="X-Small" Font-Names="Arial" Visible='<%# (bool) (((string)DataBinder.Eval(Container.DataItem,"CultureName"))!="iv")%>'>&nbsp;<%#DataBinder.Eval(Container.DataItem,"ValueAsString")%></asp:Label>
                      </ItemTemplate>
                      <SeparatorTemplate>&nbsp;</SeparatorTemplate>
                    </asp:DataList></TD>
                </TR>
                <%}%>
                <%-- Count messages --%>
                <% if(MondoSearch.Summary.SearchWords>1){ %>
                <TR>
                  <TD>
                    <asp:Label id="CountLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                      <%# MondoSearch.GetText("RTEXT.HELP")%>&nbsp;
                    </asp:Label></TD>
                  <TD>
                    <asp:Label id="CountTextLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server" Font-Bold="True">
                      <% if(MondoSearch.Summary.Phrases>0){%>
                      <%#(MondoSearch.Summary.Phrases==MondoSearch.Summary.PagesFound)?MondoSearch.GetText("RTEXT.ALL_PHRASE"):MondoSearch.GetText("RTEXT.NUM_PHRASE")%>
                      <% } else if(MondoSearch.Summary.PagesWithAllWords>0) { %>
                      <%#(MondoSearch.Summary.PagesWithAllWords==MondoSearch.Summary.PagesFound)?MondoSearch.GetText("RTEXT.ALL_ALL_WORDS"):MondoSearch.GetText("RTEXT.NUM_ALL_WORDS")%>
                      <% } else {%>
                      <%# MondoSearch.GetText("RTEXT.NO_ALL_WORDS") %>
                      <% } %>
                    </asp:Label></TD>
                </TR>
                <% } %>
              </TABLE>
            </TD>
            <TD>&nbsp;</TD>
          </TR>
          <%-- Separator --%>
          <TR>
            <TD colspan=3><br></TD>
          </TR>
          <%-- Search Headers --%>
          <% if(MondoSearch.Summary.SearchHeaders>0) { %>
          <TR>
            <TD>&nbsp;</TD>
            <TD>
              <asp:Repeater id=SearchHeadersRepeater Runat="server" DataMember="SearchHeaders" DataSource="<%# MondoSearch.SearchResults %>">
                <ItemTemplate>
                  <%# DataBinder.Eval(Container.DataItem,"SearchHeader") %>
                </ItemTemplate>
              </asp:Repeater></TD>
            <TD>&nbsp;</TD>
          </TR>
          <% } %>
          <%-- Show Results Headline --%>
          <% if(MondoSearch.Summary.PagesFound>0){ %>
          <tr>
            <td>&nbsp;</td>
            <td width="490" bgcolor="##333399" nowrap>
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left">
                    <asp:Label Runat="server" Font-Names="Arial" Font-Bold="True" Font-Size="X-Small" ForeColor="#FFFFFF" ID="Label8" NAME="Label8">
                      <%#MondoSearch.GetText("RTEXT.SITE")%>
                    </asp:Label>
                  </td>
                  <td align="right">
                    <asp:Label Runat="server" Font-Names="Arial" Font-Size="X-Small" ForeColor="#FFFFFF" ID="Label9" NAME="Label9">
                      <%#MondoSearch.GetText("RTEXT.OF")%>
                    </asp:Label>
                  </td>
                </tr>
              </table>
            </td>
            <td>&nbsp;</td>
          </tr>
          <%-- Separator --%>
          <TR>
            <TD colspan=3><br></TD>
          </TR>
          <% } %>
          <%-- List results in categories --%>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490">
              <asp:DataList id=DataList1 runat="server" DataMember="Categories" DataSource="<%# MondoSearch.SearchResults %>" Width="490px" Visible='<%#MondoSearch.Summary.PagesFound>0%>' ShowHeader="False" ShowFooter="True" OnItemCommand="MondoSearch.EventHandlerDataListItemCommand">
                <%-- Footer navigation --%>
                <FooterTemplate>
                  <TABLE cellSpacing="1" cellPadding="1" width="490" border="0">
                    <tr>
                      <td colspan="3"><IMG alt="" src="img/line.gif" width="490"></td>
                    </tr>
                    <TR>
                      <TD align="center">
                        <asp:LinkButton Runat="server" Font-Names="Arial" Font-Size="X-Small" Enabled='<%#MondoSearch.Navigation.CanMovePrevious%>' CommandName='NAVIGATE' CommandArgument='PREVIOUS' ID="Linkbutton2">
                          <% if(MondoSearch.Navigation.ItemsPreviousPage==1) {%>
                          <%# MondoSearch.GetText((!MondoSearch.Navigation.SingleCategoryMode)? ((MondoSearch.Navigation.ItemsBefore<=MondoSearch.Navigation.CategoriesPerPage)?"RTEXT.FIRST_CAT":"RTEXT.PREV_CAT"):((MondoSearch.Navigation.ItemsBefore<=MondoSearch.Navigation.ResultsPerPage)?"RTEXT.FIRST_PAGE":"RTEXT.PREV_PAGE"))%>
                          <% } else { %>
                          <%# MondoSearch.GetText((!MondoSearch.Navigation.SingleCategoryMode)? ((MondoSearch.Navigation.ItemsBefore<=MondoSearch.Navigation.CategoriesPerPage)?"RTEXT.FIRST_NUM_CATS":"RTEXT.PREV_NUM_CATS"):((MondoSearch.Navigation.ItemsBefore<=MondoSearch.Navigation.ResultsPerPage)?"RTEXT.FIRST_NUM_PAGES":"RTEXT.PREV_NUM_PAGES"))%>
                          <% } %>
                        </asp:LinkButton>
                      </TD>
                      <TD align="center">
                        <asp:LinkButton Runat="server" Font-Names="Arial" Font-Size="X-Small" Enabled='<%#MondoSearch.Navigation.CanMoveNext%>' CommandName='NAVIGATE' CommandArgument='NEXT' ID="Linkbutton3">
                          <% if(MondoSearch.Navigation.ItemsNextPage==1) {%>
                          <%# MondoSearch.GetText((!MondoSearch.Navigation.SingleCategoryMode)? ((MondoSearch.Navigation.ItemsAfter<=MondoSearch.Navigation.CategoriesPerPage)?"RTEXT.LAST_CAT":"RTEXT.NEXT_CAT"):((MondoSearch.Navigation.ItemsAfter<=MondoSearch.Navigation.ResultsPerPage)?"RTEXT.LAST_PAGE":"RTEXT.NEXT_PAGE"))%>
                          <% } else { %>
                          <%# MondoSearch.GetText((!MondoSearch.Navigation.SingleCategoryMode)? ((MondoSearch.Navigation.ItemsAfter<=MondoSearch.Navigation.CategoriesPerPage)?"RTEXT.LAST_NUM_CATS":"RTEXT.NEXT_NUM_CATS"):((MondoSearch.Navigation.ItemsAfter<=MondoSearch.Navigation.ResultsPerPage)?"RTEXT.LAST_NUM_PAGES":"RTEXT.NEXT_NUM_PAGES"))%>
                          <% } %>
                        </asp:LinkButton>
                      </TD>
                      <TD align="center">
                        <asp:LinkButton Runat="server" Font-Names="Arial" Font-Size="X-Small" Visible='<%# MondoSearch.Navigation.SingleCategoryMode%>' CommandName='CATEGORY' CommandArgument='' ID="Linkbutton1">
                          <%# MondoSearch.GetText("STEXT.SEARCH_ALL_CATS")%>
                        </asp:LinkButton>
                      </TD>
                    </TR>
                  </TABLE>
                </FooterTemplate>
                <ItemTemplate>
                  <%-- Categories --%>
                  <TABLE cellSpacing="1" cellPadding="1" width="490" border="0">
                    <TR>
                      <TD bgColor="silver">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr>
                            <td>
                              <asp:Label id="Label10" Font-Names="Arial" Runat="server" Font-Size="X-Small" Font-Bold="True">
                                <%#DataBinder.Eval(Container.DataItem,"Title")%>
                              </asp:Label>
                            </td>
                            <td align="right">
                              <asp:Label ID="CatCountLabel" Font-Names="Arial" Runat="server" Font-Size="X-Small">
                                <%#(((int)DataBinder.Eval(Container.DataItem,"PagesFound"))==1)?MondoSearch.GetText("RTEXT.ONE_PAGE_CAT"):MondoSearch.GetTextCategory("RTEXT.NUM_PAGE_CAT",Container.DataItem)%>
                              </asp:Label>
                            </td>
                          </tr>
                        </table>
                      </TD>
                    </TR>
                    <%-- Results for this category --%>
                    <TR>
                      <TD>
                        <asp:DataGrid id=DataGrid1 runat="server" Width="490px" DataSource='<%# DataBinder.Eval(Container.DataItem,"relCategoryPages") %>' Font-Size="X-Small" Font-Names="Arial" ShowHeader="False" GridLines="None" CellPadding="1" CellSpacing="1" AutoGenerateColumns="False">
                          <Columns>
                            <%-- Language column --%>
                            <asp:TemplateColumn HeaderText="Language">
                              <ItemStyle Width="20px" VerticalAlign="Top" />
                              <ItemTemplate>
                                <img src='img/<%# DataBinder.Eval(Container, "DataItem.CultureName") %>.gif' alt='<%# MondoSearch.GetText("defs_" + DataBinder.Eval(Container, "DataItem.CultureName")) %>'/>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                            <%-- Title column --%>
                            <asp:TemplateColumn HeaderText="Title" ItemStyle-VerticalAlign="Top" >
                              <ItemTemplate>
                                <asp:HyperLink runat="server" Font-Names="Arial" Text='<%# DataBinder.Eval(Container, "DataItem.Title") %>' NavigateUrl='<%# "Click.aspx?"+DataBinder.Eval(Container, "DataItem.LinkClick").ToString() %>' ID="Hyperlink1" NAME="Hyperlink1">
                                </asp:HyperLink><BR>
                                <asp:Label Runat="server" Font-Italic="True" Font-Names="Arial" Visible="<%#MondoSearch.Navigation.SingleCategoryMode%>" ID="Label11" NAME="Label11">
                                  <%#DataBinder.Eval(Container,"DataItem.Description")%>
                                </asp:Label>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                            <%-- MediaTypes --%>
                            <asp:TemplateColumn HeaderText="MediaTypes" ItemStyle-VerticalAlign="Top" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Right">
                              <ItemTemplate>
                                <asp:Image Runat="server" ImageUrl='<%#((bool)DataBinder.Eval(Container.DataItem,"PageHasAudio"))?"img/sound.gif":"img/trans.gif"%>' AlternateText='<%#((bool)DataBinder.Eval(Container.DataItem,"PageHasAudio"))?MondoSearch.GetText("RTEXT.P_ALT_AUD"):""%>' ID="Image1" NAME="Image1"/>
                                <asp:Image Runat="server" ImageUrl='<%#((bool)DataBinder.Eval(Container.DataItem,"PageHasVideo"))?"img/video.gif":"img/trans.gif"%>' AlternateText='<%#((bool)DataBinder.Eval(Container.DataItem,"PageHasVideo"))?MondoSearch.GetText("RTEXT.P_ALT_VID"):""%>' ID="Image2" NAME="Image2"/>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                            <%-- Words found on page column --%>
                            <asp:TemplateColumn HeaderText="SearchWords" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="80">
                              <ItemTemplate>
                                <asp:Label Runat="server" Font-Names="Arial" ID="Label12" Font-Size="XX-Small" Visible='<%# (MondoSearch.Summary.SearchWords>1) %>' ForeColor="#000000">
                                  <%# ((bool)DataBinder.Eval(Container,"DataItem.PageHasPhrase"))? MondoSearch.GetText("RTEXT.PHRASE"):(((bool)DataBinder.Eval(Container,"DataItem.PageHasAllSearchWords"))? MondoSearch.GetText("RTEXT.ALL_WORDS"):DataBinder.Eval(Container,"DataItem.ShortSearchWordsOnPage"))%>
                                </asp:Label>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                            <%-- "New" comment --%>
                            <asp:TemplateColumn HeaderText="DateComment" ItemStyle-VerticalAlign="Top" ItemStyle-Width="21" ItemStyle-HorizontalAlign="Right">
                              <ItemTemplate>
                                <asp:Label Runat="server" Font-Names="Arial" ID="NewLabel" Font-Size="XX-Small" Visible='<%#(bool)((((int)DataBinder.Eval(Container,"DataItem.AgeInDays"))<7)&(!((bool)DataBinder.Eval(Container,"DataItem.PageDateDynamic")))&(!((bool)DataBinder.Eval(Container,"DataItem.PageDateUnknown"))))%>' ForeColor="#FF0000">
                                  <%# MondoSearch.GetText("RTEXT.NEW")%>
                                </asp:Label>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                            <%-- Date Column --%>
                            <asp:TemplateColumn HeaderText="DateField" ItemStyle-Width="56px" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Right">
                              <ItemTemplate>
                                <asp:Label Runat="server" Font-Names="Arial" ID="DateLabel" Font-Size="XX-Small" ForeColor="#000000">
                                  <%# DataBinder.Eval(Container.DataItem,"DateAsString")%>
                                </asp:Label>
                              </ItemTemplate>
                            </asp:TemplateColumn>
                          </Columns>
                        </asp:DataGrid></TD>
                    </TR>
                    <%-- Navigate all results in category --%>
                    <TR>
                      <TD align="left">
                        <asp:LinkButton id=LinkButton4 Font-Size="X-Small" Font-Names="Arial" Font-Italic="True" Visible='<%# (!MondoSearch.Navigation.SingleCategoryMode)&(MondoSearch.Navigation.ResultsPerCategory<(int)DataBinder.Eval(Container.DataItem,"PagesFound")) %>' Runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"Name")%>' CommandName="CATEGORY">
                          <%# MondoSearch.GetTextCategory("RTEXT.ALL_DOCUMENTS",Container.DataItem)%>
                        </asp:LinkButton></TD>
                    </TR>
                  </TABLE>
                </ItemTemplate>
                <SeparatorTemplate>
                  <BR>
                </SeparatorTemplate>
              </asp:DataList></TD>
            <TD></TD>
          </TR>
        </TABLE>
      </asp:panel>
      <%-- Search Panel --%>
      <asp:Panel id="SearchPanel" runat="server" Visible='<%#!MondoSearch.SearchIsUpdating%>'>
        <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
          <% if(!MondoSearch.Summary.HasResults){ %>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490">
              <asp:Label id="SearchHeadlineLabel" Font-Size="Small" Font-Bold="True" Font-Names="Arial" Runat="server">
                <%#MondoSearch.GetText("STEXT.HEADLINE")%>
              </asp:Label><BR>
              <IMG alt="" src="img/line.gif" width="490"></TD>
            <TD>&nbsp;</TD>
          </TR>
          <% } %>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490" valign="middle">
              <P>
                <asp:Label id="QueryFieldLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                  <%# MondoSearch.GetText("STEXT.SEARCH")%>
                </asp:Label><BR>
                <asp:TextBox id="Query" runat="server" Font-Names="Arial,Helvetica" Font-Size="X-Small" Width="256px" value="<%#MondoSearch.Summary.LastQuery%>"></asp:TextBox><INPUT style="VISIBILITY: hidden; WIDTH: 0px" type="text" size="0">
                <asp:ImageButton id=ImageButton1 onclick=MondoSearch.EventHandlerNewSearchImageClick runat="server" ImageAlign="AbsMiddle" AlternateText='<%#MondoSearch.GetText("STEXT.SUBMIT_TEXT")%>' BorderStyle=None ImageUrl='<%#"img/"+MondoSearch.GetText("STEXT.SUBMIT_IMAGE")%>' WIDTH="85" HEIGHT="24">
                </asp:ImageButton></P>
            </TD>
            <TD>&nbsp;</TD>
          </TR>
          <%-- Category Selection --%>
          <% if(MondoSearch.SearchInfo!=null) if(MondoSearch.SearchInfo.Tables["CategoryInfo"].Rows.Count>1){ %>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490">
              <P>
                <asp:Label id="CategorySelectLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                  <%#MondoSearch.GetText("STEXT.SEARCH_CAT")%>
                </asp:Label><BR>
                <asp:CheckBoxList id=CategoryList runat="server" Font-Size="X-Small" Font-Names="Arial" DataMember="CategoryInfo" DataSource="<%# MondoSearch.SearchInfo %>" Width="100%" DataValueField="Name" DataTextField="Title" RepeatColumns="2">
                </asp:CheckBoxList></P>
            </TD>
            <TD>&nbsp;</TD>
          </TR>
          <%}%>
          <%-- Language selection --%>
          <% if((MondoSearch.SearchInfo!=null)&(!MondoSearch.Summary.HasResults)) if(MondoSearch.SearchInfo.Tables["LanguageInfo"].Rows.Count>1){ %>
          <tr>
            <td colspan="3"><br>
            </td>
          </tr>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490">
              <P>
                <asp:Label id="Label13" Font-Size="X-Small" Font-Names="Arial" Font-Bold="True" Runat="server">
                  <%#MondoSearch.GetText("STEXT.LANG_HEADLINE")%>
                </asp:Label><BR>
                <IMG alt="" src="img/line.gif" width="490"><br>
                <asp:CheckBoxList id="CultureList" runat="server" Font-Size="X-Small" Font-Names="Arial" RepeatLayout=Table DataSource='<%# MondoSearch.SearchInfo %>' DataMember="LanguageInfo" Width="100%" DataValueField="LCID" DataTextField="CultureUIName" RepeatColumns="4">
                </asp:CheckBoxList></P>
            </TD>
            <TD>&nbsp;</TD>
          </TR>
          <%}%>
          <%-- Alternatives list --%>
          <% if(MondoSearch.Summary.Alternatives>0){ %>
          <TR>
            <TD>&nbsp;</TD>
            <TD width="490" bgColor="#dedede">
              <asp:Label id="AlternativeLabel" Font-Size="X-Small" Font-Names="Arial" Runat="server">
                <%#MondoSearch.GetText("RTEXT.ALTERNATIVES_TITLE")%>
              </asp:Label><BR>
              <asp:DataList id=AlternativesList Font-Size="X-Small" Font-Names="Arial" Runat="server" DataMember="Alternatives" DataSource="<%# MondoSearch.SearchResults %>" Width="100%" RepeatColumns="3" RepeatDirection="Horizontal">
                <ItemTemplate>
                  <SCRIPT LANGUAGE="JavaScript" type="text/Javascript">
              <!--
              document.write('<a href="javascript:AltClck(\'<%# DataBinder.Eval(Container.DataItem,"Alternative").ToString().ToLower() %>\',/ ?<%# DataBinder.Eval(Container.DataItem,"Alternative").ToString().ToLower() %> /gi)"><%# DataBinder.Eval(Container.DataItem,"Alternative").ToString().ToLower() %></a>');
              //-->
                  </SCRIPT>
                </ItemTemplate>
              </asp:DataList></TD>
            <TD>&nbsp;</TD>
          </TR>
          <% } %>
        </TABLE>
      </asp:Panel>
      <%-- Show error page if the search is updating --%>
      <asp:Panel Runat="server" ID="SearchIsUpdatingPanel" Visible="<%# MondoSearch.SearchIsUpdating %>">
        <CENTER>
          <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="490">
            <TR>
              <TD ALIGN="CENTER" VALIGN="TOP"><FONT FACE="Arial,Helvetica">
                  <BR>
                  <B>
                    <%#MondoSearch.GetText("STEXT.DB_CLOSED")%>
                  </B>
                  <BR>
                </FONT>
              </TD>
            </TR>
          </TABLE>
        </CENTER>
      </asp:Panel>
      
      <%-- INSERT FOOTER HTML HERE --%>
      
		
		
	</EPiServer:Content>
</development:DefaultFramework>