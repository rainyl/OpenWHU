<%@ LANGUAGE="VBSCRIPT" %>
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	if session("masterlogin")<>"superadmin" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
%>
<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->
<%
		call main()
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=atablebackcolor%> align=center>
  <tr>
    <td height="30"> 
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=aTabletitlecolor%>'>
        <td align=center colspan="2">��ӭ<b><%=session("mastername")%></b>�������ҳ��
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              
          <td width="25%" valign=top> <%call left()%> </td>
              
          <td width="75%" valign=top>
<%
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
if request("save")="" then
		Set objCountFile = objFSO.OpenTextFile(Server.MapPath("forum.css"),1,True)
		If Not objCountFile.AtEndOfStream Then fdata = objCountFile.ReadAll
	else
		fdata=request("fdata")
		Set objCountFile=objFSO.CreateTextFile(Server.MapPath("forum.css"),True)
		objCountFile.Write fdata
	end if
	objCountFile.Close
	Set objCountFile=Nothing
	Set objFSO = Nothing
%> 
<form method=post>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td width="3%" height="23">&nbsp;</td>
                <td width="97%" height="23">��̳ģ��༭��<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;ע�⣺�ļ������������㰲װĿ¼�µ�<font color="<%=AlertfontColor%>">FORUM.CSS</font>�������Ŀռ䲻֧��<font color="<%=AlertfontColor%>">FSO</font>����ֱ�ӱ༭���ļ����������CSS�����Բ��˽⣬�벻Ҫ����༭��</td>
              </tr>
              <tr> 
                <td width="3%">&nbsp; </td>
                <td width="97%"> 
                  <textarea name="fdata" cols="60" rows="20"><%=fdata%></textarea>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td width="97%">
                  <input type="reset" name="Reset" value="�����޸�">
                  <input type="submit" name="save" value="�ύ�޸�"> ��ǰ�ļ�·����<font color=<%=AlertfontColor%>><b><%=Server.MapPath("forum.css")%></b></font>
                </td>
              </tr>
            </table></form>
            <p>&nbsp;</p>
            </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%

end sub%>