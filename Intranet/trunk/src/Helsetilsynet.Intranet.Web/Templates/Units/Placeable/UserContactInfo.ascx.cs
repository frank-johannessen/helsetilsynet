using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    //NOTE: This UC is also used to render output from the UserSearchService web service. Inheriting from RelateUserControlBase<T> does not currently work in WS context.
    public partial class UserContactInfo : System.Web.UI.UserControl
    {
        public IEnumerable<IUser> Users { get; set; }

        public int TotalResult { get; set; }
        public bool ShowDepartmentName { get; set; }
        
        public override void DataBind()
        {
            base.DataBind();
            if (Users != null)
            {
                lvUsers.DataSource = Users;
                lvUsers.DataBind();
                lvUsersShort.DataSource = Users;
                lvUsersShort.DataBind();
            }

            if(Users != null && TotalResult > Users.Count())
            {
                pnlDisplayMoreResultsLink.Visible = true;
            }
        }

        protected string Translate(string str)
        {
            return LanguageManager.Instance.Translate(str,GetLanguage());
        }

        private static string GetLanguage()
        {
            return "no";
        }

        protected void lvUsers_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            var lvServiceAreas = (ListView) e.Item.FindControl("lvServiceAreas");
            if (lvServiceAreas != null)
            {
                lvServiceAreas.DataSource = ((IUser) e.Item.DataItem).GetServiceAreas();
                lvServiceAreas.DataBind();
            }

            var lvProfessions = (ListView) e.Item.FindControl("lvProfessions");
            if (lvProfessions != null)
            {
                lvProfessions.DataSource = ((IUser) e.Item.DataItem).GetProfessions();
                lvProfessions.DataBind();
            }

            var lvSpecialties = (ListView) e.Item.FindControl("lvSpecialties");
            if (lvSpecialties != null)
            {
                lvSpecialties.DataSource = ((IUser) e.Item.DataItem).GetSpecialties();
                lvSpecialties.DataBind();
            }

            var lvTasks = (ListView) e.Item.FindControl("lvTasks");
            if (lvTasks != null)
            {
                lvTasks.DataSource = ((IUser) e.Item.DataItem).GetTasks();
                lvTasks.DataBind();
            }
        }

        protected string DivSeparator(int itemIndex)
        {
            return (itemIndex + 1) % 3 == 0 ? "<div style=\"clear:both\"></div>" : string.Empty;
        }
        
        protected bool ShouldDisplayDepartmentName(IUser user)
        {
            if (ShowDepartmentName)
                return true;
            else if (user.IsFylkesmann())
                return false;
            return true;
        }
    }
}