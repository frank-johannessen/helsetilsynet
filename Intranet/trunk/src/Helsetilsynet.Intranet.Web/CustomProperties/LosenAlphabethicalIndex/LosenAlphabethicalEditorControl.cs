using EPiServer.Web.PropertyControls;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.LosenAlphabethicalIndex
{
    public class LosenAlphabethicalEditorControl: PropertyTextBoxControlBase
    {
        public override bool SupportsOnPageEdit
        {
            get { return false; }
        }

        public override void CreateEditControls()
        {
            var editor = Page.LoadControl("~/CustomProperties/LosenAlphabethicalIndex/LosenAlphabethicalEditor.ascx");
            Controls.Add(editor);
        }

        public override void ApplyEditChanges()
        {
            SetValue(string.Empty);
        }

        public LosenAlphabethicalEditorProperty ArticleKeywordsAdmin
        {
            get
            {
                return PropertyData as LosenAlphabethicalEditorProperty;
            }
        }
    }
}