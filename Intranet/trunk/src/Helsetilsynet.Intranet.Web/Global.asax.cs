using System;
using System.Configuration;
using System.IO;
using System.Linq;
using Autofac;
using EPiServer;
using EPiServer.Core;
using EPiServer.UI.Edit;
using EPiServer.Web;
using EPiServer.XForms.WebControls;
using MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Common;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.DelayedPublish;
using OpenWaves;
using OpenWaves.ActivityFeed;
using OpenWaves.ActivityFeed.Web;
using OpenWaves.ActivityFeed.EPiServer.Community;
using OpenWaves.Web;
using Relate.HelpersAndExtensions;
using log4net;

namespace  MakingWaves.Helsetilsynet.Intranet.Web
{
    public class Global : EPiServer.Global
    {
		protected void Application_Start(object sender, EventArgs e)
		{
		    MoveEvoInternalToBinFolder();

            InitializationModule.FirstBeginRequest += InitializationModule_FirstBeginRequest;
            XFormControl.ControlSetup += XFormControl_ControlSetup;

            var builder = new ContainerBuilder();
		    builder.RegisterType<DocumentSessionPerRequestProvider>().As<IDocumentSessionProvider>();
            builder.Register(c => new MyEPiServerCommunityConnector()).As<IActivityFeedEPiServerCommunityConnector>();
		    builder.Register(c => new CompositeUserGroupMembershipProvider(
                new HttpContextBasedUserGroupMembershipProvider(), new MyUserGroupMembershipProvider())).As<IUserGroupMembershipProvider>();

		    ServiceLocator.SetResolver(new AutoFacResolver(builder.Build()));

            DataFactory.Instance.PublishingPage += PublishCounter;
		    DataFactory.Instance.PublishedPage += PublishedPage;
            EditPanel.LoadedPage += EditPanel_LoadedPage;

            AssemblyResourceVirtualPathProvider.EnsureRegistered();
        }

        // There is a setter for the EvoInternalFileName, and it should be possible to set any path to the EvoInternal.dll
        // http://www.evopdf.com/api/html/c8ff081d-5ce2-c4ab-75b2-479179cc1e17.htm
        // However, I've tried this, and it didn't work. The simple solution is then to manually move the file to the correct position.
        private void MoveEvoInternalToBinFolder()
        {
            var moveFromToSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.MoveEvoInternalFromTo];
            if (string.IsNullOrEmpty(moveFromToSetting))
                return;

            var moveFromTo = moveFromToSetting.Split('|');
            if (moveFromTo.Length != 2)
                return;

            string moveFrom = moveFromTo[0];
            string moveTo = moveFromTo[1];

            if (File.Exists(moveTo))
                return;

            try
            {
                File.Copy(moveFrom, moveTo);
            }
            catch (Exception)
            {
                LogManager.GetLogger(GetType()).Error(string.Format("Could not copy EvoInternal.dll file."));
            }
        }

        private static void PublishedPage(object sender, PageEventArgs e)
        {
            var relateGlobalSettingsPage = e.Page as RelateGlobalSettings;
            if(relateGlobalSettingsPage != null)
            {
                RelateTemplatePage<RelateGlobalSettings>.ClearRelateGlobalSettings();
                RelateTemplatePage<Model.BasePage>.ClearRelateGlobalSettings();
                
                RelateTemplatePage<RelateGlobalSettings>.ClearStaticSettings();
                RelateTemplatePage<Model.BasePage>.ClearStaticSettings();
            }
            var startPage = DataFactory.Instance.GetPage(PageReference.StartPage) as StartPage;
            var includeArticleInFeed = true;
            if (startPage != null)
            {
                var globalSettings = DataFactory.Instance.GetPage(startPage.GlobalSettingsReference) as GlobalSettings;
                var internalArchive = DataFactory.Instance.GetPage(globalSettings.ArticleArchive) as ArticleArchive;

                includeArticleInFeed = !isArticleDecendantOf(e.Page, internalArchive);
            }
            var article = e.Page as Article;
            if (article != null)
            {
                // stop publish of delayed publish pages
                if (article.StartPublish > DateTime.Now)
                {
                    var pages = DelayedPageManager.Instance.GetDelayedPages().ToList();
                    if(pages.Count > 0)
                    {
                        foreach (var delayedPage in pages)
                        {
                            if (delayedPage.PageReference.ID == article.PageLink.ID)
                                DelayedPageManager.Instance.RemoveDelayedPage(delayedPage);
                        }    
                    }
                    
                    DelayedPageManager.Instance.AddDelayedPage(new DelayedPage(article.PageLink));
                    return;
                }


                if ((article.IsNew || article.DisplayUpdate) && includeArticleInFeed)
                    ActivityFeedHandler.PublishArticle(article, article.IsNew);

                if (article.IsNew && IsDescendantOfArticleArchive(article))
                {
                    CacheManager.Remove(GlobalName.CacheKey.FrontPageFeaturedArticlesAll);
                    CacheManager.Remove(GlobalName.CacheKey.FrontPageFeaturedArticlesNotC1);
                }
                
                return;
            }

            var largeDocument = e.Page as LargeDocument;
            if(largeDocument != null)
            {
                if ((largeDocument.IsNew || largeDocument.DisplayUpdate) && includeArticleInFeed)
                    ActivityFeedHandler.PublishLargeDocument(largeDocument, largeDocument.IsNew);

                DeleteCachedVersionOfPdf(largeDocument);
            }

            var largeDocumentChapter = e.Page as LargeDocumentChapter;
            if (largeDocumentChapter != null)
            {
                var largeDocumentReference = LargeDocumentHelper.GetMainDocumentPage(largeDocumentChapter) as LargeDocument;
                DeleteCachedVersionOfPdf(largeDocumentReference);
            }
        }

        private static bool isArticleDecendantOf(PageData page, ArticleArchive ancestor)
        {
            if (page.PageLink == PageReference.StartPage || page.ParentLink == PageReference.StartPage)
                return false;
            if (page.ParentLink.ID == ancestor.PageLink.ID)
                return true;
            else
            
            page = DataFactory.Instance.GetPage(page.ParentLink);
             return isArticleDecendantOf(page, ancestor);
            
            
        }

        private static void DeleteCachedVersionOfPdf(LargeDocument largeDocument)
        {
            if (largeDocument == null)
                return;

            var pdfFileName = GeneratePDF.GetPdfFileName(largeDocument);
            try
            {
                if (File.Exists(pdfFileName))
                    File.Delete(pdfFileName);
            }
            catch (Exception e)
            {
                LogManager.GetLogger("Global asax").Error(string.Format("Problem deleting cached pdf file '{0}'.", pdfFileName), e);
            }
        }

        private static bool IsDescendantOfArticleArchive(Article article)
        {
            // ReSharper disable PossibleNullReferenceException
            var startPage = DataFactory.Instance.GetPage(PageReference.StartPage) as Model.StartPage;
            var articleArchive = startPage.GlobalSettings.ArticleArchive;
            // ReSharper restore PossibleNullReferenceException

            return IsDescendantOf(article, articleArchive);
        }

        private static bool IsDescendantOf(PageData pageData, PageReference articleArchive)
        {
            if (pageData.PageLink == PageReference.StartPage)
                return false;

            var parentLink = pageData.ParentLink;
            if (parentLink == articleArchive)
                return true;

            if (parentLink == PageReference.StartPage)
                return false;

            var parent = DataFactory.Instance.GetPage(parentLink);
            return IsDescendantOf(parent, articleArchive);
        }

        private static void EditPanel_LoadedPage(EditPanel sender, LoadedPageEventArgs e)
        {
            
        }

        private static void PublishCounter(object sender, PageEventArgs e)
        {
            var basePage = e.Page as Model.BasePage;
            if (basePage == null)
                return;

            if (basePage.PublishCounter == null)
                basePage.PublishCounter = 0;
            else
                basePage.PublishCounter++;
        }


        private static void XFormControl_ControlSetup(object sender, EventArgs e)
        {
            var control = (XFormControl)sender;
            control.ControlsCreated += Control_ControlsCreated;
        }

        private static void Control_ControlsCreated(object sender, EventArgs e)
        {
            XFormMarkup.CleanupXFormHtmlMarkup((XFormControl)sender);
        }

        private static void InitializationModule_FirstBeginRequest(object sender, EventArgs e)
        {
        }

        protected void Session_Start(object sender, EventArgs e)
        {
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
        }

        protected void Session_End(object sender, EventArgs e)
        {
        }

        protected void Application_End(object sender, EventArgs e)
        {
        }
    }
}