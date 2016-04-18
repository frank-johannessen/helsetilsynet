/* Custem property example 
 * Installation guide:
 * 1. Add this file to your EPiServer project
 * 2. Compile the project (Important!)
 * 3. Open EPiServer admin mode
 * 4. Scroll to "Page types", select "Edit custom property types"
 * 5. Click the Create button
 * 6. Use the following settings:
 *        Basetype:        String
 *        Name:            Color
 *        Classname:        development.PropertyColor (remember the namespace)
 *        Assemblyname:    episerversample
 * 7. You can now use this custom property type on your pagetypes 
 */		

using System;
using EPiServer;
using EPiServer.Core;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Drawing;
using System.IO;
using EPiServer.PlugIn;
using EPiServer.Web.WebControls;

namespace Avenir
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName="ListboksVirksomhet")]
	public class ListboksVirksomhet : EPiServer.Core.PropertyString
	{
		public ListboksVirksomhet()
		{
        }

        public override IPropertyControl CreatePropertyControl()
        {
            return new ListboksVirksomhetControl();
        }

	}



    public class ListboksVirksomhetControl: EPiServer.Web.PropertyControls.PropertyStringControl
    {
        public override void ApplyEditChanges()
        {
            base.SetValue(hidden.Text);
        }

        TextBox _hidden = new TextBox();

        public TextBox hidden
        {
            get { return _hidden; }
            set { _hidden = value; }
        }

        //public  void CreateEditControls(string renderType, System.Web.UI.Control container)
        public override void CreateEditControls()
        {
            System.Web.UI.Control container = this;
            
            hidden.ID = Name;
            hidden.Text = ToString();
            hidden.Attributes.Add("style", "visibility:hidden; height:0px; width:0px");

            ListBox input = new ListBox();

            input.ID = "VirksomhetList";
            input.Height = 200;
            input.SelectionMode = ListSelectionMode.Multiple;

            Avenir.Lib.GetCodeList("Virksomhet", ref input);
            //DataFactory factory = DataFactory.Instance; // Global.EPDataFactory;
            //PageReference pr = PageReference.StartPage; // new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnStartPage"]);
            //string VirksomhetList = factory.GetPage(pr).Property["Virksomhet"].ToString();

            //string[] ArrayVirksomhetList = VirksomhetList.Split(',');

            //input.Items.Add(new ListItem("(None)", ""));
            //foreach (string K in ArrayVirksomhetList)
            //{
            //        input.Items.Add(new ListItem(K.ToString(), K.ToString()));
            //}

            input.Attributes["onchange"] = "JavaScript:GetVValue()";


            container.Controls.Add(input);
            container.Controls.Add(hidden);

            Literal containercode = new Literal();

            containercode.Text = "<SCRIPT>hiddenVid='" + hidden.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>selectVid='" + input.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>valueVstring='" + ToString() + "';</SCRIPT>";


            StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\Virksomhetlist.inc");

            containercode.Text += din.ReadToEnd(); din.Close();

            container.Controls.Add(containercode);
        }    
    }

}
