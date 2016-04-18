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
using Avenir;
using EPiServer.Core;
using System.Web.UI.WebControls;
using System.IO;
using EPiServer.PlugIn;

namespace Avenir
{
    [Serializable]
    [PageDefinitionTypePlugIn(DisplayName="ListboksTjenesteomrade")]
	public class ListboksTjenesteomrade : PropertyString
	{
        public override IPropertyControl CreatePropertyControl()
        {
            return new ListboksTjenesteomradeControl();
        }

	}



    public class ListboksTjenesteomradeControl: EPiServer.Web.PropertyControls.PropertyStringControl
    {
        public override void ApplyEditChanges()
        {
            SetValue(Hidden.Text);
        }

        public ListboksTjenesteomradeControl()
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

            input.ID = "TjenesteomradeList";
            input.Height = 200;
            input.SelectionMode = ListSelectionMode.Multiple;

            Lib.GetCodeList("Tjenesteomraade", ref input);
            //DataFactory factory = DataFactory.Instance; // Global.EPDataFactory;
            //PageReference pr = PageReference.StartPage; // new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnStartPage"]);
            //string TjenesteomradeList = factory.GetPage(pr).Property["Tjenesteomraade"].ToString();

            //string[] ArrayTjenesteomradeList = TjenesteomradeList.Split(',');

            //input.Items.Add(new ListItem("(None)", ""));
            //foreach (string K in ArrayTjenesteomradeList)
            //{
            //        input.Items.Add(new ListItem(K.ToString(), K.ToString()));
            //}

            input.Attributes["onchange"] = "JavaScript:GetOValue()";


            container.Controls.Add(input);
            container.Controls.Add(Hidden);

            Literal containercode = new Literal();

            containercode.Text = "<SCRIPT>hiddenOid='" + Hidden.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>selectOid='" + input.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>valueOstring='" + ToString() + "';</SCRIPT>";


            StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\Tjenesteomradelist.inc");

            containercode.Text += din.ReadToEnd(); din.Close();

            container.Controls.Add(containercode);
        }    
    }

}
