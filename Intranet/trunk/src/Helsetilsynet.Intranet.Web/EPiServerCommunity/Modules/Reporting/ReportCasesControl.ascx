<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportCasesControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.ReportCasesControl" %>
<%@ Register TagPrefix="sc" TagName="PagingControl" Src="~/EPiServerCommunity/PagingControl.ascx" %>

<script language="javascript">

	function <%=this.ClientID%>_ToggleItem(id)
	{
		var imgElemOpen = document.getElementById("abuseItemToggleImageOpen_" + id);
		var imgElemClosed = document.getElementById("abuseItemToggleImageClosed_" + id);
		
		var rowElem = document.getElementById("abuseItemRow_" + id);
		var dataElem = document.getElementById("abuseItemData_" + id);
		
		if (dataElem.style.display == "none")
		{
			dataElem.style.display = rowElem.style.display;
			// Don't simply change image source since it's a bit buggy
			imgElemOpen.style.display = "block";
			imgElemClosed.style.display = "none";
		}
		else
		{
			dataElem.style.display = "none"
			// Don't simply change image source since it's a bit buggy
			imgElemOpen.style.display = "none";
			imgElemClosed.style.display = "block";
		}
	}
	
	function <%=this.ClientID%>_MarkReportState(val)
	{
		var i;
		for (i = 0; i < document.forms[0].elements.length; i++) {
			var elem = document.forms[0].elements[i];
			if (elem.id != null && elem.id.indexOf("radioButtonListAbuseItemState") >= 0 && elem.id.indexOf("<%=repeaterReportCases.ClientID%>") >= 0)
			{
				if (elem.value == val)
					elem.checked = true;
			}
		}
	}
	
	function <%= this.ClientID %>_toggleVisibility(elementId)
	{ 
	    var obj = document.getElementById(elementId); 
	    if ( obj.style.visibility == 'visible' )
	    { 
	        obj.style.visibility = 'hidden';
	    } 
	    else
	    { 
	        obj.style.visibility = 'visible';
	    } 
	 }
	 
	 function <%= this.ClientID %>_CheckAllForRemoval()
	 {
	    var i;
	    var check;
	    var unCheckAll = '<%= this.ClientID %>_htmlButtonUnCheckAll';
	    var checkAll = '<%= this.ClientID %>_htmlButtonCheckAll';
	    if(document.getElementById(unCheckAll) != null)
	    {
	        document.getElementById(unCheckAll).id = checkAll;
	        check = false; 
	    }
	    else
	    {
	        document.getElementById(checkAll).id = unCheckAll;
	        check = true;
	    }
           
		for (i = 0; i < document.forms[0].elements.length; i++) 
		{
			var elem = document.forms[0].elements[i];
			if (elem.id != null && elem.id.indexOf ('<%=this.ClientID %>') >=0 && elem.id.indexOf('checkBoxRemoveReportCase') >= 0)
			{
			    if(check == false)
				    elem.checked = false;
				else
				    elem.checked = true;
			}
		}
	 }
	 
	 function <%= this.ClientID %>_SetAllStatus(val)
	 {
	    var i;
		for (i = 0; i < document.forms[0].elements.length; i++) 
		{
			var elem = document.forms[0].elements[i];
			if (elem.id != null && elem.id.indexOf('<%= this.ClientID %>') >= 0 && elem.id.indexOf('radioButtonListReportCaseState') >= 0)
			{
			    if (elem.value == val)
					elem.checked = true;
			}
		}
	 }
	 
	 function ToggleVisibility(elementId)
	{ 
	    var obj = document.getElementById(elementId); 
	    if ( obj.style.visibility == 'visible' )
	    { 
	        obj.style.visibility = 'hidden';
	    } 
	    else
	    { 
	        obj.style.visibility = 'visible';
	    } 
	 }
	 
	 function SetComment(labelId, textBoxId, commentWindowId, hiddenAdminCommentId)
	 {
	    var text = document.getElementById(textBoxId).value;
	    document.getElementById(labelId).innerHTML = text;
	    document.getElementById(hiddenAdminCommentId).value = text;
	    ToggleVisibility(commentWindowId);  
	 }
	 
</script>

<div id="reportingMain">
    <table border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
            <td class="td">
                <div class="section top">
                    <%=GetTranslation("EPiServer.Community.Reporting.headingManageReports")%></div>
            </td>
            <td class="td">
                <div class="section">
                    <asp:Label ID="labelResultsHeader" runat="server" /><%=GetTranslation("EPiServer.Community.Reporting.reportCasesHeading")%></div>
            </td>
        </tr>
        <tr>
            <td class="td menu" valign="top">
                <button type="button" id="<%= this.ClientID %>_htmlButtonCheckAll" onclick="<%= this.ClientID %>_CheckAllForRemoval();" class="button">
                    <%=GetTranslation("EPiServer.Community.Reporting.buttonCheckAll")%></button><br />
                <br />
                <b>Set all as:</b><br />
                <input type="radio" id="radioButtonListChangeState_1" name="radioButtonListChangeState" onclick="<%=this.ClientID %>_SetAllStatus(this.value);" value="1" />
                <%=GetTranslation("EPiServer.Community.Reporting.statusNew")%><br />
                <input type="radio" id="radioButtonListChangeState_2" name="radioButtonListChangeState" onclick="<%=this.ClientID %>_SetAllStatus(this.value);" value="2" />
                <%=GetTranslation("EPiServer.Community.Reporting.statusIgnored")%><br />
                <input type="radio" id="radioButtonListChangeState_3" name="radioButtonListChangeState" onclick="<%=this.ClientID %>_SetAllStatus(this.value);" value="3" />
                <%=GetTranslation("EPiServer.Community.Reporting.statusHandled")%>
                <br />
                <br />
                <br />
                <asp:Button ID="buttonSaveChanges" runat="server" CssClass="button" OnClick="ButtonSaveChanges_Click" />
            </td>
            <td valign="top" class="td">
                <!-- RESULTS -->
                <div id="reports">
                    <table width="100%" cellspacing="0" border="0">
                        <tr>
                            <th>
                                &nbsp;
                            </th>
                            <th align="left" class="td" style="width: 20%">
                                <asp:LinkButton ID="linkButtonSortType" runat="server" OnCommand="SortCommand" CommandArgument="SortType"><%=GetTranslation("EPiServer.Community.Reporting.tableColumnType")%></asp:LinkButton>
                            </th>
                            <th align="left" class="td" style="width: 30%">
                                <asp:LinkButton ID="linkButtonSortDate" runat="server" OnCommand="SortCommand" CommandArgument="SortDate"><%=GetTranslation("EPiServer.Community.Reporting.tableColumnDate")%></asp:LinkButton>
                            </th>
                            <th align="right" class="td" style="width: 20%; padding-right: 30px;">
                                <asp:LinkButton ID="linkButtonSortNumReports" runat="server" OnCommand="SortCommand" CommandArgument="SortNumReports"><%=GetTranslation("EPiServer.Community.Reporting.tableColumnReports")%></asp:LinkButton>
                            </th>
                            <th align="left" class="td">
                                <%=GetTranslation("EPiServer.Community.Reporting.tableColumnStatus")%>
                            </th>
                            <th align="left" class="td" style="width: 30px">
                                <%=GetTranslation("EPiServer.Community.Reporting.tableColumnRemove")%>
                            </th>
                        </tr>
                        <tbody>
                            <tr runat="server" id="rowPagingTop" visible="false">
                                <td colspan="6" class="td">
                                    <sc:PagingControl ID="pagingControlTop" runat="server" />
                                </td>
                            </tr>
                            <asp:Repeater ID="repeaterReportCases" EnableViewState="True" runat="server" OnItemDataBound="repeaterReportCases_ItemDataBound">
                                <ItemTemplate>
                                    <input type="hidden" id="hiddenReportCaseID" value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' runat="server" />
                                    <tr id="abuseItemRow_<%# DataBinder.Eval(Container.DataItem, "ID") %>">
                                        <td valign="top">
                                            <a onclick="<%# this.ClientID%>_ToggleItem(<%# DataBinder.Eval(Container.DataItem, "ID") %>)">
                                                <img id="abuseItemToggleImageClosed_<%# DataBinder.Eval(Container.DataItem, "ID") %>" src="Images/Tree/col.gif"><img id="abuseItemToggleImageOpen_<%# DataBinder.Eval(Container.DataItem, "ID") %>" src="Images/Tree/exp.gif" style="display: none"></a>
                                        </td>
                                        <td class="td" style="width: 10px;" valign="top">
                                            <a href="javascript:void(0)" onclick="<%# this.ClientID%>_ToggleItem(<%# DataBinder.Eval(Container.DataItem, "ID") %>)">
                                                <%# GetReportedTypeName(Container.DataItem) %></a>
                                        </td>
                                        <td class="td" valign="top">
                                            <%# GetDate(Container.DataItem, "Created") %>
                                        </td>
                                        <td class="td" align="right" style="padding-right: 30px;">
                                            <%# DataBinder.Eval(Container.DataItem, "NumReports") %>
                                        </td>
                                        <td class="td" valign="top">
                                            <asp:RadioButtonList ID="radioButtonListReportCaseState" runat="server" RepeatDirection="Horizontal" CssClass="label">
                                                <asp:ListItem Value="1"></asp:ListItem>
                                                <asp:ListItem Value="2"></asp:ListItem>
                                                <asp:ListItem Value="3"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td class="td" align="center" valign="top">
                                            <asp:CheckBox ID="checkBoxRemoveReportCase" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="abuseItemData_<%# DataBinder.Eval(Container.DataItem, "ID") %>" class="abuseItemData" style="display: none">
                                        <td colspan="10" class="td">
                                            <div style="padding-left: 40px; padding-bottom: 5px">
                                                <table border="0" cellpadding="0" cellspacing="0" width="90%">
                                                    <tr>
                                                        <th align="left" colspan="2" class="label">
                                                            <%=GetTranslation("EPiServer.Community.Reporting.headingReportedContent")%>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="label">
                                                            <!------ OVERLAY START --------->
                                                            <div id="contentWindow" style="position: absolute; overflow: scroll; visibility: hidden; width: 450px; height: 350px; border: 1px solid; background-color: #ffffff;" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0" width="430" style="padding-left: 5px;">
                                                                    <tr>
                                                                        <th style="padding-top: 5px;" align="left" colspan="2" class="td">
                                                                            <span style="white-space: nowrap;"><span style="width: 100px;">
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.headingReportInformation")%></span><span style="padding-left: 270px;"><a id="viewContentLinkClose" runat="server" href=""><%=GetTranslation("EPiServer.Community.Reporting.closeWindow")%></a></span></span>
                                                                        </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.firstReportBy")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportedBy" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.created")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportCreated" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.url")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportedUrl" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.reportMessage")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportMessage" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th align="left" class="td" colspan="2" style="padding-top: 10px; padding-left: 5px;">
                                                                            <%=GetTranslation("EPiServer.Community.Reporting.headingReportedContent")%>
                                                                        </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.type")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportedType" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.created")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportedItemCreated" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.author")%>:</i>
                                                                        </td>
                                                                        <td valign="top" class="label">
                                                                            <asp:Label ID="labelReportedAuthor" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" class="label" colspan="2">
                                                                            <i>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.headingReportedContent")%>:</i>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" colspan="2" class="label">
                                                                            <asp:Label ID="labelReportedContentInfoTitle" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td valign="top" colspan="2" class="label">
                                                                            <asp:Panel ID="panelReportedInfoContent" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="td" colspan="2" style="padding-left: 5px;">
                                                                            <b>
                                                                                <%=GetTranslation("EPiServer.Community.Reporting.moreReports")%></b> (<%=GetTranslation("EPiServer.Community.Reporting.total")%>:
                                                                            <asp:Label ID="labelTotalReports" runat="server" />
                                                                            <%=GetTranslation("EPiServer.Community.Reporting.report(s)")%>)
                                                                        </td>
                                                                    </tr>
                                                                    <asp:Repeater ID="repeaterMoreReports" runat="server">
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td class="label" valign="top">
                                                                                    <i>
                                                                                        <%=GetTranslation("EPiServer.Community.Reporting.reportedBy")%>:</i>
                                                                                </td>
                                                                                <td class="label" valign="top">
                                                                                    <asp:Label ID="labelMoreReportedBy" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="label" valign="top">
                                                                                    <i>
                                                                                        <%=GetTranslation("EPiServer.Community.Reporting.created")%>:</i>
                                                                                </td>
                                                                                <td class="label" valign="top">
                                                                                    <asp:Label ID="labelMoreReportCreated" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="label" valign="top">
                                                                                    <i>
                                                                                        <%=GetTranslation("EPiServer.Community.Reporting.url")%>:</i>
                                                                                </td>
                                                                                <td class="label" valign="top">
                                                                                    <asp:Label ID="labelMoreReportedUrl" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="label" valign="top">
                                                                                    <i>
                                                                                        <%=GetTranslation("EPiServer.Community.Reporting.reportMessage")%>:</i>
                                                                                </td>
                                                                                <td class="label" valign="top">
                                                                                    <asp:Label ID="labelMoreReportMessage" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                </table>
                                                            </div>
                                                            <!-------- OVERLAY END ----------->
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="label" colspan="2" style="padding-top: 5px;">
                                                            <asp:Label ID="labelReportedContentTitle" runat="server" /><br />
                                                            <asp:Panel ID="panelTopReportedContent" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="label" style="padding-top: 5px;">
                                                            <a id="viewContentLinkOpen" runat="server" href="">
                                                                <%=GetTranslation("EPiServer.Community.Reporting.linkViewContent")%></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th align="left" colspan="2" class="label" style="padding-top: 20px; width: 100px">
                                                            <%=GetTranslation("EPiServer.Community.Reporting.headingReportComments")%>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="label" colspan="2" style="padding-top: 5px;">
                                                            <div id="commentWindow" style="position: absolute; visibility: hidden; width: 300px; height: 130px; border: 1px solid; background-color: #ffffff;" runat="server">
                                                                <table>
                                                                    <tr>
                                                                        <td align="right" class="label">
                                                                            <a id="addCommentLinkClose" runat="server" href="">Close</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox CssClass="input" ID="textBoxComment" TextMode="MultiLine" Style="width: 290px; height: 100px;" runat="server" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <input type="hidden" runat="server" id="hiddenAdminComment" />
                                                            <asp:Label ID="labelAdminComment" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="label" colspan="2" style="padding-top: 5px;">
                                                            <a id="addCommentLinkOpen" runat="server" href="">
                                                                <%=GetTranslation("EPiServer.Community.Reporting.linkAddComment")%></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right">
                                                            <asp:Literal ID="literalLogLink" runat="server" />
                                                            <asp:Label ID="labelEntityLink" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr runat="server" id="rowPagingBottom" visible="false">
                                <td colspan="6" class="td">
                                    <sc:PagingControl ID="pagingControlBottom" runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- /RESULTS -->
            </td>
        </tr>
    </table>
</div>
