using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer;
using EPiServer.Core;
using Helsetilsynet.templates.Avenir.Classes.PropertyMappings;
using Helsetilsynet.templates.Avenir.Util;

namespace Avenir.WebControls
{
    [ToolboxData("<{0}:UlCheckBoxList runat=server></{0}:UlCheckBoxList>")]

    public class UlCheckBoxList : CheckBoxList
    {

        [DefaultValue(null)]
        public string[] Groups
        {
            get { return (string[])ViewState["Groups"]; }
            set { ViewState["Groups"] = value; }
        }

        private List<string> _hiddenHeadersInMobile;

        public List<string> HiddenHeadersInMobile
        {
            get
            {
                if (_hiddenHeadersInMobile == null)
                {
                    _hiddenHeadersInMobile = new List<string>();
                    var hiddenHeadersProperty =
                        PropertyHelper.GetPropertyValue<string>(MobilePropertyMappings.SearchHiddenLists,
                                                                DataFactory.Instance.GetPage(PageReference.StartPage));
                    if (!string.IsNullOrEmpty(hiddenHeadersProperty))
                        _hiddenHeadersInMobile.AddRange(hiddenHeadersProperty.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
                }

                return _hiddenHeadersInMobile;
            }
        }

        protected override void Render(HtmlTextWriter writer)
        {
            string input = "<input id=\"{0}\" name=\"{1}\" type=\"checkbox\" value=\"{2}\"{3}{4} />";
            string label = "<label for=\"{0}\">{1}</label>";
            for (int index = 0; index < Items.Count; index++)
            {

                writer.Indent++;

                if (Groups != null)
                    GroupHeader(writer, index);
                writer.Indent++;
                writer.Indent++;
                bool enabled = Items[index].Enabled;
                if (!enabled)
                    writer.WriteLine("<span disabled=\"disabled\">");
                writer.Indent++;
                writer.WriteLine(input, base.ClientID + "_" + index, base.ClientID.Replace('_', '$') + "$" + index, Items[index].Value, (Items[index].Selected ? " checked" : ""), (enabled ? "" : "disabled=\"disabled\""));
                writer.WriteLine(label, base.ClientID + "_" + index, Items[index].Text);
                writer.WriteLine("</br>");
                writer.Indent--;
                if (!enabled)
                    writer.WriteLine("</span>");
                writer.Indent--;
                if (Groups != null)
                    GroupFooter(writer, index);

                writer.WriteLine();
                writer.Indent--;
                writer.Indent--;
            }
        }


        private void GroupHeader(HtmlTextWriter writer, int index)
        {
            if (Groups.Length < index + 1)
                return;
            if (string.IsNullOrEmpty(Groups[index]))
                return;
            string header = Groups[index];
            writer.Indent++;
            writer.Indent++;

            var divToWrite = HiddenHeadersInMobile.Contains(Groups[index])
                                 ? "<div class=\"mobile-hide\"> <!-- wrapper -->"
                                 : "<div> <!-- wrapper --> ";

            writer.WriteLine(divToWrite);

            writer.Indent++;
            writer.WriteLine("<h4 class=\"accordion-header\">" + header + "<span  class=\"icon-arrow-right\"></h4>");
            writer.Indent--;
            writer.WriteLine();
            writer.Indent--;
            writer.Indent--;
            writer.WriteLine("<div class=\"accordion-tab-content\">");
        }

        private void GroupFooter(HtmlTextWriter writer, int index)
        {
            if (Groups.Length == index + 1 || Groups[index + 1] != null)
            {
                writer.WriteLine("</div> <!-- end content -->");
                writer.WriteLine("</div> <!-- end wrapper -->");
            }

        }
    }
}
