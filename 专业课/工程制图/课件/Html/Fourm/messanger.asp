<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/stats.asp"-->
<!--#include file="inc/char.asp"-->
<html>
<head>
<title><%=ForumName%>--����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="forum.css" rel=stylesheet>
</head>
<body bgcolor="<%=Tablebodycolor%>" alink="#333333" vlink="#333333" link="#333333" topmargin=10 leftmargin=10>
<%
	dim errmsg
	dim founderr
	founderr=false
	dim msg
	set rs=server.createobject("adodb.recordset")

if membername="" then
  	errmsg=errmsg+"<br>"+"<li>��û��<a href=login.asp target=_blank>��¼</a>��"
	founderr=true
else

end if

if founderr=true then
	call error()
else
	if request("action")="inbox" then
	call inbox()
	elseif request("action")="outbox" then
	call outbox()
	elseif request("action")="new" then
	call sendmsg()
	elseif request("action")="read" or request("action")="outread" then
	call read()
	elseif request("action")="delete" then
	call delete()
	elseif request("action")="deleteall" then
	call deleteall()
	elseif request("action")="send" then
	call savemsg()
	elseif request("action")="newmsg" then
	call newmsg()
	else
	call error()
	end if
end if


'�ռ���
sub inbox()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center colspan=3><font face="����" color=#333333><b>��ӭʹ�������ռ��䣬<%=membername%></b></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=inbox"><img src="<%=picurl%>inboxpm.gif" border=0 alt="�ռ���"></a> &nbsp; <a href="messanger.asp?action=outbox"><img src="<%=picurl%>outboxpm.gif" border=0 alt="������"></a> &nbsp; <a href="messanger.asp?action=new"><img src="<%=picurl%>newpm.gif" border=0 alt="������Ϣ"></a></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color=#333333><b>����</b></td>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color=#333333><b>����</b></td>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color=#333333><b>�Ѷ�</b></td>
            </tr>
<%
	sql="select * from message where (delR=0 or delR is null) and incept='"&trim(membername)&"' order by flag,sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=3><font face="����" color=#333333>����û���������ޣ���</td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color=#333333><%=htmlencode(rs("sender"))%></td>
                    <td bgcolor=<%=Tablebodycolor%> align=left valign=middle><font face="����" color=#333333><a href="messanger.asp?action=read&id=<%=rs("id")%>"><%=htmlencode(rs("title"))%></a></td>
                    <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color="#333333"><%if rs("flag")=0 then%><font color=red><b>��</b></font><%else%>��<%end if%></font></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
%>
                <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center valign=middle colspan=3><font face="����" color=#333333><a href="messanger.asp?action=deleteall">ɾ�����еĶ���Ϣ</a></td>
                </tr>
                </table></td></tr></table>
<%
end sub


'������
sub outbox()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center colspan=2><font face="����" color=#333333><b>��ӭʹ�ö���Ϣ���ͣ�<%=membername%></b></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=inbox"><img src="<%=picurl%>inboxpm.gif" border=0 alt="�ռ���"></a> &nbsp; <a href="messanger.asp?action=outbox"><img src="<%=picurl%>outboxpm.gif" border=0 alt="������"></a> &nbsp; <a href="messanger.asp?action=new"><img src="<%=picurl%>newpm.gif" border=0 alt="������Ϣ"></a></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle width=20%><font face="����" color=#333333><b>�ռ���</b></td>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle><font face="����" color=#333333><b>����</b></td>
            </tr>
<%
	sql="select * from message where (delS=0 or delS is null) and sender='"&trim(membername)&"' order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=2><font face="����" color=#333333>����û�и����˷�����Ϣ��~~</td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> align=center valign=middle width=20%><font face="����" color=#333333><%=htmlencode(rs("incept"))%></td>
                    <td bgcolor=<%=Tablebodycolor%> align=left valign=middle><font face="����" color=#333333><a href="messanger.asp?action=outread&id=<%=rs("id")%>"><%=htmlencode(rs("title"))%></a></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
%>                
                <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center valign=middle colspan=2><font face="����" color=#333333><a href="messanger.asp?action=deleteall">ɾ�����еĶ���Ϣ</a></td>
                </tr>
                </table></td></tr></table>
<%
end sub


'������Ϣ
sub sendmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center colspan=3><font face="����" color=#333333><b>���Ͷ���Ϣ</b></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=inbox"><img src="<%=picurl%>inboxpm.gif" border=0 alt="�ռ���"></a> &nbsp; <a href="messanger.asp?action=outbox"><img src="<%=picurl%>outboxpm.gif" border=0 alt="������"></a> &nbsp; <a href="messanger.asp?action=new"><img src="<%=picurl%>newpm.gif" border=0 alt="������Ϣ"></a></td>
            </tr>
            <tr>
            <td bgcolor=<%=aTabletitlecolor%> colspan=2 align=center>
            <form action="messanger.asp" method=post name=FORM>
            <input type=hidden name="action" value="send">
            <font face="����" color=#333333><b>����������������Ϣ</b></td>
            </tr>
            <tr>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font face="����" color=#333333><b>�ռ��ˣ�</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=text name="touser" value="<%=request("touser")%>" size=20></a></td></tr>
            <tr>
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font face="����" color=#333333><b>���⣺</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=text name="title" size=36 maxlength=80></td>
            </tr>
            <tr>
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font face="����" color=#333333><b>���ݣ�</b></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><textarea cols=35 rows=6 name="message"></textarea></td>
            </tr>
            <tr>
            <td bgcolor=<%=aTabletitlecolor%> valign=middle colspan=2 align=center>
            <input type=Submit value="�� ��" name=Submit"> &nbsp; <input type="reset" name="Clear" value="�� ��">
            </td></form></tr>
            </table></td></tr></table>
<%
end sub


'��ȡ��Ϣ
sub read()
%>
<%
   	sql="update message set flag=1 where ID="&cstr(request("id"))
   	rs.open sql,conn,1,3
	sql="select * from message where incept='"&membername&"' and id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>���ǲ����ܵ����˵������������߸���Ϣ�Ѿ�ɾ����"
		founderr=true
	end if
	if founderr=true then
		call error()
	else
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=aTabletitlecolor%> align=center colspan=3><font face="����" color=#333333><b>��ӭʹ�ö���Ϣ���գ�<%=membername%></b></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=delete&id=<%=rs("id")%>"><img src="<%=picurl%>deletepm.gif" border=0 alt="ɾ����Ϣ"></a> &nbsp; <a href="messanger.asp?action=inbox"><img src="<%=picurl%>inboxpm.gif" border=0 alt="�ռ���"></a> &nbsp; <a href="messanger.asp?action=outbox"><img src="<%=picurl%>outboxpm.gif" border=0 alt="������"></a> &nbsp;<a href="messanger.asp?action=new"><img src="<%=picurl%>newpm.gif" border=0 alt="������Ϣ"></a> &nbsp;<a href="messanger.asp?action=new&touser=<%=htmlencode(rs("sender"))%>"><img src="<%=picurl%>replypm.gif" border=0 alt="�ظ���Ϣ"></a></td>
            </tr>
                <tr>
                    <td bgcolor=<%=aTabletitlecolor%> valign=middle align=center><font face="����" color=#333333>
<%if request("action")="outread" then%>
                    ��<b><%=rs("sendtime")%></b>�������ʹ���Ϣ��<b><%=htmlencode(rs("incept"))%></b>��
<%else%>
		    ��<b><%=rs("sendtime")%></b>��<b><%=htmlencode(rs("sender"))%></b>�������͵���Ϣ��
<%end if%></font></td>
                </tr>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> valign=top align=left><font face="����" color=#333333>
                    <b>��Ϣ���⣺<%=htmlencode(rs("title"))%></b><p>
                    <%if rs("sender")="����С����" then%>
                    <%=rs("content")%>
                    <%else%>
                    <%=ubbcode(rs("content"))%>
                    <%end if%>
		    </td>
                </tr>
                </table></td></tr></table>
<%end if%>
<%
end sub

sub savemsg()
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>��������д���Ͷ����˰ɡ�"
		founderr=true
	else
		incept=request("touser")
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>����û����д����ѽ��"
		founderr=true
	else
		title=request("title")
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>�����Ǳ���Ҫ��д���ޡ�"
		founderr=true
	else
		message=request("message")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from [user] where username='"&incept&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>��̳û������û���������ķ��Ͷ���д�����"
			founderr=true
		end if
		rs.close
		if founderr=true then
			call error()
		else
		sql="select * from message where (id is null)"
		rs.open sql,conn,1,3
		rs.addnew
		rs("incept")=incept
		rs("sender")=membername
		rs("title")=title
		rs("content")=message
		rs("sendtime")=Now()
		rs("flag")=0
		rs.update
		msg=msg+"<br>"+"<li><b>��ϲ�������Ͷ���Ϣ�ɹ���</b><br>���͵���Ϣͬʱ���������ķ����䡣"
		call success()
		rs.close
		end if
	end if
end sub

sub delete()
	sql="delete from message where incept='"&membername&"' and id="&cstr(request("id"))
	conn.execute sql
    	if err.Number<>0 then
	err.clear
	errmsg=errmsg+"<br>"+"<li>ɾ �� ʧ �� ��"
	founderr=true
	call error()
    	else
	msg=msg+"<br>"+"<li>����Ϣ�ɹ�ɾ����"
	call success()
    	end if
end sub

sub deleteall()
	sql="update message set delS=1 where sender='"&membername&"'"
	conn.execute sql
	
	sql="update message set delR=1 where incept='"&membername&"'"
	conn.execute sql

	sql="delete from message where delS=1 and delR=1"
	conn.execute sql
    	if err.Number<>0 then
	err.clear
	errmsg=errmsg+"<br>"+"<li>ɾ �� ʧ �� ��"
	founderr=true
	call error()
    	else
	msg=msg+"<br>"+"<li>����Ϣȫ���ɹ�ɾ����"
	call success()
    	end if
end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>�ɹ�������Ϣ</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><%=msg%>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="javascript:history.go(-1)"> << ������һҳ</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub

sub newmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>����Ϣ֪ͨ</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%> align=center><br>
<font face="����" color="#333333"><a href=messanger.asp?action=inbox><img src="<%=picurl%>newmail.gif" border=0>���µĶ���Ϣ</a><br>
                <br>
                <a href=messanger.asp?action=inbox>���˲鿴</a><br><br>
                </font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>><%=Copyright%>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
set rs=nothing
conn.close
set conn=nothing
%>

</body>
</html>