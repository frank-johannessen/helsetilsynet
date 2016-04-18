<%@ Page language="c#" Codebehind="getpagename.aspx.cs" AutoEventWireup="false" Inherits="development.admin.getpagename" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.WebControls" Assembly="EPiServer" %>


<script language="javascript">	
	<%#(Request.QueryString["id"]!=null)? "parent." + Request.QueryString["recall"] +"('" + GetPage(new EPiServer.Core.PageReference(int.Parse(Request.QueryString["id"]))).PageName + "','" + Request.QueryString["id"] + "','" + GetPage(new EPiServer.Core.PageReference(int.Parse(Request.QueryString["id"]))).PageTypeID.ToString() + "','" + Request.QueryString["index"] + "');":""%>
</script>



