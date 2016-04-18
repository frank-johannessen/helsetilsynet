using System.Linq;
using EPiServer.Common;
using EPiServer.Common.Security;
using EPiServer.Community;
using EPiServer.Community.Club;
using EPiServer.Community.Modules;
using EPiServer.Community.MyPage;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.RelateSpecificListeners
{
    [EPiServer.Common.Modules.ModuleDependency(typeof(ClubModule), typeof(MyPageModule))]
    
    public class RelateListenersAndHandlers : IModule
    {
        public void OnApplicationStart(CommunityContext context)
        {
            ClubHandler.Instance.ClubRemoved += new EPiServer.Common.EPiServerCommonEventHandler(ClubHandler_ClubRemoved);
            CommunitySystem.CurrentContext.DefaultSecurity.RemovedUser += new RemoveUserEventHandler(DefaultSecurity_RemovedUser);
        }

        private void DefaultSecurity_RemovedUser(ISecurityHandler sender, IRemoveUserEventArgs args)
        {
            var bookmarks = args.User.GetBookmarks().ToList();
            foreach (var bookmarkLink in bookmarks)
            {
                args.User.RemoveBookmark(bookmarkLink);
            }
        }

        private void ClubHandler_ClubRemoved(string sender, EPiServerCommonEventArgs e)
        {
            var club = e.Object as Club;
            if(club == null)
                return;

            var bookmarks = club.GetBookmarks().ToList();
            foreach (var bookmarkLink in bookmarks)
            {
                club.RemoveBookmark(bookmarkLink);
            }
        }

        public string AdministrationControl
        {
            get { return ""; }
        }

        public string Name
        {
            get { return "RelateListenersAndHandlers"; }
        }

        public string UniqueName
        {
            get { return "RelateListenersAndHandlers"; }
        }
    }
}