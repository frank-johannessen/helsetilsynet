using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using OpenWaves.ActivityFeed;
using OpenWaves.ActivityFeed.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ActivityFeed
{
    public class MyUserGroupMembershipProvider : IUserGroupMembershipProvider
    {
        public IEnumerable<UserGroup> UserGroups
        {
            get
            {
                if (HttpContext.Current == null)
                    return null;
                var user = HttpContext.Current.User.Identity;
                var iuser = SecurityHandler.Instance.GetUserByUserName(user.Name);

                return GetGroups(iuser.IsC1FrontPage());
            }
        }

        public static IEnumerable<UserGroup>  GetGroups(bool c1Only)
        {
            return c1Only ? new[] {C1Group} : Enumerable.Empty<UserGroup>();

        }

        public static UserGroup C1Group
        {
            get { return new UserGroup("C1Group"); }
        }
    }
}