<%@ Control Language="c#" AutoEventWireup="false" Codebehind="TranslatePage.ascx.cs" Inherits="EPiServer.Edit.TranslatePage" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="EPiServerSys" Namespace="EPiServer.SystemControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<br />
<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SaveShowTool.gif"		ID="Save"			Text="/button/saveandview"	ToolTip="/edit/editpanel/tooltipsave"		runat="server" />
<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/SavePublishTool.gif"	ID="SaveAndPublish" Name="Publish" Text="/button/saveandpublish" ToolTip="/edit/editpanel/tooltipapprove" RequiredAccess="Publish" runat="server" />
<EPiServerSys:CommandTool ImageUrl="~/Util/images/Tools/Cancel.gif"				ID="Cancel"			Name="Cancel" Text="/button/cancel"	ToolTip="/edit/editpanel/tooltipcancel" runat="server"/>
<br />
<p><EPiServerSys:ValidationSummary ID="Summary" Runat="server" DisplayMode="BulletList" /></p>

<asp:Table Width="100%" Height="100%" Runat="server">
	<asp:TableRow>
		<asp:TableCell ColumnSpan="2">
			<episerver:translate runat="server" text="/multilanguageruntime/firstlanguage" />:&nbsp;<asp:DropDownList ID="FirstLanguageSelection" Runat="Server" OnSelectedIndexChanged="Selection_Changed" AutoPostBack="True" />&nbsp;&nbsp;&nbsp;
			<episerver:translate runat="server" text="/multilanguageruntime/secondlanguage" />:&nbsp;<asp:DropDownList ID="SecondLanguageSelection" Runat="Server" AutoPostBack="True" />
		</asp:TableCell>
	</asp:TableRow>
	<asp:TableRow runat="server" Height="100%">
		<asp:TableCell Width="50%" Runat="server" ID="FirstLanguageCell" VerticalAlign="Top">
			<EPiServerSys:propertydataform id="EditForm1" runat="server" AutoLoadTabs="true" Visible="False" />
		</asp:TableCell>
		<asp:TableCell Width="50%" Runat="server" ID="SecondLanguageCell" VerticalAlign="Top">
			<EPiServerSys:propertydataform id="EditForm2" runat="server" AutoLoadTabs="true" Visible="False" DisableInputFields="True" />
		</asp:TableCell>
	</asp:TableRow>
</asp:Table>
<script type="text/javascript">
function leavePage()
{
	var eventTarget = document.all['__EVENTTARGET'];

	if (eventTarget != null && eventTarget.value!='')
	{
		if (eventTarget.value != 'Cancel' && eventTarget.value.indexOf('actionTab:')<0)
			return;
		else
			window.onerror = HidePostbackError;	
	}

	// window.confirmNavigateMessage holds translated text, defined in edit/EditPanel.aspx.
	event.returnValue = window.confirmNavigateMessage;
}
</script>