<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	dim str

	if session("masterlogin")<>"superadmin" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
		dim Errmsg
		dim Founderr
		call main()
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
        <td align=center colspan="2">��ӭ<b>
<%=session("mastername")%></b>�������ҳ��
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              
          <td width="20%" valign=top> 
            <%call left()%>
            </td>
              
          <td width="80%" valign=top> 
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td>1��ע����� �����棬��������Ŀǰ���е���̳���ࡣ�����Ա༭��̳��������������һ���µ���̳����������С� Ҳ���Ա༭��ɾ��Ŀǰ���ڵ���̳�������Զ�Ŀǰ�ķ������½������С� 
                   <p><font color=<%=AlertFontColor%>>2.�ر�ע��</font>��ɾ����̳ͬʱ��ɾ������̳���������ӣ�ɾ������ͬʱɾ��������̳���������ӣ� ����ʱ��������д����Ϣ��
                </td>
              </tr>
              <tr>
              <td>
              <p align=cetner><b><a href=admin_board.asp>��̳����</a> | <a href="admin_board.asp?action=addclass">�½���̳����</a></p>
              </td>
              <tr>
            </table>
<%
if Request("action") = "add" then
	call add()
elseif Request("action") = "edit" then
	call edit()
elseif request("action") = "savenew" then
	call savenew()
elseif request("action") = "savedit" then
	call savedit()
elseif request("action") = "del" then
	call del()
elseif request("action") = "orders" then
	call orders()
elseif request("action") = "updateorders" then
	call updateorders()
elseif request("action") = "addclass" then
	call addclass()
elseif request("action") = "saveclass" then
	call saveclass()
elseif request("action") = "del1" then
	call del1()
else
	call boardinfo()
end if
end sub

sub add()
%>
 <form action ="admin_board.asp?action=savenew" method=post>
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select boardid from board"
	rs.open sql,conn,1,1
	boardnum=rs.recordcount
	rs.close
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitlecolor%>> 
<td width="52%" height=22><b>�ֶ����ƣ�</b> </td>
<td width="48%"><b>����ֵ��</b> </td>
</tr>
<tr> 
<td width="52%">��̳��ţ�ע�ⲻ�ܺͱ����̳�����ͬ��</td>
<td width="48%"> 
<input type="text" name="boardid" size="24" value=<%=boardnum+1%>>
</td>
</tr>
<tr> 
<td width="52%">��̳��</td>
<td width="48%"> 
<input type="text" name="boardtype" size="24">
</td>
</tr>
<tr> 
<td width="52%">�������</td>
<td width="48%"> 
<select name=class>
<%
	sql = "select * from class"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	response.write "<option value=>����������"
	else
	do while not rs.EOF
%>
<option value=<%=rs("id")%>><%=rs("class")%> 
<%
	rs.MoveNext 
	loop
	end if
	rs.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%">����˵��</td>
<td width="48%"> 
<input type="text" name="readme" size="24">
</td>
</tr>
<tr> 
<td width="52%">����(������������|�ָ����磺ɳ̲С��|wodeail)��</td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24">
</td>
</tr>
<tr> 
<td width="52%">��������(0���ţ�1������2�ض��û�����)</td>
<td width="48%"> 
<select name="lockboard">
<option value="0" selected>0 
<option value="1">1 
<option value="2">2 
</select>
</td>
</tr>
<tr> 
<td width="52%">������߿���ɫ</td>
<td width="48%"> 
<input type="text" name="Tableback" size="24" value="<%=tablebackcolor%>">
</td>
</tr>
<tr> 
<td width="52%">�����������ɫ</td>
<td width="48%"> 
<input type="text" name="Tabletitle" size="24" value="<%=tabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="52%">�������ݱ����ɫ1</td>
<td width="48%"> 
<input type="text" name="Tablebody" size="24" value="<%=tablebodycolor%>">
</td>
</tr>
<tr> 
<td width="52%">�������ݱ����ɫ2����ɫ1����ɫ2��bbs����л��ഩ������</td>
<td width="48%"> 
<input type="text" name="aTablebody" size="24" value="#FFFFFF">
</td>
</tr>
<tr> 
<td width="52%">���������������ɫ</td>
<td width="48%"> 
<input type="text" name="TableFont" size="24" value="<%=tableFontcolor%>">
</td>
</tr>
<tr> 
<td width="52%">�������ݱ��������ɫ</td>
<td width="48%"> 
<input type="text" name="TableContent" size="24" value="<%=tableContentcolor%>">
</td>
</tr>
<tr> 
<td width="52%">���������ɫ</td>
<td width="48%"> 
<input type="text" name="AlertFont" size="24" value="<%=AlertFontcolor%>">
</td>
</tr>
<tr> 
<td width="52%">��̳Logo��ַ</td>
<td width="48%"> 
<input type="text" name="Logo" size="35" value="<%=logo%>">
</td>
</tr>
<tr> 
<td width="52%">��ҳ��ʾ��̳ͼƬ</td>
<td width="48%"> 
<input type="text" name="indexIMG" size="35" value="">
</td>
</tr>
<tr> 
<td width="52%">UBB��ǩ</td>
<td width="48%"> 
<select name="strAllowForumCode">
<option value="0">��ʹ�� 
<option value="1" selected>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">HTML��ǩ</td>
<td width="48%"> 
<select name="strAllowHTML">
<option value="0" selected>��ʹ�� 
<option value="1">ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">��ͼ��ǩ</td>
<td width="48%"> 
<select name="strIMGInPosts">
<option value="0">��ʹ�� 
<option value="1" selected>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">Flash��ǩ</td>
<td width="48%"> 
<select name="strflash">
<option value="0">��ʹ�� 
<option value="1" selected>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">�����ǩ</td>
<td width="48%"> 
<select name="strIcons">
<option value="0">��ʹ�� 
<option value="1" selected>ʹ�� 
</select>
</td>
</tr>
<tr bgcolor="<%=atabletitlecolor%>"> 
<td width="52%">&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="�����̳">
</td>
</tr>
</table>
</form>
<%
end sub

sub edit()
%>
 <form action ="admin_board.asp?action=savedit" method=post>           
<%
set rs_c= server.CreateObject ("adodb.recordset")
sql = "select * from class"
rs_c.open sql,conn,1,1
set rs= server.CreateObject ("adodb.recordset")
sql = "select * from board where boardid="+CSTr(request("editid"))
rs.open sql,conn,1,1
%>            
<input type='hidden' name=editid value='<%=Request("editid")%>'>
            
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=22><b>�ֶ����ƣ�</b> </td>
<td width="48%"> 
<div align="center"><b>����ֵ��</b></div>
</td>
</tr>
<tr> 
<td width="52%">��̳��ţ�ע�ⲻ�ܺͱ����̳�����ͬ��</td>
<td width="48%"> 
<input type="text" name="newboardid" size="3"  value = '<%=rs("boardid")%>'>
</td>
</tr>
<tr> 
<td width="52%">��̳��</td>
<td width="48%"> 
<input type="text" name="boardtype" size="24"  value = '<%=rs("boardtype")%>'>
</td>
</tr>
<tr> 
<td width="52%">�������</td>
<td width="48%"> 
<select name=class>
<% do while not rs_c.EOF%>
<option value=<%=rs_c("id")%> <% if rs("class") = rs_c("id") then%> selected <%end if%>><%=rs_c("class")%> 
<%
rs_c.MoveNext 
loop
rs_c.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%">����˵��</td>
<td width="48%"> 
<input type="text" name="readme" size="24" value='<%=rs("readme")%>'>
</td>
</tr>
<tr> 
<td width="52%">����(������������|�ָ����磺ɳ̲С��|wodeail)��</td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24"  value='<%=rs("boardmaster")%>'>
</td>
</tr>
<tr> 
<td width="52%">��������(0���ţ�1������2�ض��û�����)</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" <%if rs("lockboard")=0 then%>selected<%end if%>>0 
<option value="1" <%if rs("lockboard")=1 then%>selected<%end if%>>1 
<option value="2" <%if rs("lockboard")=2 then%>selected<%end if%>>2 
</select>
</td>
</tr>
<tr> 
<td width="52%">������߿���ɫ</td>
<td width="48%"> 
<input type="text" name="Tableback" size="24"  value='<%=rs("Tableback")%>'>
</td>
</tr>
<tr> 
<td width="52%">�����������ɫ</td>
<td width="48%"> 
<input type="text" name="Tabletitle" size="24"  value='<%=rs("Tabletitle")%>'>
</td>
</tr>
<tr> 
<td width="52%">�������ݱ����ɫ1</td>
<td width="48%"> 
<input type="text" name="Tablebody" size="24"  value='<%=rs("Tablebody")%>'>
</td>
</tr>
<tr > 
<td width="52%">�������ݱ����ɫ2����ɫ1����ɫ2��bbs����л��ഩ������</td>
<td width="48%"> 
<input type="text" name="aTablebody" size="24"  value='<%=rs("aTablebody")%>'>
</td>
</tr>
<tr> 
<td width="52%">���������������ɫ</td>
<td width="48%"> 
<input type="text" name="TableFont" size="24"  value='<%=rs("Tablefont")%>'>
</td>
</tr>
<tr> 
<td width="52%">�������ݱ��������ɫ</td>
<td width="48%"> 
<input type="text" name="TableContent" size="24"  value='<%=rs("TableContent")%>'>
</td>
</tr>
<tr> 
<td width="52%">���������ɫ</td>
<td width="48%"> 
<input type="text" name="AlertFont" size="24"  value='<%=rs("AlertFont")%>'>
</td>
</tr>
<tr> 
<td width="52%">��̳Logo��ַ</td>
<td width="48%"> 
<input type="text" name="Logo" size="35" value="<%=rs("forumLogo")%>">
</td>
</tr>
<tr> 
<td width="52%">��ҳ��ʾ��̳ͼƬ</td>
<td width="48%">
<input type="text" name="indexIMG" size="35" value="<%=rs("indexIMG")%>">
</td>
</tr>
<tr> 
<td width="52%">UBB��ǩ</td>
<td width="48%"> 
<select name="strAllowForumCode">
<option value="0" <%if rs("strallowForumCode")=0 then%>selected<%end if%>>��ʹ�� 
<option value="1" <%if rs("strallowForumCode")=1 then%>selected<%end if%>>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">HTML��ǩ</td>
<td width="48%"> 
<select name="strAllowHTML">
<option value="0" <%if rs("strallowHTML")=0 then%>selected<%end if%>>��ʹ�� 
<option value="1" <%if rs("strallowHTML")=1 then%>selected<%end if%>>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">��ͼ��ǩ</td>
<td width="48%"> 
<select name="strIMGInPosts">
<option value="0" <%if rs("strIMGInPosts")=0 then%>selected<%end if%>>��ʹ�� 
<option value="1" <%if rs("strIMGInPosts")=1 then%>selected<%end if%>>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">Flash��ǩ</td>
<td width="48%"> 
<select name="strflash">
<option value="0" <%if rs("strflash")=0 then%>selected<%end if%>>��ʹ�� 
<option value="1" <%if rs("strflash")=1 then%>selected<%end if%>>ʹ�� 
</select>
</td>
</tr>
<tr> 
<td width="52%">�����ǩ</td>
<td width="48%"> 
<select name="strIcons">
<option value="0" <%if rs("strIcons")=0 then%>selected<%end if%>>��ʹ�� 
<option value="1" <%if rs("strIcons")=1 then%>selected<%end if%>>ʹ�� 
</select>
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%">&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="�ύ">
</td>
</tr>
</table>
</form>
<%
rs.close
end sub

sub boardinfo()
	    set rs_1 = server.CreateObject ("adodb.recordset")
            set rs_2 = server.CreateObject ("adodb.recordset")
            sql_2 = "select * from class order by id"
            rs_2.Open sql_2,conn,1,1
	    do while not rs_2.Eof
%>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>">

                <td height="21"><%=rs_2("id")%>,��������<b><%=rs_2("class")%></b>    <a href="admin_board.asp?action=add">������̳</a> | <a href=admin_board.asp?action=orders&id=<%=rs_2("id")%>>���������޸�</a> | <a href=admin_board.asp?action=del1&id=<%=rs_2("id")%>>ɾ������</a></td>
              </tr>
            </table>
<%
            sql_1 = "select boardid,boardtype,readme from board where class="&rs_2("id")&" order by boardid"
            rs_1.Open sql_1,conn,1,1
            do while not rs_1.EOF 
            %>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td height="18"><%=rs_1("boardid")%>,��̳����<%=rs_1("boardtype")%></td>
              </tr>
              <tr>
                <td height="18">��̳��飺<%=rs_1("readme")%></td>
              </tr>
              <tr>
                <td height="15"><a href="admin_board.asp?action=edit&editid=<%=rs_1("boardid")%>">�༭����̳</a> | <a href="admin_board.asp?action=del&boardid=<%=rs_1("boardid")%>">ɾ������̳</a></td>
              </tr>
            </table>
<hr color=black height=1 width="70%" align=left>
<%
		  rs_1.MoveNext
		  loop
                  rs_1.Close 
        rs_2.MoveNext 
        Loop
        rs_2.Close
%>
          </td>
            </tr>
        </table>      
        </td>
       </tr>
</table>
<%
end sub

sub savenew()
	set rs = server.CreateObject ("adodb.recordset")
	if request("boardtype")="" then
		Errmsg=Errmsg+"<br>"+"<li>��������̳���ơ�"
		Founderr=true
	end if
	if request("class")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ѡ����̳���ࡣ"
		Founderr=true
	end if
	if request("boardmaster")="" then
		Errmsg=Errmsg+"<br>"+"<li>��������ʦ������"
		Founderr=true
	end if
	if request("readme")="" then
		Errmsg=Errmsg+"<br>"+"<li>��������̳˵����"
		Founderr=true
	end if
	if request("lockboard")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ѡ����̳����״̬��"
		Founderr=true
	end if
	if founderr=true then
	response.write ""&Errmsg&""
	else
		dim boardid
		sql="select boardid from board where boardid="+cstr(request("boardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "������ָ���ͱ����̳һ������š�"
			exit sub
		else
			boardid=request("boardid")
		end if
		rs.close
	sql = "select * from board"
	rs.Open sql,conn,1,3
	rs.AddNew
	rs("boardid") = Request("boardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Request("lockboard")
	rs("Tableback") = Request("Tableback")
	rs("Tabletitle") = Request("Tabletitle")
	rs("Tablebody") = Request("Tablebody")
	rs("aTablebody") = Request("aTablebody")
	rs("TableFont") = Request("TableFont")
	rs("TableContent") = Request("TableContent")
	rs("AlertFont") = Request("AlertFont")
	rs("Forumlogo") = Request("Logo")
	rs("indexIMG")=request.form("indexIMG")
	rs("strAllowForumCode") = Request("strAllowForumCode")
	rs("strAllowHTML") = Request("strAllowHTML")
	rs("strIMGInPosts") = Request("strIMGInPosts")
	rs("strIcons") = Request("strIcons")
	rs("strflash") = Request("strflash")
	rs("lastpostuser") ="δ֪"
	rs("lastposttime") = now()
	rs("lasttopicnum") = 0 
	rs("lastbbsnum") = 0 
	rs("lasttopicnum") = 0 
	rs.Update 
	rs.Close 
	call addmaster(Request("boardmaster"))
	response.write "<p>��̳��ӳɹ���<br><br>"&str
	end if
end sub

sub savedit()
	dim newboardid
	set rs = server.CreateObject ("adodb.recordset")
	if request("newboardid")=request("editid") then
		newboardid=request("newboardid")
	else
		sql="select boardid from board where boardid="+cstr(request("newboardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "������ָ���ͱ����̳һ������š�"
			exit sub
		else
			newboardid=request("newboardid")
		end if
		rs.close
	end if
	sql = "select * from board where boardid="+Cstr(request("editid"))
	rs.Open sql,conn,1,3
	rs("boardid") = Request.Form ("newboardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Trim(Request("lockboard"))
	rs("Tableback") = Request("Tableback")
	rs("Tabletitle") = Request("Tabletitle")
	rs("Tablebody") = Request("Tablebody")
	rs("aTablebody") = Request("aTablebody")
	rs("TableFont") = Request("TableFont")
	rs("TableContent") = Request("TableContent")
	rs("AlertFont") = Request("AlertFont")
	rs("Forumlogo") = Request("Logo")
	rs("indexIMG")=request.form("indexIMG")
	rs("strAllowForumCode") = Request("strAllowForumCode")
	rs("strAllowHTML") = Request("strAllowHTML")
	rs("strIMGInPosts") = Request("strIMGInPosts")
	rs("strIcons") = Request("strIcons")
	rs("strflash") = Request("strflash")
	rs.Update 
	if request("newboardid")<>request("editid") then
	conn.execute("update bbs1 set boardid="&Request.Form ("newboardid")&" where boardid="+Cstr(request("editid")))
	end if
	rs.Close
	call addmaster(Request("boardmaster"))
	response.write "<p>��̳�޸ĳɹ���<br><br>"&str
	sql="update bbs1 set boardid="&newboardid&" where boardid="+Cstr(request("editid"))
	conn.execute(sql)
end sub

sub del()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from board where boardid="+Cstr(Request("boardid"))
	conn.execute(sql)
	sql = "delete from bbs1 where boardid="+cstr(Request("boardid"))
	conn.execute(sql)
	response.write "<p>��̳�޸ĳɹ���"
end sub

sub del1()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from class where id="+Cstr(Request("id"))
	conn.execute(sql)
	sql = "delete from board where class="+Cstr(Request("id"))
	conn.execute(sql)
	sql="select boardid from board where class="+Cstr(Request("id"))
	rs.open sql,conn,1,1
	do while not rs.eof
	sql_1 = "delete from bbs1 where boardid="+cstr(rs("boardid"))
	conn.execute(sql_1)
	rs.movenext
	loop
	rs.close
	response.write "<p>����ɾ���ɹ���"
end sub

sub orders()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><b>��̳�������������޸�</b><br>
ע�⣺������Ӧ��̳������������������Ӧ��������ţ�ע�ⲻ�ܺͱ����̳��������ͬ��������š�
		</td>
              </tr>
	      <tr>
		<td>
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "û���ҵ���Ӧ����̳���ࡣ"
	else
		response.write "<form action=admin_board.asp?action=updateorders method=post>"
		response.write "<input type=text name=classname size=25 value="&rs("class")&">"
		response.write "  <input type=text name=newid size=2 value="&rs("id")&">"
		response.write "<input type=hidden name=id value="&request("id")&">"
		response.write "<input type=submit name=Submit value=�޸�></form>"
	end if
	rs.close
%>
		</td>
	      </tr>
            </table>
<%
end sub

sub updateorders()
	dim newid
	set rs = server.CreateObject ("Adodb.recordset")
	if request("newid")=request("id") then
		sql="update class set class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	else
	sql="select * from class where id="&cstr(request("newid"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "���������ź��������������ͬ�����������롣"
	else
		sql="update class set id="&request("newid")&",class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		sql="update board set class="&request("newid")&" where class="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	end if
	end if
end sub

sub addclass()
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select id from class"
	rs.open sql,conn,1,1
	classnum=rs.recordcount
	rs.close
%>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22" bgcolor=<%=aTableTitleColor%>><b>����µ���̳����</b><br>
ע�⣺��������д���±���Ϣ��ע�ⲻ�ܺͱ����̳��������ͬ��������š�
		</td>
              </tr>
<form action=admin_board.asp?action=saveclass method=post>
	      <tr>
		<td>��������<input name=classname type=text size=25>  ��ţ�
<input name=id type=text size=2 value=<%=classnum+1%>>   
<input type=submit name=Submit value=���>
		</td>
	      </tr>
</form>
	    </table>
<%
end sub

sub saveclass()
	set rs = server.CreateObject ("Adodb.recordset")
	if request("id")="" or request("classname")="" then
		response.write "���������ź�ԭ������ͬ�����ظ���������"
	else
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "���������ź��������������ͬ�����������롣"
	else
		sql="insert into class(id,class) values("&request("id")&",'"&request("classname")&"')"
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	end if
	end if
end sub

sub delclass()

end sub

sub addmaster(s)
	dim arr,i,rs,sql,pw
	randomize
	pw=Cint(rnd*9000)+1000
	if instr(s,"|")<>0 and instr(s,"|")<len(s) then
		arr=split(s,"|")
		set rs=server.createobject("adodb.recordset")
		for i=0 to Ubound(arr)
			sql="select username,userpassword,userclass from [user] where username='"& arr(i) &"'"
			rs.open sql,conn,1,3
			if rs.eof and rs.bof then
				rs.addnew
				rs("username")=arr(i)
				rs("userpassword")=pw
				rs("userclass")=19
				rs.update
				str=str&"������������û���<b>" &arr(i) &"</b> ���룺<b>"& pw &"</b><br><br>"
			end if
			rs.close
		next
		set rs=nothing
	else
		set rs=server.createobject("adodb.recordset")
		sql="select username,userpassword,userclass from [user] where username='"& s &"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
			rs.addnew
			rs("username")=s
			rs("userpassword")=pw
			rs("userclass")=19
			rs.update
			rs.close
			str=str&"������������û���<b>" &s &"</b> ���룺<b>"& pw &"</b><br><br>"
		end if
		set rs=nothing
	end if
end sub
%>