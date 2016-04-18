using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Common;
using EPiServer.Common.Queries;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using Relate.HelpersAndExtensions.Constants;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    internal class UserParameterSearch
    {
        public static IEnumerable<IUser> Search(UserSearchParameters userSearchParameters, int maxResult, out int totalResult)
        {
            if (userSearchParameters.IsEmpty())
            {
                return GetAllUsers(maxResult, out totalResult);
            }

            var userQuery = UserSearchQueryBuilder.BuildUserQuery(userSearchParameters);

            return Search(userQuery, maxResult, out totalResult);
        }

        private static void AddCommunityMemberCriteria(UserQuery userQuery)
        {
            var communityMembersGroup = SecurityHandler.Instance.GetGroupByName(RelateConstants.CommunityMembersGroupName);
            if (communityMembersGroup != null)
            {
                userQuery.Groups = new GroupCollectionCriterion();
                userQuery.Groups.Containing = new GroupCriterion();
                userQuery.Groups.Containing.ID = new IntegerCriterion() {Value = communityMembersGroup.ID};
            }
            
        }

        public static IEnumerable<IUser> SearchReturnAll(UserSearchParameters userSearchParameters)
        {
            int totalResult;
            return Search(userSearchParameters, int.MaxValue, out totalResult);
        }

        private static IEnumerable<IUser> Search(UserQuery userQuery, int maxResult, out int totalResult)
        {
            AddCommunityMemberCriteria(userQuery);
            var searchResult = QueryHandler.Instance.GetQueryResult<IUser, UserCollection>(userQuery, new TimeSpan(0,0,1,0) ,1, maxResult, out totalResult).Where(u =>                                      u.Status != EntityStatus.Removed);
            
            return searchResult;
        }
        
        private static IEnumerable<IUser> GetAllUsers(int maxResult, out int totalResult)
        {
            return Search(UserSearchQueryBuilder.BuildEmptyUserQuery(), maxResult, out totalResult);
        }
    }


}