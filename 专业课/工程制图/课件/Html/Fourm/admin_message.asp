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
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->

<%
		dim body
		dim rs,sql,sql1
        	set rs = server.CreateObject ("adodb.recordset")
		call main()
		set rs=nothing
		conn.close
		set conn=nothing
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
          <td width="20%" valign=top height="276"> <%call left()%> </td>
          <td width="80%" valign=top height="276"> 
<%
	if Request("action")="add" then
		call savemsg()
	elseif request("action")="del" then
		call del()
	elseif request("action")="delall" then
		call delall()
	else
		call sendmsg()
	end if
%>
<p align=center><%=body%></p>
          </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub savemsg()
	dim sendtime,sender
	sendtime=Now()
	sender="����С����"
        sql1 = "select username from [user]"
        rs.Open sql1,conn,1,1
        do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag) values('"
   
   sql=sql&(rs("username"))&"','"
   sql=sql&(sender)&"','"
   sql=sql&(TRim(Request("title")))&"','"
   sql=sql&(Trim(Request("message")))&"','"
   sql=sql&(sendtime)&"','"
   sql=sql&(0)&"')"
   conn.Execute(sql)
		rs.MoveNext 
		Loop
		rs.Close
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub sendmsg()
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="7"> 
                    <p><b>ϵͳ��Ϣ����</b>��<br>
                      ע�⣺�������������̳������ע���û����Ͷ���Ϣ��</p>
                  </td>
                </tr>
            <form action="admin_message.asp?action=add" method=post>
                <tr> 
                  <td width="22%">��Ϣ����</td>
                  <td width="78%"> 
                    <input type="text" name="title" size="50">
                  </td>
                </tr>
                <tr> 
                  <td width="22%" height="20" valign="top">
                    <p>��Ϣ����</p>
                    <p>(<font color="<%=AlertFontColor%>">HTML����֧��</font>)</p>
                  </td>
                  <td width="78%" height="20"> 
                    <textarea name="message" cols="50 " rows="10"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="22%" height="23" valign="top" align="center"> 
                    <div align="left"> </div>
                  </td>
                  <td width="78%" height="23"> 
                    <div align="center"> 
                      <input type="submit" name="Submit" value="������Ϣ">
                      <input type="reset" name="Submit2" value="������д">
                    </div>
                  </td>
                </tr>
            </form>
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="20"> 
                    <p><b>����ɾ����
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> 
            <form action="admin_message.asp?action=del" method=post>
                      ����ɾ��ĳ�û�����Ϣ����Ҫ����ɾ��ϵͳ������Ϣ������С���飩��<br><input type="text" name="username" size="20">
			<input type="submit" name="Submit" value="�� ��">
            </form>
			<a href=admin_message.asp?action=delall><font color=<%=AlertFontColor%>>ɾ�������û�����Ϣ</font></a></a>
                  </td>
                </tr>
              </table>
<%
end sub

sub del()
	if request("username")="" then
		body=body+"<br>"+"������Ҫ����ɾ�����û�����"
		exit sub
	end if
	sql="delete from message where sender='"&request("username")&"'"
	conn.Execute(sql)
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub delall()
	sql="delete from message where id>0"
	conn.Execute(sql)
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
end sub
%>