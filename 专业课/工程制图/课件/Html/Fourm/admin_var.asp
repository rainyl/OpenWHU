<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file = conn.asp-->
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
              <td width="80%" valign=top>
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
%>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub consted()
%>
<form method="POST" action=admin_var.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��̳��������</b></font></td>
</tr>
<tr> 
<td width="41%">��̳����</td>
<td width="59%"> 
<input type="text" name="ForumName" size="35" value="<%=ForumName%>">
</td>
</tr>
<tr> 
<td width="41%">��̳��url</td>
<td width="59%"> 
<input type="text" name="ForumURL" size="35" value="<%=ForumURL%>">
</td>
</tr>
<tr> 
<td width="41%">��ҳ����</td>
<td width="59%"> 
<input type="text" name="CompanyName" size="35" value="<%=CompanyName%>">
</td>
</tr>
<tr> 
<td width="41%">��ҳURL</td>
<td width="59%"> 
<input type="text" name="HostUrl" size="35" value="<%=HostUrl%>">
</td>
</tr>
<tr> 
<td width="41%">SMTP Server��ַ</td>
<td width="59%"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="41%">��̳����ԱEmail</td>
<td width="59%"> 
<input type="text" name="SystemEmail" size="35" value="<%=SystemEmail%>">
</td>
</tr>
<tr> 
<td width="41%">������ʱ��</td>
<td width="59%"> 
<input type="text" size="35" value="<%=TimeAdjust%>" name="TimeAdjust">
</td>
</tr>
<tr> 
<td width="41%">������ASP�ű���ʱʱ��ֵ�����鲻Ҫʹ��</td>
<td width="59%"> 
<input type="text" name="ScriptTimeOut" size="35" value="<%=ScriptTimeOut%>">
</td>
</tr>
<tr> 
<td width="41%">��̳Logo��ַ</td>
<td width="59%"> 
<input type="text" name="Logo" size="35" value="<%=Logo%>">
</td>
</tr>
<tr> 
<td width="41%">��̳ͼƬĿ¼</td>
<td width="59%"> 
<input type="text" name="Picurl" size="35" value="<%=picurl%>">
</td>
</tr>
<tr> 
<td width="41%">��̳�����ַ</td>
<td width="59%"> 
<input type="text" name="Faceurl" size="35" value="<%=Faceurl%>">
</td>
</tr>
<tr> 
<td width="41%">�����ʼ����</td>
<td width="59%"> 
<select name="EmailFlag">
<option value="0" <%if EmailFlag=0 then%>selected<%end if%>>��֧�� 
<option value="1" <%if EmailFlag=1 then%>selected<%end if%>>JMAIL 
<option value="2" <%if EmailFlag=2 then%>selected<%end if%>>CDONTS 
<option value="3" <%if EmailFlag=3 then%>selected<%end if%>>ASPEMAIL 
</select>
</td>
</tr>
<tr> 
<td width="41%">�����ϴ�ͼƬ</td>
<td width="59%"> 
<select name="Uploadpic">
<option value="0" <%if Uploadpic=0 then%>selected<%end if%>>�� 
<option value="1" <%if Uploadpic=1 then%>selected<%end if%>>�� 
</select>
</td>
</tr>
<tr> 
<td width="41%">�û�IP</td>
<td width="59%"> 
<select name="IpFlag">
<option value="0" <%if IpFlag=0 then%>selected<%end if%>>���� 
<option value="1" <%if IpFlag=1 then%>selected<%end if%>>���� 
</select>
</td>
</tr>
<tr> 
<td width="41%">ͷ���ϴ�</td>
<td width="59%">
<select name="uploadFlag">
<option value="0" <%if not uploadFlag then%>selected<%end if%>>�� 
<option value="1" <%if uploadFlag then%>selected<%end if%>>�� 
</select>
</td>
</tr>
<tr> 
<td width="41%">�û���Դ</td>
<td width="59%"> 
<select name="FromFlag">
<option value="0" <%if FromFlag=0 then%>selected<%end if%>>���� 
<option value="1" <%if FromFlag=1 then%>selected<%end if%>>���� 
</select>
</td>
</tr>
<tr> 
<td width="41%">�û�ͷ��</td>
<td width="59%"> 
<select name="TitleFlag">
<option value="0" <%if not TitleFlag then%>selected<%end if%>>���� 
<option value="1" <%if TitleFlag then%>selected<%end if%>>��ʾ 
</select>
</td>
</tr>
<tr> 
<td width="41%">����������ʾ��������</td>
<td width="59%"> 
<select name="guestuser">
<option value="0" <%if guestuser=0 then%>selected<%end if%>>�� 
<option value="1"  <%if guestuser=1 then%>selected<%end if%>>�� 
</select>
</td>
</tr>
<tr> 
<td width="41%">���µĶ���Ϣ��������</td>
<td width="59%"> 
<select name="openmsg">
<option value="0" <%if openmsg=0 then%>selected<%end if%>>�� 
<option value="1"  <%if openmsg=1 then%>selected<%end if%>>�� 
</select>
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>������������</b></font></td>
</tr>
<tr> 
<td height="17" width="41%">�������������ֽ���</td>
<td height="17" width="59%"> 
<input type="text" name="AnnounceMaxBytes" size="35" value="<%=AnnounceMaxBytes%>">
</td>
</tr>
<tr> 
<td width="41%">ÿҳ��ʾ����¼</td>
<td width="59%"> 
<input type="text" name="MaxAnnouncePerPage" size="35" value="<%=MaxAnnouncePerPage%>">
</td>
</tr>
<tr> 
<td width="41%">UBB����������ÿҳ��ʾ������</td>
<td width="59%"> 
<input type="text" name="Maxtitlelist" size="35" value="<%=Maxtitlelist%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>������ɫ�������ã�Ӧ���ڳ���ʾ���������ҳ�棬������ҳ��</b></font></td>
</tr>
<tr> 
<td width="41%">��񱳾�(�߿���ɫ)1<br>
һ��ҳ��</td>
<td width="59%"> 
<input type="text" name="Tablebackcolor" size="35" value="<%=Tablebackcolor%>">
</td>
</tr>
<tr> 
<td width="41%">��񱳾�(�߿���ɫ)2<br>
�û�ҳ�桢��ʾҳ��</td>
<td width="59%"> 
<input type="text" name="aTablebackcolor" size="35" value="<%=aTablebackcolor%>">
</td>
</tr>
<tr> 
<td width="41%">��������ɫ1<br>
һ��ҳ��</td>
<td width="59%"> 
<input type="text" name="Tabletitlecolor" size="35" value="<%=Tabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="41%">��������ɫ2<br>
�û�ҳ�桢��ʾҳ��</td>
<td width="59%"> 
<input type="text" name="aTabletitlecolor" size="35" value="<%=aTabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="41%">�������ɫ1</td>
<td width="59%"> 
<input type="text" name="Tablebodycolor" size="35" value="<%=Tablebodycolor%>">
</td>
</tr>
<tr> 
<td width="41%">�������ɫ2(1��2��ɫ����ҳ��ʾ�д���)</td>
<td width="59%"> 
<input type="text" name="aTablebodycolor" size="35" value="<%=aTablebodycolor%>">
</td>
</tr>
<tr> 
<td width="41%">��������ֱ�����ɫ</td>
<td width="59%"> 
<input type="text" name="TableFontcolor" size="35" value="<%=TableFontcolor%>">
</td>
</tr>
<tr> 
<td width="41%">���������������ɫ</td>
<td width="59%"> 
<input type="text" name="TableContentcolor" size="35" value="<%=TableContentcolor%>">
</td>
</tr>
<tr> 
<td width="41%">��������������ɫ</td>
<td width="59%"> 
<input type="text" name="AlertFontColor" size="35" value="<%=AlertFontColor%>">
</td>
</tr>
<tr> 
<td width="41%">��ʾ���ӵ�ʱ��������ӣ�ת�����ӣ��ظ��ȵ���ɫ</td>
<td width="59%"> 
<input type="text" name="ContentTitle" size="35" value="<%=ContentTitle%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��Ȩ�����Ϣ</b></font></td>
</tr>
<tr> 
<td width="41%">��̳ҳ�׹�����</td>
<td width="59%"> 
<input type="text" name="ads1" size="35" value="<%=ads1%>">
</td>
</tr>
<tr> 
<td width="41%">��̳ҳβ������</td>
<td width="59%"> 
<input type="text" name="ads2" size="35" value="<%=ads2%>">
</td>
</tr>
<tr> 
<td width="41%">��Ȩ��Ϣ</td>
<td width="59%"> 
<input type="text" name="Copyright" size="35" value="<%=Copyright%>">
</td>
</tr>
<tr> 
<td width="41%">�汾��Ϣ</td>
<td width="59%"> 
<input type="text" name="Version" size="35" value="<%=Version%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="41%">&nbsp;</td>
<td width="59%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
end sub

sub saveconst()
set rs = server.CreateObject ("adodb.recordset")
sql = "select * from config"
rs.open sql,conn,1,3

if Request("ForumName")="" then 
errmsg = errmsg + "<br>" + "<li>������̳���ƣ�</li>"
call error()
else
rs("ForumName") = Request("ForumName")
end if

if Request("ForumURL")="" then 
errmsg = errmsg + "<br>" + "<li>������̳���ӵ�ַ��</li>"
call error()
else
rs("ForumURL") = Request("ForumURL")
end if

if Request("CompanyName")="" then 
errmsg = errmsg + "<br>" + "<li>������ҳ�������ƣ�</li>"
call error()
else
rs("CompanyName") =Request("CompanyName")
end if

if Request("HostUrl")="" then 
errmsg = errmsg + "<br>" + "<li>������̳�������ƣ�</li>"
call error()
else
rs("HostUrl") = Request("HostUrl")
end if

if Request("SMTPServer")="" then 
errmsg = errmsg + "<br>" + "<li>����д�ʼ���������ַ��</li>"
call error()
else
rs("SMTPServer") = request("SMTPServer")
end if

if Request("SystemEmail")=""  then 
errmsg = errmsg + "<br>" + "<li>����д�ʼ���������ַ��</li>"
call error()
else
rs("SystemEmail") = Request("SystemEmail")
end if

if Request("TimeAdjust")="" then 
rs("TimeAdjust") = 0
else
rs("TimeAdjust") = Request("TimeAdjust")
end if

if Request("ScriptTimeOut")="" then 
rs("ScriptTimeOut") = 300
else
rs("ScriptTimeOut") = Request("ScriptTimeOut")
end if

if Request("logo")="" then 
errmsg = errmsg + "<br>" + "<li>����д��̳logo��ַ��</li>"
call error()
else
rs("Logo") = Request("Logo")
end if

if Request("Picurl")="" then 
errmsg = errmsg + "<br>" + "<li>����д��̳ͼƬĿ¼��</li>"
call error()
else
rs("Picurl") = Request("Picurl")
end if

if Request("Faceurl")="" then 
errmsg = errmsg + "<br>" + "<li>����д��̳����Ŀ¼��</li>"
call error()
else
rs("Faceurl") = Request("Faceurl")
end if
rs("EmailFlag") = Request("EmailFlag")

rs("Uploadpic") = Request("Uploadpic")
rs("IpFlag") = Request("IpFlag")
rs("FromFlag") = Request("FromFlag")
rs("TitleFlag")=Request("TitleFlag")
rs("uploadFlag")=request("uploadFlag")
rs("guestuser") = Request("guestuser")
rs("openmsg") = Request("openmsg")
rs("AnnounceMaxBytes") = Request("AnnounceMaxBytes")
rs("MaxAnnouncePerPage") = Request("MaxAnnouncePerPage")
rs("Maxtitlelist") = Request("Maxtitlelist")
rs("Tablebackcolor") = Request("Tablebackcolor")
rs("aTablebackcolor") = Request("aTablebackcolor")
rs("Tabletitlecolor") = Request("Tabletitlecolor")
rs("aTabletitlecolor") = Request("aTabletitlecolor")
rs("Tablebodycolor") = Request("Tablebodycolor")
rs("aTablebodycolor") = Request("aTablebodycolor")
rs("TableFontcolor") = Request("TableFontcolor")
rs("TableContentcolor") = Request("TableContentcolor")
rs("AlertFontColor") = Request("AlertFontColor")
rs("ContentTitle") = Request("ContentTitle")
rs("ads1") = Request("ads1")
rs("ads2") =Request("ads2")
rs("Copyright") = Request("Copyright")
rs("Version") = Request("Version")
rs.update
rs.close
call getconst()
set conn = nothing

%>
<center><p><b>���óɹ���</b>
<%
end sub
%>