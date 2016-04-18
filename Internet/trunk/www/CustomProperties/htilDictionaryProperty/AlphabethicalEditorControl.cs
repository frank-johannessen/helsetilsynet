using EPiServer.Web.PropertyControls;

namespace Helsetilsynet.CustomProperties.htilDictionaryProperty
{
    public class AlphabethicalEditorControl: PropertyTextBoxControlBase
    {
        public override bool SupportsOnPageEdit
        {
            get { return false; }
        }

        public override void CreateEditControls()
        {
            var editor = Page.LoadControl("~/CustomProperties/htilDictionaryProperty/AlphabethicalEditor.ascx");
            Controls.Add(editor);
        }

        public override void ApplyEditChanges()
        {
            SetValue(string.Empty);
        }

        public AlphabethicalEditorProperty ArticleKeywordsAdmin
        {
            get
            {
                return PropertyData as AlphabethicalEditorProperty;
            }
        }
    }
}