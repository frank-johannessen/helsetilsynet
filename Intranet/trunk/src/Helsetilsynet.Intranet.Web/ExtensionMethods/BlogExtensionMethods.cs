using System;
using Castle.Components.DictionaryAdapter;
using EPiServer.Common;
using EPiServer.Common.Queries;
using EPiServer.Common.Sorting;
using EPiServer.Community.Blog;
using EPiServer.Community.Blog.Queries;

namespace MakingWaves.Helsetilsynet.Intranet.Web.ExtensionMethods
{
    public static class BlogExtensionMethods
    {
        public static EntryCollection GetNews(this Blog blog, int page, int pageSize, out int totalnews)
        {
            return BlogHandler.Instance.GetEntries(blog, EntryPublishState.Published, EntityStatus.Approved, page, pageSize, out totalnews,
                new EntrySortOrder(EntrySortField.Created, SortingDirection.Descending));
        }
        public static EntryCollection GetNewsWithQuery(this Blog blog, int page, int pageSize, out int totalnews)
        {
            var entryQuery = new EntryQuery
                                 {
                                     Blog = new BlogCriterion {ID = new IntegerCriterion {Value = blog.ID}},
                                     Created = new DateTimeCriterion()
                                 };
            entryQuery.OrderBy.Add(new CriterionSortOrder(entryQuery.Created, SortingDirection.Descending));
            
            var result = QueryHandler.Instance.GetQueryResult<Entry, EntryCollection>(entryQuery, TimeSpan.MinValue, page, pageSize, out totalnews);
            return result;
        }
    }
}