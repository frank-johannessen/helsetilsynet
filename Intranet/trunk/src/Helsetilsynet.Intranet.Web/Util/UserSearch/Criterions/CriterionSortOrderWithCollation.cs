using System;
using EPiServer.Common.Queries;
using EPiServer.Common.Sorting;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util.UserSearch
{
    [Serializable]
    public class CriterionSortOrderWithCollation : CriterionSortOrder
    {
        private SqlServerCollation.ICollation collation;

        public CriterionSortOrderWithCollation(StringCriterion criterion, SortingDirection sortDirection, SqlServerCollation.ICollation collation) : base(criterion, sortDirection)
        {
            this.collation = collation;
        }

        protected override string GetDirectionString()
        {
            string sortingDirection;

            if (this.Direction == SortingDirection.Ascending)
                sortingDirection = "ASC";
            else if (this.Direction == SortingDirection.Descending)
                sortingDirection = "DESC";
            else
                throw new NotSupportedException("Invalid SortingDirection specified.");

            return string.Format("COLLATE {0} {1}", collation.Name, sortingDirection);
        }
    }

    public sealed class SqlServerCollation
    {
        public class SQL_Latin1_General_CP1_CI_AS : ICollation
        {
            public string Name { get { return "SQL_Latin1_General_CP1_CI_AS"; } }
        }

        public class SQL_Scandinavian_CP850_CI_AS : ICollation
        {
            public string Name { get { return "SQL_Scandinavian_CP850_CI_AS"; } }
        }

        public class SQL_Danish_Pref_CP1_CI_AS : ICollation
        {
            public string Name { get { return "SQL_Danish_Pref_CP1_CI_AS"; } }
        }

        public interface ICollation
        {
            string Name { get; }
        }
    }
}