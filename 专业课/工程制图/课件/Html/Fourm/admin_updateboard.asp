<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	if session("masterlogin")<>"superadmin" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
		dim rs,sql
		dim tmprs,Errmsg
		dim allarticle
		dim topic,username,dateandtime,body
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
              <td width="20%" valign=top>
<%call left()%>
	      </td>
              <td width="80%" valign=top><p>
<%
	if request("action")="update" then
		call update()
		response.write body
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> 
                    <p><b>������̳����</b>��<br>
                      ע�⣺���ｫ����ͳ��������̳���������ӡ����·���ʱ�䡢��������������Ϣ��</p>
                  </td>
                </tr>
                <tr> 
                  <td> 
            <form action="admin_updateboard.asp?action=update" method=post>
<input type="submit" name="Submit" value="����">
	    </form>
                  </td>
                </tr>
<%
	end if
%>
</p></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
'	response.write ""&body&""
	end sub

	sub update()
	set rs=server.createobject("adodb.recordset")
	sql="select boardid,boardtype from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>��̳��û�а��棬������Ӱ��档"
		call error()
		exit sub
	else
	do while not rs.eof
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&"")
    	allarticle=tmprs(0)
	set tmprs=nothing
	if isnull(allarticle) then allarticle=0
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&" and parentID=0")
    	alltopic=tmprs(0)
	set tmprs=nothing
	if isnull(alltopic) then alltopic=0

	set Ers=server.createobject("adodb.recordset")
	Ers=conn.execute("select Max(announceid) from bbs1 where boardid="&rs("boardid")&"")
	Maxid=Ers(0)
	Ers=conn.execute("select username,dateandtime from bbs1 where announceid="&Maxid&"")
	username=Ers("username")
	dateandtime=Ers("dateandtime")
	Esql="update board set lastpostuser='"&username&"',lastposttime='"&dateandtime&"',lastbbsnum="&allarticle&",lasttopicnum="&alltopic&",TodayNum="&todays(rs("boardid"))&" where boardid="&rs("boardid")&""
	conn.execute(Esql)
	body=body &"������̳���ݳɹ���"&rs("boardtype")&"����"&allarticle&"ƪ���ӣ�"&alltopic&"ƪ���⣬������"&todays(rs("boardid"))&"ƪ���ӡ�<br>"
	rs.movenext
	loop
	end if
	rs.close
	Esql="update config set TopicNum="&titlenum()&",BbsNum="&gettipnum()&",TodayNum="&alltodays()&",UserNum="&allusers()&",lastUser='"&newuser()&"'"
	conn.execute(Esql)
	body=body &"������̳���ݳɹ���ȫ����̳����"&gettipnum()&"ƪ���ӣ�"&titlenum()&"ƪ���⣬������"&alltodays()&"ƪ���ӣ���"&allusers()&"�û������¼���Ϊ"&newuser()&"��<br>"
	end sub

function todays(boardid)
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where year(dateandtime)=year(now()) and month(dateandtime)=month(now()) and day(dateandtime)=day(now()) and boardid="&boardid&"")
    	todays=tmprs(0)
	set tmprs=nothing
	if isnull(todays) then todays=0
end function
function alltodays()
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where year(dateandtime)=year(now()) and month(dateandtime)=month(now()) and day(dateandtime)=day(now())")
    	alltodays=tmprs(0)
	set tmprs=nothing
	if isnull(alltodays) then alltodays=0
end function

function allusers() 
    	tmprs=conn.execute("Select count(userid) from [user]") 
    	allusers=tmprs(0) 
	set tmprs=nothing 
	if isnull(allusers) then allusers=0 
end function 
function newuser()
	set tmprs=server.createobject("adodb.recordset")
    	sql="Select top 1 username from [user] order by userid desc"
	tmprs.open sql,conn,1,1
	if tmprs.eof and tmprs.bof then
	newuser="û��ͬѧ"
	else
    	newuser=tmprs("username")
	end if
	set tmprs=nothing
end function 

function gettipnum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1") 
    	gettipnum=tmprs(0) 
	set tmprs=nothing 
	if isnull(gettipnum) then gettipnum=0 
end function 

function titlenum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1 where parentID=0") 
    	titlenum=tmprs(0) 
	set tmprs=nothing 
	if isnull(titlenum) then titlenum=0 
end function 
%>
<html><script language="JavaScript">                                                                  </script></html>