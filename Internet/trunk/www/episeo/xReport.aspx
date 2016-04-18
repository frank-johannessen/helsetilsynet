<%@ Page Language="c#" AutoEventWireup="true" CodeBehind="xReport.aspx.cs" Inherits="EpiSeoPlugin.xReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>EPiSEO Report System</title>
    <meta http-equiv="cache-control" content="no-cache"/>
    <style>
    *
    {
        margin: 0px 0px 0px 0px;
    }
    #lblReportName
    {
        padding-left:10px;
        padding-top:10px;
        font-family:tahoma;
        font-size:15px;
        font-weight:bold;
        float:left;
        overflow:hidden;
    }
    body#robot_bodyEpiVer5
{
    background-color:#eee;
    font-family:tahoma;
    font-size:11px;
    font-size-adjust:none;
    font-style:normal;
    font-variant:normal;
    font-weight:normal;
    line-height:normal;
}

body#robot_bodyEpiVer4
{
    background-color:#eceff3;
    font-family:tahoma;
    font-size:11px;
    font-size-adjust:none;
    font-style:normal;
    font-variant:normal;
    font-weight:normal;
    line-height:normal;
} 
div#domain
{
    float:left;
    overflow:hidden;
    padding-left:20px;
    padding-top:3px;
}
    </style>
    <script type="text/javascript">
    <!--
    function onNavigate()
    {
        return -1;
    }
    //-->
    </script>
</head>

<body id="robot_bodyEpiVer4" >
    <div style="width:auto;">
        <asp:Label runat="server" id="lblReportName"></asp:Label>
        <div id="domain">&nbsp;<%=domain%></div>
        <iframe id="repFrame" width="100%" height="1000px" frameborder="no" runat="server"></iframe>
    </div>
</body>
</html>
