using System;
using System.IO;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Hosting;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using EPiServer.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.DelayedPublish
{
    [ScheduledPlugIn(DisplayName = "Publish delayed pages to newsfeed", Description = "This job published delayed published pages to the newsfeed on the frontpage")]
    public class PublishDelayedPagesToNewsFeed
    {
        public static string Execute()
        {
            if (HttpContext.Current == null)
            {
                PrincipalInfo.CurrentPrincipal = new GenericPrincipal(
                    new GenericIdentity("PublishDelayedPagesToNewsfeed"),
                    new[] { "Administrators" });


                //SimpleWorkerRequest request = new SimpleWorkerRequest("default.aspx", "", new StringWriter());//("/", @"C:\Helsetilsynet\src\Helsetilsynet.Intranet.Web", "default.aspx", null, new StringWriter()));
                //HttpContext context = new HttpContext(request);
                //context.User = PrincipalInfo.CurrentPrincipal;
                //HttpContext.Current = context;
            }
            
            var pages = DelayedPageManager.Instance.GetDelayedPages().ToList();
            var deletedCount = 0;
            foreach (var delayedPage in pages)
            {
                var page = delayedPage.PageReference.SafeGetPageData();
                if (page != null)
                {
                    if (page.StartPublish < DateTime.Now)
                    {
                        DataFactory.Instance.Save(page.CreateWritableClone(), EPiServer.DataAccess.SaveAction.Publish);
                        DelayedPageManager.Instance.RemoveDelayedPage(delayedPage);
                        deletedCount++;
                    }
                }
                else
                    DelayedPageManager.Instance.RemoveDelayedPage(delayedPage);
            }
            return "Job complete: Published pages = " + deletedCount;
        }
    }
}