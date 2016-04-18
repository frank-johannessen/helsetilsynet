<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditProfileCompetenceView.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static.EditProfileCompetenceView" %>
<div class="edit-competence">
    <h2 class="heading"><%= Translate("/personinformation/competence") %></h2>
    <fieldset>
        <legend><asp:Literal runat="server" Text="<%$ Resources: EPiServer, personinformation.serviceareas %>"/></legend>
        <asp:CheckBoxList RepeatLayout="UnorderedList" runat="server" ID="cblServiceAreas" OnDataBound="cblServiceAreas_DataBound" />
    </fieldset>

    <fieldset class="profession">
        <legend><asp:Literal runat="server" Text="<%$ Resources: EPiServer, personinformation.profession %>"/></legend>
        <asp:CheckBoxList RepeatLayout="UnorderedList" runat="server" ID="cblProfession" OnDataBound="cblProfession_DataBound" />
        <asp:ListBox runat="server" SelectionMode="Multiple" CssClass="specialty-selector specialty-lege" ID="lbDoctorSpecialties" OnDataBound="lbSpecialties_DataBound" />
        <asp:ListBox runat="server" SelectionMode="Multiple" CssClass="specialty-selector specialty-sykepleier" ID="lbNurseSpecialties" OnDataBound="lbSpecialties_DataBound" />
        <asp:ListBox runat="server" SelectionMode="Multiple" CssClass="specialty-selector specialty-andre" ID="lbOtherProfessions" OnDataBound="lbProfessions_DataBound" />
    </fieldset>
    <fieldset>
        <legend><asp:Literal runat="server" Text="<%$ Resources: EPiServer, personinformation.tasks %>"/></legend>
        <asp:CheckBoxList RepeatLayout="UnorderedList" runat="server" ID="cblTasks" OnDataBound="cblTasks_DataBound" />
    </fieldset>
    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.moreabouteducation %>" AssociatedControlID="txtMoreAboutEducation" />
    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtMoreAboutEducation" />

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.moreaboutserviceareas %>" AssociatedControlID="txtMoreAboutServiceAreas" />
    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtMoreAboutServiceAreas" />

    <asp:Label runat="server" Text="<%$ Resources: EPiServer, personinformation.previousworkexperience %>" AssociatedControlID="txtPreviousWorkExperience" />
    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtPreviousWorkExperience" />

    <asp:Button ID="btnSaveCompetence" runat="server" OnClick="btnSaveCompetence_Click" ValidationGroup="editCompetenceGroup" Text="<%$ Resources: EPiServer, personinformation.savecompetenceinfo %>" />
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $(".profession-selector.profession-lege").appendSpecialty({ specialtyToAppend: '.specialty-lege' });
        $(".profession-selector.profession-sykepleier").appendSpecialty({ specialtyToAppend: '.specialty-sykepleier' });
        $(".profession-selector.profession-andre").appendSpecialty({ specialtyToAppend: '.specialty-andre' });
    });

    (function ($) {
        $.fn.appendSpecialty = function (params) {
            $(this).append($(params.specialtyToAppend));
        };
    })(jQuery);	
</script>