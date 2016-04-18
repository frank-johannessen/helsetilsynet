using System;
using System.Collections.Generic;
using EPiServer.Core;
using EPiServer.DataAbstraction;

namespace MakingWaves.Helsetilsynet.Util.GoogleMini
{
    /// <summary>
    /// Used for search results from <see cref="DocQuery"/>
    /// </summary>
    public struct ResultElement
    {
        public string Title { get; private set; }

        public string Description { get; private set; }

        public DateTime? Date { get; private set; }

        public string Url { get; private set; }

        public string MetaDescp { get; private set; }

        public string Pageid { get; private set; }

        public string Source { get; private set; }

        public string FileExtension { get; private set; }

        public string ImageUrl { get; private set; }

        public List<Category> CatIds { get; private set; }

        public ResultElement(string title, string description, DateTime? date, string url, string metaDescp,
                             string pageid, string source, string fileExtension, string imageUrl, string catIds)
            : this()
        {
            Title = title;
            Description = description;
            Date = date;
            Url = url;
            MetaDescp = metaDescp;
            Pageid = pageid;
            Source = source;
            FileExtension = fileExtension;
            ImageUrl = imageUrl;

            CatIds = GetCatIds(catIds);
        }

        private static List<Category> GetCatIds(string catIds)
        {
            var cats = new List<Category>();
            if (string.IsNullOrEmpty(catIds))
                return cats;

            foreach (var idString in catIds.Split(new[] {',', '-'}))
            {
                int id;
                if (!int.TryParse(idString, out id)) 
                    continue;

                var found = Category.Find(id);
                if (found != null)
                    cats.Add(found);
            }
            return cats;
        }
    }
}