using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using EPiServer.Common.Security;
using MakingWaves.Helsetilsynet.Intranet.Web.Templates.Units.Placeable;
using MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch;

namespace MakingWaves.Helsetilsynet.Intranet.Web.WebServices
{
    /// <summary>
    /// Search for users...
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class UserSearchService : WebService
    {
        /// <summary>
        /// Used to search for users. Renders result using the <see cref="UserContactInfo"/> user control.
        /// </summary>
        /// <param name="freetext">Freetext. Case-insentitive. Split into single words.</param>
        /// <param name="services">List of category ids, separated with comma</param>
        /// <param name="departments">List of department ids, separated with comma</param>
        /// <param name="county">Single county name</param>
        /// <param name="proffessions">List of profiess, separated with comma</param>
        /// <param name="specialities">List of nurse specialities, separated with comma</param>
        /// <param name="tasks">List of task names, separated with comma</param>
        /// <param name="maxResult">Max number of result>Maximum numer of results</param>
        /// <returns>Rendered html</returns>
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public string Search(string freetext, string services, string departments, string county, string proffessions, string tasks, string specialities, int maxResult)
        {
            var userSearchParameters = CreateSearchParameters(services, departments, county, proffessions, tasks, specialities);
            
            int totalResult;
            var users = UserSearch.Search(userSearchParameters, freetext, maxResult, out totalResult);

            var result = RenderUserContactInfoControl(users, totalResult);
            
            return result;
        }

        ///// <summary>
        ///// Used for auto-complete on user names. Returns full name of users matching search string.
        ///// </summary>
        ///// <param name="freetext"></param>
        ///// <param name="maxResult"></param>
        ///// <returns></returns>
        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        //public IList<string> SearchGetNames(string freetext, string services, string departments, string county, string proffessions, string tasks, string specialities, int maxResult)
        //{
        //    var userSearchParameters = CreateSearchParameters(services, departments, county, proffessions, tasks, specialities);

        //    int totalResult;
        //    var users = UserSearch.Search(userSearchParameters, freetext, maxResult, out totalResult);

        //    return users.Select(u => u.GetPresentationName()).ToList();

        //}

        private UserSearchParameters CreateSearchParameters(string services, string departments, string county,
                                                            string professions, string tasks, string specialities)
        {
            var userSearchParameters = new UserSearchParameters
                                           {
                                               Services = SplitString(services),
                                               Departments = SplitString(departments),
                                               County = county,
                                               Professions = GetProfessionsSplitString(professions),
                                               Tasks = SplitString(tasks),
                                               Specialities = SplitString(specialities)
                                           };
            return userSearchParameters;
        }

        private IList<string> GetProfessionsSplitString(string professions)
        {
            //for connecting other professions to the list of the other possible professions and search only in them.
            var professionsList = SplitString(professions);
            IList<string> retList = new List<string>(professionsList);
            foreach (var profession in professionsList)
            {
                bool isOtherProfession = profession.Contains("other");
                if(isOtherProfession)
                {
                    string otherProfession = profession.Replace("other", string.Empty); 
                    if(!string.IsNullOrWhiteSpace(otherProfession))
                    {
                        retList.Remove("Andre");
                        retList.Remove(profession);
                        retList.Add(otherProfession);
                    }
                        
                }
            }
            return retList;
        }

        private IList<string> SplitString(string str)
        {
            if(str == null || str.Trim() == "")
                return new List<string>();

            return str.Trim().Split(new[] { ',' }).ToList();
        }
    
        private static string RenderUserContactInfoControl(IEnumerable<IUser> users, int totalResult)
        {
            var stringWriter = new StringWriter();
            var htmlTextWriter = new HtmlTextWriter(stringWriter);

            var page = new Page();
            var userContactInfoControl = (UserContactInfo) page.LoadControl("~/Templates/Units/Placeable/UserContactInfo.ascx");
            page.Controls.Add(userContactInfoControl);
            userContactInfoControl.Users = users;
            userContactInfoControl.TotalResult = totalResult;
            userContactInfoControl.DataBind();
            userContactInfoControl.RenderControl(htmlTextWriter);

            string result = stringWriter.ToString();
            return result;
        }

    }
}

