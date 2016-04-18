using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    //We should use fulltext index instead, but this will probably be fast enough if the number of users is not too great.
    //Assumes number of users it will be around 800-1600. Caching must also be used, at least to cache result of all users before freetext is applied.

    internal class UserFreetextSearch
    {
        public static IEnumerable<IUser> Search(UserSearchParameters userSearchParameters, string freetext, int maxResult,  out int totalResult)
        {
            
            var users = UserParameterSearch.SearchReturnAll(userSearchParameters);

            if (!IsEmpty(freetext))
            {
                users = FilterWithFreetext(freetext, users);
            }

            totalResult = users.Count();

            var result = users
                .Take(maxResult)
                .ToList();

            return result;
        }

        private static IEnumerable<IUser> FilterWithFreetext(string freetext, IEnumerable<IUser> users)
        {
            var searchWords = SplitIntoSearchWords(freetext);
            users = users.Where(u => UserInfoContainsAllSearchWords(u, searchWords));
            return users;
        }

        private static bool IsEmpty(string freetext)
        {
            return freetext == null || freetext.Trim() == "";
        }

        private static IEnumerable<string> SplitIntoSearchWords(string freetext)
        {
            var searchWords = Regex.Split(freetext.Trim(), @"[\s,]+");
            return searchWords;
        }

        private static bool UserInfoContainsAllSearchWords(IUser user, IEnumerable<string> searchWords)
        {
            return searchWords.All(searchWord => UserInfoContainsWord(user, searchWord));
        }

        private static bool UserInfoContainsWord(IUser user, string searchWord)
        {
            return (
                ValueContainsText(user.EMail, searchWord) ||
                ValueContainsText(user.GivenName, searchWord) ||
                ValueContainsText(user.SurName, searchWord) ||
                ValueContainsText(user.GetTelephone(), searchWord) ||
                ValueContainsText(user.GetInitials(), searchWord)||
                ValueContainsText(user.GetTitle(), searchWord) ||
                ValueContainsText(user.GetMobile(), searchWord) ||
                ValueContainsText(user.GetProfessionNamesString(), searchWord) ||
                ValueContainsText(user.GetTasksNamesString(), searchWord) ||
                ValueContainsText(user.GetSpecialtyNamesString(), searchWord) ||
                ValueContainsText(user.GetServiceAreaNamesString(), searchWord) ||
                ValueContainsText(user.GetMoreAboutEducation(), searchWord) ||
                ValueContainsText(user.GetMoreAboutServiceAreas(), searchWord) ||
                ValueContainsText(user.GetPreviousWorkExperience(), searchWord)
            );
        }

        private static bool ValueContainsText(string value, string text)
        {
            if (value == null || value.Trim() == "")
                return false;

            return value.ToUpper().Contains(text.ToUpper());
        }
    }
}