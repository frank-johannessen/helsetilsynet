using System;
using EPiServer.PlugIn;

namespace development.Class.PlugIn
{
	[ScheduledPlugIn(DisplayName="Helsetilsyn Abonnement", HelpFile="SubscriptionJob.htm")]
	public class HTSubscripton : EPiServer.Personalization.SubscriptionJob 
	{
		protected override bool CanSendSubscription(EPiServer.DataAccess.SubscriptionItem subscription, EPiServer.Core.PageReference subscriptionPage, EPiServer.Core.PageDataCollection pages)
		{
			for(int i=0; i<pages.Count;i++)
			{
				if (pages[i].Property.Exists("SubscriptionException"))
				{
					try
					{
						if(!Convert.ToBoolean(pages[i]["SubscriptionException"].ToString()))
						{
							return true;
						}
					}
					catch
					{
						return true;
					}
				}
			}
			return false;
			//return base.CanSendSubscription (subscription, subscriptionPage, pages);
		}

		public new static string Execute()
		{
			HTSubscripton job1 = new HTSubscripton();
			return job1.InternalExecute();
		}
 

	}
}
