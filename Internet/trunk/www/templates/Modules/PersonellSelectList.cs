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
    [PageDefinitionTypePlugIn(DisplayName="ListboksPersonell")]
	public class ListboksPersonell : PropertyString
	{
        public override IPropertyControl CreatePropertyControl()
        {
            return new ListboksPersonellControl();
        }

	}



    public class ListboksPersonellControl: EPiServer.Web.PropertyControls.PropertyStringControl
    {
        public override void ApplyEditChanges()
        {
            SetValue(Hidden.Text);
        }

        public ListboksPersonellControl()
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

            input.ID = "PersonellList";
            input.Height = 200;
            input.SelectionMode = ListSelectionMode.Multiple;


            Lib.GetCodeList("Personell", ref input);
            //DataFactory factory = DataFactory.Instance; // Global.EPDataFactory;
            //PageReference pr = PageReference.StartPage; // new PageReference(System.Configuration.ConfigurationManager.AppSettings["EPnStartPage"]);
            //string PersonellList = factory.GetPage(pr).Property["Personell"].ToString();

            //string[] ArrayPersonellList = PersonellList.Split(',');

            //input.Items.Add(new ListItem("(None)", ""));
            //foreach (string K in ArrayPersonellList)
            //{
            //        input.Items.Add(new ListItem(K.ToString(), K.ToString()));
            //}

            input.Attributes["onchange"] = "JavaScript:GetPValue()";


            container.Controls.Add(input);
            container.Controls.Add(Hidden);

            Literal containercode = new Literal();

            containercode.Text = "<SCRIPT>hiddenPid='" + Hidden.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>selectPid='" + input.ClientID + "';</SCRIPT>";
            containercode.Text += "<SCRIPT>valuePstring='" + ToString() + "';</SCRIPT>";


            StreamReader din = File.OpenText(EPiServer.Global.BaseDirectory + @"inc\\Personelllist.inc");

            containercode.Text += din.ReadToEnd(); din.Close();

            container.Controls.Add(containercode);
        }    
    }

}
