using System.Collections.Generic;
using EPiServer.Common.Security;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    internal class UserSearch
    {
        public static IEnumerable<IUser> Search(UserSearchParameters userSearchParameters, string freetext, int maxResult, out int totalResult)
        {
            if (!string.IsNullOrWhiteSpace(freetext))
            {
                var result = UserFreetextSearch.Search(userSearchParameters, freetext, maxResult, out totalResult);
                return result;
            }

            var paramResult = UserParameterSearch.Search(userSearchParameters, maxResult, out totalResult);
            return paramResult;
        }
    }
}
