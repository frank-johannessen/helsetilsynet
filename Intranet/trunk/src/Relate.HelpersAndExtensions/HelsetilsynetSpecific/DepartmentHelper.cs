using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EPiServer.Common.Security;
using EPiServer.Community;
using Relate.HelpersAndExtensions.Constants;
using Relate.HelpersAndExtensions.ExtensionMethods;

namespace Relate.HelpersAndExtensions.HelsetilsynetSpecific
{
    public class DepartmentHelper
    {
        public static List<IGroup> GetAllDepartments()
        {
            var groups = CommunitySystem.CurrentContext.DefaultSecurity.GetGroups().Where(o => o.GetAttributeValue<bool>(AttributeNames.IsDepartmentGroup)).ToList();
            if(groups.Count != RelateTemplatePage<RelateGlobalSettings>.Departments.Count)
            {
                groups = GetOrCreateGroupsFromRelateSettings(RelateTemplatePage<RelateGlobalSettings>.Departments, AttributeNames.IsDepartmentGroup);
            }
            return groups;
        }
        
        public static List<IGroup> GetAllFylkesmannsEmbete()
        {
            var groups = CommunitySystem.CurrentContext.DefaultSecurity.GetGroups().Where(o => o.GetAttributeValue<bool>(AttributeNames.IsFylkesmannsEmbete)).ToList();
            if (groups.Count != RelateTemplatePage<RelateGlobalSettings>.FylkesmannsEmbete.Count)
            {
                groups = GetOrCreateGroupsFromRelateSettings(RelateTemplatePage<RelateGlobalSettings>.FylkesmannsEmbete, AttributeNames.IsFylkesmannsEmbete);
            }
            return groups;
        }
        /// <summary>
        /// This will try to get the department group for fylkesmennene, this group is made to make it easier to search for members in that group.
        /// </summary>
        /// <returns></returns>
        public static IGroup GetFylkesmannenDepartmentgroup()
        {
            var group = CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(RelateConstants.FylkesmenneneDepartmentGroup);
            return group != null && group.IsDepartmentGroup() ? group : null;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="groupsToCreate">List of the names to create groups for</param>
        /// <param name="boolAttributeSetToTrue">This is for setting an attribute in IGroup to show what kind of group it is (i.e. IsDepartmentGroup, IsFylkesmannsEmbete)</param>
        /// <returns></returns>
        private static List<IGroup> GetOrCreateGroupsFromRelateSettings(IEnumerable<string> groupsToCreate, string boolAttributeSetToTrue)
        {
            var groups = new List<IGroup>();
            if (groupsToCreate != null)
            {
                foreach (var item in groupsToCreate)
                {
                    var group = (IGroup)CommunitySystem.CurrentContext.DefaultSecurity.GetGroupByName(item);
                    if (group != null)
                        groups.Add(group);
                    else
                    {
                        var newGroup = (IGroup)CommunitySystem.CurrentContext.DefaultSecurity.AddGroup(new Group(item)).Clone();
                        newGroup.SetAttributeValue<bool>(boolAttributeSetToTrue, true);
                        CommunitySystem.CurrentContext.DefaultSecurity.UpdateGroup(newGroup);
                        groups.Add(newGroup);
                    }
                }
            }
            return groups;
        }

        public static IGroup GetDepartment(int did)
        {
            return CommunitySystem.CurrentContext.DefaultSecurity.GetGroup(did);
        }
    }
}
