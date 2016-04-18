#region Copyright
/*
Copyright (c) 2010 EPiServer AB.  All rights reserved.

This code is released by EPiServer AB under the Source Code File - Specific License Conditions, published August 20, 2007. 
See http://www.episerver.com/Specific_License_Conditions for details. 
*/
#endregion

#region Known Limitations
/*
The template has no known limitations.
*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Common.Data;
using EPiServer.Common.Security;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Login
{
    public partial class Register : RelateUserControlBase<Model.BasePage>
    {
        #region Method overrides
        /// <summary>
        /// Binds a data source to the invoked server control and all its child controls.
        /// </summary>
        public override void DataBind()
        {
            valFirstName.ErrorMessage = GetErrorMessage("/registration/firstnamemissing");
            valLastName.ErrorMessage = GetErrorMessage("/registration/lastnamemissing");
            valRequiredEmail.ErrorMessage = GetErrorMessage("/registration/emailmissing");
            valEmail.ErrorMessage = GetErrorMessage("/registration/emailwrongformat");
            valPassword.ErrorMessage = GetErrorMessage("/registration/passwordmissing");
            valConfirmPassword.ErrorMessage = GetErrorMessage("/registration/passwordmissing");
            valComparePassword.ErrorMessage = GetErrorMessage("/registration/passwordnotmatching");
            valNewPassword.ErrorMessage = GetErrorMessage("/registration/invalidpasswordformat");
            valCountyOrDepartment.ErrorMessage = GetErrorMessage("/registration/bothcountyanddepartmentmissing");
            valPhone.ErrorMessage = GetErrorMessage("/registration/invalidphoneformat");
            valRequiredPhoneNumber.ErrorMessage = GetErrorMessage("/registration/invalidphoneformat");

            // Set focus on first textbox
            Page.SetFocus(txtFirstName);
        }

        protected override void OnLoad(EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDepartmentsList();
                PopulateCountiesList();
            }
        }

        private void PopulateCountiesList()
        {
            var counties = DepartmentHelper.GetAllFylkesmannsEmbete().Select(o => new ListItem(o.Name, o.ID.ToString())).ToList();
            ddlCounties.Items.Clear();
            ddlCounties.Items.Add(new ListItem(Translate("/registration/choosecounty"), Translate("/registration/choosecounty")));
            ddlCounties.Items.AddRange(counties.ToArray());
        }

        private void PopulateDepartmentsList()
        {
            //var departments = DepartmentHelper.GetAllDepartments().Select(g => new ListItem(g.Name, g.ID.ToString())).ToList();
            //ddlDepartments.Items.Clear();
            //ddlDepartments.Items.Add(new ListItem(Translate("/registration/choosedepartment"), Translate("/registration/choosedepartment")));
            //ddlDepartments.Items.AddRange(departments.ToArray());

            ddlDepartments.DataSource = GetDepartmentItems();
            ddlDepartments.DataTextField = "Text";
            ddlDepartments.DataValueField = "Value";
            ddlDepartments.DataBind();
        }
        private static List<ListItem> GetDepartmentItems()
        {
            var retVal = new List<ListItem> { new ListItem("Velg avdeling", "0") };
            retVal.AddRange(from @group in GetDepartmentsForDropDown() select new ListItem(@group.Name, @group.ID.ToString()));
            return retVal;
        }

        private static IEnumerable<IGroup> GetDepartmentsForDropDown()
        {
            var allDeps = DepartmentHelper.GetAllDepartments();
            var fylkesMannGroup = DepartmentHelper.GetFylkesmannenDepartmentgroup();
            if (fylkesMannGroup != null && allDeps.Contains(fylkesMannGroup))
                allDeps.Remove(fylkesMannGroup);
            return allDeps;
        }

        private string PreparePhoneNumber(string phoneText)
        {
            phoneText = phoneText.Trim().Replace(" ", "");
            for (int i = 3; i > 0; i--)
            {
                phoneText = phoneText.Insert(i * 2, " ");
            }

            return phoneText;
        }

        #endregion

        #region Event handlers

        /// <summary>
        /// Validates whether user selected department or county, during registration
        /// </summary>
        protected void ValidateDepartmentAndCounty(object sender, ServerValidateEventArgs args)
        {
            if (ddlCounties.SelectedIndex == 0 && ddlDepartments.SelectedIndex == 0 ||
                ddlCounties.SelectedIndex != 0 && ddlDepartments.SelectedIndex != 0)
            {
                args.IsValid = false;
            }
            else
                args.IsValid = true;
        }

        /// <summary>
        /// Handles the Click event of the btnCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Visible = false;
        }

        /// <summary>
        /// Handles the Click event of the btnRegister control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                IUser newUser = CommunitySystem.CurrentContext.DefaultSecurity.GetUserByUserName(txtEmail.Text) as IUser;

                if (newUser == null)
                {
                    DatabaseHandler.Instance.RunInTransaction(delegate
                    {
                        newUser = (IUser)CommunitySystem.CurrentContext.DefaultSecurity.NewUser;
                        newUser.UserName = txtEmail.Text;
                        newUser.EMail = txtEmail.Text;
                        newUser.Password = txtPassword.Text;
                        newUser.GivenName = txtFirstName.Text.Trim();
                        newUser.SurName = txtLastName.Text.Trim();
                        newUser.Alias = String.Format("{0} {1}", newUser.GivenName, newUser.SurName);
                        newUser.BirthDate = DateTime.Now; // Minimum community value

                        newUser.SetInitials(txtInitials.Text.Trim());
                        newUser.SetTelephone(PreparePhoneNumber(txtTelephone.Text));
                        SetDepartmentOrCounty(newUser);
                        newUser = (IUser)CommunitySystem.CurrentContext.DefaultSecurity.AddUser(newUser);

                        System.Web.Security.FormsAuthentication.SetAuthCookie(newUser.UserName, false);
                    });

                    var userclone = (IUser)newUser.Clone();
                    ActivityFeedHandler.SubscribeUserToUser(userclone, newUser);
                    userclone.IsFirstTimeLogin(true);
                    CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(userclone);
                    Response.Redirect(newUser.GetMyPageUri().ToString());
                }
                else
                {
                    valEmail.IsValid = false;
                    valEmail.Text = String.Format(Translate("/registration/emailinuse"), txtEmail.Text);
                }
            }
        }

        private void SetDepartmentOrCounty(IUser newUser)
        {
            IGroup department;

            //User selected county
            if (ddlCounties.SelectedIndex != 0)
            {
                newUser.SetFylkesmannDepartment(ddlCounties.SelectedItem.Text);
                var fylkesmannsEmbete = CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(int.Parse(ddlCounties.SelectedValue));
                if (fylkesmannsEmbete != null)
                {
                    newUser.SetFylkesmannsEmbete(fylkesmannsEmbete);
                    newUser.IsFylkesmann(true);
                }
                department = DepartmentHelper.GetFylkesmannenDepartmentgroup();
            }
            else
            {
                department = CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(int.Parse(ddlDepartments.SelectedValue));
                
            }

            newUser.SetDepartment(department);
        }

        #endregion
    }
}
