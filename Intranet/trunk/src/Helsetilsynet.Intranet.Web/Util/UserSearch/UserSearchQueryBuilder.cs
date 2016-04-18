using System.Collections.Generic;
using System.Linq;
using EPiServer.Common.Queries;
using EPiServer.Common.Sorting;
using EPiServer.Community;
using EPiServer.DataAbstraction;
using Relate.HelpersAndExtensions.ExtensionMethods;
using Relate.HelpersAndExtensions.HelsetilsynetSpecific;
using AttributeNames = MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods.AttributeNames;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    internal class UserSearchQueryBuilder
    {
        public static UserQuery BuildUserQuery(UserSearchParameters parameters)
        {
            var userQuery = new UserQuery();
            //parameters.Specialities = new List<string>() { "Anestesi", "Barn" };

            //parameters.County = "27";

            AddCriteria(userQuery, AttributeNames.Profession, parameters.Professions, LogicalOperator.Or);
            AddCriteria(userQuery, AttributeNames.Tasks, parameters.Tasks, LogicalOperator.Or);
            AddCriteria(userQuery, AttributeNames.Specialties, parameters.Specialities, LogicalOperator.Or);
            AddServiceAreaCriteria(userQuery, parameters.Services);
            AddDepartmentCriteria(parameters.Departments, userQuery);

            if(!string.IsNullOrWhiteSpace(parameters.County) && parameters.Departments.Count == 1)
               AddFylkesmannEmbeteCritera(userQuery, int.Parse(parameters.County));

            userQuery.SurName = new StringCriterion { WildCardType = WildCardType.Both };
            userQuery.OrderBy.Add(new CriterionSortOrderWithCollation(userQuery.SurName, SortingDirection.Ascending, new SqlServerCollation.SQL_Danish_Pref_CP1_CI_AS()));

            return userQuery;
        }

        public static UserQuery BuildEmptyUserQuery()
        {
            var emptyUserQuery = new UserQuery();
            
            emptyUserQuery.SurName = new StringCriterion { WildCardType = WildCardType.Both };
            emptyUserQuery.OrderBy.Add(new CriterionSortOrderWithCollation(
                emptyUserQuery.SurName, SortingDirection.Ascending, new SqlServerCollation.SQL_Danish_Pref_CP1_CI_AS()));
            
            return emptyUserQuery;
        }

        private static void AddFylkesmannEmbeteCritera(UserQuery userQuery, int county)
        {
                var fylkesEmbete = CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(county);
                if (fylkesEmbete != null)
                    userQuery[AttributeNames.FylkesmannsEmbete] = new GroupCriterion() { ID = new IntegerCriterion() { Value = fylkesEmbete.ID } };
        }

        private static void AddServiceAreaCriteria(UserQuery userQuery, IEnumerable<string> services)
        {
            if(services != null)
            {
                var serviceAreasList = new List<string>();
                foreach (var service in services)
                {
                    var cat = Category.Find(service);
                    if (cat != null)
                    {
                        serviceAreasList.Add(cat.ID.ToString());
                    }
                }
                AddCriteria(userQuery, AttributeNames.ServiceAreas, serviceAreasList, LogicalOperator.Or);
            }
        }

        private static void AddDepartmentCriteria(IEnumerable<string> departments, UserQuery userQuery)
        {
            if (IsNullOrEmpty(departments))
                return;
            if (departments.Count() == 1)
            {
                var group = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(departments.First());
                if (group != null && group.IsDepartmentGroup())
                {
                    userQuery[Relate.HelpersAndExtensions.Constants.AttributeNames.Department] = new GroupCriterion { ID = new IntegerCriterion { Value = group.ID }};
                }
            }

            else
            {
                var departmentCritGroup = new CriteriaGroup();
                foreach (var department in departments)
                {
                    var group = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(department);
                    if (group != null && group.IsDepartmentGroup())
                    {
                        var crit = userQuery[Relate.HelpersAndExtensions.Constants.AttributeNames.Department] = new GroupCriterion() { ID = new IntegerCriterion() { Value = group.ID } };
                        departmentCritGroup.AddCriterion(LogicalOperator.Or, crit);
                    }
                }
                userQuery.AddCriteriaGroup(departmentCritGroup);
            }
        }

        private static void AddCriteria(UserQuery userQuery, string attributeName, IEnumerable<string> values, LogicalOperator logicalOperator)
        {
            if (IsNullOrEmpty(values))
                return;

            if (values.Count() == 1)
                AddCriteriaSingleValue(userQuery, attributeName, values.First());
            else
                AddCriteriaMultiValue(userQuery, attributeName, values, logicalOperator);

        }

        private static void AddCriteriaMultiValue(UserQuery userQuery, string attributeName, IEnumerable<string> values, LogicalOperator logicalOperator)
        {
            var criteriaGroup = CreateCriteriaGroup(userQuery, attributeName, values, logicalOperator);
            userQuery.AddCriteriaGroup(criteriaGroup);
        }

        private static void AddCriteriaSingleValue(UserQuery userQuery, string attributeName, string value)
        {
            var criterion = new StringCriterion();
            criterion.Value = value;
            criterion.WildCardType = WildCardType.Both;
            userQuery[attributeName] = criterion;
        }

        private static CriteriaGroup CreateCriteriaGroup(UserQuery userQuery, string attributeName, IEnumerable<string> values, LogicalOperator logicalOperator)
        {
            var criteriaGroup = new CriteriaGroup();
            
            foreach (var value in values)
            {
                userQuery[attributeName] = new StringCriterion() { Value = value,  WildCardType = WildCardType.Both };
                criteriaGroup.AddCriterion(logicalOperator, userQuery[attributeName]);
            }
            return criteriaGroup;
        }

        private static bool IsNullOrEmpty<T>(IEnumerable<T> values)
        {
            return values == null || !values.Any();
        }
    }
}