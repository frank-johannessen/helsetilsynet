<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Categories.ascx.cs" Inherits="EPiServer.Community.Web.Administration.Categories" %>
			<table class="epi-default" cellSpacing="0" cellPadding="0">
				<thead>
					<tr>
						<th><%=EPiServer.Common.Globalization.GlobalizationHandler.Instance.GetTranslation("EPiServer.Community.EntityEditorExtensions.Categories.CategoriesHeader")%></th>
					</tr>
				</thead>
				<tr>
					<td>
						<asp:Panel ID="panelCategoryCheckBoxes" Runat="server"></asp:Panel>&nbsp;
					</td>
				</tr>
			</table>