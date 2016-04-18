using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using EPiServer.Core;
using EPiServer.DataAbstraction;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class CategoryMethods
    {
        public static IEnumerable<string> CategoryNames(this PageData pageData)
        {
            return from cat in pageData.Category
                   let category = Category.Find(cat)
                   select category.Name;
        }
        
        public static IEnumerable<Category> GetList(this CategoryList categoryList)
        {
            return from cat in categoryList
                   let category = Category.Find(cat)
                   select category;
        }

        public static string GetClassName(this Category category)
        {
            if (category == null)
                return string.Empty;

            var appSetting = ConfigurationManager.AppSettings[GlobalName.AppSettings.CategoryClassNames];
            if (string.IsNullOrEmpty(appSetting))
                return string.Empty;

            var keyValuePairs = appSetting.Split(',');
            foreach(var pair in keyValuePairs)
            {
                var keyValue = pair.Split('=');
                if (keyValue.Length != 2)
                    return string.Empty;

                if (keyValue[0] == string.Format("cat{0}", category.ID))
                    return keyValue[1];
            }

            return string.Empty;
        }
        
        public static IEnumerable<string> GetCategoryClasses(this PageData currentPage)
        {
            return currentPage.Category.Select(cat => Category.Find(cat).GetClassName());
        }
    }
}