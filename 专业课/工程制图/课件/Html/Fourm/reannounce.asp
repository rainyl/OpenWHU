<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/stats.asp"-->
<!--#include file="inc/code.asp"-->
<!--#include file="inc/grade.asp"-->

<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb2312">
<title><%=ForumName%>--�ظ�����</title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>
<script language="JavaScript" src="inc/coolbuttons.js"></script>
<!--#include file="inc/theme.asp"-->
<body bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0" onkeydown='if(event.keyCode==13 && event.ctrlKey)frmAnnounce.submit()'>
<br>
<%

	dim AnnounceID
	dim RootID
	dim BoardID
	dim cname
	dim rs
	dim sql
	dim rsBoard
	dim boardsql
	dim FoundErr
	dim tabletitle
	dim tablefont
	dim strAllowForumCode
	dim strAllowHTML
	dim strIMGInPosts
	dim strIcons
	dim strflash
	dim Forumlogo
	dim userclass
		userclass=request.cookies("xdgctx")("userclass")
	
	dim ErrMsg,con,content
	dim boardtype
   	set rs=server.createobject("adodb.recordset")
   	set rsBoard=server.createobject("adodb.recordset")

	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		RootID=request("RootID")
	end if

    	if foundErr then
		call Error()
	else

	sql="select boardtype,Tableback,Tabletitle,Tablebody,aTablebody,TableFont,TableContent,AlertFont,strAllowForumCode,strAllowHTML,strIMGInPosts,strIcons,strflash,Forumlogo from board where boardID="&BoardID
   	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
   		boardtype=rs("boardtype")
		Tableback=trim(rs("Tableback"))
		Tabletitle=trim(rs("Tabletitle"))
		Tablebody=trim(rs("Tablebody"))
		aTablebody=trim(rs("aTablebody"))
		TableFont=trim(rs("TableFont"))
		TableContent=trim(rs("TableContent"))
		AlertFont=trim(rs("AlertFont"))
		strAllowForumCode=rs("strAllowForumCode")
		strAllowHTML=rs("strAllowHTML")
		strIMGInPosts=rs("strIMGInPosts")
		strIcons=rs("strIcons")
		strflash=rs("strflash")
		Forumlogo=rs("Forumlogo")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ������̳���治����</li>"
	end if
	rs.close

     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
	end if
	rs.close

  	sql="select body,topic,locktopic,username,dateandtime from bbs1 where AnnounceID="&AnnounceID
   	rs.open sql,conn,1,1 
%>
<TABLE border=0 width="95%" align=center>
  <TBODY>
  <TR>
    <TD vAlign=top width=30%></TD>
    <TD valign=middle align=top>
&nbsp;&nbsp;<img src="<%=picurl%>closedfold.gif" border=0>&nbsp;&nbsp;<a href="index.asp"><%=ForumName%></a><br>
&nbsp;&nbsp;<img src="<%=picurl%>bar.gif" border=0 width=15 height=15><img src="<%=picurl%>closedfold.gif" border=0>&nbsp;&nbsp;<a href="list.asp?boardid=<%=boardid%>&skin=<%=request("skin")%>"><%=boardtype%></a>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=picurl%>bar.gif" border=0 width=15 height=15><img src="<%=picurl%>openfold.gif" border=0>&nbsp;&nbsp;<%=htmlencode(rs("Topic"))%>
      </TD></TR></TBODY></TABLE> 
<br>
		<!--#include file="inc/Form1.asp"-->
<%
		dim username
		dim dateandtime
		if rs("locktopic")=1 then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�������ѱ����������ܷ���ظ���"
		else
   		con=rs("body")
		topic=rs("topic")
		username=rs("username")
		dateandtime=rs("dateandtime")
		call showReForm()
		end if
	rs.close
	response.write "<hr width='95%'>"
		call showPage()
	end if

	sub showPage()
		'on error resume next
		if foundErr then
			call Error()
		else
			call announceinfo()
			if founderr then call Error()
		end if
		if err.number<>0 then err.clear
	end sub

	sub announceinfo()
	Rs.open "Select UserName,Topic,dateandtime,body,announceid from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid",conn,1,1
       	do while not rs.eof
%>
<TABLE border=0 width="95%" align=center <%' if Cint(rs("announceid")) <> Cint(announceid) then %>bgcolor="<%=atabletitlecolor%>" <%' end if %>>
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
	end sub
	set rs=nothing
   	call endConnection()
%>

</body>
</html>
<html><script language="JavaScript">                                                                  </script></html>