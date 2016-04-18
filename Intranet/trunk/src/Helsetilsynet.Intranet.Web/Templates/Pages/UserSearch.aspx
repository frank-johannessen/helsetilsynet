<%@ Page Title="" Language="C#" MasterPageFile="~/Templates/MasterPage.Master" AutoEventWireup="true" CodeBehind="UserSearch.aspx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Pages.UserSearch" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Register TagPrefix="Relate" TagName="Users" Src="~/Templates/Units/Placeable/UserContactInfo.ascx" %>
<%@ Register tagPrefix="ht" tagName="LeftMenu" src="~/Templates/Units/Placeable/LeftMenuUsingParentNode.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="profile" href="http://microformats.org/profile/hcard" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <div class="main-content section">
        <h1><EPiServer:Property runat="server" PropertyName="PageName" CustomTagName="span" /></h1>
        <input type="hidden" value="<%= GetMaxResults() %>" name="max-results"/>
        <div class="filter-options">
            <asp:Label ID="Label1" runat="server" Text="<%$ Resources: EPiServer, UserSearchFilter.freetextsearch %>" AssociatedControlID="txtSearchText" />
            <asp:TextBox ID="txtSearchText" runat="server" CssClass="freetext-input" Columns="65" />
            <fieldset class="departments">
                <legend><%= Translate("/UserSearchFilter/department")%></legend>
                <div class="select-all checked">
                    <asp:CheckBox ID="cbxSelectAllDepartments" runat="server" Checked="True" />
                    <asp:Label runat="server" AssociatedControlID="cbxSelectAllDepartments" CssClass="select-all-departments"><%= Translate("/UserSearchFilter/AllDepartments")%></asp:Label>
                </div>
                <asp:CheckBoxList runat="server" ID="cblDepartmentList" RepeatLayout="UnorderedList"  CssClass="button-selector" OnDataBound="cblDepartmentList_OnDataBound" />
                
                <asp:DropDownList runat="server" CssClass="county-selector county" ID="ddlCounty"></asp:DropDownList>
                    
                    <%--<input id="Checkbox1" type="checkbox" name="neio$0" />
						<div class="label-wrapper">
							<label for="neio_0">Fylke</label>
							<select class="specify county">
							    <option value="">Alle</option>
                                <asp:Repeater runat="server" ID="rptCountyList">
                                    <ItemTemplate>
                                        <option value="<%# ((ListItem)Container.DataItem).Value %>"><%# ((ListItem)Container.DataItem).Value %></option>
                                    </ItemTemplate>
                                </asp:Repeater>
							</select>
						</div>--%>
            </fieldset>
            <fieldset class="services">
                <legend><%= Translate("/UserSearchFilter/services")%></legend>
                <div class="select-all checked">
                    <asp:CheckBox runat="server" ID="cbxSelectAllCategories" Checked="True"/> 
                    <asp:Label runat="server" AssociatedControlID="cbxSelectAllCategories" CssClass="select-all-categories"><%= Translate("/UserSearchFilter/AllServices")%></asp:Label>
                </div>
                <asp:CheckBoxList runat="server" ID="cblCategoryList" RepeatLayout="UnorderedList" CssClass="button-selector" OnDataBound="cblCategoryList_OnDataBound" />
            </fieldset>
        </div>
        <div class="extra-filter-options">
            <fieldset class="professions">
                <legend><%= Translate("/UserSearchFilter/profession")%></legend>
                <div class="select-all checked">
                    <asp:CheckBox ID="cbxSelectAllProfessions" runat="server" Checked="True"/>
                    <asp:Label runat="server" AssociatedControlID="cbxSelectAllProfessions" CssClass="select-all-professions"><%= Translate("/UserSearchFilter/AllProfessions")%></asp:Label>
                </div>
                
                <asp:CheckBoxList runat="server" ID="cblProfessions" RepeatLayout="UnorderedList" CssClass="button-selector" OnDataBound="cblProfessions_OnDataBOund" />

                <asp:DropDownList runat="server" CssClass="specialty-selector specialty-lege" ID="ddlDoctorSpecialties" />
                <asp:DropDownList runat="server" CssClass="specialty-selector specialty-sykepleier" ID="ddlNurseSpecialties" />
                <asp:DropDownList runat="server" CssClass="specialty-selector specialty-andre" ID="ddlOtherProfessions" OnDataBound="ddlOtherProfessions_OnDataBound" />

<%--				<select class="specialty-selector specialty-lege">
					<option value="">Alle</option>
                    <asp:Repeater runat="server" ID="rptDoctorSpecialities">
                        <ItemTemplate>
                            <option value="<%# ((ListItem)Container.DataItem).Value %>"><%# ((ListItem)Container.DataItem).Value %></option>
                        </ItemTemplate>
                    </asp:Repeater>
				</select>
				<select class="specify">
					<option value="">Alle</option>
					<asp:Repeater runat="server" ID="rptNurseSpecialities">
                        <ItemTemplate>
                            <option value="<%# ((ListItem)Container.DataItem).Value %>"><%# ((ListItem)Container.DataItem).Value %></option>
                        </ItemTemplate>
                    </asp:Repeater>
				</select>
				<select class="specify">
					<option value="">Alle øvrige</option>
					<asp:Repeater runat="server" ID="rptOtherProfessions">
                        <ItemTemplate>
                            <option value="<%# ((ListItem)Container.DataItem).Value %>"><%# ((ListItem)Container.DataItem).Value %></option>
                        </ItemTemplate>
                    </asp:Repeater>
				</select>
                --%>
                

                </fieldset>
            <fieldset class="tasks">
                <legend><%= Translate("/UserSearchFilter/tasks")%></legend>
                <div class="select-all checked">
                    <asp:CheckBox ID="cbxSelectAllTasks" runat="server" Checked="True"/>
                    <asp:Label runat="server" AssociatedControlID="cbxSelectAllTasks" CssClass="select-all-tasks"><%= Translate("/UserSearchFilter/AllTasks")%></asp:Label>
                </div>
                <asp:CheckBoxList runat="server" ID="cblTasks" RepeatLayout="UnorderedList" CssClass="button-selector" />
            </fieldset>
        </div>
        <div class="result">    
            <Relate:Users runat="server" ID="rltUsers"/>
        </div>
    </div>
    
    <div class="aside"></div>

    <ht:LeftMenu runat="server" />
    <script type="text/javascript">
        var losen = losen || {};
        losen.userSearch = losen.userSearch || {};
        losen.userSearch.showExtendedFiltersText = 'Vis profesjoner og oppgaver';
        losen.userSearch.hideExtendedFiltersText = 'Skjul profesjoner og oppgaver';
        
    </script>
    <script type="text/javascript">
        replace_val = '<%=  LanguageManager.Instance.Translate("/UserSearchFilter/descriptiontext") %>';
        $(document).ready(function (event) {
            $('.freetext-input').val(replace_val);
        });

        // BEGIN: auto clear search text box default text Søk på Losen og Helsetilsynet.no
        $('.freetext-input').focusin(function () {
            if ($(this).val() == replace_val) {
                $(this).val("");
            }
        }).focusout(function () {
            if ($.trim($(this).val()) == "") {
                $(this).val(replace_val);
            }
        });
        // END: auto clear search text box default text
        </script>
    <script type="text/javascript" src="/Templates/scripts/user_search.js"></script>
</asp:Content>
