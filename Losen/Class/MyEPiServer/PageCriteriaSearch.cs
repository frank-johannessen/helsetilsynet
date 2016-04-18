using System;

using EPiServer;
using EPiServer.Core;
using EPiServer.Filters;

namespace development.Class.MyEPiServer
{
	/// <summary>
	/// Forskjellige s�kemetoder for � finne EPiServer sider.
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
		/// S�ker p� boolean verdi
		/// </summary>
		/// <param name="property">Navnet p� EPiServer egenskapen det skal s�kes etter</param>
		/// <param name="val">Verdien p� EPiServer egenskapen det s�kes etter</param>
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
		/// S�ker p� sider med inndato og intil 24 timer f�r inndato
		/// </summary>
		/// <param name="property">Navnet p� EPiServer egenskapen det skal s�kes etter</param>
		/// <param name="now">Verdien p� EPiServer egenskapen det s�kes etter</param>
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
