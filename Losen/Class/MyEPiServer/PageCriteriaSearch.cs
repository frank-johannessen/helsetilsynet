using System;

using EPiServer;
using EPiServer.Core;
using EPiServer.Filters;

namespace development.Class.MyEPiServer
{
	/// <summary>
	/// Forskjellige søkemetoder for å finne EPiServer sider.
	/// </summary>
	public class PageCriteriaSearch
	{
		public PageCriteriaSearch()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		/// <summary>
		/// Søker på boolean verdi
		/// </summary>
		/// <param name="property">Navnet på EPiServer egenskapen det skal søkes etter</param>
		/// <param name="val">Verdien på EPiServer egenskapen det søkes etter</param>
		/// <returns></returns>
		static public PageDataCollection PropertySearchBool(string property, bool val)
		{
			PageDataCollection Activity = new PageDataCollection();
			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
			PropertyCriteria criteria;
			criteria = new PropertyCriteria();
			criteria.Name = property; 
			criteria.Type = PropertyDataType.Boolean;
			criteria.Condition = CompareCondition.Equal; 
			criteria.Value = val.ToString();
			criteria.Required = true;
			criterias.Add(criteria);
			Activity.Add(Global.EPDataFactory.FindPagesWithCriteria(Global.EPConfig.StartPage, criterias)); 
			return Activity;

			
		}

		/// <summary>
		/// Søker på sider med inndato og intil 24 timer før inndato
		/// </summary>
		/// <param name="property">Navnet på EPiServer egenskapen det skal søkes etter</param>
		/// <param name="now">Verdien på EPiServer egenskapen det søkes etter</param>
		/// <returns></returns>
		static public PageDataCollection PropertySearchDatePeriodDay(string property, DateTime now)
		{
			PageDataCollection Activity = new PageDataCollection();
			PropertyCriteriaCollection criterias = new PropertyCriteriaCollection();
			PropertyCriteria criteria;
			criteria = new PropertyCriteria();
			criteria.Name = property; 
			criteria.Type = PropertyDataType.Date;
			criteria.Condition = CompareCondition.GreaterThan; 
			criteria.Value = now.AddHours(-24).ToString();
			criteria.Required = true;
			criterias.Add(criteria);
			criteria = new PropertyCriteria();
			criteria.Name = property; 
			criteria.Type = PropertyDataType.Date;
			criteria.Condition = CompareCondition.LessThan; 
			criteria.Value = now.ToString();
			criteria.Required = true;
			criterias.Add(criteria);
			Activity.Add(Global.EPDataFactory.FindPagesWithCriteria(Global.EPConfig.StartPage, criterias)); 
			return Activity;
		}
	}
}
