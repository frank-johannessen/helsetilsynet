using System;
using System.Web.UI.WebControls;
using EPiServer.Community;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MyContacts : RelateUserControlBase<Model.BasePage>
    {
        public bool DisplayRemoveButton { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            BindContacts();
        }
        protected void BindContacts()
        {
            ucMyContacts.Users = CurrentUser.GetContacts();
            ucMyContacts.DisplayRemoveButton = DisplayRemoveButton;
            ucMyContacts.DataBind();
        }

        protected void ucMyContacts_ContactRemoved(object sender, CommandEventArgs e)
        {
            // Get the user for whom we are deleting friendship
            var contactToRemove =
                CommunitySystem.CurrentContext.DefaultSecurity.GetUser(int.Parse(e.CommandArgument.ToString()));

            if (contactToRemove != null)
                CurrentUser.RemoveContact(contactToRemove);

            //bind after removed
            BindContacts();
        }
    }
}