using System;
using EPiServer.Common.Queries;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using EPiServer.Community;
using EPiServer.Community.Club;
using Relate.HelpersAndExtensions.Constants;

namespace Relate.HelpersAndExtensions
{
    public static class PeopleHelper
    {
        public static UserCollection GetUsers(Club club, int selectedPage, int membersCount, out int totalItems)
        {
            var membersQuery = new UserQuery();

            if (club != null)
            {
                var clubAccessGroup = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(string.Format(RelateConstants.ClubGroupName, club.ID));
                membersQuery.Groups = new GroupCollectionCriterion();
                membersQuery.Groups.Containing = new GroupCriterion();
                membersQuery.Groups.Containing.ID = new IntegerCriterion();
                membersQuery.Groups.Containing.ID.Value = clubAccessGroup.ID;
            }
            membersQuery.SurName = new StringCriterion { WildCardType = WildCardType.Both };
            membersQuery.Status = new EntityStatusCriterion { Value = EPiServer.Common.EntityStatus.Approved };

            membersQuery.OrderBy.Add(new CriterionSortOrder(membersQuery.SurName, SortingDirection.Ascending));

            return QueryHandler.Instance.GetQueryResult<IUser, UserCollection>(membersQuery, TimeSpan.MinValue, selectedPage, membersCount, out totalItems);
        }

        public static IUser GetUserByUsernameThenEmail(string usernameOrEmail)
        {
            //Search user by username
            var user = CommunitySystem.CurrentContext.DefaultSecurity.GetUserByUserName(usernameOrEmail);

            if (user != null)
                return user;

            //If it's null - search for user by email (there may be more than one)
            var usersByEmail = CommunitySystem.CurrentContext.DefaultSecurity.GetUsersByEMail(usernameOrEmail);
            if (usersByEmail.Count == 0)
                return null;

            user = CommunitySystem.CurrentContext.DefaultSecurity.GetUsersByEMail(usernameOrEmail)[0];
            return user;
        }
    }
}
