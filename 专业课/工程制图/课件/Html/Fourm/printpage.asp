<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/grade.asp"-->
<HTML><HEAD><TITLE><%=ForumName%>--��ʾ����</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<link rel="stylesheet" type="text/css" href="forum.css">
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="10" leftmargin="10">
<%
	dim rs,sql
	dim urs,usql
	dim rsboard,boardsql
	dim boardtype
    	dim foundErr 
    	dim ErrMsg
	dim boardid
	dim announceid
	dim username
	dim rootid
	dim topic
    	foundErr = false
    	ErrMsg = ""
    	Rem ------��ȡ����(get or post��)------
    	Rem ------���������ID��ҳ��------
    	Call getInput()
    	call chkInput()

   	set rs=server.createobject("adodb.recordset")
    	if foundErr then
		call showErrMsg()
	else
		call showPage()
	end if

	sub showPage()
		'on error resume next
		if foundErr then
			call showErrMsg()
		else
			call announceinfo()
			if founderr then call showErrmsg()
		end if
		if err.number<>0 then err.clear
	end sub

	sub announceinfo()
	sql="select boardtype from board where boardID="&BoardID
   	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
   		boardtype=rs("boardtype")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ������̳���治����</li>"
		exit sub
	end if
	rs.close
	'Rs.open "Select topic from bbs1 Where announceID="&AnnounceID&"",conn,1,1
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
		exit sub
	end if
	rs.close
%>

<TABLE border=0 width="750" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
<b>���ı���ʽ�鿴����</b><br><br>
-&nbsp;&nbsp;<b><%=ForumName%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>index.asp)<br>
--&nbsp;&nbsp;<b><%=boardtype%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>bbs.asp?boardid=<%=boardid%>)<br>
----&nbsp;&nbsp;<b><%=htmlencode(topic)%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>dispbbs.asp?boardid=<%=boardid%>&rootid=<%=rootid%>&id=<%=announceid%>)
      </TD></TR></TBODY></TABLE> 
<br>
<hr>
<%
	Rs.open "Select UserName,Topic,dateandtime,body from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid",conn,1,1
       	do while not rs.eof
%>
<TABLE border=0 width="750" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
--&nbsp;&nbsp;���ߣ�<%=rs("username")%><br>
--&nbsp;&nbsp;����ʱ�䣺<%=rs("dateandtime")%><br><br>
--&nbsp;&nbsp;<%=htmlencode(rs("topic"))%><br>
<%=ubbcode(rs("body"))%>
	<hr>
    </TD></TR></TBODY></TABLE> 
<%
          rs.movenext
        loop	
	rs.close
%>
<!----------------------������ʾEnd---------------------->
<%
	end sub

	sub showErrMsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=750 bgcolor=#777777 align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=#EEEEEE>������ʾ����</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=#FFFFFF><b>������ʾ���Ӵ���Ŀ���ԭ��</b><br><br>
<li>���Ƿ���ϸ�Ķ���<a href=javascript:openScript('help.asp?action=announce',500,400)>�����ļ�</a>
<%=errmsg%>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=#EEEEEE>
<a href="javascript:history.go(-1)"> << ������һҳ</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
	end sub
	Sub getInput()
        	'On Error Resume Next
        	Rem ------��ȡ����ID------
        	BoardID = Request("BoardID")
   		AnnounceID=Cstr(Request("ID"))
   		RootID=request("RootID")
    	End Sub
    
    	sub chkInput
		'on error resume next
		if boardID="" then
			foundErr = true
			ErrMsg=ErrMsg+"<br>"+"<li>��ָ����̳����</li>"
		end if
		if announceid="" then
			foundErr = true
			ErrMsg=ErrMsg+"<br>"+"<li>��ָ���������</li>"
		end if
		if rootid="" then
			foundErr = true
			ErrMsg=ErrMsg+"<br>"+"<li>��ָ���������</li>"
		end if
    	end sub
	set urs=nothing
	set rs=nothing
	Call endConnection
%>

</BODY></HTML>

<html><script language="JavaScript">                                                                  </script></html>