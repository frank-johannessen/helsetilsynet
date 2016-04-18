using System;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.DataAbstraction;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class EditProfileCompetenceView : RelateUserControlBase<Model.MyPage>
    {
        public override void DataBind()
        {
            base.DataBind();

            txtMoreAboutEducation.Text = DisplayUser.GetMoreAboutEducation();
            txtMoreAboutServiceAreas.Text = DisplayUser.GetMoreAboutServiceAreas();
            txtPreviousWorkExperience.Text = DisplayUser.GetPreviousWorkExperience();

            cblServiceAreas.DataSource = Category.GetRoot().Categories;
            cblServiceAreas.DataTextField = "Name";
            cblServiceAreas.DataValueField = "ID";
            cblServiceAreas.DataBind();

            cblProfession.DataSource = RelateTemplatePage<RelateGlobalSettings>.Professions;
            cblProfession.DataBind();

            lbDoctorSpecialties.DataSource = RelateTemplatePage<RelateGlobalSettings>.PhysicianSpecialties;
            lbDoctorSpecialties.DataBind();

            lbNurseSpecialties.DataSource = RelateTemplatePage<RelateGlobalSettings>.NurseSpecialties;
            lbNurseSpecialties.DataBind();

            lbOtherProfessions.DataSource = RelateTemplatePage<RelateGlobalSettings>.OtherProfessions;
            lbOtherProfessions.DataBind();

            cblTasks.DataSource = RelateTemplatePage<RelateGlobalSettings>.Tasks;
            cblTasks.DataBind();
        }

        protected void btnSaveCompetence_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                IUser displayUserClone = DisplayUser.Clone() as IUser;

                displayUserClone.SetServiceAreas(cblServiceAreas.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("", (current, item) => current + item.Value + ","));

                displayUserClone.SetProfession(
                    (cblProfession.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("", (current, item) => current + item.Value + ",")) +
                    (lbOtherProfessions.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("", (current, item) => current + item.Value + ","))
                );

                displayUserClone.SetSpecialties(
                    (lbDoctorSpecialties.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("", (current, item) => current + item.Value + ",")) +
                    (lbNurseSpecialties.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("", (current, item) => current + item.Value + ","))
                );

                displayUserClone.SetTasks(cblTasks.Items.Cast<ListItem>().Where(item => item.Selected).Aggregate("",(current,item) => current + item.Value + ","));

                displayUserClone.SetMoreAboutEducation(txtMoreAboutEducation.Text.Trim().FormatContentTextNoHtml());
                displayUserClone.SetMoreAboutServiceAreas(txtMoreAboutServiceAreas.Text.Trim().FormatContentTextNoHtml());
                displayUserClone.SetPreviousWorkExperience(txtPreviousWorkExperience.Text.Trim().FormatContentTextNoHtml());

                UpdateUser(displayUserClone);
                OnInfoSaved(sender, e);
            }

        }

        private void UpdateUser(IUser displayUserClone)
        {
            // Save everything to the user
            CommunitySystem.CurrentContext.DefaultSecurity.UpdateUser(displayUserClone);

            //DataBind();
            //Response.Redirect(Request.RawUrl);
        }
        protected void OnInfoSaved(object sender, EventArgs e)
        {
            if (InfoSaved != null)
            {
                InfoSaved(sender, e);
            }
        }

        public event EventHandler<EventArgs> InfoSaved;

        protected void cblServiceAreas_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList) sender).Items)
            {
                var preSelected = DisplayUser.GetServiceAreas();
                foreach (var category in preSelected)
                {
                    if (li.Value == category.ID.ToString())
                    {
                        li.Selected = true;
                    }
                }
            }
        }

        protected void cblProfession_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList) sender).Items)
            {
                var professions = DisplayUser.GetProfessions();
                foreach (var profession in professions)
                {
                    if (li.Value == profession)
                    {
                        li.Selected = true;
                        
                    }
                    
                }
                li.Attributes.Add("class", "profession-selector profession-"+li.Value.ToLower());
            }
        }

        protected void lbSpecialties_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((ListBox) sender).Items)
            {
                var specialties = DisplayUser.GetSpecialties();
                foreach (var specialty in specialties)
                {
                    if (li.Value == specialty)
                    {
                        li.Selected = true;
                    }
                }
            }
        }

        protected void lbProfessions_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((ListBox) sender).Items)
            {
                var professions = DisplayUser.GetProfessions();
                foreach (var profession in professions)
                {
                    if (li.Value == profession)
                    {
                        li.Selected = true;
                    }
                }
            }
        }

        protected void cblTasks_DataBound(object sender, EventArgs e)
        {
            foreach (ListItem li in ((CheckBoxList) sender).Items)
            {
                var tasks = DisplayUser.GetTasks();
                foreach (var task in tasks)
                {
                    if (li.Value == task)
                    {
                        li.Selected = true;
                    }
                }
            }
        }
    }
}