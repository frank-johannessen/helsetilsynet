/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPost
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Runtime.Remoting;
using System.Configuration;
using System.Web.Mail;
using EPiServer;
using EPiServer.Core;
using System.Collections.Specialized;
using EPiServer.DataAccess;
using EPiServer.Security;
using EPiServer.Personalization;
using EPiServer.PlugIn;
using EPiServer.Filters;


namespace development.templates.Units
{

	[GuiPlugIn("Verktøy", "Verktøy", PlugInArea.EditTree,"~/templates/Modules/Tools.ascx")]	

	public class ExpiredPages : System.Web.UI.UserControl
	{
		private void Page_Load(object sender, System.EventArgs e)
		{
		}							
	}
}

