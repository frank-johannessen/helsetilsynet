using System;
using EPiServer;

namespace Avenir.Templates.Units.Placeable
{
    public partial class ChangedPagesFront : UserControlBase
    {
        private string _query = string.Empty;

        public string DocType
        { get; set; }

        public int MaxNumber
        { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            int listCount = 3;
            if (MaxNumber != 0)
                listCount = MaxNumber;
            //if (!string.IsNullOrEmpty(DocType))
            //{
                _query = "kode:Htil"  + ";m:" + listCount;
            //}

        }

        protected string GetGoogleList()
        {
            if (_query != string.Empty)
                return Lib.GoogleFrontpage(_query);
            return string.Empty;
        }

    }
}