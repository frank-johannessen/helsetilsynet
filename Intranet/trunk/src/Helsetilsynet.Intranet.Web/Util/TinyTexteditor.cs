using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using MakingWaves.Common.Web;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Util
{
    public class TinyTexteditor : System.Web.UI.WebControls.TextBox
    {
        // JIRA 43407-264
        // TODO: Check if it is OK to include the following as it is taken from the http://tinymce.moxiecode.com/punbb/viewtopic.php?id=8141 forum.
        // Should we just point people to the page on how to insert the editor.
        // To make images available to the editor you must???

        protected override void OnPreRender(EventArgs e)
        {
            string tinyMceIncludeKey = "TinyMCEInclude";
            //string tinyMceIncludeScript = "<script type=\"text/javascript\" src=\"../JavaScripts/tiny_mce/tiny_mce_gzip.js\"></script>";
            string tinyMceIncludeScript = "<script type=\"text/javascript\" src=\"/Templates/Scripts/tiny_mce/tiny_mce.js\"></script>";
            //string tinyMceIncludeScript = string.Format("<script type=\"text/javascript\" src=\"{0}\"></script>", Assets.JavaScript.GetUrl("tiny_mce/tiny_mce.js"));
            //string tinyMceIncludeScript = "<script type=\"text/javascript\" src=\"../JavaScripts/tiny_mce/tiny_mce.js\"></script>";

            if (!Page.ClientScript.IsStartupScriptRegistered(tinyMceIncludeKey))
                Page.ClientScript.RegisterStartupScript(this.GetType(), tinyMceIncludeKey, tinyMceIncludeScript);


            //string systemJSIncludeKey = "RelatePlusSystemJS";
            //string systemJSIncludeScript = "<script type=\"text/javascript\" src=\"~/Content/Scripts/SystemJS.aspx\"></script>";

            //if (!Page.ClientScript.IsStartupScriptRegistered(systemJSIncludeKey))
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), systemJSIncludeKey, systemJSIncludeScript);


            if (!Page.ClientScript.IsStartupScriptRegistered(GetInitKey()))
            {
//                string gZipInit =
//                    @"<script type='text/javascript'>
//                    tinyMCE_GZ.init({
//                        plugins : 'layer,table,advhr,advimage,epiphotobrowser,emotions,iespell,inlinepopups,insertdatetime,media,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist',
//                        themes : 'simple,advanced',
//                        theme_advanced_toolbar_location : 'top',
//                        theme_advanced_buttons1 : 'bold,italic,underline,strikethrough,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,formatselect,separator,bullist,numlist,outdent,indent',
//                        theme_advanced_buttons2 : 'undo,redo,separator,link,unlink,anchor,image,cleanup,code,separator,hr,removeformat,visualaid,separator,sub,sup,separator,charmap',
//                        theme_advanced_buttons3 : '',
//                        languages : 'en',
//                        disk_cache : true,
//                        debug : false
//                    });
//                    </script>
//                    ";
//                Page.ClientScript.RegisterStartupScript(this.GetType(), "tinyMCE_GZ.init", gZipInit);
                Page.ClientScript.RegisterStartupScript(this.GetType(), GetInitKey(), GetInitScript());
            }

            if (!CssClass.Contains(GetEditorClass())) //probably this is not the best way how to add the css class but I do not know any beter way
            {
                if (CssClass.Length > 0)
                {
                    CssClass += " ";
                }
                CssClass += GetEditorClass();
            }
            base.OnPreRender(e);
        }

        private string GetInitKey()
        {
            string simpleKey = "TinyMCESimple";
            string blogEntryKey = "TinyMCEBlogEntry";
            string fullKey = "TinyMCEFull";

            switch (Mode)
            {
                case TextEditorMode.Simple:
                    return simpleKey;
                case TextEditorMode.BlogEntry:
                    return blogEntryKey;
                case TextEditorMode.Full:
                    return fullKey;
                default:
                    goto case TextEditorMode.Simple;
            }
        }

        private string GetEditorClass()
        {
            return GetEditorClass(Mode);
        }

        private string GetEditorClass(TextEditorMode mode)
        {
            string simpleClass = "SimpleTextEditor";
            string fullClass = "FullTextEditor";

            switch (mode)
            {
                case TextEditorMode.Simple:
                    return simpleClass;
                case TextEditorMode.Full:
                    return fullClass;
                default:
                    goto case TextEditorMode.Simple;
            }
        }

        private string GetInitScript()
        {
            string simpleScript =
                @"<script language='javascript' type='text/javascript'>
                tinyMCE.init({{
                    mode : 'textareas',
                    theme : 'simple',
                    editor_selector : '{0}'
                }});
                </script>";

            string blogEntryScript =
                @"<script language='javascript' type='text/javascript'>
                tinyMCE.init({{
                    mode : 'textareas',
                    resize : true,
                    width : 425,
                    height : 300,
                    theme : 'advanced',
                    //language : 'nb_NO',
                    elements: 'absurls',
                    theme_advanced_toolbar_location : 'top',
                    relative_urls: false,
                    plugins : 'inlinepopups,paste',
                    theme_advanced_buttons1 : 'bold,italic,underline,separator,link,unlink,separator,bullist,numlist',
                    theme_advanced_buttons2 : '',
                    theme_advanced_buttons3 : '',
                    theme_advanced_toolbar_align : 'left',
                    editor_selector : '{0}',
//                    paste_preprocess : function(pl, o) {{
                      //example: keep bold,italic,underline and paragraphs
                      //o.content = strip_tags( o.content,'<b><u><i><p>' );

                      // remove all tags => plain text
                      //o.content = strip_tags( o.content,'<b><u><i><p><ul><ol><li><a>' );
  //                  }}
                }});
                </script>";

            string fullScript =
                @"<script language='javascript' type='text/javascript'>
                tinyMCE.init({{
                    mode : 'textareas',
                    theme : 'advanced',
                    elements: 'absurls',
                    theme_advanced_toolbar_location : 'top',
                    relative_urls: false,
                    plugins : 'layer,table,advhr,advimage,epiphotobrowser,emotions,iespell,inlinepopups,insertdatetime,media,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,advlist',
                    theme_advanced_buttons1 : 'bold,italic,underline,strikethrough,separator,justifyleft,justifycenter,justifyright,justifyfull,separator,formatselect,separator,bullist,numlist,outdent,indent',
                    theme_advanced_buttons2 : 'undo,redo,separator,link,unlink,anchor,image,cleanup,code,separator,hr,removeformat,visualaid,separator,sub,sup,separator,charmap',
                    theme_advanced_buttons3 : '',
                    editor_selector : '{0}'
                }});
                </script>";

            switch (Mode)
            {
                case TextEditorMode.Simple:
                    return string.Format(simpleScript, GetEditorClass(TextEditorMode.Simple));
                case TextEditorMode.BlogEntry:
                    return string.Format(blogEntryScript, GetEditorClass(TextEditorMode.BlogEntry));
                case TextEditorMode.Full:
                    return string.Format(fullScript, GetEditorClass(TextEditorMode.Full));
                default:
                    goto case TextEditorMode.Simple;
            }
        }

        public override TextBoxMode TextMode
        {
            get
            {
                return TextBoxMode.MultiLine;
            }
        }

        public TextEditorMode Mode
        {
            get
            {

                Object obj = ViewState["Mode"];
                if (obj == null)
                {
                    return TextEditorMode.Simple;
                }
                return (TextEditorMode)obj;
            }
            set
            {
                ViewState["Mode"] = value;
            }
        }

        public enum TextEditorMode
        {
            Simple,
            BlogEntry,
            Full
        }

    }
}