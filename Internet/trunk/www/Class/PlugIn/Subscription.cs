using System;
using System.Collections;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
//using System.Web.Mail;    // obsolete in .NET 2.0
using System.Net.Mail;
using EPiServer;
using EPiServer.Core;
using EPiServer.Filters;
using EPiServer.Personalization;
using EPiServer.Security;



[SubscriptionPlugIn(DisplayName="HelsetilsynAbbonement")]
public class MySubscription : ISubscriptionHandler
{
	int                     _sid = 0;
	PersonalizedData        _data = null;
	bool					send=false;
	const string DATEPROPERTY = "__SubscriptionMailDate";
    private static readonly log4net.ILog _log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

	/// <summary>
	/// Required for ISubscriptionHandler
	/// </summary>
	public int SID
	{
		get{return _sid;}
		set{_sid=value;}
	}

	/// <summary>
	/// Required for ISubscriptionHandler
	/// </summary>
	public PersonalizedData UserData
	{
		get{return _data;}
		set{_data=value;}
	}

	/// <summary>
	/// The actual method called to send message
	/// </summary>
	/// <param name="subscriptionPage"></param>
	/// <param name="changedPages"></param>
	public void Send(PageData subscriptionPage,PageDataCollection changedPages)
	{
		try {
			MailMessage msg = new MailMessage();
            SmtpClient smtpClient;

			// Make sure we have a valid e-mail
			if(UserData.Email==null || UserData.Email.IndexOf("@") <= 0)
				return;

			SortByLatestDate(changedPages);
	    
			Uri uri						= new Uri( Global.EPConfig.HostUrl );

            //msg.From					= "subscription@" + uri.Host;   // obsolete in .NET 2.0
            msg.From = new MailAddress("subscription@" + uri.Host);
            //msg.To						= UserData.Email;   // obsolete in .NET 2.0
            msg.To.Add(new MailAddress(UserData.Email));
            msg.Subject					= "Senaste nytt";
            //msg.UrlContentBase			= Global.EPConfig.HostUrl;  // obsolete in .NET 2.0
            msg.Headers.Add("Content-Base", Global.EPConfig.HostUrl);
            //msg.Headers["X-Mailer"]		= "EPiServer 4"; // obsolete in .NET 2.0
            msg.Headers.Add("X-Mailer", "EPiServer 4");
            //msg.BodyFormat				= MailFormat.Html;  // obsolete in .NET 2.0
            msg.IsBodyHtml = true;

			msg.Body					= GenerateMailBody(subscriptionPage,changedPages);

			// Override default settings with custom properties, if any
			if(subscriptionPage["MailSubject"]!=null)
				msg.Subject    = subscriptionPage["MailSubject"] as string;
			if(subscriptionPage["MailFrom"]!=null)
				msg.From    = new MailAddress(subscriptionPage["MailFrom"] as string);

            // obsolete in .NET 2.0
            //Global.EPConfig.InitSmtpServer();
            //if(send)
            //    SmtpMail.Send(msg);
            System.Net.Mime.ContentType ct = new System.Net.Mime.ContentType();

            smtpClient = new SmtpClient(Global.EPConfig["EPsSmtpServer"].ToString());
            if (send)
            {
                smtpClient.Send(msg);
                _log.Debug(string.Format("Email has been sent to: {0}", UserData.Email));
            }
		} catch (Exception exc)
        {
            _log.Error(string.Format("Error when sending email to: '{0}'. Error: '{1}' ", UserData.Email, exc.Message + exc.StackTrace));
        }
	}

	private string GenerateMailBody(PageData subscriptionPage,PageDataCollection changedPages)
	{
		StringBuilder body = new StringBuilder();

		AddMailHeader(body);

		if(subscriptionPage["MailBody"]!=null)
			body.Append( subscriptionPage["MailBody"] );

		//foreach(PageData page in changedPages)
		for(int i=0; i<changedPages.Count;i++)
		{
			if (changedPages[i].Property.Exists("SubscriptionException"))
			{
				bool subscription=false;
				try
				{
					subscription=Convert.ToBoolean(changedPages[i]["SubscriptionException"].ToString());
				}
				catch
				{
				}
				if(!subscription)
				{
					send=true;
					body.Append( "<br><span class=MailDate>" );
					body.Append( "[" );
					body.Append( ((DateTime)changedPages[i][DATEPROPERTY]).ToShortDateString() );
					body.Append( "]</span>" );
					body.Append( "<br><span class=MailPageName>" );
					body.Append(changedPages[i].PageName);//body.Append( CreateBreadCrumb(page) );
					body.Append( "</span><br><span class=MailPagePreview>" );
                
					if(changedPages[i]["NewsPageText"]!=null)
					{
						body.Append( changedPages[i]["NewsPageText"].ToString() );
						body.Append( "<br>" );
					}
					else 
					{
						if(changedPages[i].Property.Exists("MetaDescription"))
						{
							try
							{
								body.Append( changedPages[i]["MetaDescription"].ToString() );
								body.Append( "<br>" );
							}
							catch
							{
								body.Append( "<br>" );
							}
						}
					}
			
					body.Append( "</span><a class=MailReadMore href=\"" );
			
					if ((PageShortcutType)changedPages[i]["PageShortcutType"] != PageShortcutType.External)
						body.Append( Global.EPConfig.HostUrl );
					body.Append( changedPages[i].LinkURL );

					body.Append( "\">" );
					if(subscriptionPage["MailReadMore"]!=null)
						body.Append( subscriptionPage["MailReadMore"].ToString() );
					else
						body.Append( "Les mer" );
					body.Append( "</a>" );
					body.Append( "<br>" );
				}
				else
				{
					changedPages.RemoveAt(i);
					i--;
				}
			}
			else
			{
				changedPages.RemoveAt(i);
				i--;
			}

		}

		body.Append("</body></html>");

		return body.ToString();

	}

	private string CreateBreadCrumb(PageData page)
	{
		PageData curPage = page;
		string output = String.Empty;

		while(curPage.ParentLink!=Global.EPConfig.RootPage && curPage.PageLink!=Global.EPConfig.RootPage)
		{
			output = "/" + curPage.PageName + output;
			curPage = Global.EPDataFactory.GetPage(curPage.ParentLink,AccessControlList.NoAccess);
		}

		return output;
	}

	private void AddMailHeader(StringBuilder body)
	{
		StringBuilder    css = new StringBuilder();
		System.IO.FileInfo cssFile = new System.IO.FileInfo(AppDomain.CurrentDomain.BaseDirectory + Global.EPConfig.CssPath);
		if(cssFile.Exists)
		{
			StreamReader    r    = null;

			try
			{
				r = cssFile.OpenText();
				string textLine;
				while ((textLine = r.ReadLine()) != null) 
				{
					css.Append( textLine );
				}
			}
			catch
			{
			}
			finally
			{
				if(r!=null)
					r.Close();
			}
		}

		body.Append("<html>");
		body.Append("<head>");
		if(css.Length>0)
		{
			body.Append("<style>");
			body.Append(css);
			body.Append("</style>");
		}
		body.Append("</head>");
		body.Append("<body>");
	}

	private string CreatePreviewText(string title, string html, int len)
	{
		if(title==null || html==null)
			return null;

		if(html.Length>(len*10))
			html = html.Substring(0,len*10);

		html = html.Replace("<br>"," ");
		html = html.Replace("<BR>"," ");
		html = html.Replace("</p>"," ");
		html = html.Replace("</P>"," ");


		Regex reg = new Regex("<[^>]*>",RegexOptions.IgnorePatternWhitespace);
		string text = reg.Replace( html, "" );
		text = System.Web.HttpUtility.HtmlDecode( text );
		text = text.TrimStart( new char[1]{' '});
		if(text.ToLower().StartsWith(title.ToLower()))
		{
			text = text.Remove(0,title.Length);
			text = text.TrimStart( new char[1]{' '});
		}

		if(text.Length>len)
			text = text.Substring(0,len);

		int stopPos = text.LastIndexOfAny( new char[2]{' ','.'});

		if( stopPos > (text.Length/2) )
			text = text.Substring(0,stopPos+1);
            
		if(text.Length>0)
			return text + "..";
		else
			return null;
	}

	private void SortByLatestDate(PageDataCollection pages)
	{
		foreach(PageData page in pages)
		{
			if( (DateTime)page["PageChanged"] > (DateTime)page["PageStartPublish"] )
				page.Property.Add(DATEPROPERTY, new PropertyDate( (DateTime)page["PageChanged"] ));
			else
				page.Property.Add(DATEPROPERTY, new PropertyDate( (DateTime)page["PageStartPublish"] ));
		}
		//FilterPropertySort filter = new FilterPropertySort(DATEPROPERTY, FilterSortDirection.Descending);
		//filter.Filter(this, new FilterEventArgs(pages));
		pages.Sort(new CompareLatestDateDescending());
	}

	private class CompareLatestDateDescending: IComparer
	{
		public int Compare(object x, object y)
		{
			try {
				return DateTime.Compare((DateTime) ((PageData) y)[DATEPROPERTY], (DateTime) ((PageData) x)[DATEPROPERTY]);
			} catch {
				return 0;
			}
		}
	}
}


