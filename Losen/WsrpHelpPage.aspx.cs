using System.Collections;
using System.IO;
using System.Xml.Serialization;
using System.Xml;
using System.Xml.Schema;
using System.Web.Services.Description;
using System;
using System.Globalization;
using System.Resources;
using System.Diagnostics;
using System.Net;
using System.Web;
using System.Text;
namespace development
{
	/// <summary>
	/// Summary description for WsrpHelpPage.
	/// </summary>
	public class WsrpHelpPage : System.Web.UI.Page
	{

		protected System.Web.UI.WebControls.Repeater MethodList;
		// set this to true if you want to see a POST test form instead of a GET test form
		protected bool showPost = true;

		// set this to true if you want to see the raw XML as outputted from the XmlWriter (useful for debugging)
		protected bool dontFilterXml = false;
    
		// set this higher or lower to adjust the depth into your object graph of the sample messages
		protected int maxObjectGraphDepth = 4;

		// set this higher or lower to adjust the number of array items in sample messages
		protected int maxArraySize = 2;

		// set this to true to see debug output in sample messages
		protected bool debug = false;
    
		protected string soapNs = "http://schemas.xmlsoap.org/soap/envelope/";
		protected string soapEncNs = "http://schemas.xmlsoap.org/soap/encoding/";
		protected string msTypesNs = "http://microsoft.com/wsdl/types/";
		protected string wsdlNs = "http://schemas.xmlsoap.org/wsdl/";

		protected string urType = "anyType";

		protected ServiceDescriptionCollection serviceDescriptions;
		protected XmlSchemas schemas;
		protected string operationName;
		protected OperationBinding soapOperationBinding;
		protected Operation soapOperation;
		protected OperationBinding httpGetOperationBinding;
		protected Operation httpGetOperation;
		protected OperationBinding httpPostOperationBinding;
		protected Operation httpPostOperation;
		protected StringWriter writer;
		protected MemoryStream xmlSrc;
		protected XmlTextWriter xmlWriter;
		protected Uri getUrl, postUrl;
		protected Queue referencedTypes;
		protected int hrefID;
		protected bool operationExists = false;
		protected int nextPrefix = 1;
		protected static readonly char[] hexTable = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		protected bool requestIsLocal = false;

		protected string OperationName 
		{
			get { return operationName; }
		}

		protected string ServiceName 
		{ 
			get { return serviceDescriptions[0].Services[0].Name; }
		}

		protected string ServiceNamespace 
		{
			get { return serviceDescriptions[0].TargetNamespace; }
		}

		protected string ServiceDocumentation 
		{ 
			get { return serviceDescriptions[0].Services[0].Documentation; }
		}

		protected string FileName 
		{
			get 
			{ 
				return Path.GetFileName(Request.Path);
			}
		}

		protected string EscapedFileName 
		{
			get 
			{ 
				return HttpUtility.UrlEncode(FileName, Encoding.UTF8);
			}
		}

		protected bool ShowingMethodList 
		{
			get { return operationName == null; }
		}

		protected bool OperationExists 
		{
			get { return operationExists; }
		}

		// encodes a Unicode string into utf-8 bytes then copies each byte into a new Unicode string,
		// escaping bytes > 0x7f, per the URI escaping rules
		protected static string UTF8EscapeString(string source) 
		{
			byte[] bytes = Encoding.UTF8.GetBytes(source);
			StringBuilder sb = new StringBuilder(bytes.Length); // start out with enough room to hold each byte as a char
			for (int i = 0; i < bytes.Length; i++) 
			{
				byte b = bytes[i];
				if (b > 0x7f) 
				{
					sb.Append('%');
					sb.Append(hexTable[(b >> 4) & 0x0f]);
					sb.Append(hexTable[(b     ) & 0x0f]);
				}
				else
					sb.Append((char)b);
			}
			return sb.ToString();
		}

		protected string EscapeParam(string param) 
		{
			return HttpUtility.UrlEncode(param, Request.ContentEncoding);
		}

		protected XmlQualifiedName XmlEscapeQName(XmlQualifiedName qname) 
		{
			return new XmlQualifiedName(XmlConvert.EncodeLocalName(qname.Name), qname.Namespace);
		}

		protected string SoapOperationInput 
		{
			get 
			{ 
				if (SoapOperationBinding == null) return "";
				WriteBegin();

				Port port = FindPort(SoapOperationBinding.Binding);
				SoapAddressBinding soapAddress = (SoapAddressBinding)port.Extensions.Find(typeof(SoapAddressBinding));

				string action = UTF8EscapeString(((SoapOperationBinding)SoapOperationBinding.Extensions.Find(typeof(SoapOperationBinding))).SoapAction);

				Uri uri = new Uri(soapAddress.Location, false);

				Write("POST ");
				Write(uri.AbsolutePath);
				Write(" HTTP/1.1");
				WriteLine();

				Write("Host: ");
				Write(uri.Host);
				WriteLine();

				Write("Content-Type: text/xml; charset=utf-8");
				WriteLine();

				Write("Content-Length: ");
				WriteValue("length");
				WriteLine();

				Write("SOAPAction: \"");
				Write(action);
				Write("\"");
				WriteLine();

				WriteLine();
            
				WriteSoapMessage(SoapOperationBinding.Input, serviceDescriptions.GetMessage(SoapOperation.Messages.Input.Message));
				return WriteEnd();
			}
		}

		protected string SoapOperationOutput 
		{
			get 
			{ 
				if (SoapOperationBinding == null) return "";
				WriteBegin();
				if (SoapOperationBinding.Output == null) 
				{
					Write("HTTP/1.1 202 Accepted");
					WriteLine();
				}
				else 
				{
					Write("HTTP/1.1 200 OK");
					WriteLine();
					Write("Content-Type: text/xml; charset=utf-8");
					WriteLine();
					Write("Content-Length: ");
					WriteValue("length");
					WriteLine();
					WriteLine();

					WriteSoapMessage(SoapOperationBinding.Output, serviceDescriptions.GetMessage(SoapOperation.Messages.Output.Message));
				}
				return WriteEnd();
			}
		}

		protected OperationBinding SoapOperationBinding 
		{
			get 
			{ 
				if (soapOperationBinding == null)
					soapOperationBinding = FindBinding(typeof(SoapBinding));
				return soapOperationBinding;
			}
		}

		protected Operation SoapOperation 
		{
			get 
			{ 
				if (soapOperation == null)
					soapOperation = FindOperation(SoapOperationBinding);
				return soapOperation;
			}
		}

		protected bool ShowingSoap 
		{
			get 
			{ 
				return SoapOperationBinding != null; 
			}
		}

		private static string GetEncodedNamespace(string ns) 
		{
			if (ns.EndsWith("/"))
				return ns + "encodedTypes";
			else return ns + "/encodedTypes";
		}

		protected void WriteSoapMessage(MessageBinding messageBinding, Message message) 
		{
			SoapOperationBinding soapBinding = (SoapOperationBinding)SoapOperationBinding.Extensions.Find(typeof(SoapOperationBinding));
			SoapBodyBinding soapBodyBinding = (SoapBodyBinding)messageBinding.Extensions.Find(typeof(SoapBodyBinding));
			bool rpc = soapBinding != null && soapBinding.Style == SoapBindingStyle.Rpc;
			bool encoded = soapBodyBinding.Use == SoapBindingUse.Encoded;

			xmlWriter.WriteStartDocument();
			xmlWriter.WriteStartElement("soap", "Envelope", soapNs);
			DefineNamespace("xsi", XmlSchema.InstanceNamespace);
			DefineNamespace("xsd", XmlSchema.Namespace);
			if (encoded) 
			{
				DefineNamespace("soapenc", soapEncNs);
				string targetNamespace = message.ServiceDescription.TargetNamespace;
				DefineNamespace("tns", targetNamespace);
				DefineNamespace("types", GetEncodedNamespace(targetNamespace));
			}

			SoapHeaderBinding[] headers = (SoapHeaderBinding[])messageBinding.Extensions.FindAll(typeof(SoapHeaderBinding));
			if (headers.Length > 0) 
			{
				xmlWriter.WriteStartElement("Header", soapNs);
				foreach (SoapHeaderBinding header in headers) 
				{
					Message headerMessage = serviceDescriptions.GetMessage(header.Message);
					if (headerMessage != null) 
					{
						MessagePart part = headerMessage.Parts[header.Part];
						if (part != null) 
						{
							if (encoded)
								WriteType(part.Type, part.Type, XmlSchemaForm.Qualified, -1, 0, false);
							else
								WriteTopLevelElement(XmlEscapeQName(part.Element), 0);
						}
					}
				}
				if (encoded)
					WriteQueuedTypes();
				xmlWriter.WriteEndElement();
			}

			xmlWriter.WriteStartElement("Body", soapNs);
			if (soapBodyBinding.Encoding != null && soapBodyBinding.Encoding != String.Empty)
				xmlWriter.WriteAttributeString("encodingStyle", soapNs, soapEncNs);

			if (rpc) 
			{
				string messageName = SoapOperationBinding.Output == messageBinding ? SoapOperation.Name + "Response" : SoapOperation.Name;
				if (encoded) 
				{
					string prefix = null;
					if (soapBodyBinding.Namespace.Length > 0) 
					{
						prefix = xmlWriter.LookupPrefix(soapBodyBinding.Namespace);
						if (prefix == null)
							prefix = "q" + nextPrefix++;
					}
					xmlWriter.WriteStartElement(prefix, messageName, soapBodyBinding.Namespace);
				}
				else
					xmlWriter.WriteStartElement(messageName, soapBodyBinding.Namespace);
			}
			foreach (MessagePart part in message.Parts) 
			{
				if (encoded) 
				{
					if (rpc)
						WriteType(new XmlQualifiedName(part.Name, soapBodyBinding.Namespace), part.Type, XmlSchemaForm.Unqualified, 0, 0, true);
					else
						WriteType(part.Type, part.Type, XmlSchemaForm.Qualified, -1, 0, true); // id == -1 writes the definition without writing the id attr
				}
				else 
				{
					if (!part.Element.IsEmpty)
						WriteTopLevelElement(XmlEscapeQName(part.Element), 0);
					else
						WriteXmlValue("xml");
				}
			}
			if (rpc) 
			{
				xmlWriter.WriteEndElement();
			}
			if (encoded) 
			{
				WriteQueuedTypes();
			}            
			xmlWriter.WriteEndElement();
			xmlWriter.WriteEndElement();
		}

		protected string HttpGetOperationInput 
		{
			get 
			{ 
				if (TryGetUrl == null) return "";
				WriteBegin();

				Write("GET ");
				Write(TryGetUrl.AbsolutePath);

				Write("?");
				WriteQueryStringMessage(serviceDescriptions.GetMessage(HttpGetOperation.Messages.Input.Message));
            
				Write(" HTTP/1.1");
				WriteLine();

				Write("Host: ");
				Write(TryGetUrl.Host);
				WriteLine();

				return WriteEnd();
			}
		}

		protected string HttpGetOperationOutput 
		{
			get 
			{ 
				if (HttpGetOperationBinding == null) return "";
				if (HttpGetOperationBinding.Output == null) return "";
				Message message = serviceDescriptions.GetMessage(HttpGetOperation.Messages.Output.Message);
				WriteBegin();
				Write("HTTP/1.1 200 OK");
				WriteLine();
				if (message.Parts.Count > 0) 
				{
					Write("Content-Type: text/xml; charset=utf-8");
					WriteLine();
					Write("Content-Length: ");
					WriteValue("length");
					WriteLine();
					WriteLine();

					WriteHttpReturnPart(message.Parts[0].Element);
				}

				return WriteEnd();
			}
		}

		protected void WriteQueryStringMessage(Message message) 
		{
			bool first = true;
			foreach (MessagePart part in message.Parts) 
			{
				int count = 1;
				string typeName = part.Type.Name;
				if (part.Type.Namespace != XmlSchema.Namespace && part.Type.Namespace != msTypesNs) 
				{
					int arrIndex = typeName.IndexOf("Array");
					if (arrIndex >= 0) 
					{
						typeName = CodeIdentifier.MakeCamel(typeName.Substring(0, arrIndex));
						count = 2;
					}
				}
				for (int i=0; i<count; i++) 
				{
					if (first) 
					{
						first = false; 
					}
					else 
					{
						Write("&amp;");
					}
					Write("<font class=key>");
					Write(part.Name);
					Write("</font>=");
            
					WriteValue(typeName);
				}
			}
		}

		protected OperationBinding HttpGetOperationBinding 
		{
			get 
			{ 
				if (httpGetOperationBinding == null)
					httpGetOperationBinding = FindHttpBinding("GET");
				return httpGetOperationBinding;
			}
		}

		protected Operation HttpGetOperation 
		{
			get 
			{ 
				if (httpGetOperation == null)
					httpGetOperation = FindOperation(HttpGetOperationBinding);
				return httpGetOperation;
			}
		}

		protected bool ShowingHttpGet 
		{
			get 
			{ 
				return HttpGetOperationBinding != null; 
			}
		}

		protected string HttpPostOperationInput 
		{
			get 
			{ 
				if (TryPostUrl == null) return "";
				WriteBegin();

				Write("POST ");
				Write(TryPostUrl.AbsolutePath);

				Write(" HTTP/1.1");
				WriteLine();

				Write("Host: ");
				Write(TryPostUrl.Host);
				WriteLine();

				Write("Content-Type: application/x-www-form-urlencoded");
				WriteLine();
				Write("Content-Length: ");
				WriteValue("length");
				WriteLine();
				WriteLine();

				WriteQueryStringMessage(serviceDescriptions.GetMessage(HttpPostOperation.Messages.Input.Message));

				return WriteEnd();
			}
		}

		protected string HttpPostOperationOutput 
		{
			get 
			{ 
				if (HttpPostOperationBinding == null) return "";
				if (HttpPostOperationBinding.Output == null) return "";
				Message message = serviceDescriptions.GetMessage(HttpPostOperation.Messages.Output.Message);
				WriteBegin();
				Write("HTTP/1.1 200 OK");
				WriteLine();
				if (message.Parts.Count > 0) 
				{
					Write("Content-Type: text/xml; charset=utf-8");
					WriteLine();
					Write("Content-Length: ");
					WriteValue("length");
					WriteLine();
					WriteLine();

					WriteHttpReturnPart(message.Parts[0].Element);
				}

				return WriteEnd();
			}
		}

		protected OperationBinding HttpPostOperationBinding 
		{
			get 
			{ 
				if (httpPostOperationBinding == null)
					httpPostOperationBinding = FindHttpBinding("POST");
				return httpPostOperationBinding;
			}
		}

		protected Operation HttpPostOperation 
		{
			get 
			{ 
				if (httpPostOperation == null)
					httpPostOperation = FindOperation(HttpPostOperationBinding);
				return httpPostOperation;
			}
		}

		protected bool ShowingHttpPost 
		{
			get 
			{ 
				return HttpPostOperationBinding != null; 
			}
		}

		protected MessagePart[] TryGetMessageParts 
		{
			get 
			{ 
				if (HttpGetOperationBinding == null) return new MessagePart[0];
				Message message = serviceDescriptions.GetMessage(HttpGetOperation.Messages.Input.Message);
				MessagePart[] parts = new MessagePart[message.Parts.Count];
				message.Parts.CopyTo(parts, 0);
				return parts;
			}
		}

		protected bool ShowGetTestForm 
		{
			get 
			{
				if (!ShowingHttpGet) return false;
				Message message = serviceDescriptions.GetMessage(HttpGetOperation.Messages.Input.Message);
				foreach (MessagePart part in message.Parts) 
				{
					if (part.Type.Namespace != XmlSchema.Namespace && part.Type.Namespace != msTypesNs)
						return false;
				}
				return true;
			}
		}            

		protected Uri TryGetUrl 
		{
			get 
			{
				if (getUrl == null) 
				{
					if (HttpGetOperationBinding == null) return null;
					Port port = FindPort(HttpGetOperationBinding.Binding);
					if (port == null) return null;
					HttpAddressBinding httpAddress = (HttpAddressBinding)port.Extensions.Find(typeof(HttpAddressBinding));
					HttpOperationBinding httpOperation = (HttpOperationBinding)HttpGetOperationBinding.Extensions.Find(typeof(HttpOperationBinding));
					if (httpAddress == null || httpOperation == null) return null;
					getUrl = new Uri(httpAddress.Location + httpOperation.Location);
				}
				return getUrl;
			}
		}

		protected MessagePart[] TryPostMessageParts 
		{
			get 
			{ 
				if (HttpPostOperationBinding == null) return new MessagePart[0];
				Message message = serviceDescriptions.GetMessage(HttpPostOperation.Messages.Input.Message);
				MessagePart[] parts = new MessagePart[message.Parts.Count];
				message.Parts.CopyTo(parts, 0);
				return parts;
			}
		}

		protected bool ShowPostTestForm 
		{
			get 
			{
				if (!ShowingHttpPost) return false;
				Message message = serviceDescriptions.GetMessage(HttpPostOperation.Messages.Input.Message);
				foreach (MessagePart part in message.Parts) 
				{
					if (part.Type.Namespace != XmlSchema.Namespace && part.Type.Namespace != msTypesNs)
						return false;
				}
				return true;
			}
		}            

		protected Uri TryPostUrl 
		{
			get 
			{
				if (postUrl == null) 
				{
					if (HttpPostOperationBinding == null) return null;
					Port port = FindPort(HttpPostOperationBinding.Binding);
					if (port == null) return null;
					HttpAddressBinding httpAddress = (HttpAddressBinding)port.Extensions.Find(typeof(HttpAddressBinding));
					HttpOperationBinding httpOperation = (HttpOperationBinding)HttpPostOperationBinding.Extensions.Find(typeof(HttpOperationBinding));
					if (httpAddress == null || httpOperation == null) return null;
					postUrl = new Uri(httpAddress.Location + httpOperation.Location);
				}
				return postUrl;
			}
		}

		protected void WriteHttpReturnPart(XmlQualifiedName elementName) 
		{
			if (elementName == null || elementName.IsEmpty) 
			{
				Write("&lt;?xml version=\"1.0\"?&gt;");
				WriteLine();
				WriteValue("xml");
			}
			else 
			{
				xmlWriter.WriteStartDocument();
				WriteTopLevelElement(XmlEscapeQName(elementName), 0);
			}
		}

		protected XmlSchemaType GetPartType(MessagePart part) 
		{
			if (part.Element != null && !part.Element.IsEmpty) 
			{
				XmlSchemaElement element = (XmlSchemaElement)schemas.Find(part.Element, typeof(XmlSchemaElement));
				if (element != null) return element.SchemaType;
				return null;
			}
			else if (part.Type != null && !part.Type.IsEmpty) 
			{
				XmlSchemaType xmlSchemaType = (XmlSchemaType)schemas.Find(part.Type, typeof(XmlSchemaSimpleType));
				if (xmlSchemaType != null) return xmlSchemaType;
				xmlSchemaType = (XmlSchemaType)schemas.Find(part.Type, typeof(XmlSchemaComplexType));
				return xmlSchemaType;
			}
			return null;
		}

		protected void WriteTopLevelElement(XmlQualifiedName name, int depth) 
		{
			WriteTopLevelElement((XmlSchemaElement)schemas.Find(name, typeof(XmlSchemaElement)), name.Namespace, depth);
		}

		protected void WriteTopLevelElement(XmlSchemaElement element, string ns, int depth) 
		{
			WriteElement(element, ns, XmlSchemaForm.Qualified, false, 0, depth, false);
		}

		public class QueuedType 
		{
			internal XmlQualifiedName name;
			internal XmlQualifiedName typeName;
			internal XmlSchemaForm form;
			internal int id;
			internal int depth;
			internal bool writeXsiType;
		}

		protected void WriteQueuedTypes() 
		{
			while (referencedTypes.Count > 0) 
			{
				QueuedType q = (QueuedType)referencedTypes.Dequeue();
				WriteType(q.name, q.typeName, q.form, q.id, q.depth, q.writeXsiType);
			}
		}

		protected void AddQueuedType(XmlQualifiedName name, XmlQualifiedName type, int id, int depth, bool writeXsiType) 
		{
			AddQueuedType(name, type, XmlSchemaForm.Unqualified, id, depth, writeXsiType);
		}

		protected void AddQueuedType(XmlQualifiedName name, XmlQualifiedName typeName, XmlSchemaForm form, int id, int depth, bool writeXsiType) 
		{
			QueuedType q = new QueuedType();
			q.name = name;
			q.typeName = typeName;
			q.form = form;
			q.id = id;
			q.depth = depth;
			q.writeXsiType = writeXsiType;
			referencedTypes.Enqueue(q);
		}

		protected void WriteType(XmlQualifiedName name, XmlQualifiedName typeName, int id, int depth, bool writeXsiType) 
		{
			WriteType(name, typeName, XmlSchemaForm.None, id, depth, writeXsiType);
		}

		protected void WriteType(XmlQualifiedName name, XmlQualifiedName typeName, XmlSchemaForm form, int id, int depth, bool writeXsiType) 
		{
			XmlSchemaElement element = new XmlSchemaElement();
			element.Name = name.Name;
			element.MaxOccurs = 1;
			element.Form = form;
			element.SchemaTypeName = typeName;
			WriteElement(element, name.Namespace, true, id, depth, writeXsiType);
		}

		protected void WriteElement(XmlSchemaElement element, string ns, bool encoded, int id, int depth, bool writeXsiType) 
		{
			XmlSchemaForm form = element.Form;
			if (form == XmlSchemaForm.None) 
			{
				XmlSchema schema = schemas[ns];
				if (schema != null) form = schema.ElementFormDefault;
			}
			WriteElement(element, ns, form, encoded, id, depth, writeXsiType);
		}

		protected void WriteElement(XmlSchemaElement element, string ns, XmlSchemaForm form, bool encoded, int id, int depth, bool writeXsiType) 
		{
			if (element == null) return;
			int count = element.MaxOccurs > 1 ? maxArraySize : 1;

			for (int i = 0; i < count; i++) 
			{
				XmlQualifiedName elementName = (element.QualifiedName == null || element.QualifiedName.IsEmpty ? new XmlQualifiedName(element.Name, ns) : element.QualifiedName);
				if (encoded && count > 1) 
				{
					elementName = new XmlQualifiedName("Item", null);
				}

				if (IsRef(element.RefName)) 
				{
					WriteTopLevelElement(XmlEscapeQName(element.RefName), depth);
					continue;
				}
            
				if (encoded) 
				{
					string prefix = null;
					if (form != XmlSchemaForm.Unqualified && elementName.Namespace.Length > 0) 
					{
						prefix = xmlWriter.LookupPrefix(elementName.Namespace);
						if (prefix == null)
							prefix = "q" + nextPrefix++;
					}
                
					if (id != 0) 
					{ // intercept array definitions
						XmlSchemaComplexType ct = null;
						if (IsStruct(element, out ct)) 
						{
							XmlQualifiedName typeName = element.SchemaTypeName;
							XmlQualifiedName baseTypeName = GetBaseTypeName(ct);
							if (baseTypeName != null && IsArray(baseTypeName))
								typeName = baseTypeName;
							if (typeName != elementName) 
							{
								WriteType(typeName, element.SchemaTypeName, form, id, depth, writeXsiType);
								return;
							}
						}
					}
					xmlWriter.WriteStartElement(prefix, elementName.Name, form != XmlSchemaForm.Unqualified ? elementName.Namespace : "");
				}
				else
					xmlWriter.WriteStartElement(elementName.Name, form != XmlSchemaForm.Unqualified ? elementName.Namespace : "");

				XmlSchemaSimpleType simpleType = null;
				XmlSchemaComplexType complexType = null;

				if (IsPrimitive(element.SchemaTypeName)) 
				{
					if (writeXsiType) WriteTypeAttribute(element.SchemaTypeName);
					WritePrimitive(element.SchemaTypeName);
				}
				else if (IsEnum(element.SchemaTypeName, out simpleType)) 
				{
					if (writeXsiType) WriteTypeAttribute(element.SchemaTypeName);
					WriteEnum(simpleType);
				}
				else if (IsStruct(element, out complexType)) 
				{
					if (depth >= maxObjectGraphDepth)
						WriteNullAttribute(encoded);
					else if (encoded) 
					{
						if (id != 0) 
						{
							// id == -1 means write the definition without writing the id
							if (id > 0) 
							{
								WriteIDAttribute(id);
							}
							WriteComplexType(complexType, ns, encoded, depth, writeXsiType);
						}
						else 
						{
							int href = hrefID++;
							WriteHref(href);
							AddQueuedType(elementName, element.SchemaTypeName, XmlSchemaForm.Qualified, href, depth, true);
						}
					}
					else 
					{
						WriteComplexType(complexType, ns, encoded, depth, false);
					}
				}
				else if (IsByteArray(element, out simpleType)) 
				{
					WriteByteArray(simpleType);
				}
				else if (IsSchemaRef(element.RefName)) 
				{
					WriteXmlValue("schema");
				}
				else if (IsUrType(element.SchemaTypeName)) 
				{
					WriteTypeAttribute(new XmlQualifiedName(GetXmlValue("type"), null));
				}
				else 
				{
					if (debug) 
					{
						WriteDebugAttribute("error", "Unknown type");
						WriteDebugAttribute("elementName", element.QualifiedName.ToString());
						WriteDebugAttribute("typeName", element.SchemaTypeName.ToString());
						WriteDebugAttribute("type", element.SchemaType != null ? element.SchemaType.ToString() : "null");
					}
				}
				xmlWriter.WriteEndElement();
				xmlWriter.Formatting = Formatting.Indented;
			}
		}

		public bool IsArray(XmlQualifiedName typeName) 
		{
			return (typeName.Namespace == soapEncNs && typeName.Name == "Array");
		}

		public bool IsPrimitive(XmlQualifiedName typeName) 
		{
			return (!typeName.IsEmpty && 
				(typeName.Namespace == XmlSchema.Namespace || typeName.Namespace == msTypesNs) &&
				typeName.Name != urType);
		}

		public bool IsRef(XmlQualifiedName refName) 
		{
			return refName != null && !refName.IsEmpty && !IsSchemaRef(refName);
		}

		public bool IsSchemaRef(XmlQualifiedName refName) 
		{
			return refName != null && refName.Name == "schema" && refName.Namespace == XmlSchema.Namespace;
		}

		public bool IsUrType(XmlQualifiedName typeName) 
		{
			return (!typeName.IsEmpty && typeName.Namespace == XmlSchema.Namespace && typeName.Name == urType);
		}

		public bool IsEnum(XmlQualifiedName typeName, out XmlSchemaSimpleType type) 
		{
			XmlSchemaSimpleType simpleType = null;
			if (typeName != null && !typeName.IsEmpty) 
			{
				simpleType = (XmlSchemaSimpleType)schemas.Find(typeName, typeof(XmlSchemaSimpleType));
				if (simpleType != null) 
				{
					type = simpleType;
					return true;
				}
			}
			type = null;
			return false;
		}

		public bool IsStruct(XmlSchemaElement element, out XmlSchemaComplexType type) 
		{
			XmlSchemaComplexType complexType = null;

			if (!element.SchemaTypeName.IsEmpty) 
			{
				complexType = (XmlSchemaComplexType)schemas.Find(element.SchemaTypeName, typeof(XmlSchemaComplexType));
				if (complexType != null) 
				{
					type = complexType;
					return true;
				}
			}
			if (element.SchemaType != null && element.SchemaType is XmlSchemaComplexType) 
			{
				complexType = element.SchemaType as XmlSchemaComplexType;
				if (complexType != null) 
				{
					type = complexType;
					return true;
				}
			}
			type = null;
			return false;
		}

		public bool IsByteArray(XmlSchemaElement element, out XmlSchemaSimpleType type) 
		{
			if (element.SchemaTypeName.IsEmpty && element.SchemaType is XmlSchemaSimpleType) 
			{
				type = element.SchemaType as XmlSchemaSimpleType;
				return true;
			}
			type = null;
			return false;
		}
    
		public XmlQualifiedName ArrayItemType(string typeDef) 
		{
			string ns;
			string name;

			int nsLen = typeDef.LastIndexOf(':');

			if (nsLen <= 0) 
			{
				ns = "";
			}
			else 
			{
				ns = typeDef.Substring(0, nsLen);
			}
			int nameLen = typeDef.IndexOf('[', nsLen + 1);

			if (nameLen <= nsLen) 
			{
				return new XmlQualifiedName(urType, XmlSchema.Namespace);
			}
			name = typeDef.Substring(nsLen + 1, nameLen - nsLen - 1);

			return new XmlQualifiedName(name, ns);
		}

		public void WriteByteArray(XmlSchemaSimpleType dataType) 
		{
			WriteXmlValue("bytes");
		}

		public void WriteEnum(XmlSchemaSimpleType dataType) 
		{
			if (dataType.Content is XmlSchemaSimpleTypeList) 
			{ // "flags" enum -- appears inside a list
				XmlSchemaSimpleTypeList list = (XmlSchemaSimpleTypeList)dataType.Content;
				dataType = list.ItemType;
			}

			bool first = true;
			if (dataType.Content is XmlSchemaSimpleTypeRestriction) 
			{
				XmlSchemaSimpleTypeRestriction restriction = (XmlSchemaSimpleTypeRestriction)dataType.Content;
				foreach (XmlSchemaFacet facet in restriction.Facets) 
				{
					if (facet is XmlSchemaEnumerationFacet) 
					{
						if (!first) xmlWriter.WriteString(" or "); else first = false;
						WriteXmlValue(facet.Value);
					}
				}
			}
		}

		public void WriteArrayTypeAttribute(XmlQualifiedName type, int maxOccurs) 
		{
			StringBuilder sb = new StringBuilder(type.Name);
			sb.Append("[");
			sb.Append(maxOccurs.ToString());
			sb.Append("]");
			string prefix = DefineNamespace("q1", type.Namespace);
			XmlQualifiedName typeName = new XmlQualifiedName(sb.ToString(), prefix);
			xmlWriter.WriteAttributeString("arrayType", soapEncNs, typeName.ToString());
		}

		public void WriteTypeAttribute(XmlQualifiedName type) 
		{
			string prefix = DefineNamespace("s0", type.Namespace);
			xmlWriter.WriteStartAttribute("type", XmlSchema.InstanceNamespace);
			xmlWriter.WriteString(new XmlQualifiedName(type.Name, prefix).ToString());
			xmlWriter.WriteEndAttribute();
		}

		public void WriteNullAttribute(bool encoded) 
		{
			if (encoded)
				xmlWriter.WriteAttributeString("null", XmlSchema.InstanceNamespace, "1");
			else
				xmlWriter.WriteAttributeString("nil", XmlSchema.InstanceNamespace, "true");
		}

		public void WriteIDAttribute(int href) 
		{
			xmlWriter.WriteAttributeString("id", "id" + href.ToString());
		}

		public void WriteHref(int href) 
		{
			xmlWriter.WriteAttributeString("href", "#id" + href.ToString());
		}

		public void WritePrimitive(XmlQualifiedName name) 
		{
			if (name.Namespace == XmlSchema.Namespace && name.Name == "QName") 
			{
				DefineNamespace("q1", "http://tempuri.org/SampleNamespace");
				WriteXmlValue("q1:QName");
			}
			else
				WriteXmlValue(name.Name);
		}
        
		public XmlQualifiedName GetBaseTypeName(XmlSchemaComplexType complexType) 
		{
			if (complexType.ContentModel is XmlSchemaComplexContent) 
			{
				XmlSchemaComplexContent content = (XmlSchemaComplexContent)complexType.ContentModel;
				if (content.Content is XmlSchemaComplexContentRestriction) 
				{
					XmlSchemaComplexContentRestriction restriction = (XmlSchemaComplexContentRestriction)content.Content;
					return restriction.BaseTypeName;
				}
			}
			return null;
		}

		internal class TypeItems 
		{
			internal XmlSchemaObjectCollection Attributes = new XmlSchemaObjectCollection();
			internal XmlSchemaAnyAttribute AnyAttribute;
			internal XmlSchemaObjectCollection Items = new XmlSchemaObjectCollection();
			internal XmlQualifiedName baseSimpleType;
		}

		internal TypeItems GetTypeItems(XmlSchemaComplexType type) 
		{
			TypeItems items = new TypeItems();
			if (type == null)
				return items;

			XmlSchemaParticle particle = null;
			if (type.ContentModel != null) 
			{
				XmlSchemaContent content = type.ContentModel.Content;
				if (content is XmlSchemaComplexContentExtension) 
				{
					XmlSchemaComplexContentExtension extension = (XmlSchemaComplexContentExtension)content;
					items.Attributes = extension.Attributes;
					items.AnyAttribute = extension.AnyAttribute;
					particle = extension.Particle;
				}
				else if (content is XmlSchemaComplexContentRestriction) 
				{
					XmlSchemaComplexContentRestriction restriction = (XmlSchemaComplexContentRestriction)content;
					items.Attributes = restriction.Attributes;
					items.AnyAttribute = restriction.AnyAttribute;
					particle = restriction.Particle;
				}
				else if (content is XmlSchemaSimpleContentExtension) 
				{
					XmlSchemaSimpleContentExtension extension = (XmlSchemaSimpleContentExtension)content;
					items.Attributes = extension.Attributes;
					items.AnyAttribute = extension.AnyAttribute;
					items.baseSimpleType = extension.BaseTypeName;
				}
				else if (content is XmlSchemaSimpleContentRestriction) 
				{
					XmlSchemaSimpleContentRestriction restriction = (XmlSchemaSimpleContentRestriction)content;
					items.Attributes = restriction.Attributes;
					items.AnyAttribute = restriction.AnyAttribute;
					items.baseSimpleType = restriction.BaseTypeName;
				}
			}
			else 
			{
				items.Attributes = type.Attributes;
				items.AnyAttribute = type.AnyAttribute;
				particle = type.Particle;
			}
			if (particle != null) 
			{
				if (particle is XmlSchemaGroupRef) 
				{
					XmlSchemaGroupRef refGroup = (XmlSchemaGroupRef)particle;

					XmlSchemaGroup group = (XmlSchemaGroup)schemas.Find(refGroup.RefName, typeof(XmlSchemaGroup));
					if (group != null) 
					{
						items.Items = group.Particle.Items;
					}
				}
				else if (particle is XmlSchemaGroupBase) 
				{
					items.Items = ((XmlSchemaGroupBase)particle).Items;
				}
			}
			return items;
		}

		public void WriteComplexType(XmlSchemaComplexType type, string ns, bool encoded, int depth, bool writeXsiType) 
		{
			bool wroteArrayType = false;
			bool isSoapArray = false;
			TypeItems typeItems = GetTypeItems(type);
			if (encoded) 
			{
				/*
				  Check to see if the type looks like the new WSDL 1.1 array delaration:

				  <xsd:complexType name="ArrayOfInt">
					<xsd:complexContent mixed="false">
					  <xsd:restriction base="soapenc:Array">
						<xsd:attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:int[]" />
					  </xsd:restriction>
					</xsd:complexContent>
				  </xsd:complexType>

				*/

				XmlQualifiedName itemType = null;
				XmlQualifiedName topItemType = null;
				string brackets = "";
				XmlSchemaComplexType t = type;
				XmlQualifiedName baseTypeName = GetBaseTypeName(t);
				TypeItems arrayItems = typeItems;
				while (t != null) 
				{
					XmlSchemaObjectCollection attributes = arrayItems.Attributes;
					t = null; // if we don't set t after this stop looping
					if (baseTypeName != null && IsArray(baseTypeName) && attributes.Count > 0) 
					{
						XmlSchemaAttribute refAttr = attributes[0] as XmlSchemaAttribute;
						if (refAttr != null) 
						{
							XmlQualifiedName qnameArray = refAttr.RefName;
							if (qnameArray.Namespace == soapEncNs && qnameArray.Name == "arrayType") 
							{
								isSoapArray = true;
								XmlAttribute typeAttribute = refAttr.UnhandledAttributes[0];
								if (typeAttribute.NamespaceURI == wsdlNs && typeAttribute.LocalName == "arrayType") 
								{
									itemType = ArrayItemType(typeAttribute.Value);
									if (topItemType == null)
										topItemType = itemType;
									else
										brackets += "[]";

									if (!IsPrimitive(itemType)) 
									{
										t = (XmlSchemaComplexType)schemas.Find(itemType, typeof(XmlSchemaComplexType));
										arrayItems = GetTypeItems(t);
									}
								}
							}
						}
					}
				}
				if (itemType != null) 
				{
					wroteArrayType = true;
					if (IsUrType(itemType))
						WriteArrayTypeAttribute(new XmlQualifiedName(GetXmlValue("type") + brackets, null), maxArraySize);
					else
						WriteArrayTypeAttribute(new XmlQualifiedName(itemType.Name + brackets, itemType.Namespace), maxArraySize);
                
					for (int i = 0; i < maxArraySize; i++) 
					{
						WriteType(new XmlQualifiedName("Item", null), topItemType, 0, depth+1, false);
					}
				}
			}

			if (writeXsiType && !wroteArrayType) 
			{
				WriteTypeAttribute(type.QualifiedName);
			}

			if (!isSoapArray) 
			{
				foreach (XmlSchemaAttribute attr in typeItems.Attributes) 
				{
					if (attr != null && attr.Use != XmlSchemaUse.Prohibited) 
					{
						if (attr.Form == XmlSchemaForm.Qualified && attr.QualifiedName != null)
							xmlWriter.WriteStartAttribute(attr.Name, attr.QualifiedName.Namespace);
						else
							xmlWriter.WriteStartAttribute(attr.Name, null);

						XmlSchemaSimpleType dataType = null;

						// special code for the QNames
						if (attr.SchemaTypeName.Namespace == XmlSchema.Namespace && attr.SchemaTypeName.Name == "QName") 
						{
							WriteXmlValue("q1:QName");
							xmlWriter.WriteEndAttribute();
							DefineNamespace("q1", "http://tempuri.org/SampleNamespace");
						}
						else 
						{
							if (IsPrimitive(attr.SchemaTypeName)) 
								WriteXmlValue(attr.SchemaTypeName.Name);
							else if (IsEnum(attr.SchemaTypeName, out dataType))
								WriteEnum(dataType);
							xmlWriter.WriteEndAttribute();
						}
					}
				}
			}

			XmlSchemaObjectCollection items = typeItems.Items;
			foreach (object item in items) 
			{
				if (item is XmlSchemaElement) 
				{
					WriteElement((XmlSchemaElement)item, ns, encoded, 0, depth + 1, encoded);
				}
				else if (item is XmlSchemaAny) 
				{
					XmlSchemaAny any = (XmlSchemaAny)item;
					XmlSchema schema = schemas[any.Namespace];
					if (schema == null) 
					{
						WriteXmlValue("xml");
					}
					else 
					{
						foreach (object schemaItem in schema.Items) 
						{
							if (schemaItem is XmlSchemaElement) 
							{
								if (IsDataSetRoot((XmlSchemaElement)schemaItem))
									WriteXmlValue("dataset");
								else
									WriteTopLevelElement((XmlSchemaElement)schemaItem, any.Namespace, depth + 1);
							}
						}
					}
				}
			}
		}

		public bool IsDataSetRoot(XmlSchemaElement element) 
		{
			if (element.UnhandledAttributes == null) return false;
			foreach (XmlAttribute a in element.UnhandledAttributes) 
			{
				if (a.NamespaceURI == "urn:schemas-microsoft-com:xml-msdata" && a.LocalName == "IsDataSet")
					return true;
			}
			return false;
		}

		public void WriteBegin() 
		{
			writer = new StringWriter();
			xmlSrc = new MemoryStream();
			xmlWriter = new XmlTextWriter(xmlSrc, new UTF8Encoding(false));
			xmlWriter.Formatting = Formatting.Indented;
			xmlWriter.Indentation = 2;
			referencedTypes = new Queue();
			hrefID = 1;
		}

		public string WriteEnd() 
		{
			xmlWriter.Flush();
			xmlSrc.Position = 0;
			StreamReader reader = new StreamReader(xmlSrc, Encoding.UTF8);
			writer.Write(HtmlEncode(reader.ReadToEnd()));
			return writer.ToString();
		}

		public string HtmlEncode(string text) 
		{
			StringBuilder sb = new StringBuilder();
			for (int i=0; i<text.Length; i++) 
			{
				char c = text[i];
				if (c == '&') 
				{
					string special = ReadComment(text, i);
					if (special.Length > 0) 
					{
						sb.Append(Server.HtmlDecode(special));
						i += (special.Length + "&lt;!--".Length + "--&gt;".Length - 1);
					}
					else
						sb.Append("&amp;");
				}
				else if (c == '<')
					sb.Append("&lt;");
				else if (c == '>')
					sb.Append("&gt;");
				else
					sb.Append(c);
			}
			return sb.ToString();
		}

		public string ReadComment(string text, int index) 
		{
			if (dontFilterXml) return String.Empty;
			if (String.Compare(text, index, "&lt;!--", 0, "&lt;!--".Length, false, CultureInfo.InvariantCulture) == 0) 
			{
				int start = index + "&lt;!--".Length;
				int end = text.IndexOf("--&gt;", start);
				if (end < 0) return String.Empty;
				return text.Substring(start, end-start);
			}
			return String.Empty;
		}

		public void Write(string text) 
		{
			writer.Write(text);
		}

		public void WriteLine() 
		{
			writer.WriteLine();
		}

		public void WriteValue(string text) 
		{
			Write("<font class=value>" + text + "</font>");
		}

		public void WriteStartXmlValue() 
		{
			xmlWriter.WriteString("<!--<font class=value>");
		}

		public void WriteEndXmlValue() 
		{
			xmlWriter.WriteString("</font>-->");
		}

		public void WriteDebugAttribute(string text) 
		{
			WriteDebugAttribute("debug", text);
		}

		public void WriteDebugAttribute(string id, string text) 
		{
			xmlWriter.WriteAttributeString(id, text);
		}

		public string GetXmlValue(string text) 
		{
			return "<!--<font class=value>" + text + "</font>-->";
		}

		public void WriteXmlValue(string text) 
		{
			xmlWriter.WriteString(GetXmlValue(text));
		}

		public string DefineNamespace(string prefix, string ns) 
		{
			if (ns == null || ns == String.Empty) return null;
			string existingPrefix = xmlWriter.LookupPrefix(ns);
			if (existingPrefix != null && existingPrefix.Length > 0)
				return existingPrefix;
			xmlWriter.WriteAttributeString("xmlns", prefix, null, ns);
			return prefix;
		}

		public Port FindPort(Binding binding) 
		{
			foreach (ServiceDescription description in serviceDescriptions) 
			{
				foreach (Service service in description.Services) 
				{
					foreach (Port port in service.Ports) 
					{
						if (port.Binding.Name == binding.Name &&
							port.Binding.Namespace == binding.ServiceDescription.TargetNamespace) 
						{
							return port;
						}
					}
				}
			}
			return null;
		}

		public OperationBinding FindBinding(Type bindingType) 
		{
			OperationBinding nextBestMatch = null;
			foreach (ServiceDescription description in serviceDescriptions) 
			{
				foreach (Binding binding in description.Bindings) 
				{
					object ext = binding.Extensions.Find(bindingType);
					if (ext == null) continue;
					foreach (OperationBinding operationBinding in binding.Operations) 
					{
						string messageName = operationBinding.Input.Name;
						if (messageName == null || messageName.Length == 0) 
							messageName = operationBinding.Name;
						if (messageName == operationName) 
						{
							if (ext.GetType() != bindingType) 
							{
								nextBestMatch = operationBinding; // see if we can do better
								break;
							}
							else
								return operationBinding;
						}
					}
				}
			}
			return nextBestMatch;
		}

		public OperationBinding FindHttpBinding(string verb) 
		{
			foreach (ServiceDescription description in serviceDescriptions) 
			{
				foreach (Binding binding in description.Bindings) 
				{
					HttpBinding httpBinding = (HttpBinding)binding.Extensions.Find(typeof(HttpBinding));
					if (httpBinding == null) 
						continue;
					if (httpBinding.Verb != verb) 
						continue;
					foreach (OperationBinding operationBinding in binding.Operations) 
					{
						string messageName = operationBinding.Input.Name;
						if (messageName == null || messageName.Length == 0) 
							messageName = operationBinding.Name;
						if (messageName == operationName) 
							return operationBinding;
					}
				}
			}
			return null;
		}

		public Operation FindOperation(OperationBinding operationBinding) 
		{
			PortType portType = serviceDescriptions.GetPortType(operationBinding.Binding.Type);
			foreach (Operation operation in portType.Operations) 
			{
				if (operation.IsBoundBy(operationBinding)) 
				{
					return operation;
				}
			}
			return null;
		}

		public string GetLocalizedText(string name) 
		{
			return GetLocalizedText(name, new object[0]);
		}

		public string GetLocalizedText(string name, object[] args) 
		{
			ResourceManager rm = (ResourceManager)Application["RM"];
			string val = rm.GetString("HelpGenerator" + name);
			if (val == null) return String.Empty;
			return String.Format(val, args);
		}
    
		public String FullUri
		{
			get { return Request.Url.Scheme + "://" + Request.Url.Authority + ":" + Request.Url.Port + Request.Url.AbsolutePath; }
		}

		public void RenderSpecializedWsdl(ServiceDescriptionCollection services)
		{
			Response.Clear();
			Response.ContentType = "text/xml";
			Response.Write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n");
			Response.Write("<wsdl:definitions xmlns=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:bind=\"urn:oasis:names:tc:wsrp:v1:bind\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" targetNamespace=\"urn:oasis:names:tc:wsrp:v1:wsdl\">\n");
  			Response.Write("<import namespace=\"urn:oasis:names:tc:wsrp:v1:bind\" location=\"http://www.oasis-open.org/committees/wsrp/specifications/version1/wsrp_v1_bindings.wsdl\"/>\n");
  			Response.Write("<wsdl:service name=\"WSRPService\">\n");
    		Response.Write("	<wsdl:port binding=\"bind:WSRP_v1_Markup_Binding_SOAP\" name=\"WSRPBaseService\">\n");
			Response.Write("      <soap:address location=\"");
			Response.Write(FullUri);
			Response.Write("\"/>\n");
			Response.Write("    </wsdl:port>\n");
			Response.Write("    <wsdl:port binding=\"bind:WSRP_v1_ServiceDescription_Binding_SOAP\" name=\"WSRPServiceDescriptionService\">\n");
			Response.Write("      <soap:address location=\"");
			Response.Write(FullUri);
			Response.Write("\"/>\n");
			Response.Write("    </wsdl:port>\n");
			Response.Write("    <wsdl:port binding=\"bind:WSRP_v1_Registration_Binding_SOAP\" name=\"WSRPRegistrationService\">\n");
			Response.Write("      <soap:address location=\"");
			Response.Write(FullUri);
			Response.Write("\"/>\n");
			Response.Write("    </wsdl:port>\n");
			Response.Write("    <wsdl:port binding=\"bind:WSRP_v1_PortletManagement_Binding_SOAP\" name=\"WSRPPortletManagementService\">\n");
			Response.Write("      <soap:address location=\"");
			Response.Write(FullUri);
			Response.Write("\"/>\n");
			Response.Write("    </wsdl:port>\n");
			Response.Write("  </wsdl:service>\n");
			Response.Write("</wsdl:definitions>\n");
			Response.End();
		}
		
		private void Page_Load(object sender, System.EventArgs e)
		{
			if (Application["RM"] == null) 
			{
				lock (this.GetType()) 
				{
					if (Application["RM"] == null) 
					{
						Application["RM"] = new ResourceManager("System.Web.Services", typeof(System.Web.Services.WebService).Assembly);
					}
				}
			}

			operationName = Request.QueryString["op"];

			// Slots filled on HttpContext:
			// "wsdls"              A ServiceDescriptionCollection representing what is displayed for .asmx?wsdl
			// "schemas"            An XmlSchemas object containing schemas associated with .asmx?wsdl
			// "wsdlsWithPost"      Wsdls the same as "wsdls", plus bindings for the HttpPost protocol.
			// "schemasWithPost"    Schemas corresponding to "wsdlsWithPost".
			// The objects stored at "wsdlsWithPost" and "schemasWithPost" are available if
			// the HttpPost protocol is turned on in config.
        
			// Obtain WSDL contract from Http Context

			XmlSchemas schemasToUse;
			serviceDescriptions = (ServiceDescriptionCollection) Context.Items["wsdlsWithPost"];
			if (serviceDescriptions != null) 
			{
				requestIsLocal = true;
				schemasToUse = (XmlSchemas) Context.Items["schemasWithPost"];
			}
			else 
			{
				serviceDescriptions = (ServiceDescriptionCollection) Context.Items["wsdls"];
				schemasToUse = (XmlSchemas) Context.Items["schemas"];
			}

			schemas = new XmlSchemas();
			foreach (XmlSchema schema in schemasToUse) 
			{
				schemas.Add(schema);
			}
			foreach (ServiceDescription description in serviceDescriptions) 
			{
				foreach (XmlSchema schema in description.Types.Schemas) 
				{
					schemas.Add(schema);
				}
			}

			if (operationName != null && operationName.ToLower() == "wsdl")
				RenderSpecializedWsdl(serviceDescriptions);
			
			Hashtable methodsTable = new Hashtable();

			operationExists = false;
			foreach (ServiceDescription description in serviceDescriptions) 
			{
				foreach (PortType portType in description.PortTypes) 
				{
					foreach (Operation operation in portType.Operations) 
					{
						string messageName = operation.Messages.Input.Name;
						if (messageName == null || messageName.Length == 0) 
							messageName = operation.Name;
						if (messageName == operationName) 
							operationExists = true;
						if (messageName == null)
							messageName = String.Empty;
						methodsTable[messageName] = operation;
					}
				}
			}

			MethodList.DataSource = methodsTable;

			// Databind all values within the page
    
			Page.DataBind();
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Load += new System.EventHandler(this.Page_Load);
		}
		#endregion
	}
}
