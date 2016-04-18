<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Register.ascx.cs" Inherits="MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login.Register" %>
    
<asp:Panel ID="pnlRegister" runat="server" CssClass="modal-popup-wrapper" DefaultButton="btnRegister">
    <script type="text/javascript">
        var ddlDepartmentsId, ddlCountiesId;
        
        $(document).ready(function () {
            ddlDepartmentsId = '<%=ddlDepartments.ClientID %>';
            ddlCountiesId = '<%=ddlCounties.ClientID %>';
            BindOnChangeEvents();
        });

        var BindOnChangeEvents = function () {
            BindOnChangeEventToDropDown(ddlDepartmentsId);
            BindOnChangeEventToDropDown(ddlCountiesId);
        };

        var BindOnChangeEventToDropDown = function (dropDownId) {
            var ddl = document.getElementById(dropDownId);
            ddl.onchange = function() {
                var validator = document.getElementById('<%=valCountyOrDepartment.ClientID%>');
                ValidatorValidate(validator);
            };
        };

        var ValidateDepartmentAndCountyClient = function(sender, args) {
            var validationResult = custom_validators.validateTwoDropDownLists('<%=ddlDepartments.ClientID %>', '<%=ddlCounties.ClientID %>');
            args.IsValid = validationResult === false ? false : true;
        };

        var btnRegister_ClientClick = function() {
            var initialsControl = document.getElementById('<%=txtInitials.ClientID %>');
            initialsControl.value = initialsControl.value.toUpperCase();
        };
    </script>
    <div class="modal-popup">
        <fieldset>
            <legend>
                <%= Translate("/registration/required") %>
            </legend>
            <asp:Label ID="lblFirstName" runat="server" Text="<%$Resources: EPiServer, general.firstname %>" AssociatedControlID="txtFirstName" />
            <div class="validation">
                <asp:TextBox ID="txtFirstName" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valFirstName" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtFirstName" Display="Dynamic" />
                </div>
            </div>

            <asp:Label ID="lblLastName" runat="server" Text="<%$Resources: EPiServer, general.lastname %>" AssociatedControlID="txtLastName" />
            <div class="validation">
                <asp:TextBox ID="txtLastName" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valLastName" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtLastName" Display="Dynamic" />
                </div>
            </div>

            <asp:Label ID="lblEmail" runat="server" Text="<%$Resources: EPiServer, general.email %>" AssociatedControlID="txtEmail" />
            <div class="validation">
                <asp:TextBox ID="txtEmail" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valRequiredEmail" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtEmail" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="valEmail" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtEmail" ValidationExpression="^[A-Za-z0-9._%-]+@[A-Za-z0-9._%-]+\.[A-Za-z0-9._%-]{2,4}$" Display="Dynamic" />
                </div>
            </div>

            <asp:Label ID="lblPassword" runat="server" Text="<%$Resources: EPiServer, login.password %>" AssociatedControlID="txtPassword" />
            <div class="validation">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valPassword" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtPassword" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="valNewPassword" runat="server" ControlToValidate="txtPassword" ValidationExpression="^.{6,}$" Display="Dynamic" ValidationGroup="registerFormGroup" />
                </div>
            </div>

            <asp:Label ID="lblConfirmPassword" runat="server" Text="<%$Resources: EPiServer, registration.confirmpassword %>" AssociatedControlID="txtConfirmPassword" />
            <div class="validation">
                <asp:TextBox ID="txtConfirmPassword" runat="server" ValidationGroup="registerFormGroup" TextMode="Password" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valConfirmPassword" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtConfirmPassword" Display="Dynamic" />
                    <asp:CompareValidator ID="valComparePassword" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" Display="Dynamic" />
                </div>
            </div>
            
            <asp:Label ID="lblDepartment" runat="server" Text="<%$Resources: EPiServer, registration.choosedepartment %>" AssociatedControlID="ddlDepartments" />
            <div class="validation">
                <asp:DropDownList ID="ddlDepartments" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
            </div>
            
            <asp:Label ID="lblCounty" runat="server" Text="<%$Resources: EPiServer, registration.choosecounty %>" AssociatedControlID="ddlCounties" />
            <div class="validation">
                <asp:DropDownList ID="ddlCounties" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:CustomValidator ID="valCountyOrDepartment" runat="server" ValidationGroup="registerFormGroup" OnServerValidate="ValidateDepartmentAndCounty" ClientValidationFunction="ValidateDepartmentAndCountyClient" Display="Dynamic" />
                </div>
            </div>
            
            <asp:Label ID="lblPhoneNumber" runat="server" Text="<%$Resources: EPiServer, personinformation.telephone %>" AssociatedControlID="txtTelephone" />
            <div class="validation">
                <asp:TextBox ID="txtTelephone" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
                <div class="valMessage">
                    <asp:RequiredFieldValidator ID="valRequiredPhoneNumber" runat="server" ValidationGroup="registerFormGroup" ControlToValidate="txtTelephone" Display="Dynamic" />
                    <asp:RegularExpressionValidator runat="server" ID="valPhone" ValidationGroup="registerFormGroup" ControlToValidate="txtTelephone" ValidationExpression="^\s*?(\d\s*?){8}$" Display="Dynamic" />
                </div>
            </div>
            
            <asp:Label ID="lblInitials" runat="server" Text="<%$Resources: EPiServer, personinformation.initials %>" AssociatedControlID="txtInitials" />
            <div class="validation">
                <asp:TextBox ID="txtInitials" runat="server" ValidationGroup="registerFormGroup" CssClass="text" />
            </div>

            <div class="actions">
                <asp:Button ID="btnCancel" runat="server" Text="<%$ Resources: EPiServer, general.cancel %>" CausesValidation="false" OnClick="btnCancel_Click" />
                <asp:Button ID="btnRegister" runat="server" Text="<%$Resources: EPiServer, registration.newaccount  %>" ValidationGroup="registerFormGroup" OnClientClick="btnRegister_ClientClick()" OnClick="btnRegister_Click" />
            </div>
        </fieldset>
    </div>
</asp:Panel>
    
