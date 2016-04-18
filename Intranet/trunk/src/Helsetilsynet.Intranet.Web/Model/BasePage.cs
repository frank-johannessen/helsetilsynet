using System.Diagnostics;
using EPiServer;
using EPiServer.Core;
using PageTypeBuilder;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Model
{
    [DebuggerDisplay("PageType: {MyPageType}, PageName: {PageName}")]
    public abstract class BasePage : TypedPageData
    {
        public string LayoutClassName { get; set; }

        public GlobalSettings GlobalSettings
        {
            get
            {
                var frontPage = DataFactory.Instance.GetPage(PageReference.StartPage) as StartPage;
                if (frontPage == null)
                    return null;

                return DataFactory.Instance.GetPage(frontPage.GlobalSettingsReference) as GlobalSettings;
            }
        }

        public MegaMenuSettings MegaMenuSettings
        {
            get
            {
                var frontPage = DataFactory.Instance.GetPage(PageReference.StartPage) as StartPage;
                if (frontPage == null)
                    return null;

                return DataFactory.Instance.GetPage(frontPage.MegaMenuSettingsPage) as MegaMenuSettings;
            }
        }

        public string MyPageType
        {
            get
            {
                // GetType() returns something like the following: "Castle.Proxies.BoxDoubleQuoteProxy"
                return GetType().ToString().Replace("Castle.Proxies.", string.Empty).Replace("Proxy", string.Empty);
            }
        }

        [PageTypeProperty(
            EditCaption = "PublishCounter",
            DisplayInEditMode = false,
            DefaultValue = 0,
            Tab = typeof(Tabs.Advanced),
            Type = typeof (PropertyNumber)
            )]
        public virtual int? PublishCounter { get; set; }

        public bool IsNew
        {
            get { return !PublishCounter.HasValue || PublishCounter.Value == 0; }
        }

        public bool DisplayUpdate
        {
            get
            {
                var prop = Property["PageChangedOnPublish"];
                if (prop == null)
                    return false;

                bool changedOnPublish;
                bool.TryParse(prop.ToString(), out changedOnPublish);
                return changedOnPublish;
            }
        }
    }
}