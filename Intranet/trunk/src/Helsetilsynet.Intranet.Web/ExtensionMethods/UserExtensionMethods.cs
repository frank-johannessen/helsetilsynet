using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Common;
using EPiServer.Common.Exceptions;
using EPiServer.Common.Security;
using EPiServer.Common.Sorting;
using EPiServer.Community.Contact;
using EPiServer.Community.MyPage;
using EPiServer.DataAbstraction;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class UserExtensionMethods
    {
        public static IUser GetUserFromUserName(this string userName)
        {
            return string.IsNullOrWhiteSpace(userName)
                       ? null
                       : SecurityHandler.Instance.GetUserByUserName(userName, EntityStatus.Approved);
        }
        public static bool IsFylkesmann(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<bool>(AttributeNames.IsFylkesmann);
            }
            catch (FrameworkException)
            {
                return false;
            }
        }

        /// <summary>
        /// For setting IsC1FrontPage
        /// </summary>
        /// <param name="user"></param>
        /// <param name="IsC1FrontPage">the value to set</param>
        public static void IsC1FrontPage(this IUser user, bool IsC1FrontPage)
        {
            try
            {
                user.SetAttributeValue<bool>(AttributeNames.IsC1FrontPage, IsC1FrontPage);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static bool IsC1FrontPage(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<bool>(AttributeNames.IsC1FrontPage);
            }
            catch (FrameworkException)
            {
                return false;
            }
        }

        /// <summary>
        /// For setting isfylkesmann
        /// </summary>
        /// <param name="user"></param>
        /// <param name="isFylkesmann">the value to set</param>
        public static void IsFylkesmann(this IUser user, bool isFylkesmann)
        {
            try
            {
                user.SetAttributeValue<bool>(AttributeNames.IsFylkesmann, isFylkesmann);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static List<Category> GetServiceAreas(this IUser user)
        {
            try
            {
                var propertyValue = user.GetAttributeValue<string>(AttributeNames.ServiceAreas);
                if(propertyValue != null)
                {
                    var spilt = propertyValue.Split(',');
                    return spilt.Where(id => id != string.Empty).Select(id => Category.Find(int.Parse(id))).Where(category => category != null).ToList();
                }
                return new List<Category>();
            }
            catch (FrameworkException)
            {
                return new List<Category>();
            }
        }

        public static void IsFirstTimeLogin(this IUser user, bool IsFirstTimeLogin)
        {
            try
            {
                user.SetAttributeValue<bool>(AttributeNames.IsFirstTimeLogin, IsFirstTimeLogin);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static bool IsFirstTimeLogin(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<bool>(AttributeNames.IsFirstTimeLogin);
            }
            catch (FrameworkException)
            {
                return false;
            }
        }

        public static string GetServiceAreaNamesString(this IUser user)
        {
            var returnValue = string.Empty;
            foreach (var serviceArea in user.GetServiceAreas())
            {
                if (returnValue != string.Empty)
                    returnValue += ",";
                returnValue += serviceArea.Name;
            }
            return returnValue;
        }
        public static void SetServiceAreas(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.ServiceAreas, data);
            }
            catch (FrameworkException)
            {

            }
        }
        public static List<string> GetSpecialties(this IUser user)
        {
            try
            {
                return GetListFromString(user.GetAttributeValue<string>(AttributeNames.Specialties));
            }
            catch (FrameworkException)
            {
                return new List<string>();
            }
        }
        public static string GetSpecialtyNamesString(this IUser user)
        {
            var returnValue = string.Empty;
            foreach (var specialty in user.GetSpecialties())
            {
                if (returnValue != string.Empty)
                    returnValue += ",";
                returnValue += specialty;
            }
            return returnValue;
        }
        public static void SetSpecialties(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Specialties, data);
            }
            catch (FrameworkException)
            {

            }
        }
        public static List<string> GetProfessions(this IUser user)
        {
            try
            {
                return GetListFromString(user.GetAttributeValue<string>(AttributeNames.Profession));
            }
            catch (FrameworkException)
            {
                return new List<string>();
            }
        }
        public static string GetProfessionNamesString(this IUser user)
        {
            var returnValue = string.Empty;
            foreach (var profession in user.GetProfessions())
            {
                if (returnValue != string.Empty)
                    returnValue += ",";
                returnValue += profession;
            }
            return returnValue;
        }
        public static void SetProfession(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Profession, data);
            }
            catch (FrameworkException)
            {

            }
        }
        public static List<string> GetTasks(this IUser user)
        {
            try
            {
                return GetListFromString(user.GetAttributeValue<string>(AttributeNames.Tasks));
            }
            catch (FrameworkException)
            {
                return new List<string>();
            }
        }
        public static string GetTasksNamesString(this IUser user)
        {
            var returnValue = string.Empty;
            foreach (var task in user.GetTasks())
            {
                if (returnValue != string.Empty)
                    returnValue += ",";
                returnValue += task;
            }
            return returnValue;
        }
        public static void SetTasks(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Tasks, data);
            }
            catch (FrameworkException)
            {

            }
        }

        public static IGroup GetFylkesmannsEmbete(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<IGroup>(AttributeNames.FylkesmannsEmbete);
            }
            catch (FrameworkException)
            {
                return null;
            }
        }

        public static void SetFylkesmannsEmbete(this IUser user, IGroup group)
        {
            try
            {
                user.SetAttributeValue<IGroup>(AttributeNames.FylkesmannsEmbete, group);
            }
            catch (FrameworkException)
            {

            }
        }

        public static void SetDepartment(this IUser user, IGroup department)
        {
            try
            {
                user.SetAttributeValue<IGroup>(Relate.HelpersAndExtensions.Constants.AttributeNames.Department, department);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static IGroup GetDepartment(this IUser user)
        {
            try
            {
                if (user.IsFylkesmann())
                    return null;
                return user.GetAttributeValue<IGroup>(Relate.HelpersAndExtensions.Constants.AttributeNames.Department);
            }
            catch (FrameworkException)
            {
                //Atr does not extist
                return null;
            }
        }
        public static string GetDepartmentName(this IUser user)
        {
            try
            {
                if (user.IsFylkesmann())
                    return user.GetFylkesmannDepartment();
                return
                    user.GetAttributeValue<IGroup>(Relate.HelpersAndExtensions.Constants.AttributeNames.Department) !=null ? 
                    user.GetAttributeValue<IGroup>(Relate.HelpersAndExtensions.Constants.AttributeNames.Department).Name : string.Empty;
            }
            catch (FrameworkException)
            {
                //Atr does not extist
                return null;
            }
        }
        public static void SetFylkesmannDepartment(this IUser user, string department)
        {
            try
            {
                user.SetAttributeValue<string>(Relate.HelpersAndExtensions.Constants.AttributeNames.FylkesmannDepartment, department);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static string GetFylkesmannDepartment(this IUser user)
        {
            try
            {
                if (!user.IsFylkesmann())
                    return string.Empty;
                return user.GetAttributeValue<string>(Relate.HelpersAndExtensions.Constants.AttributeNames.FylkesmannDepartment);
            }
            catch (FrameworkException)
            {
                //Atr does not extist
                return null;
            }
        }

        public static string GetRoomNumber(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.RoomNumber);
            }
            catch (Exception)
            {

                //Atr does not extist
                return null;
            }
        }

        public static void SetRoomNumber(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.RoomNumber, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static string GetInitials(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.Initials);
            }
            catch (Exception)
            {

                //Atr does not extist
                return null;
            }
        }

        public static void SetInitials(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.Initials, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static UserCollection GetContacts(this IUser user)
        {
            // The total number of items in the search
            int totalItems = 0;

            ContactRelationCollection contacts = new ContactRelationCollection();
            UserCollection myContacts = new UserCollection();

            contacts = ContactHandler.Instance.GetContacts(user,
                        Perspective.FromMe, EntityStatus.Approved, null,
                        1, 1000, out totalItems,
                        new ContactRelationSortOrder(ContactRelationSortField.ContactAlias, SortingDirection.Ascending));

            // Add the contact to the usercollection
            foreach (ContactRelation contact in contacts)
            {
                    myContacts.Add(contact.ContactUser);
            }
            return myContacts;
        }

        public static UserCollection GetContacts(this IUser user, int page, int pageSize)
        {
            // The total number of items in the search
            int totalItems = 0;

            ContactRelationCollection contacts = new ContactRelationCollection();
            UserCollection myContacts = new UserCollection();

            contacts = ContactHandler.Instance.GetContacts(user,
                        Perspective.FromMe, EntityStatus.Approved, null,
                        page, pageSize, out totalItems,
                        new ContactRelationSortOrder(ContactRelationSortField.ContactAlias, SortingDirection.Ascending));

            // Add the contact to the usercollection
            foreach (ContactRelation contact in contacts)
            {
                myContacts.Add(contact.ContactUser);
            }
            return myContacts;
        }

        public static void RemoveContact(this IUser user, IUser contactToRemove)
        {
            // Get the my page for the user
            var myPage = MyPageHandler.Instance.GetMyPage(user);

            // Get the actual contact between the users
            var relation = ContactHandler.Instance.GetContactRelation(myPage.Contact, contactToRemove);

            // Remove the realtion
            ContactHandler.Instance.RemoveContactRelation(relation);
        }

        public static void AddContact(this IUser user, IUser contactToAdd)
        {
            // Get the contact container for userA via my page.
            ContactContainer contactContainer = MyPageHandler.Instance.GetMyPage(user).Contact;

            var contactRelation = new ContactRelation(contactContainer, contactToAdd) {Status = EntityStatus.Approved};

            // Commit the contact relation to database.
            ContactHandler.Instance.AddContactRelation(contactRelation);
        }

        private static List<string> GetListFromString(string propertyValue)
        {
            var returnList = new List<string>();
            if (propertyValue != null)
            {
                var spilt = propertyValue.Split(',');
                returnList.AddRange(spilt.Where(s => !string.IsNullOrWhiteSpace(s)));
            }
            return returnList;
        }
        public static string GetMoreAboutEducation(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.MoreAboutEducation);
            }
            catch (Exception)
            {

                //Atr does not extist
                return null;
            }
        }
        public static void SetMoreAboutEducation(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.MoreAboutEducation, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static string GetMoreAboutServiceAreas(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.MoreAboutServiceAreas);
            }
            catch (Exception)
            {

                //Atr does not extist
                return null;
            }
        }
        public static void SetMoreAboutServiceAreas(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.MoreAboutServiceAreas, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
        public static string GetPreviousWorkExperience(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.PreviousWorkExperience);
            }
            catch (Exception)
            {

                //Atr does not extist
                return null;
            }
        }
        public static void SetPreviousWorkExperience(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.PreviousWorkExperience, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }

        public static List<string> GetExternalSystemsId(this IUser user)
        {
            try
            {
                var propertyValue = user.GetAttributeValue<string>(AttributeNames.ExternalSystems);
                if (propertyValue != null)
                {
                    return propertyValue.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).ToList();
                }
                return new List<string>();
            }
            catch (FrameworkException)
            {
                return new List<string>();
            }
        }
        public static void SetExternalSystems(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.ExternalSystems, data);
            }
            catch (FrameworkException)
            {

            }
        }

        public static List<string> GetActivityfeedTopics(this IUser user)
        {
            try
            {
                var propertyValue = user.GetAttributeValue<string>(AttributeNames.ActivityfeedTopics);
                if (propertyValue != null)
                {
                    return propertyValue.Split(',').Where(s => !string.IsNullOrWhiteSpace(s)).ToList();
                }
                return new List<string>();
            }
            catch (FrameworkException)
            {
                return new List<string>();
            }
        }

        public static void AddActivityfeedTopic(this IUser user, string topic)
        {
            var currentTopics = user.GetActivityfeedTopics();
            currentTopics.Add(topic);
            user.SetActivityfeedTopics(currentTopics);
        }

        public static void RemoveActivityfeedTopic(this IUser user, string topic)
        {
            var currentTopics = user.GetActivityfeedTopics();
            currentTopics.Remove(topic);
            user.SetActivityfeedTopics(currentTopics);
        }

        private static void SetActivityfeedTopics(this IUser user, IEnumerable<string> topics)
        {
            try
            {
                var stringToSave = topics.Aggregate(string.Empty, (current, t) => current + (t + ","));
                user.SetAttributeValue<string>(AttributeNames.ActivityfeedTopics, stringToSave);
            }
            catch (FrameworkException)
            {

            }
        }

        public static string GetHelsetilsynetRssFeed(this IUser user)
        {
            try
            {
                return user.GetAttributeValue<string>(AttributeNames.HelsetilsynetRssFeed);
            }
            catch (Exception)
            {
                //Atr does not extist
                return null;
            }
        }

        public static void SetHelsetilsynetRssFeed(this IUser user, string data)
        {
            try
            {
                user.SetAttributeValue<string>(AttributeNames.HelsetilsynetRssFeed, data);
            }
            catch (FrameworkException)
            {
                //Atr does not extist   
            }
        }
    }
}