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
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/grade.asp" -->
<!-- #include file="admin_left.asp" -->
<%
		dim rs,sql
		dim topic,username,dateandtime,body
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
		response.write ""&body&""
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> 
                    <p><b>�����û�����</b>��<br>
                      ע�⣺���ｫ����ͳ�������û��ȼ���Ϣ�����º������û����ݽ������趨�������������еȼ���</p>
                  </td>
                </tr>
                <tr> 
                  <td> 
            <form action="admin_updateuser.asp?action=update" method=post>
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
	on error resume next
	conn.execute("update [user] set userclass='18' where userclass='���'")
	conn.execute("update [user] set userclass='19' where userclass='��ʦ'")
	conn.execute("update [user] set userclass='20' where userclass='����ʦ'")
	conn.execute("update [user] set userclass='20' where userclass='����Ա'")
	'conn.execute("update [user] set userclass=1 where article<0")
	'conn.execute("update [user] set userclass=1 where (article>="&point(1)&" and article<"&point(2)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=2 where (article>="&point(2)&" and article<"&point(3)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=3 where (article>="&point(3)&" and article<"&point(4)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=4 where (article>="&point(4)&" and article<"&point(5)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=5 where (article>="&point(5)&" and article<"&point(6)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=6 where (article>="&point(6)&" and article<"&point(7)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=7 where (article>="&point(7)&" and article<"&point(8)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=8 where (article>="&point(8)&" and article<"&point(9)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=9 where (article>="&point(9)&" and article<"&point(10)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=10 where (article>="&point(10)&" and article<"&point(11)&") and not (userclass=18 or userclass=19 or  userclass=20)")	
	'conn.execute("update [user] set userclass=11 where (article>="&point(11)&" and article<"&point(12)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=12 where (article>="&point(12)&" and article<"&point(13)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=13 where (article>="&level13_point&" and article<"&point(14)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=14 where (article>="&point(14)&" and article<"&point(15)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=15 where (article>="&point(15)&" and article<"&point(16)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=16 where (article>="&point(16)&" and article<"&point(17)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=17 where article>="&point(17)&" and not (userclass=18 or userclass=19 or  userclass=20)")
	'conn.execute("update [user] set userclass=1 where userclass>'20'")
	body=body+"<br>"+"�����û����ݳɹ�("&now()&")��"
	end sub
%>