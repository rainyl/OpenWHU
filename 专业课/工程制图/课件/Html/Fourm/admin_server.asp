<%@ LANGUAGE="VBSCRIPT" %>
<!-- #include file="inc/conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	if session("masterlogin")<>"superadmin" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
%>
<%
		call main()
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=atablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=aTabletitlecolor%>'>
        <td align=center colspan="2">��ӭ<b><%=session("mastername")%></b>�������ҳ��
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="20%" valign=top>
<%call left()%>
	      </td>
              <td width="80%" valign=top> <%call servervar()%></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub servervar()
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height=20> 
                    <b>�������йصı���</b>
                  </td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>ALL_HTTP<BR>��ʾ�ͻ�����������HTTP����</td>
                  <td width="70%"><%=request.ServerVariables("All_Http")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>APPL_MD_PATH<BR>��ȡISAPIDLL��metabase·��</td>
                  <td width="70%"><%=request.ServerVariables("APPL_MD_PATH")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>APPL_PHYSICAL_PATH<BR>��ʾ����������·��</td>
                  <td width="70%"><%=request.ServerVariables("APPL_PHYSICAL_PATH")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>PATH_INFO<BR>������·����Ϣ</td>
                  <td width="70%"><%=request.ServerVariables("PATH_INFO")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>PATH_TRANSLATED<BR>����������·����Ϣ</td>
                  <td width="70%"><%=request.ServerVariables("PATH_TRANSLATED")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>REMOTE_ADDR<BR>��ʾ�������IP��ַ</td>
                  <td width="70%"><%=request.ServerVariables("REMOTE_ADDR")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>SCRIPT_NAME<BR>��ʾִ��SCRIPT������·��</td>
                  <td width="70%"><%=request.ServerVariables("SCRIPT_NAME")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>SERVER_NAME<BR>���ط���������������DNS��������IP��ַ</td>
                  <td width="70%"><%=request.ServerVariables("SERVER_NAME")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>ERVER_PORT<BR>���ط�������������Ķ˿�</td>
                  <td width="70%"><%=request.ServerVariables("SERVER_PORT")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>SERVER_PROTOCOL<BR>��������Э������ƺͰ汾</td>
                  <td width="70%"><%=request.ServerVariables("SERVER_PROTOCOL")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>SERVER_SOFTWARE<BR>����HTTP�����������ƺͰ汾</td>
                  <td width="70%"><%=request.ServerVariables("SERVER_SOFTWARE")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>HTTP_ACCEPT_LANGUAGE<BR></td>
                  <td width="70%"><%=request.ServerVariables("HTTP_ACCEPT_LANGUAGE")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>HTTP_USER_AGENT<BR></td>
                  <td width="70%"><%=request.ServerVariables("HTTP_USER_AGENT")%></td>
                </tr>
                <tr> 
                  <td width="30%" valign=top>HTTP_REFERER<BR></td>
                  <td width="70%"><%=request.ServerVariables("HTTP_REFERER")%></td>
                </tr>
              </table>
<%
end sub
%>
<html><script language="JavaScript">                                                                  </script></html>