<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/stats.asp"-->
<!--#include file="inc/grade.asp"-->
<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312">
<link rel="stylesheet" type="text/css" href="forum.css">
<title><%=ForumName%>--����</title>
</head>
<!--#include file="inc/theme.asp"-->
<body bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0">
<br>
<TABLE border=0 width="95%" align=center>
  <TBODY>
  <TR>
    <TD vAlign=top width=30%></TD>
    <TD valign=middle align=top>
&nbsp;&nbsp;<img src="<%=picurl%>closedfold.gif" border=0>&nbsp;&nbsp;<a href="index.asp"><%=ForumName%></a><br>
&nbsp;&nbsp;<img src="<%=picurl%>bar.gif" border=0 width=15 height=15><img src="<%=picurl%>openfold.gif" border=0>&nbsp;&nbsp;��̳����</a>
      </TD></TR></TBODY></TABLE> 
<br>
<%
   	dim sql,rs
   	dim sel
   	dim boardid
   	dim username
	dim guestlist
	if memberclass = user_level18 or memberclass = user_level19 or memberclass = user_level20 then
		guestlist=""
	else
		guestlist=" where lockboard<>2"
	end if

   boardid=1
   if not (isNUll(request("boardid")) or isEmpty(request("boardid")) or (request("BoardID")="") ) then
      boardid=request("boardid")
   end if

   set rs=server.createobject("adodb.recordset")
   sql="select * from board "&guestlist&""
   rs.open sql,conn,1,1
%>
<table cellpadding=0 cellspacing=0 border=0 width=500 bgcolor=<%=aTablebackcolor%> align=center>
    <tr>    
        <td>
<table cellpadding=6 cellspacing=1 border=0 width=100%>
  <TBODY>
  <TR align=middle bgColor=<%=aTabletitlecolor%>>
    <TD colSpan=2 height=23><b>��̳����</b></TD></TR>
<form name="queryTopic" method="POST" action="queryResult.asp?type=1">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32>�����⣺</TD>
    <TD height=32>
<input type="text" name="txtTopic" size="13"> ���棺<select class="smallSel" name="selBoard" size="1">
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
                             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
		             rs.movenext
		      loop
			  %>        
          </select>  <input type="submit" value="�� ѯ" name="cmdTopic">
    </TD></TR>
</form>
<form name="queryUser" method="POST" action="queryResult.asp?type=2">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32>�����ˣ�</TD>
    <TD height=32>
<input type="text" name="txtUser" size="13"> ���棺<select name="selBoard" size="1">
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
		             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
		             rs.movenext
    		          loop

			  %>        
          </select>  <input type="submit" value="�� ѯ" name="cmdTopic">
    </TD></TR>
</form>
<form name="queryUser" method="POST" action="queryResult.asp?type=3">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32>�ڡ��ݣ�</TD>
    <TD height=32>
<input type="text" name="txtCon" size="13"> ���棺<select name="selBoard" size="1">
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
		             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
		             rs.movenext
    		          loop
			  %>        
</select>
<input type="submit" value="�� ѯ">
    </TD></TR>
</form>
<form name="queryUser" method="POST" action="queryResult.asp?type=4">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32><b> I&nbsp;D��</b></TD>
    <TD height=32>
<select name="selCompare" size="1">
 <option selected value="=">=</option>
 <option value=">">></option>
 <option value=">=">>=</option>
 <option value="<"><</option>
 <option value="<="><=</option>
 </select>
<input type="text" name="aid" size="6">
���棺<select name="selBoard" size="1">
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
		             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
		             rs.movenext
    		          loop

			  %>        
</select>
<input type="submit" value="�� ѯ">
    </TD></TR>
</form>
<form name="queryUser" method="POST" action="queryResult.asp?type=5">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32>�¡�����</TD>
    <TD height=32>
<select  name="selTimeLimit" size="1">    <option value="һ��">һ����&nbsp;</option>    <option value="һ��">һ����</option>    <option value="һ��">һ����</option>    <option value="һ��">һ����</option>  </select>&nbsp;&nbsp;&nbsp; ���棺<select class="smallSel" name="selBoard" size="1">		  	  
		  	  <%
			  rs.movefirst
			  do while not rs.eof
                             if boardid=cstr(rs("boardid")) then
                                sel="selected"
                             else
                                sel=""
                             end if		    
		             response.write "<option " & sel & " value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
		             rs.movenext
    		          loop
			rs.close
			set rs=nothing
			call endConnection()
			  %>        
</select>
<input type="submit" value="�� ѯ">
    </TD></TR>
</form>
<form name="queryUser" method="POST" action="queryResult.asp?type=6">
  <TR bgColor=<%=Tablebodycolor%>>
    <TD width=150 height=32>������ѯ��</TD>
    <TD height=32>
<select name="selCompare" size="1">
          <option value="2">��ѯ���µ�50������</option><option value="1">��ѯ�����Ϊǰ10λ������</option></select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="�� ѯ" name="cmdTopic">
    </td>
  </TR>
  <TR align=middle bgColor=<%=aTabletitlecolor%>>
    <TD colSpan=2 height=23><b>��̳��������֧��<a href=help.asp>������ģ����ѯ</a></b></TD></TR>
</TBODY></TABLE>
    </td>
  </TR>
</TBODY></TABLE>

</body>
</html>
<html><script language="JavaScript">                                                                  </script></html>