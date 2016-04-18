using System.Web.UI;
using System.Web.UI.WebControls.WebParts;
using EPiServer.Core;
using EPiServer.Editor;
using EPiCode.WebParts;
using System.IO;
using System;

namespace Helsetilsynet.templates.Avenir.Webparts.Units
{
    public partial class LongStringWebPart :  EPiCode.WebParts.UserControlWebPartBase // PropertyDataWebPartBase
    {
        [Obsolete]
        public override string Title
        {
            get { return "Fritekst boks"; }
            set { }
        }

        [Personalizable]
        [WebBrowsable]
        [WebDisplayName("Title")]
        [PropertyDataLanguage(
           "/webparts/parts/pagelist/listtitlelabel",
           "/webparts/parts/pagelist/listtitledesc")]
        public PropertyString Heading { get; set; }

        //[Personalizable]
        //[WebDisplayName("Vis fokusbilde")]
        //public PropertyBoolean ShowImg { get; set; }



        [IsRequired, Personalizable]
        [PropertyDataLanguage("/webparts/parts/longstring/editorlabel", "/webparts/parts/longstring/editordesc")]
        public PropertyLongString LongString { get; set; }

        public LongStringWebPart()
        {
            LongString = new PropertyLongString() { EditorToolOptions = EditorToolOption.All ^ EditorToolOption.Font ^ EditorToolOption.DynamicContent };
        }


        protected string getHtml()
        {
            using (StringWriter stringWriter = new StringWriter())
            {
                XhtmlTextWriter writer = new XhtmlTextWriter(stringWriter);
                // Render LongString
                if (LongString != null && LongString.IsNull == false)
                {
                    bool vis = false;
                    //if (ShowImg != null && ShowImg.Boolean == true && (bool)ShowImg.Value == true) vis = true;
                    if (vis)
                    {
                        writer.AddAttribute(HtmlTextWriterAttribute.Class, "box focusBox");
                        writer.RenderBeginTag(HtmlTextWriterTag.Div);
                        writer.Write("<img class=\"focusTopImageLeft\"  src=\"" +
                                     ResolveUrl("~/Templates/Avenir/images/focusInspect2.jpg") + "\" alt=\"\" />");
                    }
                    else
                    {
                        writer.AddAttribute(HtmlTextWriterAttribute.Class, "box");
                        writer.RenderBeginTag(HtmlTextWriterTag.Div);
                    }
                    if (Heading != null && Heading.IsNull == false)
                    {
                        writer.RenderBeginTag(HtmlTextWriterTag.H2);
                        writer.Write(Heading.ToWebString());
                        writer.RenderEndTag(); //H2
                    }
                    writer.AddAttribute(HtmlTextWriterAttribute.Class, "clearBoth");
                    writer.RenderBeginTag(HtmlTextWriterTag.Div);
                    writer.Write(LongString.ToString());
                    writer.RenderEndTag();
                    writer.RenderEndTag();
                }
                return writer.InnerWriter.ToString();
            }
        }
    }
}