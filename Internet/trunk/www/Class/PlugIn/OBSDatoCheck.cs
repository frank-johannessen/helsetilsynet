using System;
using System.Web.Mail;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using EPiServer.DataAbstraction;


namespace development.Class.PlugIn
{
	/// <summary>
	/// Sjekker om OBS dato er nådd og sender ut en mail til ansvarlig om at OBSdato er nådd. obsdate er en dato
	/// satt i EPiServer.
	/// </summary>
	[ScheduledPlugIn(DisplayName="OBS.Dato",Description="Sjekker om OBS.Dato er nådd")] 
	public class OBSDatoCheck : UserControlBase
	{
		public OBSDatoCheck()
		{
			
		}
		public static string Execute()
		{
			string Error="";
			PageDataCollection pages= Class.MyEPiServer.PageCriteriaSearch.PropertySearchDatePeriodDay("obsDate",DateTime.Now);
			foreach(PageData page in pages)
			{
				
				UserSid _user =UserSid.Load(page.CreatedBy);
				MailMessage Mail		= new MailMessage();
				Mail.From				= (string) EPiServer.Global.EPConfig["OBSEmailFrom"];
				if (page.Property.Exists("Obsmail"))
				{
					if((string)page["Obsmail"]!="")
						Mail.To=(string)page["Obsmail"];
					else 
						Mail.To					= _user.Email;
				}
				Mail.Cc					= (string) EPiServer.Global.EPConfig["OBSEmailAdmin"];
				Mail.Subject			="Obs.Dato";
				Mail.BodyEncoding		=System.Text.Encoding.UTF8; 
				Mail.Body				="OBS.dato er nådd på følgende side: " + page.PageName + ". Vennligst revider siden. Klikk på følgende link for å komme til siden.  http://localhost/edit?id=" + page.PageLink.ID;
				try
				{
					SmtpMail.SmtpServer		=EPiServer.Global.EPConfig["EPsSmtpServer"].ToString();
					SmtpMail.Send(Mail);
				}
				catch(Exception ex)
				{
					Error +=" " + ex.Message;
				}
				
			}
			return "Antall OBS meldinger: " + pages.Count.ToString() + ". Feilmeldinger: "+Error;;
		}
	}
}
