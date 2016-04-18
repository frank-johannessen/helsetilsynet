using System.Collections.Generic;
using System.Linq;
using EPiServer.DynamicContent;
using EPiServer.Web.Hosting;
using MakingWaves.Helsetilsynet.Intranet.Web.CustomProperties.FolderBrowserProperty;
using MakingWaves.Helsetilsynet.Intranet.Web.Model;
using PageTypeBuilder.UI;

namespace MakingWaves.Helsetilsynet.Intranet.Web.Templates.DynamicContent
{
    // Simple walk-through on DynamicContent:
    // http://blog.fredrikhaglund.se/blog/2011/06/28/dynamic-content-in-episerver-cms-6-r2/

    [DynamicContentPlugIn(DisplayName = "LinksFiles",
        ViewUrl = "~/Templates/DynamicContent/LinksFiles.ascx")]
    public partial class LinksFiles : UserControlBase<BasePage>
    {
        // ReSharper disable MemberCanBeProtected.Global

        public PropertyFolderBrowser FolderBrowser { get; set; }
        public string FileTypeFilter { get; set; }

        private List<string> _fileTypes;
        private IEnumerable<string> FileTypes
        {
            get
            {
                if (_fileTypes != null)
                    return _fileTypes;

                _fileTypes = string.IsNullOrEmpty(FileTypeFilter) 
                    ? new List<string>() 
                    : FileTypeFilter.Split(new[] {',', ';'}).ToList();

                return _fileTypes;
            }
        }

        private List<string> _fileExtensions;
        private List<string> FileExtensions
        {
            get
            {
                if (_fileExtensions != null)
                    return _fileExtensions;

                _fileExtensions = new List<string>();
                foreach (var fileType in FileTypes)
                {
                    var split = fileType.Trim().Split('.');
                    if (split.Length != 2)
                        continue;

                    _fileExtensions.Add("." + split[1]);
                }

                return _fileExtensions;
            }
        }

        // ReSharper restore MemberCanBeProtected.Global

        private List<string> GetFiles()
        {
            var fileNames = new List<string>();
            var folder = FolderBrowser.Value;
            if (folder == null)
                return fileNames;

            var vpp = System.Web.Hosting.HostingEnvironment.VirtualPathProvider;
            if (vpp != null)
            {
                var dir = vpp.GetDirectory(folder.ToString()) as UnifiedDirectory;
                if (dir != null)
                {
                    System.Collections.IEnumerable allFiles = dir.GetFiles();
                    var files = from UnifiedFile file in allFiles where Filter(file.Name) select file.Name;
                    fileNames.AddRange(files);
                }
            }

            return fileNames;
        }

        private bool Filter(string fileName)
        {
            return FileExtensions.Count < 1 || FileExtensions.Any(fileName.EndsWith);
        }

        protected override void  OnLoad(System.EventArgs e)
        {
            rptFiles.DataSource = GetFiles();
            rptFiles.DataBind();
        }
    }
}