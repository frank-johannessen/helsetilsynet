using System.Collections.Generic;
using System.Linq;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    internal class UserSearchParameters
    {
        //TODO: Update UserSearchParameterReader
        public IList<int> DepartmentIDs { get; set; } 

        //TODO: Replace this with DepartmentIDs
        public IList<string> Departments { get; set; }

        public IList<string> Services { get; set; }

        public IList<string> Professions { get; set; }

        public string County { get; set; }
        
        public IList<string> Tasks { get; set; }

        public IList<string> Specialities { get; set; }
        
        public bool IsEmpty()
        {
            return 
                IsEmpty(Departments) &&
                IsEmpty(Services) &&
                IsEmpty(Professions) &&
                IsEmpty(County) &&
                IsEmpty(Tasks) &&
                IsEmpty(Specialities) 
                ;
        }

        public bool IsNotEmpty()
        {
            return !IsEmpty();
        }

        private bool IsEmpty(IEnumerable<string> list)
        {
            return list == null || !list.Any();
        }
        private bool IsEmpty(string str)
        {
            return str == null || str.Trim() == "";
        }
    }
}