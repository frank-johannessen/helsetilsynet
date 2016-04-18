using System;
using System.Web.UI.WebControls;
using EPiServer.Community.Calendar;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class MinimalCalenderViewItem : RelateUserControlBase<Model.BasePage>
    {
        public EventCollection EventCollection { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public override void DataBind()
        {
            base.DataBind();
            rptItems.DataSource = EventCollection;
            rptItems.DataBind();
        }

        protected void lbEditEvent_OnCommand(object sender, CommandEventArgs e)
        {
            OnEditEvent(e);
        }

        private void OnEditEvent(CommandEventArgs e)
        {
            if (EditEvent != null)
                EditEvent(this, e);
        }
        public event EventHandler<CommandEventArgs> EditEvent;

        protected void lbDeleteEvent_OnCommand(object sender, CommandEventArgs e)
        {
            OnDeleteEvent(e);
        }

        private void OnDeleteEvent(CommandEventArgs e)
        {
            if (DeleteEvent != null)
                DeleteEvent(this, e);
        }

        public event EventHandler<CommandEventArgs> DeleteEvent;

        protected string GetConfirmDelete()
        {
            return string.Format("return confirm('{0}');", Translate("/confirmdeletequestions/calendarevent"));
        }
    }
}