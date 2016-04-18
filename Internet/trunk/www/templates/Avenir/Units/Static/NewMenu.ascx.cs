using System;
using EPiServer;
using EPiServer.Core;

namespace Helsetilsynet.templates.Avenir.Units.Static
{
    public partial class NewMenu : UserControlBase
    {
        protected override void OnLoad(EventArgs e)
        {
            Menu.PageLink = new PageReference(CurrentPage.Property["MainMenuContainer"].ToString());
            Menu.DataBind();
        }

        protected string GetMenuLevel(PageData pageData)
        {
            var pageRef = new PageReference(pageData.PageLink.ID);
            var page = pageData;

            //To avoid counting root page
            int pageLevel = -1;

            while (pageRef != PageReference.RootPage)
            {
                pageLevel++;
                pageRef = page.ParentLink;
                page = DataFactory.Instance.GetPage(pageRef);
            }

            return "level" + pageLevel;
        }

        protected string GetExpandedClass(object dataItem)
        {
            var page = dataItem as PageData;
            if (page != null && Menu.OpenPages.Contains(page.PageLink))
                return "class=\"expanded\"";
            return string.Empty;

        }
    }
}