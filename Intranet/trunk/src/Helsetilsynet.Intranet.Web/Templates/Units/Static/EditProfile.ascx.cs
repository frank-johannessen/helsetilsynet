using System;
using Relate.HelpersAndExtensions;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class EditProfile : RelateUserControlBase<Model.MyPage>
    {
        public override void DataBind()
        {
            if (!IsPostBack)
            {
                BindEditControls();
            }
        }

        public void BindEditControls()
        {
            if(CurrentUser == DisplayUser || CurrentUser.IsAdmin())
            {
                if(CurrentUser == DisplayUser)
                {
                    ucEditProfileCompetenceInfo.DataBind();
                    ucEditProfileCompetenceInfo.Visible = true;
                }
                    
                ucEditProfileContactInfo.DataBind();
                ucEditProfileContactInfo.Visible = true;
            }
        }

        protected void Profileinfo_Saved(object sender, EventArgs e)
        {
            lblEditProfileMessage.Visible = true;
            lblEditProfileMessage.Text = Translate("/personinformation/contactinfosaved");
            BindEditControls();
        }

        protected void Competenceinfo_Saved(object sender, EventArgs e)
        {
            lblEditProfileMessage.Visible = true;
            lblEditProfileMessage.Text = Translate("/personinformation/competenceinfosaved");
            BindEditControls();
        }

    }
}