<!--#include file=inc/grade.asp-->
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
	activeuser="select username,userpassword from [user] where userpassword='"&memberword&"' and username='"&membername&"'"
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

'����������
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		id=request("id")
	end if
	if request("rootid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("rootid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		rootid=request("rootid")
	end if
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
%>
<html><script language="JavaScript">                                                                  </script></html>