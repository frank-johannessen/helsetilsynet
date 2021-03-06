<%@ Control EnableViewState="False" Language="c#" AutoEventWireup="false" Codebehind="RenameFile.ascx.cs" Inherits="EPiServer.Util.FileManager.RenameFile" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="FileManager" TagName="FileReferenceList"	Src="~/util/FileManager/FileReferenceList.ascx"%>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>
<asp:PlaceHolder Runat="server" ID="FileList">
	<table class="FM-MarginTable">
		<tr>
			<td>
				<FileManager:FileReferenceList UseWarningStyle="True" id="fileReferenceList" runat="server"/>
			</td>
		</tr>
	</table>
</asp:PlaceHolder>
<table class="FM-MarginTable">
	<tr>
		<td>
			<EPiServer:Translate Text="/filemanager/renamefile/newname" runat="server" ID="Translate1" NAME="Translate1"/>:
		</td>
		<td>
			<asp:TextBox ID="FileName" Size="50" Runat="server"/><asp:Label Runat="server" ID="extension" />
			<asp:RequiredFieldValidator ID="Requiredfieldvalidator1"
					ErrorMessage="*"
					Display="Dynamic"
					ControlToValidate="FileName"
					Runat="server"/>
			<asp:CustomValidator id="CustomValidator1"
					ControlToValidate="FileName"
					OnServerValidate="ValidateNewFile"
					Display="Dynamic"
					ErrorMessage="Directory already exists"
					Translate="/filemanager/renamefile/alreadyexists"
					runat="server"/>
			<asp:CustomValidator id="Customvalidator2"
					ControlToValidate="FileName"
					OnServerValidate="ValidateFileSystemName"
					Display="Dynamic"
					ErrorMessage="Invalid characters in name"
					Translate="/filemanager/invalidcharacters"
					runat="server"/>
		</td>
	</tr>
</table>
<table class="FM-MarginTable">
	<tr>
		<td>
			<asp:Button ID="SaveButton" Translate="/button/save" Runat="server"/>
			<asp:Button ID="CancelButton" Translate="/button/cancel" CausesValidation="False" Runat="server"/>
		</td>
	</tr>
</table>

<script type="text/javascript">

document.forms[0].<%=FileName.ClientID%>.focus();
document.body.attachEvent("onkeydown",handleKeyPressed);

function handleKeyPressed()
{
	if(event.keyCode == 13 && event.srcElement.type == 'text')
	{
		document.forms[0].<%=SaveButton.ClientID%>.click();
		return false;
	}
	return true;
}
</script>
