/*
Copyright © 2005 Making Waves. All Rights Reserved.
*/
using System;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.ComponentModel;
using EPiServer;
using EPiServer.Core;
using EPiServer.WebControls;

namespace MakingWaves.MakingCode.EPiServer.WebControls
{
	/// <summary>
	/// Control for rendering page list, extends <see cref="PageListData"/> with templates
	/// </summary>
	/// <example>Example usage of PageList rendering a simple list of links to pages
	/// <code lang="c#"><![CDATA[
	/// <episerver:PageList PageLink=<%#CurrentPage.PageLink%> runat="server" ID="PageList1">
	///		<ItemTemplate>
	///			<episerver:property PropertyName="PageLink" runat="server"/>
	///			<br/>
	///		</ItemTemplate>
	/// </episerver:PageList>
	/// ]]></code>
	/// </example>
 	/// <seealso cref="PageListData"/>
	/// <seealso cref="PageControlBase"/>

	[ToolboxData("<{0}:PageList runat=server></{0}:PageList>")]
	public class PageList : PageListData,INamingContainer
	{
		private ITemplate			_itemTemplate;
		private ITemplate			_headerTemplate;
		private ITemplate			_footerTemplate;
		private PageDataCollection  _pages;

		public PageList()
		{
		}

		protected override void Render(HtmlTextWriter writer)
		{
			RenderChildren(writer);
		}
		
		protected override void CreateChildControls()
		{
			if(_itemTemplate==null)
				return;

			 _pages	= GetPages();
			if(_pages.Count==0)
				return;

			PageData rootPage			= null;
			if (PageLink!=PageReference.EmptyReference)
				rootPage = GetPage(PageLink);

			if (_headerTemplate!=null)
			{
				Control template = new PageTemplateContainer(rootPage);
				_headerTemplate.InstantiateIn(template);
				Controls.Add(template);
			}

			for (int i=0;i<_pages.Count;i++)
			{
				Control template = new PageTemplateContainer(_pages[i]);
				_itemTemplate.InstantiateIn(template);
				Controls.Add(template);
			}

			if (_footerTemplate!=null)
			{
				Control template = new PageTemplateContainer(rootPage);
				_footerTemplate.InstantiateIn(template);
				Controls.Add(template);
			}

		}

		#region Accessors
		
		/// <summary>
		/// The default template for pages
		/// </summary>
		[TemplateContainer(typeof(PageTemplateContainer))]
		public ITemplate ItemTemplate
		{
			set
			{
				_itemTemplate = value;
				
			}
			get
			{
				return _itemTemplate;
			}
		}

		/// <summary>
		/// Template for listing header
		/// </summary>
		[TemplateContainer(typeof(PageTemplateContainer))]
		public ITemplate HeaderTemplate
		{
			set
			{
				_headerTemplate = value;
				
			}
			get
			{
				return _headerTemplate;
			}
		}

		/// <summary>
		/// Template for listing footer
		/// </summary>
		[TemplateContainer(typeof(PageTemplateContainer))]
		public ITemplate FooterTemplate
		{
			set
			{
				_footerTemplate = value;
				
			}
			get
			{
				return _footerTemplate;
			}
		}

		public PageDataCollection GetInnerPages()
		{
			return _pages;
		}

		#endregion
	}
}
