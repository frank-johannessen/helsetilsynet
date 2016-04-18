using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Avenir;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace Helsetilsynet.templates.Modules
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName = "ListboksUndersokelsessaker")]
    public class UndersokelsessakerSelectList : PropertyString
    {

        public override IPropertyControl CreatePropertyControl()
        {
            return new ListboksUndersokelsessakerControl();
        }

    }

    public class ListboksUndersokelsessakerControl : EPiServer.Web.PropertyControls.PropertyStringControl
    {
        public override void ApplyEditChanges()
        {
            SetValue(Hidden.Text);
        }

        public ListboksUndersokelsessakerControl()
        {
            Hidden = new TextBox();
        }

        public TextBox Hidden { get; set; }

        //public  void CreateEditControls(string renderType, System.Web.UI.Control container)
        public override void CreateEditControls()
        {
            System.Web.UI.Control container = this;

            Hidden.ID = Name;
            Hidden.Text = ToString();
            Hidden.Attributes.Add("style", "visibility:hidden; height:0px; width:0px");

            ListBox input = new ListBox();

            input.ID = "UndersokelsessakerList";
            input.Height = 200;
            input.SelectionMode = ListSelectionMode.Multiple;

            Lib.GetCodeList("Undersokelsessaker", ref input);
            //DataFactory factory = DataFactory.Instance; // Global.EPDataFactory;
            //PageReference pr = PageReference.StartPage; // new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnStartPage"]);
            //string ReaksjonstypeList = factory.GetPage(pr).Property["Reaksjonstype"].ToString();

            //string[] ArrayReaksjonstypeList = ReaksjonstypeList.Split(',');

            //input.Items.Add(new ListItem("(None)", ""));
            //foreach (string K in ArrayReaksjonstypeList)
            //{
            //        input.Items.Add(new ListItem(K.ToString(), K.ToString()));
            //}

            input.Attributes["onchange"] = "JavaScript:GetUValue()";


            container.Controls.Add(input);
            container.Controls.Add(Hidden);

            Literal containercode = new Literal();

            containercode.Text = "<SCRIPT>hiddenUid='" + Hidden.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>selectUid='" + input.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>valueUstring='" + ToString() + "';</SCRIPT>";


            StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\Undersokelsessakerlist.inc");

            containercode.Text += din.ReadToEnd();
            din.Close();

            container.Controls.Add(containercode);
        }
    }
}
