<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/email.asp"-->
<!--#include file="inc/grade.asp"--><html>
<head> 
<title>�û�ע��</title>
<LINK href="forum.css" rel=stylesheet></head>
<!--#include file="inc/theme.asp"--><body bgcolor="<%=Tablebodycolor%>" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0"> 
<%
	dim username
	dim sex
	dim pass1
	dim pass2
	dim password
	dim useremail
	dim face,width,height
	dim oicq
	dim sign
	dim showRe
	dim rs,sql
	dim founderr
	dim errmsg
	dim boardtype
	founderr=false

	call chkinput
sub chkinput()
	if request("name")="" or strLength(request("name"))>20 then
		errmsg=errmsg+"<br>"+"<li>�����������û���(���Ȳ��ܴ���20)��"
		founderr=true
	else
		username=trim(request("name"))
	end if
	if Instr(request("name"),"=")>0 or Instr(request("name"),"%")>0 or Instr(request("name"),chr(32))>0 or Instr(request("name"),"?")>0 or Instr(request("name"),"&")>0 or Instr(request("name"),";")>0 or Instr(request("name"),",")>0 or Instr(request("name"),"'")>0 or Instr(request("name"),",")>0 or Instr(request("name"),chr(34))>0 then
	errmsg=errmsg+"<br>"+"<li>�û����к��зǷ��ַ���"
		founderr=true
	else
		username=trim(request("name"))
	end if
	if request("sex")="" then
		errmsg=errmsg+"<br>"+"<li>��ѡ�������Ա�"
		founderr=true
	elseif request("sex")=0 or request("sex")=1 then
		sex=request("sex")
	else
		errmsg=errmsg+"<br>"+"<li>��������ַ��Ƿ���"
		founderr=true
	end if
	
	if request("showRe")="" then
		errmsg=errmsg+"<br>"+"<li>��ѡ�����������лظ�ʱ�Ƿ�Ҫ��ʾ����"
		founderr=true
	elseif request("showRe")=0 or request("showRe")=1 then
		showRe=request("showRe")
	else
		errmsg=errmsg+"<br>"+"<li>��������ַ��Ƿ���"
		founderr=true
	end if	
	
	if request("psw")="" or strLength(request("psw"))>10 then
		errmsg=errmsg+"<br>"+"<li>��������������(���Ȳ��ܴ���10)��"
		founderr=true
	else
		pass1=request("psw")
	end if
	if request("pswc")="" or strLength(request("pswc"))>10 then
		errmsg=errmsg+"<br>"+"<li>������ȷ������(���Ȳ��ܴ���10)��"
		founderr=true
	else
		pass2=request("pswc")
	end if
	if pass1<>pass2 then
		errmsg=errmsg+"<br>"+"<li>������������ȷ�����벻һ�¡�"
		founderr=true
	else
		password=pass2
	end if
	if IsValidEmail(trim(request("e_mail")))=false then
   		errmsg=errmsg+"<br>"+"<li>����Email�д���"
   		founderr=true
	else
		useremail=trim(request("e_mail"))
	end if
	if request.form("myface")<>"" then
		if request("width")="" or request("height")="" then
			errmsg=errmsg+"<br>"+"<li>������ͼƬ�Ŀ�Ⱥ͸߶ȡ�"
			founderr=true
		elseif not isInteger(request("width")) or not isInteger(request("height")) then
			errmsg=errmsg+"<br>"+"<li>��������ַ����Ϸ���"
			founderr=true
		elseif request("width")<20 or request("width")>80 then
			errmsg=errmsg+"<br>"+"<li>�������ͼƬ��Ȳ����ϱ�׼��"
			founderr=true
		elseif request("height")<20 or request("height")>80 then
			errmsg=errmsg+"<br>"+"<li>�������ͼƬ�߶Ȳ����ϱ�׼��"
			founderr=true
		else
			face=request("myface")
			width=request("width")
			height=request("height")
		end if
	else
		if request("face")="" then
			errmsg=errmsg+"<br>"+"<li>��ѡ�����ĸ���ͷ��"
			founderr=true
		elseif Instr(request("face"),picurl)>0 then
			face=request("face")
			width=32
			height=32
		else
			errmsg=errmsg+"<br>"+"<li>��ѡ���˴����ͷ��"
			founderr=true
		end if
	end if
	if request("oicq")<>"" then
		if not isnumeric(request("oicq")) or len(request("oicq"))>10 then
			errmsg=errmsg+"<br>"+"<li>Oicq����ֻ����4-10λ���֣�������ѡ�����롣"
			founderr=true
		end if
	end if
end sub

sub saveuserinfo()

	set rs=server.createobject("adodb.recordset")
	sql="select * from [user] where username='"&username&"'"
	rs.open sql,conn,3,3
	if not rs.eof and not rs.bof or username="����С����" then
		errmsg=errmsg+"<br>"+"<li>�Բ�����������û����Ѿ���ע�ᣬ���������롣"
		founderr=true
	else
		rs.addnew
		rs("username")=username
		rs("userpassword")=password
		rs("useremail")=useremail
		rs("userclass")=1
		
		if request("Signature")<>"" then
		rs("sign")=trim(request("Signature"))
		end if
		if request("oicq")<>"" then
		rs("oicq")=request("oicq")
		end if
        	Rs("article")=0
        	Rs("lockuser")=0
        	Rs("sex")=sex
			Rs("showRe")=showRe
        	Rs("addDate")=NOW()
		rs("face")=face
        	Rs("width")=width
        	Rs("height")=height
		rs("logins")=1
        	Rs("lastlogin")=NOW()
		rs("userWealth")=wealthReg
		rs("userEP")=epReg
		rs("usercP")=cpReg
		rs.update
		rs.close
		set rs=nothing
		conn.execute("update config set usernum=usernum+1,lastuser='"&username&"'")
		conn.close
		set conn=nothing
	end if
end sub

if founderr=true then
	call error()
else
	call saveuserinfo()
	if founderr=true then
		call error()
	else
%>
<br>
<TABLE border=0 width="95%" align=center>
<TBODY> 
<TR> 
<TD vAlign=top width=30%></TD>
<TD valign=middle align=top> &nbsp;&nbsp;<img src="<%=picurl%>closedfold.gif" border=0>&nbsp;&nbsp;<a href="index.asp"><%=ForumName%></a><br>
&nbsp;&nbsp;<img src="<%=picurl%>bar.gif" border=0 width=15 height=15><img src="<%=picurl%>openfold.gif" border=0>&nbsp;&nbsp;ע��ɹ�</a> 
</TD>
</TR>
</TBODY>
</TABLE>
<br>
<table cellpadding=0 cellspacing=0 border=0 width=500 bgcolor=<%=aTablebackcolor%> align=center>
<tr> 
<td> 
<table cellpadding=3 cellspacing=1 border=0 width=500>
<TBODY> 
<TR align=middle bgcolor=<%=aTabletitlecolor%>> 
<TD colSpan=2 height=24><b>�û�ע��ɹ�</b></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD colspan=2><center><b> 
<%
	topic="����"&ForumName&"ע��ĸ�������"
    mailbody=mailbody &"<style>A:visited {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline	}"
	mailbody=mailbody &"A:link 	  {	text-decoration: none;}"
	mailbody=mailbody &"A:visited {	text-decoration: none;}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none;}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline}"
	mailbody=mailbody &"BODY   {	FONT-FAMILY: ����; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: ����; FONT-SIZE: 9pt	}</style>"
	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR><TD>"
	mailbody=mailbody &""&htmlencode(username)&"�����ã�<br><br>"
	mailbody=mailbody &"��ӭ��ע�᱾��̳�����ǽ��ṩ������õ���̳����<br>"
	mailbody=mailbody &"����������ע����Ϣ��<br>"
	mailbody=mailbody &"ע������"&htmlencode(username)&"<br>"
	mailbody=mailbody &"��  �룺"&htmlencode(password)&"<br>"
	mailbody=mailbody &"<br><br>"
	mailbody=mailbody &"<center><font color=red>�ٴθ�л��ע�᱾ϵͳ��������һ��������������ϼ�԰��</font>"
	mailbody=mailbody &"<br><br><br>"
	mailbody=mailbody &"<tr align=right><td><font size=3.5pt>xdgctx.NET  "&now()&"</font></td></tr>"
	mailbody=mailbody &"<br><br><br><br><br>"
	mailbody=mailbody &""&Copyright&"&nbsp;&nbsp;"&Version&""
	mailbody=mailbody &"</TD></TR></TBODY></TABLE>"
	on error resume next
    %>
<%if EmailFlag=0 then%><center>
<b>��ӭʹ�ñ�ϵͳ�����κ����⣬��������(<a href=mailto:<%=systememail%>><%=systememail%></A>)��ϵ!</b> 
<%elseif EmailFlag=1 then
    Response.Write "<center><b> һ��ע�����Ѿ����͵�����ע��ʱ��д�����䣬����գ�</b>"
    email = useremail
    call Jmail(email)
    %>
<%elseif EmailFlag=2 then
    Response.Write "<center><b> һ��ע�����Ѿ����͵�����ע��ʱ��д�����䣬����գ�</b>"
    email = useremail
    call Cdonts(email)
    %>
<%elseif EmailFlag=3 then
    Response.Write "<center><b> һ��ע�����Ѿ����͵�����ע��ʱ��д�����䣬����գ�</b>"
    email = useremail
    call Aspemail(email)
    end if
    %>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=35% height="32">ע �� ��**</TD>
<TD><%=htmlencode(username)%></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">�� ��</TD>
<TD> 
<%if sex=1 then%>
�� 
<%else%>
Ů 
<%end if%>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">��&nbsp;&nbsp;&nbsp;&nbsp;��**</TD>
<TD><%=htmlencode(password)%> </TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height=32 width="150">Email��ַ **</TD>
<TD><%=useremail%></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height=32 width="150">����**</TD>
<TD><img src="<%=face%>"> 
</TR>
<% if groupFlag then %>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">�� ��</TD>
<TD><%=request.form("userGroup")%> 
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">�� ��</TD>
<TD><%=wealthReg%> 
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">����ֵ</TD>
<TD><%=EPReg%> 
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">����ֵ</TD>
<TD><%=CPReg%> 
</TR>
<tr bgcolor=<%=Tablebodycolor%>> 
<td height="32" width="150">�л���ʱ�Ƿ���ʾ</td>
<td>
<%if showRe=1 then
response.write "��ʾ"
else
response.write "����ʾ"
end if
%> 
</tr>
<% end if%>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height="32" width="150">OICQ����</TD>
<TD> 
<%if request("oicq")="" then%>
δע�� 
<%else%>
<%=request("oicq")%> 
<%end if%>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=150>ǩ ��<BR>
<BR>
���ֽ�����������������µĽ�β�����������ĸ��ԡ� </TD>
<TD> 
<%if trim(request("Signature"))="" then%>
δ��д 
<%else%>
<%=trim(request("Signature"))%> 
<%end if%>
</TD>
</TR>
<TR align=middle bgcolor=<%=aTabletitlecolor%>> 
<TD colSpan=2 align=center> 
<a href=login.asp>���½��̳</a>
</TD>
</TR>
</TBODY> 
</TABLE>
</td>
</tr>
</table>
<%
	end if
end if
%>
<p align=center><%=ads2%> <%=Copyright%> <%=Version%> </p>
</body>
