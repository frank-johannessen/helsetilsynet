using System;
using EPiServer;

namespace Avenir.Templates.Units.Placeable
{
    public partial class GoogleShortList : UserControlBase
    {
        private string _query = string.Empty;

        public string DocType
        { get; set; }

        public string MenuGroup
        { get; set; }

        public int MaxNumber
        { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            int listCount = 3;
            if (MaxNumber != 0)
                listCount = MaxNumber;
            if (!string.IsNullOrEmpty(DocType))
            {
                _query = "dokumenttype:" + DocType + ";m:" + listCount;
            }
            if (!string.IsNullOrEmpty(MenuGroup))
            {
                _query = "menugroup:" + MenuGroup + ";m:" + listCount;
            }

        }

        protected string GetGoogleList()
        {
            if (_query != string.Empty)
                return Lib.GoogleShortSearch(_query);
            return string.Empty;
        }

    }
}