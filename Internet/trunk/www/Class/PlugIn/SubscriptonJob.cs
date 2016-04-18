using System;
using EPiServer.Core;
using EPiServer.PlugIn;

namespace development.Class.PlugIn
{
	[ScheduledPlugIn(DisplayName="Helsetilsyn Abonnement (*)", HelpFile="SubscriptionJob.htm")]
	public class SubscriptonJob : EPiServer.Personalization.SubscriptionJob
	{
		protected bool CanSendSubscription(EPiServer.DataAccess.SubscriptionItem subscription, EPiServer.Core.PageReference subscriptionPage, EPiServer.Core.PageDataCollection pages) {
			PageData page;
			for (int i=pages.Count-1; i>-1; i--) {
				page = pages[i];
                if (page.Property["SubscriptionException"] != null)
                {
					try {
						if (Convert.ToBoolean(page["SubscriptionException"].ToString())) {
							pages.RemoveAt(i);
						}
					} catch {
						continue;
					}
				}
			}
			return (pages.Count>0);
		}

		public new static string Execute() {
			SubscriptonJob job = new SubscriptonJob();
			return job.InternalExecute();
		}
	}
}