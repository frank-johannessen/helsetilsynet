/*
Copyright © 1997-2003 ElektroPost Stockholm AB. All Rights Reserved.

This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidded without prior written permission from ElektroPostf
Stockholm AB.

EPiServer is a registered trademark of ElektroPost Stockholm AB. For
more information see http://www.episerver.com/license or request a
copy of the EPiServer License Agreement by sending an email to info@ep.se
*/

using EPiServer;
using System;
using Winnovative.WnvHtmlConvert;

namespace Avenir.Templates.Pages
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public partial class Pdf : TemplatePage
	{

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            ConvertUrltoPdf();
        }

        /// <summary>
        /// Convert the HTML code from the specified URL to a PDF document and send the 
        /// document as an attachment to the browser
        /// </summary>
        private void ConvertUrltoPdf()
        {
            if (Request.UrlReferrer != null)
            {
                string refUrl = Request.UrlReferrer.AbsoluteUri; // Request.servervariables("http_referer"); 

                string urlToConvert = refUrl +"?pdf=true"; // "http://localhost:17000/no/Tilsyn-funn-avgjorelser-metoder/Omradeovervaking/?pdf=true";
                bool selectablePDF = true;

                // Create the PDF converter.Optionally you can specify the virtual browser 

                // width as parameter. 1024 pixels is default, 0 means autodetect

                PdfConverter pdfConverter = new PdfConverter();

                // set the new PdfConverter();license key

                pdfConverter.LicenseKey = "IAsRABEAFgAWDhAAExEOERIOGRkZGQ==";

                //pdfConverter.HtmlExcludedRegionsOptions.HtmlElementIds = new string[] { "top", "menuAndSearch", "left", "right", "footer", "tools", "social", "pageUtilities" };
                pdfConverter.HtmlExcludedRegionsOptions.HtmlElementIds = new[] { "footer", "creditline" };
                //
                // set the converter options
                pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4;
                pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
                pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
                pdfConverter.PdfDocumentOptions.ShowHeader = true;
                pdfConverter.PdfDocumentOptions.ShowFooter = false;
                pdfConverter.AvoidImageBreak = true;

                pdfConverter.PdfDocumentOptions.LeftMargin = 100; // 85; // 40;
                pdfConverter.PdfDocumentOptions.RightMargin = 40; // 20;
                pdfConverter.PdfDocumentOptions.TopMargin = 10;
                pdfConverter.PdfDocumentOptions.BottomMargin = 30;
                //pdfConverter.PdfDocumentOptions.FitWidth = true;
                //pdfConverter.PageWidth = 1800;
                //.FitWidth = true;
                pdfConverter.PdfHeaderOptions.HeaderHeight = 40;
                pdfConverter.PdfHeaderOptions.HeaderText = "Dokumentet er hentet fra http://www.helsetilsynet.no";
                pdfConverter.PdfHeaderOptions.HeaderTextFontSize = 9;
                pdfConverter.PdfHeaderOptions.HeaderTextFontType = PdfFontType.Helvetica;
                pdfConverter.PdfHeaderOptions.HeaderTextAlign = HorizontalTextAlign.Left;
                pdfConverter.PdfHeaderOptions.HeaderTextYLocation = 5;
                pdfConverter.PdfHeaderOptions.DrawHeaderLine = false;
                //string imagePath = System.IO.Path.Combine(Server.MapPath("~"), "templates/avenir/images/logoHelsetilsynet.png");
                //ImageElement imageE = new ImageElement(0,0,System.IO.Path.Combine(imagePath,"logoHelsetilsynet.png"));
                //ImageArea imageA = new ImageArea(0,40,300,System.IO.Path.Combine(imagePath,"logoHelsetilsynet.png"));
                //pdfConverter.PdfHeaderOptions.AddImageArea(imageA);
                //pdfConverter.PdfHeaderOptions.ImageArea.ImageObj.
                //pdfConverter.PdfHeaderOptions.HeaderImageLocation = new System.Drawing.PointF(0, 40);


                //string filename = AppDomain.CurrentDomain.BaseDirectory + "/templates/avenir/images/htillogo_skrivut_screen.gif";
                //ImageArea imageA = new ImageArea(0, 20, 256, filename);
                //pdfConverter.PdfHeaderOptions.AddImageArea(imageA);

                //pdfConverter.PdfHeaderOptions.HeaderImageLocation = new System.Drawing.PointF(12, 40);
                //pdfConverter.PdfHeaderOptions.HeaderImage = System.Drawing.Image.FromFile(AppDomain.CurrentDomain.BaseDirectory + "/templates/avenir/images/htillogo_skrivut_screen.gif");

                //pdfConverter.PdfHeaderOptions.ShowOnFirstPage = true;
                //pdfConverter.PdfHeaderOptions.ShowOnEvenPages = false;
                //pdfConverter.PdfHeaderOptions.ShowOnOddPages = false;
                // set to generate selectable pdf or a pdf with embedded image
                pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = selectablePDF;

                // Performs the conversion and get the pdf document bytes that you can further 

                // save to  a file or send as a browser response

                byte[] pdfBytes = pdfConverter.GetPdfFromUrlBytes(urlToConvert);

                // send the PDF document as a response to the browser for download

                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.Clear();
                response.AddHeader("Content-Type", "binary/octet-stream");

                response.AddHeader("Content-Disposition",
                                   "attachment;filename=ConversionResult.pdf; size=" + pdfBytes.Length);
                response.Flush();
                response.BinaryWrite(pdfBytes);
                response.Flush();
                response.End();
            }
        }
    
    
    }
}
