using System;
using EPiServer.PlugIn;

namespace development.Class.PlugIn
{
	[ScheduledPlugIn(DisplayName="Helsetilsyn Abonnement", HelpFile="SubscriptionJob.htm")]
	public class HTSubscripton : EPiServer.Personalization.SubscriptionJob {
		protected bool CanSendSubscription(EPiServer.DataAccess.SubscriptionItem subscription, EPiServer.Core.PageReference subscriptionPage, EPiServer.Core.PageDataCollection pages)
		{
			EPiServer.Core.PageData page;
			for(int i=0; i<pages.Count;i++)
			{
				page = pages[i];
                if (page.Property["SubscriptionException"] != null)
                {
					try {
						return (!Convert.ToBoolean(page["SubscriptionException"].ToString()));
					} catch {
						return true;
					}
				}
			}
			return false;
			//return base.CanSendSubscription (subscription, subscriptionPage, pages);
		}

		public new static string Execute() {
			HTSubscripton job1 = new HTSubscripton();
			return job1.InternalExecute();
		}
 

	}
}
