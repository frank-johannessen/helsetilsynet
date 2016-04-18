<%@ Page Language="c#" CodeBehind="FastUploadDialog.aspx.cs" AutoEventWireup="False"
    Inherits="MakingWaves.FastUpload.FastUpload.FastUploadDialog" MasterPageFile="Temp.Master" %>

<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" Assembly="EPiServer.UI" %>
<%@ Register TagPrefix="EPiServerScript" Namespace="EPiServer.ClientScript.WebControls"
    Assembly="EPiServer" %>
<%@ Register TagPrefix="EPiServerScript" Namespace="EPiServer.UI.ClientScript.WebControls"
    Assembly="EPiServer.UI" %>
<asp:Content ContentPlaceHolderID="HeaderContentRegion" runat="server">
    <script type="text/javascript">
        function GetUploadDir() {
            return '<%=Request.QueryString["tofolder"]%>';
        }
    </script>
    <script language="JavaScript" src="js/ee.js"> </script>

    <!-- Load Queue widget CSS and jQuery -->
    <style type="text/css">
        @import url(/FastUpload/js/jquery.plupload.queue/css/jquery.plupload.queue.css);
    </style>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"> </script>

    <!-- Third party script for BrowserPlus runtime (Google Gears included in Gears runtime now) -->
    <script type="text/javascript" src="http://bp.yahooapis.com/2.4.21/browserplus-min.js"> </script>

    <!-- Load plupload and all it's runtimes and finally the jQuery queue widget -->
    <script type="text/javascript" src="/FastUpload/js/plupload.full.js"> </script>
    <script type="text/javascript" src="/FastUpload/js/jquery.plupload.queue/jquery.plupload.queue.js"> </script>
    <script type="text/javascript">
    // <![CDATA[
        // Is run from startupscript in code behind
        function ToolButtonClick(returnValue) {
            EPi.GetDialog().Close(returnValue);
        }        
    // ]]>
    </script>
    <style type="text/css">
        .nosupport
        {
            padding: 20px;
        }
        .nosupport a
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="FullRegion" runat="server">
    <script type="text/javascript">
        // Convert divs to queue widgets when the DOM is ready
        $(function () {
            $(function () {
                $("#uploader").pluploadQueue({
                    // General settings
                    runtimes: 'html5, flash, silverlight, gears, browserplus',
                    url: '/FastUpload/FastUploadService.ashx?toDirectory=' + GetUploadDir(),
                    max_file_size: '60mb',
                    chunk_size: '1mb',
                    unique_names: true,

                    flash_swf_url: '/FastUpload/js/plupload.flash.swf',
                    silverlight_xap_url: '/FastUpload/js/plupload.silverlight.xap',

                    // PreInit events, bound before any internal events
                    preinit: {
                        UploadFile: function (up, file) {
                            //alert('String upload of file: ' + file.name);
                            if (up.runtime == 'html5') { $.post("/FastUpload/FastUploadService.ashx", { fileName: file.name }); }
                        }
                    },

                    // Post init events, bound after the internal events
                    init: {
                        // Fires when a file has finished uploading
                        FileUploaded: function (up, file, info) {
                            ee(info);
                            // If last file is done uploading
                            if (up.total.uploaded == up.files.length) {

                            }
                        },
                        // Fires when a error has occured
                        Error: function (up, args) {
                            //alert("ERROR!!!");
                            //alert(args);
                        }
                    }
                });
            });
        });
            
    </script>
    <div id="uploadArea">
        <form method="post" action="FastUploadService.ashx">
        <div id='uploader'>
            <div class="nosupport">
                <h1>
                    Your browser can't upload multiple files.</h1>
                <br />
                Use <a href="https://www.google.com/chrome">Google Chrome</a> or <a href="http://www.mozilla.org/en-US/firefox/new/">
                    Firefox</a> to allow for multiple file uploads and drag and drop support using
                HTML5.
                <br />
                <br />
                As an alternative you can also <a href="http://get.adobe.com/flashplayer/">download
                    and install Flash</a> in your current browser to enable multiple file uploads,
                but his will not give you drag and drop support.
            </div>
        </div>
        </form>
        <div class="FMB-DialogContent">
            <div class="epitoolbuttonrowrightaligned">
                <EPiServerUI:ToolButton ID="InsertButton" OnClientClick="ToolButtonClick({closeAction:'cancel', items:null})"
                    GeneratesPostBack="false" SkinID="Save" Text="<%$ Resources: EPiServer, button.ok %>"
                    ToolTip="<%$ Resources: EPiServer, button.ok %>" runat="server" />
            </div>
        </div>
    </div>
    <div id="pzl"><div id="puzzle" /></div>
</asp:Content>
