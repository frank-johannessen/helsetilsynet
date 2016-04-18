using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.Hosting;
using EPiServer;
using EPiServer.Web.Hosting;
using EPiServer.Core;

namespace MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.FolderBrowserProperty
{
	    public partial class FolderBrowserDialog : EditPage {
	        /* *******************************************************************
	        *  Methods
	        * *******************************************************************/
	        #region public void CloseAndSave()
	        /// <summary>
	        ///
	        /// </summary>
	        public void CloseAndSave() {
	            if (Page.IsValid) {
	
	                const string scriptCaller = "OnCloseAndSave('{0}');";
	
	                Page.ClientScript.RegisterStartupScript(
	                    GetType(),
	                    "OnCloseAndSaveScriptKey",
	                    string.Format(scriptCaller, ReturnValue.Value),
	                    true);
	            }
	        }
	        #endregion
	        #region public void CloseAndCancel()
	        /// <summary>
	        ///
	        /// </summary>
	        public void CloseAndCancel() {
	            const string scriptCaller = "OnCloseAndCancel();";
	
	            Page.ClientScript.RegisterStartupScript(
	                    GetType(),
	                    "CloseAndCancelScriptKey",
	                    scriptCaller,
	                    true);
	        }
	
	        #endregion       
	        #region protected override void InitializeCulture()

            protected override void InitializeCulture() {
	            EPiServer.Globalization.UserInterfaceLanguage.Instance.SetCulture(EPiServer.Personalization.EPiServerProfile.Current.Language);
	        }
	        #endregion
	        /* *******************************************************************
	        *  Event methods
	        * *******************************************************************/
	        #region protected void InsertButton_Click(object sender, EventArgs e)
	        /// <summary>
	        /// This method is called when the InsertButton's Click event has been fired.
	        /// </summary>
	        /// <param name="sender">The <see cref="object"/> that fired the event.</param>
	        /// <param name="e">The <see cref="EventArgs"/> of the event.</param>
	        protected void InsertButton_Click(object sender, EventArgs e) {
	            CloseAndSave();
	        }
	        #endregion
	        #region protected void CancelButton_Click(object sender, EventArgs e)
	        /// <summary>
	        /// This method is called when the CancelButton's Click event has been fired.
	        /// </summary>
	        /// <param name="sender">The <see cref="object"/> that fired the event.</param>
	        /// <param name="e">The <see cref="EventArgs"/> of the event.</param>
	        protected void CancelButton_Click(object sender, EventArgs e) {
	            CloseAndCancel();
	        }
	        #endregion
	        #region protected void FileTree_TreeNodeDataBound(object sender, TreeNodeEventArgs e)
	        /// <summary>
	        /// This method is called when the FileTree's TreeNodeDataBound event has been fired.
	        /// </summary>
	        /// <param name="sender">The <see cref="object"/> that fired the event.</param>
	        /// <param name="e">The <see cref="TreeNodeEventArgs"/> of the event.</param>
	        protected void FileTree_TreeNodeDataBound(object sender, TreeNodeEventArgs e) {
	            var virtualFile = e.Node.DataItem as VirtualFileBase;
	            if (virtualFile != null)
	                if (virtualFile.IsDirectory) {
	                    // We dont´t want to use the path as text
	                    // so therefore we fetch the virtualname and set it as text
	                    IDictionary<string, string> mappings = VirtualPathHandler.Instance.VirtualPathToNameMapping;
	                    if (mappings.ContainsKey(virtualFile.VirtualPath))
	                        e.Node.Text = mappings[virtualFile.VirtualPath];
	                    else if (virtualFile.VirtualPath.ToLower().Contains("pagefiles") && e.Node.Depth == 1)
	                    {
	                        PageData page = UnifiedDirectory.GetOwnerPageFromVirtualPath(virtualFile.VirtualPath);
	                        if (page != null)
	                            e.Node.Text = page.PageName;
	                        else
	                            e.Node.Text = virtualFile.Name + " " + Translate("/meridium.epcms/folderbrowser/deleted");
	                    }
	
	                    e.Node.SelectAction = TreeNodeSelectAction.Select;
	                }
	                else {
	                    if(e.Node.Parent != null)
	                        e.Node.Parent.ChildNodes.Remove(e.Node);
	                }
	        }
	        #endregion
        #region protected void FileTree_TreeNodeSelected(object sender, EventArgs e)
	        /// <summary>
	        /// This method is called when the FileTree's TreeNodeSelected event has been fired.
	        /// </summary>
	        /// <param name="sender">The <see cref="object"/> that fired the event.</param>
	        /// <param name="e">The <see cref="EventArgs"/> of the event.</param>
	        protected void FileTree_TreeNodeSelected(object sender, EventArgs e) {
	            if (FileTree.SelectedNode != null)
	                ReturnValue.Value = FileTree.SelectedNode.DataPath;
	        }
	        #endregion
	
	        private string _shellPath;
	
	        public string ShellPath
	        {
	            get
	            {
	                if (string.IsNullOrEmpty(_shellPath))
	                {
	                    var shellProvider =
	                        VirtualPathHandler.GetProvider("EPiServerShell") as VirtualPathNonUnifiedProvider;
	
	                    if (shellProvider != null)
	                        _shellPath = shellProvider.VirtualPathRoot;
	                    else
	                        return "~/";
	                }
	                return _shellPath;
	            }
	        }
	    }
	}