using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.Web.WebControls;
using EPiServer.SpecializedProperties;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer.Editor;

namespace Avenir.Templates.KB.Webparts.Units
{
    [Obsolete("Probably obsolete class")]
  public partial class PageSummaryWebPart : EPiCode.WebParts.UserControlWebPartBase
  {
    private static readonly log4net.ILog _log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

    #region Private Property Declarations
    // Example data
    private PropertyDate _myDate = new PropertyDate(DateTime.Now);
    // Holds url to image
    private PropertyImageUrl _imageUrl = new PropertyImageUrl();
    // Holds link when clicking on the image
    private PropertyUrl _imageClickUrl = new PropertyUrl();
    private PropertyLongString _introText;


    //private PropertyLongString _mainBody = new PropertyLongString();

    #endregion

    public PageSummaryWebPart()
    {
      this.Title = WebPartUtil.Translate("/webparts/parts/PageSummaryWebPart/title");
      this.Description = WebPartUtil.Translate("/webparts/parts/PageSummaryWebPart/description");

      _imageUrl.Name = "ImageUrl";


      _introText =  new PropertyLongString() { EditorToolOptions = EditorToolOption.All ^ EditorToolOption.Font ^ EditorToolOption.DynamicContent };
     _introText.Name = "IntroText";
    }



    #region Public Property
    /// <summary>
    /// Gets or sets the page link to a PageData.
    /// </summary>
    /// <value>The page link</value>
    [IsRequired, Personalizable]
    [PropertyDataLanguageAttribute("/webparts/parts/pagesummarywebpart/articlepagelinklabel", "/webparts/parts/pagesummarywebpart/articlepagelinkdesc")]
    public PropertyPageReference ArticlePageLink { get; set; }

    [Personalizable()]
    [PropertyDataLanguageAttribute(
        "/webparts/parts/PageSummaryWebPart/imageurllabel",
      "/webparts/parts/PageSummaryWebPart/imageurldesc")]
    public PropertyImageUrl ImageUrl
    {
      get
      {
        return _imageUrl;
      }
      set
      {
        _imageUrl = value;
        //SetDirty();
      }
    }


    [Personalizable()]
    [PropertyDataLanguageAttribute(
                "/webparts/parts/PageSummaryWebPart/IntroTextlabel",
                "/webparts/parts/PageSummaryWebPart/IntroTextdesc")]
    public PropertyLongString IntroText
    {
      get
      {
        return _introText;
      }
      set
      {
        _introText = value;
        //SetDirty();
      }
    }

    #endregion Public Property

    #region override
    public override string Title
    {
      get
      {
        return "Intro"; ;
      }
      set
      {

      }
    }
    protected override void OnLoad(EventArgs e)
    {
      base.OnLoad(e);
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);

    }
    #endregion

    protected string getIntroText()
    {
      if (IntroText != null && IntroText.Value != null)
        return IntroText.Value.ToString();
      return string.Empty;
    }

    protected string getImgUrl()
    {
      if (_imageUrl != null && _imageUrl.Value != null)
        return _imageUrl.Value.ToString();
      return string.Empty;
    }


      protected string getLinkUrl()
      {
#warning ????? is it working properly?
          if (_imageClickUrl != null && _imageClickUrl.Value != null)
              return _imageClickUrl.Value.ToString();
          return string.Empty;
      }
  }
}
