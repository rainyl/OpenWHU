<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
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
	dim Maxid
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
	activeuser="select username,userpassword from [user] where userpassword='"&trim(memberword)&"' and username='"&trim(membername)&"'"
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
	on error resume next
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
	else
		Errmsg=Errmsg+"<br>"+"<li>��û��ִ�д˲�����Ȩ�ޡ�"
		Founderr=true
	end if
	if founderr=true then
		call error()
	else
	dim title
	dim content
	set rs=server.createobject("adodb.recordset")
	call main()
	set rs=nothing
	conn.close
	set conn=nothing
	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=atablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=aTabletitlecolor%>'>
        <td align=center colspan="2">��ӭ<b>
<%=htmlencode(membername)%></b>�������ҳ��
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="20%" valign=top>
ע�⣺����������ʦ�������Լ��������ɷ������棬����Ա���������а��淢����������Ϣ���й��������
<br>
	      </td>
              <td width="80%" valign=top>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr>
			<td width="100%" valign=top height=24 bgcolor=<%=aTableTitlecolor%>>

<font color=red>��������д��Ϣ</font>
		  </td></tr>
		</table>
<%
	if request("action")="new" then
		call savenews()
	elseif request("action")="manage" then
		call manage()
	elseif request("action")="edit" then
		call edit()
	elseif request("action")="del" then
		call del()
	elseif request("action")="update" then
		call update()
	else
		call news()
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

sub news()
%>
<form action="admin_news.asp?action=new" method=post name=FORM>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="100%" valign=top height=24 colspan="2"><br>
<b><a href=admin_news.asp>��̳���淢��</a></b><%if session("masterlogin")="superadmin" then%>  |  <b><a href=admin_news.asp?action=manage>�������</a></b><%end if%><br><br>
		  </td></tr>
		  <tr><td width="20%" valign=top>
�������棺
		  </td>
		  <td width="80%">
<%if session("masterlogin")="superadmin" then%>
<%
   sql="select boardid,boardtype from board"
   rs.open sql,conn,1,1
%>
<select name="boardid" size="1">
<option value="0">��̳��ҳ</option>
<%
	do while not rs.eof
        response.write "<option value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
<%else%>
<%
	sql="select boardtype from board where boardid="&session("manageboard")
	rs.open sql,conn,1,1
	boardtype=rs("boardtype")
%>
<select name="boardid" size="1">
<option value="<%=session("manageboard")%>"><%=boardtype%></option>
</select>
<%end if%>
		  </td></tr>
		  <tr><td width="20%" valign=top>
�����ˣ�
		  </td>
		  <td width="80%"><input type=text name=username size=36></td></tr>
		  <tr><td width="20%" valign=top>
���⣺
		  </td>
		  <td width="80%"><input type=text name=title size=36></td></tr>
		  <tr><td width="20%" valign=top>
���ݣ�
		  </td>
		  <td width="80%"><textarea cols=35 rows=6 name="content"></textarea></td>
		  </tr>
		  <tr><td width="100%" valign=top colspan="2" align=center>
<input type=Submit value="�� ��" name=Submit"> &nbsp; <input type="reset" name="Clear" value="�� ��">
		  </td></tr>
		</table>
</form>
<%
end sub

sub savenews()
	if session("masterlogin")="superadmin" then
		boardid=request("boardid")
	else
		boardid=session("manageboard")
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����뷢���ߡ�"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>���������ű��⡣"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>�������������ݡ�"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews"
		rs.open sql,conn,1,3
		rs.addnew
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub manage()
	if session("masterlogin")<>"superadmin" then
	exit sub
	end if
	sql="select * from bbsnews"
	rs.open sql,conn,1,1
%>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="100%" valign=top height=24 colspan="2"><br>
<b><a href=admin_news.asp>��̳���淢��</a></b><%if session("masterlogin")="superadmin" then%>  |  <b>�������</b><%end if%><br>��������������޸ġ�<br><br>
		  </td></tr>
		  <tr><td width="80%" valign=top height=22>
����
		  </td>
		  <td width="20%">
����
		  </td></tr>
<%do while not rs.eof%>
		  <tr><td width="80%" valign=top height=22><a href=admin_news.asp?action=edit&id=<%=rs("id")%>&boardid=<%=rs("boardid")%>><%=rs("title")%></a>
		  </td>
		  <td width="20%"><a href=admin_news.asp?action=del&id=<%=rs("id")%>>ɾ��</a>
		  </td></tr>
<%
	rs.movenext
	loop
	rs.close
end sub

sub edit()
%>
<form action="admin_news.asp?action=update&id=<%=request("id")%>" method=post>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="100%" valign=top height=24 colspan="2"><br>
<b><a href=admin_news.asp>��̳���淢��</a></b><%if session("masterlogin")="superadmin" then%>  |  <b><a href=admin_news.asp?action=manage>�������</a></b><%end if%><br><br>
		  </td></tr>
		  <tr><td width="20%" valign=top>
�������棺
		  </td>
		  <td width="80%">
<%
	dim sel
   	sql="select boardid,boardtype from board"
   	rs.open sql,conn,1,1
%>
<select name="boardid" size="1">
<option value="0" <%if request("boardid")=0 then%>selected<%end if%>>��̳��ҳ</option>
<%
	do while not rs.eof
	if Cint(request("boardid"))=Cint(rs("boardid")) then
	sel="selected"
	else
	sel=""
	end if
        response.write "<option value='"+CStr(rs("BoardID"))+"' "&sel&">"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
		  </td></tr>
<%
	sql="select * from bbsnews where id="&cstr(request("id"))
	rs.open sql,conn,1,1
%>
		  <tr><td width="20%" valign=top>
�����ˣ�
		  </td>
		  <td width="80%"><input type=text name=username size=36 value=<%=rs("username")%>></td></tr>
		  <tr><td width="20%" valign=top>
���⣺
		  </td>
		  <td width="80%"><input type=text name=title size=36 value=<%=rs("title")%>></td></tr>
		  <tr><td width="20%" valign=top>
���ݣ�
		  </td>
		  <td width="80%"><textarea cols=35 rows=6 name="content">
<%
	    content=replace(rs("content"),"<br>",chr(13))
            content=replace(content,"&nbsp;"," ")
            response.write ""&content&""
	    rs.close
%>
		  </textarea></td>
		  </tr>
		  <tr><td width="100%" valign=top colspan="2" align=center>
<input type=Submit value="�� ��" name=Submit"> &nbsp; <input type="reset" name="Clear" value="�� ��">
		  </td></tr>
		</table>
</form>
<%
end sub

sub update()
	if session("masterlogin")="superadmin" then
		boardid=request("boardid")
	else
		exit sub
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����뷢���ߡ�"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>���������ű��⡣"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>�������������ݡ�"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews where id="&cstr(request("id"))
		rs.open sql,conn,1,3
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub del()
	sql="delete from bbsnews where id="&cstr(request("id"))
	conn.execute(sql)
	call success()
end sub

sub success()
%><br><br>
�ɹ������Ų����������Լ�����ӣ�
<%
end sub
end if
%>
