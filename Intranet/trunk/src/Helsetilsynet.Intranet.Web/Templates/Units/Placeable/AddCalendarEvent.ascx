<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddCalendarEvent.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable.AddCalendarEvent" %>
<%@ Import Namespace="MakingWaves.Helsetilsynet.Intranet.Web.Model" %>
<%@ Import Namespace="Relate.HelpersAndExtensions" %>
<asp:LinkButton runat="server" ID="btnShowCreateEvent" OnClick="btnShowCreateEvent_OnClick" Text="<%$ Resources: EPiServer, calendar.addevent %>" CssClass="add-event" />
<asp:Panel runat="server" ID="pnlCreateEvent" Visible="False">
    <div class="modal-popup-wrapper">
        <div class="add-calendar-event modal-popup">
            <h2 class="heading"><%= Translate("/calendar/addeditevent") %></h2>
            <p><asp:Literal runat="server" Text="<%# RelateTemplatePage<RelateGlobalSettings>.AddCalendarEventDescription  %>" /></p>
            <fieldset class="timespan">
                <legend><%= Translate("/calendar/choosetimeanddate") %></legend>
                <div id="divDatetimeSelector">
                    <div class="date-row">
                        <div class="date-label">
                            <span><%= Translate("/calendar/starttime") %></span>
                        </div>
                        <div class="date-values">
                        <asp:TextBox runat="server" ID="tbStartDate" />
                        <asp:DropDownList runat="server" ID="ddlStartDateHours" /> : <asp:TextBox runat="server" ID="tbStartDateMinutes" MaxLength="2" Columns="2" Text="00" CssClass="minutes" />
                        <asp:CustomValidator ID="cvStartDate"
                            ControlToValidate="tbStartDate" 
                            ValidationGroup="vgCreateEvent"
                            ErrorMessage="*" OnServerValidate="cvValidateDate" 
                            SetFocusOnError="true" Display="Dynamic" runat="server" />
         
                        <asp:CustomValidator ID="cvStartDateMinutes"
                            ControlToValidate="tbStartDateMinutes" 
                            ValidationGroup="vgCreateEvent"
                            ErrorMessage="*" OnServerValidate="cvValidateMinutes" 
                            SetFocusOnError="true" Display="Dynamic" runat="server" />
                        </div>
                    </div>
                    <div class="date-row">
                        <div class="date-label">
                            <span><%= Translate("/calendar/endtime") %></span>
                        </div>
                        <div class="date-values">
                                <asp:TextBox runat="server" ID="tbEndDate" />
                            <asp:DropDownList runat="server" ID="ddlEndDateHours" /> : <asp:TextBox runat="server" ID="tbEndDateMinutes" MaxLength="2" Columns="2" Text="00" CssClass="minutes" />
                            <asp:CustomValidator ID="cvEndDate"
                                    ControlToValidate="tbEndDate" 
                                    ValidationGroup="vgCreateEvent"
                                    ErrorMessage="*" OnServerValidate="cvValidateDate" 
                                    SetFocusOnError="true" Display="Dynamic" runat="server" />
        
                            <asp:CustomValidator ID="cvEndDateMinutes"
                                    ControlToValidate="tbEndDateMinutes" 
                                    ValidationGroup="vgCreateEvent"
                                    ErrorMessage="*" OnServerValidate="cvValidateMinutes" 
                                    SetFocusOnError="true" Display="Dynamic" runat="server" />
                        </div>
                    </div>
                </div>
            </fieldset>
            <div class="event-details">
                <asp:Label runat="server" Text="<%$ Resources: EPiServer, calendar.title %>" AssociatedControlID="txtTitle" />
                <asp:TextBox runat="server" ID="txtTitle"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="<%$ Resources: EPiServer, calendar.description %>" AssociatedControlID="txtDescription" />
                <asp:TextBox runat="server" TextMode="MultiLine" ID="txtDescription"></asp:TextBox>
                <br />
                <asp:Label runat="server" Text="<%$ Resources: EPiServer, calendar.articlelink %>" AssociatedControlID="txtArticleLink" />
                <asp:TextBox runat="server" ID="txtArticleLink"></asp:TextBox>
            </div>
            <fieldset class="service-areas">
                <legend><%= Translate("/personinformation/serviceareas") %></legend>
                <asp:CheckBoxList RepeatLayout="UnorderedList" runat="server" ID="cblServiceAreas" OnDataBound="cblServiceAreas_OnDataBound" />
            </fieldset>
            <div class="actions">
                <asp:button runat="server" OnClick="btnCancel_OnClick" Text="<%$ Resources: EPiServer, general.cancel %>" />
                <asp:Button runat="server" OnClick="btnCreateEvent_OnClick" ValidationGroup="vgCreateEvent" ID="btnCreateEvent" />
            </div>
        </div>
    </div>    
</asp:Panel>

<script type="text/javascript">
    $(document).ready(function() {
        $('#<%= tbStartDate.ClientID %>').datepicker({ dateFormat: 'dd.mm.yy' }, $.datepicker.regional['no']);
        $('#<%= tbEndDate.ClientID %>').datepicker({ dateFormat: 'dd.mm.yy' }, $.datepicker.regional['no']);
    });
//    $(function () {
//        $('#<%= tbStartDate.ClientID %>').datepicker({ dateFormat: 'dd.mm.yy' }, $.datepicker.regional['no']);
//        $('#<%= tbEndDate.ClientID %>').datepicker({ dateFormat: 'dd.mm.yy' }, $.datepicker.regional['no']);
//    });
</script>