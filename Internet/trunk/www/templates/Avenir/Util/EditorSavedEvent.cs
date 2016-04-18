
using EPiServer;
using EPiServer.Core;
using EPiServer.PlugIn;
using PageEventArgs = EPiServer.PageEventArgs;
using EPiServer.DataAccess;



//<A onclick="_gaq.push(['_trackEvent', 'Publikasjoner', 'Klikk', 'helsetilsynetrapport1_2010.pdf']);" href="/upload/Publikasjoner/rapporter2010/helsetilsynetrapport1_2010.pdf">Last ned rapporten</A>&nbsp;(pdf)


namespace Helsetilsynet.templates.Avenir.Util
{
    //obs - for å aktivere: 1 fjern kommentar neste linje og på Start()

    public class EditorSavedEvent // : PlugInAttribute
    {
        private static string _bodyText;
        private static int _cursorPos;
        private static bool _endSearch;
        private static bool _funn;

        public static void Start()
        {
            //           DataFactory.Instance.PublishingPage += SavePage;
        }

        public static string ReplacePdfLinks(string bodyText)
        {
            //Tracking av pdf og eksterne lenker deaktivert. Ref.oppg. fra HT 6.01.12
            return bodyText;
            _cursorPos = 0;
            _endSearch = false;
            _funn = false;
            if (!string.IsNullOrEmpty(bodyText))
            {
                _bodyText = bodyText;
                while (!_endSearch)
                {
                    NextPdfLink();
                }
                if (_funn)
                {
                    return _bodyText;
                }
            }
            return bodyText;
        }

        private static void SavePage(object sender, PageEventArgs e)
        {
            _cursorPos = 0;
            _endSearch = false;
            _funn = false;
            PageData pd = e.Page;
            if (pd.Property["MainBody"] != null && pd.Property["MainBody"].ToString() != string.Empty)
            {
                _bodyText = pd.Property["MainBody"].ToString();
                while (!_endSearch)
                {
                    NextPdfLink();
                }
                if (_funn)
                {
                    pd.Property["MainBody"].Value = _bodyText;
                    //SaveAction saveAction = SaveAction.ForceCurrentVersion;
                    //DataFactory.Instance.Save(pd, saveAction);
                    //e.CancelAction = true;
                }
            }
        }


        private static void NextPdfLink ()
        {
            int pStart = _bodyText.IndexOf("<a", _cursorPos);
            if (pStart > -1)
            {
                int pEnd = _bodyText.IndexOf("</a>", pStart);
                if (pEnd == -1) //html error
                {
                    _endSearch = true;
                    return;
                }
                int linkLength = pEnd - pStart; // _cursorPos;
                string link = _bodyText.Substring(pStart, linkLength);
                int pUpload = link.IndexOf("/upload/");
                int pPdf = link.IndexOf(".pdf");
                _cursorPos = pEnd + 4;
                if (pUpload > -1  && pPdf > -1) // We have an internal pdf-link
                {

                    int pPush = link.IndexOf("_gaq.push");
                    if (pPush > -1) // Google kode er allerede lagt inn
                        return;
                    _funn = true;

                    int hrefStart = link.LastIndexOf("/", pPdf) + 1;
                    int pdfCount = pPdf - hrefStart + 4;
                    string href = link.Substring(hrefStart, pdfCount);
                    string addIn = @"onclick=""_gaq.push(['_trackEvent', 'Publikasjoner', 'Klikk', '" + href + @"']);"" ";

                    _bodyText = _bodyText.Insert(pStart + 3, addIn);
                    return;
                }
                return;
            }
            _endSearch = true;
            return;
        }

    }
}
