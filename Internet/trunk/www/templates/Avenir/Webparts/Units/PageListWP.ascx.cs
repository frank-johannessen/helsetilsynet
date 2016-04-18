using System;
using System.Web;
using System.Web.UI.WebControls.WebParts;
using EPiCode.WebParts;
using EPiServer;
using EPiServer.Core;
using EPiServer.Filters;

namespace Avenir.Templates.KB.Webparts.Units
{
  /// <summary>
  /// PageList with preview text webpart
  /// 
  /// </summary>
  [Obsolete("Probably obsolete class")]
  public partial class PageListWP : EPiCode.WebParts.UserControlWebPartBase
  {
    private PropertyPageReference _listingContainer = new PropertyPageReference();
    private PageData _containerPage;
    //private PropertyLongString _mainBody = new PropertyLongString();
    private PropertyString _moreText = new PropertyString();
    private PropertyString _listTitle = new PropertyString();
    private PropertyBoolean _showDate = new PropertyBoolean();
    private PropertyNumber _showNumberOfItems = new PropertyNumber();

    public PageListWP()
    {
      // The properties needs a name, or they won't save
      _listingContainer.Name = "ListingContainerProperty";
      //_mainBody.Name = "MainBodyProperty";
      //_mainBody.EditorToolOptions = EPiServer.Editor.EditorToolOption.All;
    }

    [Obsolete]
    public override string Title
    {
      get
      {
        return "Page List";
      }
      set
      {

      }
    }

    [Personalizable]
    [WebBrowsable]
    [WebDisplayName("List Title")]
    [PropertyDataLanguageAttribute(
       "/webparts/parts/pagelist/listtitlelabel",
       "/webparts/parts/pagelist/listtitledesc")]
    public PropertyString ListTitle
    {
      get
      {
        return _listTitle;
      }
      set
      {
        _listTitle = value;
        SetDirty();
      }
    }
    /// <summary>
    /// Gets or sets the page link to a PageData.
    /// </summary>
    /// <value>The page link</value>
    [Personalizable]
    [PropertyDataLanguageAttribute(
        "/webparts/parts/pagelist/articlepagelinklabel",
        "/webparts/parts/pagelist/articlepagelinkdesc")]
    public PropertyPageReference ListingContainer
    {
      get { return _listingContainer; }
      set
      {
        _listingContainer = value;
        SetDirty();
      }
    }

    /// <summary>
    /// Gets or sets the ShowDate.
    /// </summary>
    /// <value>The page link</value>
    [Personalizable]
    [PropertyDataLanguageAttribute(
        "/webparts/parts/pagelist/showdate",
        "/webparts/parts/pagelist/showdatedesc")]
    public PropertyBoolean ShowDate
    {
      get { return _showDate; }
      set
      {
        _showDate = value;
        SetDirty();
      }
    }

    /// <summary>
    /// Gets or sets the text for the 'read more' link
    /// </summary>
    /// <returns>The text for the 'read more' link</returns>
    /// <remarks>
    /// The 'read more' link points to the parent page of the PageList
    /// </remarks>
    /// 
    private string _seeMoreText;
    public string SeeMoreText
    {
      get { return _seeMoreText; }
      set { _seeMoreText = value; }
    }



    /// <summary>
    /// Gets or sets the ShowDate.
    /// </summary>
    /// <value>The page link</value>
    [Personalizable]
    [PropertyDataLanguageAttribute(
        "/webparts/parts/pagelist/shownumberofitems",
        "/webparts/parts/pagelist/shownumberofitemsdesc")]
    public PropertyNumber ShowNumberOfItems
    {
      get { return _showNumberOfItems; }
      set
      {
        _showNumberOfItems = value;
        SetDirty();
      }
    }



    [Personalizable]
    [PropertyDataLanguageAttribute(
        "/webparts/parts/pagelist/seemoretext",
        "/webparts/parts/pagelist/seemoretextdesc")]
    public PropertyString MoreText
    {
      get
      {
        return _moreText;
      }
      set
      {
        _moreText = value;

        SetDirty();
      }
    }




    private string _dateProperty = "PageStartPublish"; // default

    protected string DateProperty
    {
      get { return _dateProperty; }
      set { _dateProperty = value; }
    }

    /// <returns>
    /// Returns a string representation of the date for the specified PageData using 
    /// standard formating
    /// </returns>
    /// <remarks>
    /// In this case the DateTime object is formated to show only the date according 
    /// to the websites CultureInfo before it is returned as a string
    /// </remarks>
    protected string GetFormattedDate(PageData page)
    {
      string date = GetFormattedDate(page, "d");
      return String.IsNullOrEmpty(date) ? date : date + "<br />";
    }
    /// <returns>Returns a string representation of the date for the specified PageData </returns>
    /// <remarks>
    /// In this case the DateTime object is formated according to the websites CultureInfo
    /// and a given DateTime format before it is returned as a string
    /// </remarks>
    protected string GetFormattedDate(PageData page, string format)
    {
      if (ShowDate != null && ShowDate.Boolean == true)
      {
        // Format the date according to the threads culture info
        return ((DateTime)page[DateProperty]).ToString(format);
      }
      return string.Empty;
    }
    /// <returns>A link to the contanier of the PageList</returns>
    /// <remarks>Both SeeMoreText and PageLinkProperty must be set in order for the link to function correctly.</remarks>
    protected string GetContainerLink()
    {
      if (SeeMoreText != null)
      {
        string _linkTag = "<a href=\"{0}\">{1}</a>";

        PageReference containerPage = _listingContainer.PageLink as PageReference;
        if (containerPage != null)
        {
          PageData page = GetPage(containerPage);
          return string.Format(_linkTag, HttpUtility.UrlPathEncode(page.LinkURL), SeeMoreText);
        }
      }
      return string.Empty;
    }

    protected override void OnLoad(EventArgs e)
    {
      base.OnLoad(e);
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
      if (!PageReference.IsNullOrEmpty(_listingContainer.PageLink))
      {
        if (MoreText != null && MoreText.ToString().Length > 0)
          SeeMoreText = MoreText.ToString();

        PageDataCollection pages = Global.EPDataFactory.GetChildren(_listingContainer.PageLink);


        //JT: Don't show unpublished or unaccessible articles
        FilterPublished filterPublished = new FilterPublished();
        filterPublished.Filter(pages);
        FilterAccess filterAccess = new FilterAccess();
        filterAccess.Filter(pages);

        //JT: If ShowNumberOfItems is set for the webpart, then be sure to limit the list accordingly.
        if (ShowNumberOfItems.Number > 0)
        {
          FilterCount filterCount = new FilterCount();
          filterCount.Count = ShowNumberOfItems.Number;
          filterCount.Filter(pages);
        }

        lstPages.DataSource = applySort(pages);
        lstPages.DataBind();


        if (pages.Count > 0 && string.IsNullOrEmpty(_listTitle.ToString()) == false)
        {
          //lblListTitle.Text = _listTitle.ToString();
        }
      }
    }

    //static readonly string EventStartDate = "EventStartDate"; //EventStartDate
    static readonly string CalenderType = "CalenderType";

    public PageData ContainerPage
    {
      get
      {
        if (_containerPage != null)
          return _containerPage;

        PageReference containerPage = _listingContainer.PageLink as PageReference;
        if (containerPage != null)
        {
          _containerPage = GetPage(containerPage);
        }
        return _containerPage;
      }
    }

    private PageDataCollection applySort(PageDataCollection pages)
    {
      //if (isCalendarType())
      //{
      //  DateProperty = EventStartDate;
      //  CalenderComparer comparer = new CalenderComparer();
      //  pages.Sort(comparer);
      //}
      //else
      //{
      //  PageComparer comparer = new PageComparer();
      //  pages.Sort(comparer);
      //}
      return pages;
    }


    private bool isCalendarType()
    {
      if (ContainerPage == null)
        return false;
      PropertyBoolean property = ContainerPage.Property[CalenderType] as PropertyBoolean;
      if (property != null && !property.IsNull)
        return true;

      return false;
    }

  }
}
