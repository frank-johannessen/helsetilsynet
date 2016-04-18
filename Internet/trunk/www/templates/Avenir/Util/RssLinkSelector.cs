using System;
using System.Web.UI;
using EPiServer.DynamicContent;

namespace Avenir.DynamicContent
{
    public class RssLinkSelector : IDynamicContent
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region IDynamicContent Members

        Control IDynamicContent.GetControl(EPiServer.PageBase hostPage)
        {
            return hostPage.LoadControl("~/templates/Avenir/Units/Placeable/RssQuery.ascx");
        }

        EPiServer.Core.PropertyDataCollection IDynamicContent.Properties
        {
            get { return null; }
        }

        string IDynamicContent.Render(EPiServer.PageBase hostPage)
        {
            return null;
        }

        bool IDynamicContent.RendersWithControl
        {
            get { return true; }
        }

        string IDynamicContent.State
        {
            get
            {
                return null;
            }
            set
            {
            }
        }

        #endregion
    }
}