using System;
using EPiServer.Core;
using EPiUtilities.Extensions;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using Relate.HelpersAndExtensions;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable
{
    public partial class LeftMenuUsingParentNode : RelateUserControlBase<Model.BasePage>
    {
        /// <summary>
        /// this will list all pages under the parentnode of the currentpage, if the currentpage is a sectionpage, it will just list the pages under it.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public int CorrectActivePageId { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            FindCorrectActivePageId();
            if (IsBelowArticleArchive(CurrentPage))
            {
                plhArchiveButton.Visible = true;
                plhLeftMenu.Visible = false;
            }
            else
            {
                plhLeftMenu.Visible = true;
                plhArchiveButton.Visible = false;

                plPages.PageLink = GetNodeToListPagesFrom();
                plPages.DataBind();

                plhExtraNodeForLvlTwo.Visible = GetNodeToListPagesFrom() == CurrentPage.PageLink;
            }
        }

        private void FindCorrectActivePageId()
        {
            PageData page = CurrentPage;
            while (!page.VisibleInMenu)
            {
                page = page.Parent();
            }
            CorrectActivePageId = page.PageLink.ID;
        }

        private static bool IsBelowArticleArchive(PageData page)
        {
            if (page.PageLink == PageReference.StartPage || page.PageLink == PageReference.RootPage)
                return false;

            if (page is ArticleArchive)
                return true;

            return IsBelowArticleArchive(page.Parent());
        }

        public PageReference GetNodeToListPagesFrom()
        {
            return IsTopNode(CurrentPage.PageLink.ToPageData()) ? CurrentPage.PageLink : GetTopNode(CurrentPage);
        }

        private static bool IsTopNode(PageData currentPage)
        {
            return currentPage.IsSectionPage() ||
                   currentPage.PageLink == PageReference.StartPage ||
                   currentPage.PageLink == PageReference.RootPage ||
                   currentPage.PageLink.ToPageData() as Folder != null;
        }

        public PageReference GetTopNode(PageData currentPage)
        {
            var topNode = currentPage;
            if (IsChildOfSectionOrStartPage((BasePage)topNode))
            {
                while (!IsTopNode(topNode) && topNode != null)
                {
                    if (topNode.Parent() != null)
                        topNode = topNode.Parent();
                }
            }
            else
            {
                while (!IsTopNode(topNode) && topNode != null && !IsFolderPage(topNode.Parent()))
                {
                    if (topNode.Parent() != null)
                        topNode = topNode.Parent();
                }

            }
            return topNode.PageLink ?? currentPage.PageLink;
        }

        private static bool IsFolderPage(PageData page)
        {
            return page.PageLink.ToPageData() as Folder != null;
        }

        private static bool IsSectionOrStartPage(BasePage currentPage)
        {
            return currentPage.IsSectionPage() ||
                   currentPage.PageLink == PageReference.StartPage ||
                   currentPage.PageLink == PageReference.RootPage ||
                   currentPage.PageLink.ToPageData() as Folder != null;
        }

        private bool IsChildOfSectionOrStartPage(BasePage currentPage)
        {
            while (!IsSectionOrStartPage(currentPage))
            {
                currentPage = (BasePage)currentPage.Parent();
            }
            return currentPage as Section != null;
        }
        
        protected string GetHeader(PageReference pageReference)
        {
            return pageReference.ToPageData().PageName;
        }

        protected bool IsCurrentPageOrDecendantOf(PageData bindedPage)
        {
            var isDecendant = bindedPage.PageLink.ID == CorrectActivePageId;
            return isDecendant;
        }
        protected bool SetActiveOrNot(PageData bindedPage)
        {
            var isDecendant = bindedPage.PageLink.ID == CorrectActivePageId;
            return isDecendant;
        }
    }
}