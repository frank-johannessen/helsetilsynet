using System;
using System.Globalization;
using System.Web.UI.WebControls;
using EPiServer.Web.PropertyControls;
using MakingWaves.Helsetilsynet.Intranet.Web.ConfigSections;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.ExternalSystemPicker
{
    public class PropertyExternalSystemControl : PropertyDataControl
    {
        private DropDownList _dropDownList;

        public override bool SupportsOnPageEdit
        {
            get { return false; }
        }

        public override void ApplyEditChanges()
        {
            SetValue(string.IsNullOrEmpty(_dropDownList.SelectedValue) ? null : _dropDownList.SelectedValue);
        }

        public override void CreateEditControls()
        {
            _dropDownList = new DropDownList();
            _dropDownList.Items.Add(string.Empty);

            foreach (var system in ExternalSystemsConfig.ExternalSystems)
                _dropDownList.Items.Add(new ListItem{Enabled = true, Text = system.Name, Value = system.ID.ToString(CultureInfo.InvariantCulture)});

            _dropDownList.SelectedValue = (string)PropertyData.Value;

            Controls.Add(_dropDownList);
        }
    }
}