<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AttributeDateTimeControl.ascx.cs" Inherits="EPiServer.Community.Web.Administration.AttributeDateTimeControl" %>
<%@ Register TagPrefix="sc" TagName="DateTimePicker" Src="../../DateTimePicker.ascx" %>
<sc:datetimepicker id="dateTimePickerValue" Width="100%" ShowTimePicker="True" Visible="false" runat="server"></sc:datetimepicker>
	
<asp:DropDownList ID="dropDownValues" runat="server" CssClass="input" Visible="false"></asp:DropDownList>