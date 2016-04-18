using System;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Web;
using EPiServer;
using EPiServer.Core;
using EPiServer.SpecializedProperties;
using EvoPdf.HtmlToPdf;
using EvoPdf.HtmlToPdf.PdfDocument;
//using Winnovative.WnvHtmlConvert;
//using Winnovative.WnvHtmlConvert.PdfDocument;
using Helsetilsynet.Class;
using log4net;

namespace Helsetilsynet.templates.Avinir.Units.Placeable.LargeDocuments.Units.Placeable
{
    public partial class GeneratePDF : UserControlBase
    {
        ///
        /// Link to the API used to create .pdf
        /// http://www.evopdf.com/api/ 
        /// 
        
        public string LinkText { protected get; set; }

        public PageData PageToConvert { private get; set; }

        private int _tocEntriesCount;
        private const int PAGE_NUMBER_FONT_SIZE = 8;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        /// <summary>
        /// Convert the HTML code from the specified URL to a PDF document and send the 
        /// document as an attachment to the browser
        /// </summary>
        protected void GetPDF(object sender, EventArgs eventArgs)
        {
            var pdfFileName = GetPdfFileName(PageToConvert);
            LogManager.GetLogger(GetType()).Debug(string.Format("Trying to get PDF file '{0}'", pdfFileName));

            if (File.Exists(pdfFileName)) // a cached version of the PDF exists
            {
                try
                {
                    LogManager.GetLogger(GetType()).Debug(string.Format("Retrieving cached file '{0}'", pdfFileName));
                    SendDocumentToBrowser(File.ReadAllBytes(pdfFileName));
                }
                catch (Exception e)
                {
                    LogManager.GetLogger(GetType()).Error(string.Format("Problem reading cached pdf file '{0}'", pdfFileName), e);
                }    
            }
            else // no cached version
            {
                string errorMessage = string.Empty;
                try
                {
                    errorMessage = "Could not generate PDF file: '{0}'";
                    var pdfBytes = GeneratePdfFile();

                    if(PageToConvert.PageTypeName == "LargeDocument")
                        WritePdfToCache(pdfBytes, pdfFileName);

                    errorMessage = "Could not send PDF file to browser: '{0}'";
                    SendDocumentToBrowser(pdfBytes);
                }
                catch (Exception e)
                {
                    LogManager.GetLogger(GetType()).Error(string.Format(errorMessage, pdfFileName), e);
                }
            }
        }

        private void WritePdfToCache(byte[] pdfBytes, string pdfFileName)
        {
            try
            {
                LogManager.GetLogger(GetType()).Debug(string.Format("Caching file '{0}'", pdfFileName));
                File.WriteAllBytes(pdfFileName, pdfBytes);
            }
            catch (Exception e)
            {
                LogManager.GetLogger(GetType()).Error(string.Format("Could not write PDF file to cache: '{0}'", pdfFileName));
            }
        }


        public static string GetPdfFileName(PageData page)
        {
            return Path.Combine(
                ConfigurationManager.AppSettings["PdfConverterTempfiles"], 
                page.PageName + ".pdf");
        }

        private byte[] GeneratePdfFile()
        {
            var pdfConverter = new PdfConverter();
            SetPdfDefaults(pdfConverter);

            InitializeToc(pdfConverter);
            AddHeader(pdfConverter);
            //AddFooter(pdfConverter);
            var guid = CachePageRefWithGuidKey(PageToConvert.PageLink);
            var rendererUrl = GetRendererUrl(guid);
            LogManager.GetLogger(GetType()).Debug(string.Format("Creating PDF using renderer url = '{0}'", rendererUrl));

            var pdfDocument = pdfConverter.GetPdfDocumentObjectFromUrl(rendererUrl);
            GenerateToc(pdfConverter, pdfDocument);

            byte[] pdfBytes;
            try
            {
                pdfBytes = pdfDocument.Save();
            }
            finally
            {
                // close the Document to realease all the resources
                pdfDocument.Close();
            }

            return pdfBytes;
        }

        private void InitializeToc(PdfConverter pdfConverter)
        {
            _tocEntriesCount = DataFactory.Instance.GetDescendents(PageToConvert.PageLink).Count;

            // Inform the converter about the HTML elements for which we want the location in PDF
            // In this sample we want the location of the entries in the Table of Contents
            // The HTML ID of each entry in the table of contents is of form TOCEntry_{EntryIndex}_ID
            // the HTML ID of each target of a table of contents entry is of form TOCEntry_{EntryIndex}_Target_ID

            // Both toc entries and toc entries targets locations in PDF will be retrieved
            // and therefore the number of IDs is twice TOC entries number
            pdfConverter.HtmlElementsMappingOptions.HtmlElementSelectors = new string[2 * _tocEntriesCount];

            int mappingsTableIdx = 0;
            for (int tocEntryIndex = 1; tocEntryIndex <= _tocEntriesCount; tocEntryIndex++)
            {
                // add the HTML ID of the TOC entry element to the list of elements for which we want the PDF location
                string tocEntryID = String.Format("#TOCEntry_{0}_ID", tocEntryIndex);
                pdfConverter.HtmlElementsMappingOptions.HtmlElementSelectors[mappingsTableIdx++] = tocEntryID;

                // add the HTML ID of the TOC entry target element to the list of elements for which we want the PDF location
                string tocEntryTargetID = String.Format("#TOCEntry_{0}_Target_ID", tocEntryIndex);
                pdfConverter.HtmlElementsMappingOptions.HtmlElementSelectors[mappingsTableIdx++] = tocEntryTargetID;
            }
        }

        private void GenerateToc(PdfConverter pdfConverter, Document pdfDocument)
        {
            // Create a font used to write the page numbers in the table of contents
            var pageNumberFont = pdfDocument.Fonts.Add(new Font("Times New Roman", PAGE_NUMBER_FONT_SIZE, FontStyle.Regular, GraphicsUnit.Point), true);

            // get the right edge of the table of contents where to position the page numbers
            float tocEntryMaxRight = 0.0f;
            for (int tocEntryIdx = 1; tocEntryIdx <= _tocEntriesCount; tocEntryIdx++)
            {
                string tocEntryID = String.Format("TOCEntry_{0}_ID", tocEntryIdx);
                HtmlElementMapping tocEntryLocation = pdfConverter.HtmlElementsMappingOptions.HtmlElementsMappingResult.GetElementByHtmlId(tocEntryID);
                if (tocEntryLocation != null && tocEntryLocation.PdfRectangles[0].Rectangle.Right > tocEntryMaxRight)
                    tocEntryMaxRight = tocEntryLocation.PdfRectangles[0].Rectangle.Right;
            }
            
            // Add page number for each entry in the table of contents
            for (int tocEntryIdx = 1; tocEntryIdx <= _tocEntriesCount; tocEntryIdx++)
            {
                string tocEntryID = String.Format("TOCEntry_{0}_ID", tocEntryIdx);
                string tocEntryTargetID = String.Format("TOCEntry_{0}_Target_ID", tocEntryIdx);

                var tocEntryLocation = pdfConverter.HtmlElementsMappingOptions.HtmlElementsMappingResult.GetElementByHtmlId(tocEntryID);
                var tocEntryTargetLocation = pdfConverter.HtmlElementsMappingOptions.HtmlElementsMappingResult.GetElementByHtmlId(tocEntryTargetID);

                if (tocEntryLocation == null || tocEntryTargetLocation == null)
                    continue;

                // get the TOC entry page and bounds
                var tocEntryPdfPage = pdfDocument.Pages[tocEntryLocation.PdfRectangles[0].PageIndex];
                var tocEntryPdfRectangle = tocEntryLocation.PdfRectangles[0].Rectangle;

                // get the page number of target where the TOC entry points
                int tocEntryTargetPageNumber = tocEntryTargetLocation.PdfRectangles[0].PageIndex + 1;

                CreatePageNumberLine(tocEntryPdfPage, tocEntryMaxRight, tocEntryPdfRectangle);
                CreatePageNumber(pageNumberFont, tocEntryPdfPage, tocEntryPdfRectangle, tocEntryTargetPageNumber, tocEntryMaxRight);
            }
        }

        private static void CreatePageNumberLine(PdfPage tocEntryPdfPage, float tocEntryMaxRight, RectangleF tocEntryPdfRectangle)
        {
            var startY = tocEntryPdfRectangle.Y + tocEntryPdfRectangle.Height - 0.5f;
            var lineToNumber = new LineElement(
                tocEntryPdfRectangle.Right + 5, 
                startY, 
                465 - 3, //tocEntryMaxRight + 80, 
                startY);

            lineToNumber.LineStyle.LineWidth = 0.5f;
            lineToNumber.LineStyle.LineDashStyle = LineDashStyle.Solid;
            lineToNumber.ForeColor = Color.Black;
            tocEntryPdfPage.AddElement(lineToNumber);
        }

        private static void CreatePageNumber(PdfFont pageNumberFont, PdfPage tocEntryPdfPage, RectangleF tocEntryPdfRectangle, int tocEntryTargetPageNumber, float tocEntryMaxRight)
        {
            var pageNumberTextEement = new TextElement(
                465, //tocEntryMaxRight + 85,
                tocEntryPdfRectangle.Y + 3, - 1,
                tocEntryPdfRectangle.Height,
                tocEntryTargetPageNumber.ToString(),
                pageNumberFont);

            tocEntryPdfPage.AddElement(pageNumberTextEement);
        }

        private static void SetPdfDefaults(PdfConverter pdfConverter)
        {
            pdfConverter.LicenseKey = ConfigurationManager.AppSettings["PdfConverterLicenseKey"];

            //pdfConverter.PdfViewerPreferences.PageMode = ViewerPageMode.UseOutlines; // open doucment with bookmarks showing
            
            pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4;
            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PdfPageOrientation.Portrait;
            pdfConverter.AvoidImageBreak = true;

            pdfConverter.PdfDocumentOptions.LeftMargin = 60;
            pdfConverter.PdfDocumentOptions.RightMargin = 60;
            pdfConverter.PdfDocumentOptions.TopMargin = 40;
            pdfConverter.PdfDocumentOptions.BottomMargin = 40;
            //pdfConverter.PdfDocumentOptions.FitWidth = true;
            //pdfConverter.PageWidth = 1800;
            
            pdfConverter.PdfDocumentInfo.AuthorName = "Helsetilsynet";

            pdfConverter.PdfBookmarkOptions.HtmlElementSelectors = new[] { "H1", "H2" };
        }
        private void AddHeader(PdfConverter pdfConverter)
        {
           string headerAndFooterHtmlUrl = GetRendererUrlHeaderFooter(isHeader:true);

            //enable header
            pdfConverter.PdfDocumentOptions.ShowHeader = true;
            // set the header height in points
            pdfConverter.PdfHeaderOptions.HeaderHeight = 40;
            pdfConverter.PdfHeaderOptions.DrawHeaderLine = false;
            if(PageToConvert.PageTypeName == "LargeDocument")
                pdfConverter.PdfHeaderOptions.ShowOnFirstPage = false;
            // set the header HTML area
            pdfConverter.PdfHeaderOptions.HtmlToPdfArea = new HtmlToPdfArea(0, 0, 0, pdfConverter.PdfHeaderOptions.HeaderHeight, headerAndFooterHtmlUrl, 1024, 0);

            pdfConverter.PdfHeaderOptions.TextArea = new TextArea(5, 10, "Side &p; av &P;  ", new Font("Times New Roman", 8, GraphicsUnit.Point));
            pdfConverter.PdfHeaderOptions.TextArea.ForeColor = Color.Gray;
            pdfConverter.PdfHeaderOptions.TextArea.TextAlign = HorizontalTextAlign.Right;

            if(PageToConvert.PageName.Length>110 )
            {
                string pageNameInHeader = PageToConvert.PageName;
                if(pageNameInHeader.Length > 190)
                {
                    var pageNameEnd = pageNameInHeader.LastIndexOf(' ', 190);
                    pageNameInHeader = pageNameInHeader.Substring(0, pageNameEnd);
                    pageNameInHeader += "...";
                    
                }
                pdfConverter.PdfHeaderOptions.AddTextArea(new TextArea(74, 6, 324, 20, pageNameInHeader, new Font("Times New Roman", 8, GraphicsUnit.Point), 
                    Color.Gray));
            }

            else
                pdfConverter.PdfHeaderOptions.AddTextArea(new TextArea(74, 10, 324, PageToConvert.PageName, new Font("Times New Roman", 8, GraphicsUnit.Point),
                    Color.Gray));

            
            //pdfConverter.PdfHeaderOptions.HtmlToPdfArea.FitHeight = true;
            pdfConverter.PdfHeaderOptions.HtmlToPdfArea.EmbedFonts = false;
        }

        private void AddFooter(PdfConverter pdfConverter)
        {
            string headerAndFooterHtmlUrl = GetRendererUrlHeaderFooter(isHeader:false);

            //enable footer
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            pdfConverter.PdfFooterOptions.DrawFooterLine = false;
            if (PageToConvert.PageTypeName == "LargeDocument")
                pdfConverter.PdfFooterOptions.ShowOnFirstPage = false;
            // set the footer height in points
            pdfConverter.PdfFooterOptions.FooterHeight = 40;
            //write the page number
            pdfConverter.PdfFooterOptions.TextArea = new TextArea(5, 16, "Side &p; av &P;  ", new Font("Times New Roman", 10, GraphicsUnit.Point));
            pdfConverter.PdfFooterOptions.TextArea.ForeColor = Color.Gray;
            pdfConverter.PdfFooterOptions.TextArea.TextAlign = HorizontalTextAlign.Right;
                    
            // set the footer HTML area
            pdfConverter.PdfFooterOptions.AddTextArea(new TextArea(5, 16, 1024, PageToConvert.PageName, new Font("Times New Roman", 10, GraphicsUnit.Point), Color.Gray));
            pdfConverter.PdfFooterOptions.HtmlToPdfArea = new HtmlToPdfArea(0, 0, 0, pdfConverter.PdfFooterOptions.FooterHeight+10,
                        headerAndFooterHtmlUrl, 1024, 0);
            //pdfConverter.PdfFooterOptions.HtmlToPdfArea.FitHeight = true;
            //pdfConverter.PdfFooterOptions.HtmlToPdfArea.EmbedFonts = false;
        }
        

/*
        private void AddHeader(PdfConverter pdfConverter)
        {

            pdfConverter.PdfDocumentOptions.ShowHeader = true;
            pdfConverter.PdfHeaderOptions.ShowOnFirstPage = false;
            pdfConverter.PdfHeaderOptions.HeaderHeight = 50;
            pdfConverter.PdfHeaderOptions.HeaderLineColor = Color.Gray;
            //pdfConverter.PdfHeaderOptions.HeaderTextFontSize = 16;
            pdfConverter.PdfHeaderOptions.HeaderSubtitleText = "Helsetilsynet";
            pdfConverter.PdfHeaderOptions.HeaderSubtitleTextFontType = PdfFontType.Helvetica;
            pdfConverter.PdfHeaderOptions.HeaderTitleSubtitleYSpacing = 7;
            pdfConverter.PdfHeaderOptions.HeaderBackColor = Color.WhiteSmoke;
            pdfConverter.PdfHeaderOptions.HeaderText = LargeDocument.PageName;
            pdfConverter.PdfHeaderOptions.HeaderTextAlign = HorizontalTextAlign.Center;
            pdfConverter.PdfHeaderOptions.HeaderTextFontType = PdfFontType.Helvetica;
            pdfConverter.PdfHeaderOptions.HeaderTextYLocation = 18;
            pdfConverter.PdfHeaderOptions.HeaderSubtitleTextColor = Color.Gray;
            pdfConverter.PdfHeaderOptions.HeaderSubtitleTextFontSize = 12;
            pdfConverter.PdfHeaderOptions.HeaderImageLocation = new PointF(0, 0);

            var logoPath = Server.MapPath("/Templates/styles/images/pdf-logo.png");
            LogManager.GetLogger(GetType()).Debug(string.Format("Setting header logoPath = '{0}'", logoPath));
//TODO:            pdfConverter.PdfHeaderOptions.HeaderImage = Image.FromFile(logoPath);
            pdfConverter.PdfHeaderOptions.DrawHeaderLine = true;
            pdfConverter.PdfHeaderOptions.HeaderLineColor = Color.Gray;
         }
 */       

        /*
        private void AddFooter(PdfConverter pdfConverter)
        {
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            pdfConverter.PdfFooterOptions.ShowOnFirstPage = false;

            pdfConverter.PdfFooterOptions.FooterBackColor = Color.WhiteSmoke;
            pdfConverter.PdfFooterOptions.FooterTextColor = Color.Gray;
            pdfConverter.PdfFooterOptions.FooterTextFontSize = 8;
            pdfConverter.PdfFooterOptions.PageNumberText = "Side";
            pdfConverter.PdfFooterOptions.PageNumberTextFontType = PdfFontType.HelveticaBold;
            pdfConverter.PdfFooterOptions.ShowPageNumber = true;
            pdfConverter.PdfFooterOptions.FooterText = LargeDocument.PageName;
            pdfConverter.PdfFooterOptions.FooterHeight = 40;
            pdfConverter.PdfFooterOptions.FooterTextFontType = PdfFontType.HelveticaOblique;
            pdfConverter.PdfFooterOptions.DrawFooterLine = true;
            pdfConverter.PdfFooterOptions.PageNumberTextColor = Color.Gray;
            pdfConverter.PdfFooterOptions.PageNumberTextFontSize = 8;
            pdfConverter.PdfFooterOptions.FooterLineColor = Color.Gray;
        }
        */

        private void SendDocumentToBrowser(byte[] documentBytes)
        {
            try
            {
                var response = HttpContext.Current.Response;
                var attachment = string.Format("attachment; filename={0}.pdf; size={1}", HttpUtility.UrlEncode(PageToConvert.PageName), documentBytes.Length);
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");
                response.AddHeader("Content-Disposition", attachment);
                response.BinaryWrite(documentBytes);
                response.Flush();
                response.End();

                ////http://scottstoecker.wordpress.com/2012/01/12/fixing-threadabortexception-when-using-response-end/
                //HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception e)
            {
                LogManager.GetLogger(GetType()).Error(string.Format("Problem sending document to browser."), e);
            }
        }

        private string GetRendererUrl(string encryptedName)
        {
            //return GetFriendlyURL(CurrentPage, true);
            var startPage = DataFactory.Instance.GetPage(PageReference.StartPage);
            var pdfRendererPage = DataFactory.Instance.GetPage(new PageReference(startPage.Property["PdfRenderer"].ToString()));
            var friendlyURL = GetFriendlyURL(pdfRendererPage, true); var separator = friendlyURL.Contains("?") ? "&" : "?";
            friendlyURL += string.Format("{0}{1}={2}&{3}={4}",
                                         separator,
                                         GlobalName.QueryStringName.PdfView,
                                         encryptedName,
                                         GlobalName.QueryStringName.Section,
                                         GlobalName.QueryStringName.SectionValue.Main
                );

            return friendlyURL;
        }        
        
        private string GetRendererUrlHeaderFooter(bool isHeader)
        {
            var sectionValue = isHeader
                                   ? GlobalName.QueryStringName.SectionValue.Header
                                   : GlobalName.QueryStringName.SectionValue.Footer;
            var startPage = DataFactory.Instance.GetPage(PageReference.StartPage);
            var pdfRendererPage = DataFactory.Instance.GetPage(new PageReference(startPage.Property["PdfRenderer"].ToString()));
            var friendlyURL = GetFriendlyURL(pdfRendererPage, true);
            var separator = friendlyURL.Contains("?") ? "&" : "?";
            friendlyURL += string.Format("{0}{1}={2}", separator, GlobalName.QueryStringName.Section, sectionValue);
            //return GetFriendlyURL(CurrentPage, true);
            return friendlyURL;
        }

        private string CachePageRefWithGuidKey(PageReference largeDocument)
        {
            var guid = Guid.NewGuid().ToString();
            Cache.Insert(guid, largeDocument.ID, null, DateTime.Now.AddMinutes(1), new TimeSpan());

            return guid;
        }
        public static string GetFriendlyURL(PageData page, bool includeDomainName)
        {
            if (page != null)
            {
                var url = new UrlBuilder(page.LinkURL);

                PropertyLinkType linkType = (PropertyLinkType)page.Property["PageShortcutType"];
                if (LinkType.External.Equals(linkType.Link))
                    return (url.ToString());

                EPiServer.Global.UrlRewriteProvider.ConvertToExternal(url, page.PageLink, System.Text.Encoding.UTF8);
                string urlString = url.ToString();

                if (includeDomainName)
                {
                    if (urlString.StartsWith("/"))
                        urlString = urlString.Substring(1);

                    return EPiServer.Configuration.Settings.Instance.SiteUrl + urlString;
                }

                return urlString;
            }
            return "";
        }
    }
}