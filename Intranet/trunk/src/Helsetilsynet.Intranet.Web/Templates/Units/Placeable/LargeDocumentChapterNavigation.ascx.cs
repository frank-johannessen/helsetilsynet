using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Dummy
{
    public partial class LargeDocumentChapterNavigation : UserControlBase<BasePage>
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulatePrevNextNavigation();
        }

        private void PopulatePrevNextNavigation()
        {
            var prevPage = LargeDocumentHelper.GetPreviousClosestDocument(CurrentPage);
            var nextPage = LargeDocumentHelper.GetNextClosestDocuemnt(CurrentPage);
            var mainPage = LargeDocumentHelper.GetMainDocumentPage(CurrentPage);

            DisplayHyperLink(hlPrevDocLink, prevPage, "&lt; {0}");
            DisplayHyperLink(hlNextDocLink, nextPage, "{0} &gt;");
            DisplayHyperLink(hlMainDocLink2, mainPage, "{0}");

            DisplayDocLinkSeparators(nextPage, prevPage);
        }

        private static void DisplayHyperLink(HyperLink hlLink, PageData pageData, string nameFormat)
        {
            if (pageData != null)
            {
                hlLink.NavigateUrl = pageData.LinkURL;
                hlLink.Text = String.Format(nameFormat, pageData.PageNameWithMaxLength(20));
                hlLink.Visible = true;
            }
        }

        private void DisplayDocLinkSeparators(PageData nextPage, PageData prevPage)
        {
            if (prevPage != null && nextPage != null)
            {
                ltrPrevNextDocLinkSeparator.Visible = true;
            }

            if (nextPage != null || prevPage != null)
            {
                ltrMainDocLinkSeparator.Visible = true;
            }

        }
    }
}