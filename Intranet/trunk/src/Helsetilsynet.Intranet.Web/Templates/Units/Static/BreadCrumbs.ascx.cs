using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using EPiServer.Core;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Static
{
    public partial class BreadCrumbs : UserControlBase<BasePage>
    {
        private IEnumerable<int> _viewableFolders;
        private IEnumerable<int> ViewableFolders
        {
            get
            {
                if (_viewableFolders != null)
                    return _viewableFolders;

                _viewableFolders = new List<int>();

                var viewableFoldersSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.FoldersInBreadCrumbs];
                if (string.IsNullOrEmpty(viewableFoldersSetting))
                    return _viewableFolders;

                _viewableFolders = from item in viewableFoldersSetting.Split(',')
                                   select int.Parse(item);

                return _viewableFolders;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            BreadCrumbsMenu1.Visible = CurrentPage.PageLink.ID != PageReference.StartPage.ID;
        }

        protected bool IsViewableFolder(PageData pageData)
        {
            if (!(pageData is Folder))
                return false;

            return ViewableFolders.Contains(pageData.PageLink.ID);
        }
    }
}