using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Text;
using System.Net;
using System.IO;

namespace Avenir
{
    //Anvendelse: q = new Nyno(q).Query;
    public class Nyno
    {
        public string Query { get; set; }
        public bool Testing { get; set; }

        private Hashtable configH = new Hashtable();
        private string configS = string.Empty;

        public Nyno(string q, string conf, bool test)
        {
            Testing = test;
            InitConfig();
            SetConfig(conf);
            Run(q);
        }


        public Nyno(string q, string conf)
        {
            Testing = false;
            InitConfig();
            SetConfig(conf);
            Run(q);
        }

        public Nyno(string q)
        {
            Testing = false;
            InitConfig();
            Run(q);
        }

        private void InitConfig()
        {
            configH["pq"] = "query";
            configH["pcharset"] = "UTF-8";
            configH["pqsntx"] = "standard";
            configH["ppwd"] = "local";
            configH["puser"] = "local";
            configH["prealm"] = "local";
            configH["pu"] = @"http://www.helsetilsynet.no.epi5-hotel.osl.basefarm.net/templates/avenir/pages";
            configH["px"] = "px+pq+pcharset+pqsntx+ppwd+puser+prealm+pu";
            //configH["query"] = "";
        }

        private void SetConfig(string conf)
        {
            string[] confs = conf.Split('&');
            string value;
            string key;
            foreach (string item in confs)
            {
                if (FindKeyValue(item,out key,out value))
                    configH[key] = value;
            }
        }

        private bool FindKeyValue(string inn, out string key, out string value)
        {
            int p = inn.IndexOf('=');
            key = string.Empty;
            value = string.Empty;
            if (p < 1)
                return false;
            key = inn.Substring(0, p);
            value = inn.Substring(p + 1);
            return true;
        }

        private string GetConfig()
        {
            string s = string.Empty;
            string skill = string.Empty;
            foreach (DictionaryEntry item in configH)
	        {
                s += skill + item.Key + "=" + item.Value;
                skill = "&";
	        }
            return s;
        }

        private void Run (string query)
        {
            String resultData = HttpUtility.UrlEncode(query);
            //string link = "http://hts-nyno01.osl.basefarm.net:8090/ts/svc/rewrite";
            string link = System.Configuration.ConfigurationManager.AppSettings["NynoLink"];
            ASCIIEncoding encoding = new ASCIIEncoding();
            string postData = GetConfig()+ "&query=" + query;
            byte[] data = encoding.GetBytes(postData);

            // Prepare web request...
            HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(link);
            myRequest.Timeout = 1000;
            myRequest.Method = "POST";
            myRequest.ContentType = "application/x-www-form-urlencoded";
            myRequest.ContentLength = data.Length;
            try
            {
                Stream newStream = myRequest.GetRequestStream();
                // Send the data.
                newStream.Write(data, 0, data.Length);
                newStream.Close();
                // Assign the response object of 'HttpWebRequest' to a 'HttpWebResponse' variable.
                HttpWebResponse myHttpWebResponse = (HttpWebResponse)myRequest.GetResponse();
                // Display the contents of the page to the console.
                Stream streamResponse = myHttpWebResponse.GetResponseStream();
                // Get stream object
                StreamReader streamRead = new StreamReader(streamResponse);
                Char[] readBuffer = new Char[256];
                // Read from buffer
                int count = streamRead.Read(readBuffer, 0, 256);
                resultData = string.Empty;
                while (count > 0)
                {
                    resultData += new String(readBuffer, 0, count);
                    // Write the data 
                    //Console.WriteLine(resultData);
                    // Read from buffer
                    count = streamRead.Read(readBuffer, 0, 256);
                }
                if (resultData.Length > 8)
                    resultData = resultData.Substring(7);
                // Release the response object resources.
                streamRead.Close();
                if (streamResponse != null) streamResponse.Close();
                // Close response
                myHttpWebResponse.Close();
            }
            catch (Exception e)
            {
                if (Testing)
                {
                    Query = resultData + " ERROR: " + e.Message + "<br /><br />" + postData;
                    return;
                }
            }
            if (resultData.Contains('?'))
                resultData = query;
            Query = resultData;
            if (Testing)
            {
                Query  += "<br /><br />" + postData;
                return;
            }
        }

    }
}
