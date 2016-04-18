using System;
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using System.Web.UI.WebControls;

namespace development
{
	[PageDefinitionTypePlugIn(DisplayName="Skillelinje", 
		 Description="Skillelinje for redigeringsmodus.")]
	public class PropertyDivider : PropertyNumber, IPropertyFormLayout
	{
		public PropertyDivider()
		{
		}

		public override void CreateChildControls(string renderType,System.Web.UI.Control container)
		{
			switch(renderType)
			{
				case "edit":
					string divTag = "<div style=\"width: 100%; border-bottom: 2px solid #808080; padding-top: 6px;\"><b>{0}</b></div>";
					Literal hr = new Literal();
					hr.Text = string.Format(divTag, this.Description);

					PlaceHolder oCtrl = new PlaceHolder();
					oCtrl.EnableViewState = false;
					oCtrl.ID = Name;
					oCtrl.Controls.Add(hr);
                    
					CopyWebAttributes(container, oCtrl);

					// Add the control to the page
					container.Controls.Add(oCtrl);

					break;
				default:
					base.CreateChildControls(renderType,container);
					break;
			}
		}
		#region IPropertyFormLayout Members

		public EPiServer.Core.TableRowLayout RowLayout
		{
			get
			{
				return EPiServer.Core.TableRowLayout.Wide;
			}
		}

		#endregion
	}
}

