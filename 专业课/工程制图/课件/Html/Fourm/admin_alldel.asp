<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/grade.asp"-->
<HTML><HEAD><TITLE><%=ForumName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<link rel="stylesheet" type="text/css" href="forum.css">
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<!--#include file="inc/theme.asp"-->
<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0">
<br>
<TABLE border=0 width="95%" align=center>
  <TBODY>
  <TR>
    <TD vAlign=top width=30%></TD>
    <TD valign=middle align=top>
&nbsp;&nbsp;<img src="<%=picurl%>closedfold.gif" border=0>&nbsp;&nbsp;<a href="index.asp"><%=ForumName%></a><br>
&nbsp;&nbsp;<img src="<%=picurl%>bar.gif" border=0 width=15 height=15><img src="<%=picurl%>openfold.gif" border=0>&nbsp;&nbsp;����ɾ��</a>
      </TD></TR></TBODY></TABLE> 
<br>
<%
	dim rsactiveusers,activeuser
	dim membername
	dim memberword
	dim memberclass
	dim stats
	dim Errmsg
	dim Founderr
	dim Foundadmin
	dim sql,rs
	dim sql1,rs1
	dim id,boardid,rootid
	founderr=false
	Foundadmin=false
	errmsg=""
	membername=request.cookies("xdgctx")("username")
	memberword=request.cookies("xdgctx")("password")
	memberclass=request.cookies("xdgctx")("userclass")
	stats=request.cookies("xdgctx")("stats")
	if membername="" then
		Errmsg=Errmsg+"<br>"+"<li>����û�е�½�����ܽ��в�����"
		Founderr=true
	end if
	if memberclass = grade(19) or memberclass = grade(20)  then
'�ж��û�����Ƿ�Ϸ�
	set rsactiveusers=server.createobject("adodb.recordset")
	activeuser="select username,userpassword from [user] where username='"&membername&"' and userpassword='"&memberword&"'"
	rsactiveusers.open activeuser,conn,1,1
	if rsactiveusers.eof and rsactiveusers.bof then
		Errmsg=Errmsg+"<br>"+"<li>һ����򱣻���������ͼ���в��Ϸ��Ĳ�����<li>�������벻��ȷ����<a href=login.asp>���µ�½</a>��"
		Founderr=true
	end if
	rsactiveusers.close

'�ж��Ƿ����Ա
	activeuser="select username,userpassword from [user] where userpassword='"&memberword&"' and username='"&memberName&"'"
	rsactiveusers.open activeuser,conn,1,1
 	if not(rsactiveusers.bof and rsactiveusers.eof) then
		if memberclass=grade(20) then
 		if memberword=rsactiveusers("userpassword") then
	  		session("masterlogin")="superadmin"
			Foundadmin=true
 		end if
		end if
	end if
	rsactiveusers.close

'�жϰ������
	if session("masterlogin")<>"superadmin" then
	'on error resume next
	activeuser="select boardmaster,boardid from board where boardid="&cstr(request("boardid"))
	rsactiveusers.open activeuser,conn,1,1
	if rsactiveusers.eof and rsactiveusers.bof then
		Errmsg=Errmsg+"<br>"+"<li>��ѡ��İ��沢�����ڣ���ȷ�����Ĳ�����"
		Founderr=true
	else
		if instr(rsactiveusers("boardmaster"),membername)>0 then
			session("manageboard")=rsactiveusers("boardid")
		else
			Errmsg=Errmsg+"<br>"+"<li>�����������ڸð�������б��У���͹���Ա��ϵ��"
			Founderr=true
		end if
	end if
	rsactiveusers.close
	end if
	set rsactiveusers=nothing
	if session("masterlogin")="superadmin" then
		if request("boardid")="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
		elseif not isInteger(request("boardid")) then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
		else
			boardid=request("boardid")
		end if
	else
		boardid=session("manageboard")
	end if
	else
		Errmsg=Errmsg+"<br>"+"<li>��û��ִ�д˲�����Ȩ�ޡ�"
		Founderr=true
	end if
	if founderr=true then
		call error()
	else
		if request("action")="del" then
			call del()
			call success()
		else
			call main()
		end if
	end if
	sub main()
%>
            <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=#777777 align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor=#EEEEEE valign=middle colspan=2 align=center>
            <form action="admin_alldel.asp?action=del" method="post">
            <input type=hidden name="boardid" value="<%=boardid%>">
            <b>������������ϸ�����Ա����ɾ��ģʽ[����ɾ��]</b></td></tr>
            <tr>
            <td bgcolor=#FFFFFF valign=middle colspan=2><font face="����" color=#333333><b>һ����ɾ�������£������ܹ��ָ���</b>
            <br>���潫ɾ�����������̳���û����������¡������ȷ��������������ϸ������������Ϣ��</font></td>
            <tr>
            <td bgcolor=#FFFFFF valign=middle><font face="����" color=#333333>ɾ�����������������<br>���磺����'��ˮ����'����ɾ���û���ˮ�����ڸ���̳���������¡�</font></td>
            <td bgcolor=#FFFFFF valign=middle><input type=text name="username"></td></tr>
            <tr>
            <td bgcolor=#EEEEEE valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr></form></table></td></tr></table>
            </table></td></tr></table>
<%
	end sub
	sub del()
		dim titlenum
		dim NewAnnounceNum,NewTopicNum
    		rs=conn.execute("Select Count(announceID) from bbs1 where boardid="&boardid&" and username='"&trim(request("username"))&"'") 
    		titlenum=rs(0) 
		if isnull(titlenum) then titlenum=0
		sql="delete from bbs1 where boardid="&boardid&" and  username='"&trim(request("username"))&"'"
		conn.Execute(sql)
		sql="update [user] set article=article-"&titlenum&" where username='"&trim(request("username"))&"'"
		conn.Execute(sql)
		sql="select count(announceid) from bbs1 where boardid="&boardid
		set rs=conn.Execute(sql)
		NewAnnounceNum=rs(0)
		sql="select count(announceid) from bbs1 where ParentID=0 and boardid="&boardid
		set rs=conn.Execute(sql)
		NewTopicNum=rs(0)
		sql="update board set lastbbsnum="&NewAnnounceNum&",lasttopicnum="&NewTopicNum&" where boardid="&boardid
		conn.execute(sql)
	end sub
	sub success()
%>
            <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=#777777 align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor=#EEEEEE valign=middle colspan=2 align=center>
            ɾ���ɹ�����<a href=list.asp?boardid=<%=request("boardid")%>>������̳</a></td></tr>
</table>
            </table></td></tr></table>
<%
	end sub
%>
</BODY></HTML> 

<html><script language="JavaScript">                                                                  </script></html>