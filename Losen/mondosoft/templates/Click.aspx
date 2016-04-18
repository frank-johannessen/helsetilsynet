<%@ Page language="c#" %>
<%@ Register TagPrefix="MondoSearch" Namespace="Mondosoft.MondoSearch" Assembly="MsmSearch,Version=1.0.0.2,Culture=neutral,PublicKeyToken=beb56c6686670998" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<title><%# MondoSearch.Resources.GetText("STEXT.TITLE")%></title>
</head>
<body>
<form id="MONDOSEARCHFORM" name="MONDOSEARCHFORM" method="post" runat="server">
<MondoSearch:Click id="MondoSearch" runat="Server"/>
<table border="0" cellpadding="0" cellspacing="0" width="590">
  <tr>
    <td align="CENTER" valign="TOP"><font face="Arial,Helvetica">
        <br>
        <b>
          <%#MondoSearch.Resources.GetText("STEXT.DB_CLOSED")%>
        </b>
        <br>
      </font>
    </td>
  </tr>
</table>
</form>
</body>
</html>