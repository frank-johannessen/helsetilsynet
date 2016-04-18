using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EPiServer.Core;
using EPiServer.Web.PropertyControls;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.FolderBrowserProperty
{
    public class PropertyFolderBrowserControl : PropertyTextBoxControlBase
    {
        private const string OPEN_FOLDER_BROWSER_JS_KEY = "OpenFolderBrowserScript";
        private const string OPEN_FOLDER_BROWSER_JS_FUNCTION_NAME = "OpenFolderBrowser";
        private const string OPEN_FOLDER_SELECTION_CLEARJS_FUNCTION_NAME = "ClearFolderBrowserPath";

        public PropertyFolderBrowser PropertyFolderBrowser
        {
            get { return PropertyData as PropertyFolderBrowser; }
        }


        public override TableRowLayout RowLayout
        {
            get { return TableRowLayout.Default; }
        }

        #region protected override void SetupEditControls()

        protected override void SetupEditControls()
        {
            base.SetupEditControls();

            var button = new HtmlInputButton {Value = "...",};
            button.Attributes.Add("class", "epismallbutton");
            button.Attributes.Add("onclick", string.Format("{0}('{1}');", OPEN_FOLDER_BROWSER_JS_FUNCTION_NAME, EditControl.ClientID));

            var clearLink = new HyperLink
                                {
                                    NavigateUrl = "#",
                                    Text = "Clear Links"
                                };
            clearLink.Style.Add(HtmlTextWriterStyle.Color, "#888");
            clearLink.Attributes.Add("onclick", string.Format("return {0}('{1}');", OPEN_FOLDER_SELECTION_CLEARJS_FUNCTION_NAME, EditControl.ClientID));

            Controls.Add(button);
            Controls.Add(new LiteralControl("&nbsp;"));
            Controls.Add(clearLink);

            GenerateClientScript();
        }

        #endregion

        #region (private) Generate Client Script

        /// <summary>
        /// Responsible for generating the client script and add it to the page
        /// </summary>
        private void GenerateClientScript()
        {
            // build the url of the dialog page.
            string selectionEditorUrl =
                string.Format("{0}CustomProperties/FolderBrowserProperty/FolderBrowserDialog.aspx", ResolveUrl("/"));

            string scriptString =
                @"
	            <script type='text/javascript'>
	            <!--
	
	                function " +
                OPEN_FOLDER_BROWSER_JS_FUNCTION_NAME + @"(statusTextboxId){
	
	                    var url = '" +
                selectionEditorUrl + @"';
	                    var callbackMethod = " +
                OPEN_FOLDER_BROWSER_JS_FUNCTION_NAME +
                @"DialogCallBack;
	                    var callbackArguments = new Object();
	                    callbackArguments.statusTextboxId = statusTextboxId;
	                   
	                    EPi.CreateDialog(url, callbackMethod , callbackArguments, null, {width:400});
	                }
	
	                function " +
                OPEN_FOLDER_BROWSER_JS_FUNCTION_NAME +
                @"DialogCallBack(returnValue, callbackArguments){
	                    if(returnValue != null){
	                        var statusTextboxCtrl = document.getElementById(callbackArguments.statusTextboxId);
	
	                        if (returnValue.isOk == true){
	                            statusTextboxCtrl.value = returnValue.Path;
	                            statusTextboxCtrl.fireEvent('onchange');
	                        }
	                        else if (returnValue.isClear == true){
	                            statusTextboxCtrl.value = '';
	                            statusTextboxCtrl.fireEvent('onchange');
	                        }
	                    }
	                }
	
	                function " +
                OPEN_FOLDER_SELECTION_CLEARJS_FUNCTION_NAME +
                @"(statusTextboxId){
	                    var doClear = confirm('" +
                "Confirm" +
                @"');
	                    if (doClear)
	                    {
	                        var statusTextboxCtrl = document.getElementById(statusTextboxId);
	                        statusTextboxCtrl.value = '';
	                        statusTextboxCtrl.fireEvent('onchange');
	                    }
	                    return false;
	                }
	
	                //-->
	                </script>
	                ";

            // register the javascript on the page.
            if (!Page.ClientScript.IsStartupScriptRegistered(GetType(), OPEN_FOLDER_BROWSER_JS_KEY))
                Page.ClientScript.RegisterStartupScript(GetType(), OPEN_FOLDER_BROWSER_JS_KEY, scriptString);
        }

        #endregion
    }
}