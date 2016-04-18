using System;
using System.Web.UI.WebControls;
using EPiServer.Common.Security;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class DisplayUserCollection : RelateUserControlBase<Model.BasePage>
    {
        public UserCollection Users { get; set; }
        public bool DisplayRemoveButton { get; set; }
        public override void DataBind()
        {
            base.DataBind();
            lvUsers.DataSource = Users;
            lvUsers.DataBind();
        }

        protected void lbRemoveContacts_Command(object sender, CommandEventArgs e)
        {
            OnRemove(sender, e);
        }
        protected void OnRemove(object sender, CommandEventArgs e)
        {
            if (ContactRemoved != null)
            {
                ContactRemoved(sender, e);
            }
        }
        protected string GetConfirmDelete()
        {
            return string.Format("return confirm('{0}');", Translate("/confirmdeletequestions/contact"));
        }
        public event EventHandler<CommandEventArgs> ContactRemoved;
    }
}