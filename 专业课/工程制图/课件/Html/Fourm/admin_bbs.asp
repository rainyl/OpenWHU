<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<HTML><HEAD><TITLE><%=ForumName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<link rel="stylesheet" type="text/css" href="forum.css">
<script language="javascript">
     function viewPage2(ipage){
        document.frmList2.Page.value=ipage
        document.frmList2.submit()        
     }
</script>
<script language="javascript">
     function viewPage1(ipage){
        document.frmList2.Page.value=ipage
        document.frmList2.submit()        
     }
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0">
<br>
<%
	if session("masterlogin")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
%>
      <table cellpadding=3 cellspacing=1 border=0 width=95% align=center>
        <tr bgcolor='<%=aTabletitlecolor%>'>
        <td align=center height=22>��ӭ<b>
<%=session("mastername")%></b>�������ҳ��
        </td>
        </tr>
        <tr>
        <td height=22><b>ע��</b>������������ʦ���ԶԸ��Եİ������ӽ������������������ɾ����ת�����ӡ�����ɾ���Ȳ������������Ӳ��ܻظ���<font color=<%=alertfontcolor%>>ɾ�����Ӳ��ָܻ�</font>������ʦ����ʹ�ù����ܡ�
        </td>
        </tr>
        <tr>
        <td height=22><a href=admin_main.asp>����������ҳ��</a>
        </td>
        </tr>
      </table>
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	dim CurrentPage
   	dim sql,rs
    	dim foundErr 
    	dim ErrMsg
    	dim bBoardEmpty
	dim boardid
	dim Ers,Esql    
	dim tableback
	dim tabletitle
	dim tablebody
	dim atablebody
	dim tablefont
	dim tablecontent
	dim alertfont
	dim totalrec
	dim n ,RowCount
	dim p
    	dim announceIDRange1
    	dim announceIDRange2
    	foundErr = false
    	ErrMsg = ""
    	selStr = "()"

    	Rem ------��ȡ����(get or post��)------
    	Rem ------���������ID��ҳ��------
    	Call getInput()
    	call chkInput()
	set rs=server.createobject("adodb.recordset")
	'��ʾ��ͷ
    	if foundErr then
		call Error()
	else
		call showPage()
	end if

	sub showPage()
		'on error resume next
		if foundErr then
			call Error()
		else
			if request("action")="del" then call del()
			if bBoardEmpty <> true then
				if foundErr = true then
					call Error()
				else
					if session("masterlogin")="superadmin" then call boardlist()
					call AnnounceList()
					call listPages2()
				end if
			end if
		end if
		if err.number<>0 then err.clear
	end sub

	REM ��ʾ�����б�	
	sub showPageList()
	i=0
%>
<span id=forum>
<TABLE bgColor="<%=Tableback%>" border=0 cellPadding=4 cellSpacing=1 width="95%" align=center>
  <TBODY>
  <TR bgColor="<%=Tabletitle%>">
    <TD align=middle noWrap height=25><font color=<%=TableFont%>>״̬</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�� ��  (�������Ϊ���´����)</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�� �� </font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�ظ�/����</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>����Ա����</font></TD></TR> 
<%
       do while not rs.eof
%>
  <TR> 
    <TD align=middle bgColor="<%=Tablebody%>"><font color=<%=TableContent%>>
<%if rs("lockboard")=1 then%><img src=<%=picurl%>lockfolder.gif alt="����̳������"><%else%><%if rs("locktopic")=1 then%><img src=<%=picurl%>lockfolder.gif alt="������������"><%else%><%if rs("child")>=10 then%><img src=<%=picurl%>hotfolder.gif><%else%><img src=<%=picurl%>folder.gif><%end if%><%end if%><%end if%></font>
    </TD> 
    <TD bgColor=<%=Tablebody%> width="100%"><font color=<%=TableContent%>><a href='dispbbs.asp?boardID=<%=boardID%>&RootID=<%=rs("RootID")%>&ID=<%=rs("announceID")%>' target=_blank><img src='images/<%=rs("Expression")%>' border=0 alt="���´������������"></a> <a href='dispbbs.asp?boardID=<%=boardID%>&RootID=<%=rs("RootID")%>&ID=<%=rs("announceID")%>'><%=htmlencode(rs("topic"))%></a>
<%if rs("child")>Maxtitlelist then%>
&nbsp;&nbsp;[��ҳ��
<%
Pnum=Cint(rs("child")/Maxtitlelist)+1
for p=1 to Pnum
response.write " <a href='dispbbs.asp?boardID="&boardID&"&RootID="&rs("RootID")&"&ID="&rs("announceID")&"&star="&P&"'><b>"&p&"</b></a> "
next
%>
]
<%end if%></font>
    </TD> 
    <TD align=middle bgColor="<%=aTablebody%>" noWrap><font color=<%=TableContent%>><a href=javascript:openScript('dispuser.asp?name=<%=htmlencode(rs("username"))%>',350,300)><%=htmlencode(rs("username"))%></a></font></TD> 
    <TD align=middle bgColor="<%=Tablebody%>"><font color=<%=TableContent%>><%=rs("child")%>/<%=rs("hits")%></font></TD> 
    <TD bgColor=<%=aTablebody%> noWrap><font color=<%=TableContent%>>
<a href=admin_postings.asp?action=lock&boardID=<%=boardID%>&ID=<%=rs("announceID")%>&rootid=<%=rs("rootID")%>>����</a> | <a href=admin_postings.asp?action=unlock&boardID=<%=boardID%>&ID=<%=rs("announceID")%>&rootid=<%=rs("rootID")%>>����</a> | <a href=admin_postings.asp?action=delete&boardID=<%=boardID%>&ID=<%=rs("announceID")%>&rootid=<%=rs("rootID")%>>ɾ��</a> | <a href=admin_postings.asp?action=move&boardID=<%=boardID%>&ID=<%=rs("announceID")%>&rootid=<%=rs("rootID")%>>�ƶ�</a>
</FONT></TD></TR>
<%
	  i=i+1
	  if i>=MaxAnnouncePerPage then exit do
          rs.movenext
        loop
	rs.close
%>
</TBODY></TABLE>
</span>
<%
		if err.number<>0 then err.clear
	end sub

	sub AnnounceList()	
	'on error resume next

  	sql="select boardtype,lockboard,boardmaster,boardmaster1,boardmaster2,boardskin,Tableback,Tabletitle,Tablebody,aTablebody,TableFont,TableContent,AlertFont from board where boardID="&cstr(boardid)
 	rs.open sql,conn,1,1
 	if not(rs.bof and rs.eof) then
    		boardtype=rs("boardtype")
		boardskin=rs("boardskin")
		lockboard=rs("lockboard")
		Tableback=trim(rs("Tableback"))
		Tabletitle=trim(rs("Tabletitle"))
		Tablebody=trim(rs("Tablebody"))
		aTablebody=trim(rs("aTablebody"))
		TableFont=trim(rs("TableFont"))
		TableContent=trim(rs("TableContent"))
		AlertFont=trim(rs("AlertFont"))
	end if
	rs.close

	sql="select bbs1.AnnounceID,bbs1.parentID,bbs1.boardID,bbs1.UserName,bbs1.UserEmail,bbs1.child,bbs1.Topic,bbs1.DateAndTime,bbs1.hits,bbs1.length,bbs1.RootID,bbs1.Expression,bbs1.time,bbs1.locktopic,board.lockboard from bbs1,board where bbs1.boardid=board.boardid and bbs1.boardID="&cstr(boardID)&" and bbs1.parentID=0 "&tl&" ORDER BY bbs1.time desc,bbs1.announceid desc"
	rs.open sql,conn,1,1
	if err.number<>0 then
		foundErr = true
		ErrMsg = "<li>���ݿ����ʧ�ܣ�" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			'��̳������
			call showEmptyBoard()
			bBoardEmpty = true
		else
	      		totalrec=rs.recordcount 
      			if currentpage<1 then 
          			currentpage=1 
      			end if 

      			if (currentpage-1)*MaxAnnouncePerPage>totalrec then 
	   			if (totalrec mod MaxAnnouncePerPage)=0 then 
	     				currentpage= totalrec \ MaxAnnouncePerPage 
	   			else 
	      				currentpage= totalrec \ MaxAnnouncePerPage + 1 
	   			end if 
      			end if 
       			if currentPage=1 then 
            			call showpagelist() 
       			else 
          			if (currentPage-1)*MaxAnnouncePerPage<totalrec then 
            				rs.move  (currentPage-1)*MaxAnnouncePerPage 
            				call showpagelist() 
        			else 
	        			currentPage=1 
           				call showpagelist() 
	      			end if 
	   		end if 
		end if
	end if				
		if err.number<>0 then err.clear	
	end sub

	sub listPages2()
	'on error resume next

  	dim n
  	if totalrec mod MaxAnnouncePerPage=0 then
     		n= totalrec \ MaxAnnouncePerPage
  	else
     		n= totalrec \ MaxAnnouncePerPage+1
  	end if
%>
<table border="0" cellpadding="0" cellspacing="3" width="750" align="center">
<form method="post" action="admin_bbs.asp" name="frmList2">
  <tr>
    <td valign="middle" nowrap><span class="smallFont">ҳ�Σ�<strong><%=currentPage%></strong>/<strong><%=n%></strong>ҳ ÿҳ<strong><%=MaxAnnouncePerPage%></strong> ������<strong><%=totalrec%></strong></td>
    <td valign="middle" nowrap>
      <div align="right"><p>��ҳ��
<%
	   for p=1 to n
	   if p<10 then
	       if p=currentPage then
	          response.write "["+Cstr(p)+"] "
		   else
		      response.write "<a href='javascript:viewPage2("+Cstr(p)+")' language='javascript'>["+Cstr(p)+"]</a>   "
		   end if
		end if
	next
%>
<span class="smallFont">ת��:<input type="text" name="Page" size=3 maxlength=10  value="<%=currentpage%>"><input type="button" value="Go" language="javascript" onclick="viewPage1(document.frmList2.Page.value)" id="button1" name="button1"></span></p>      
      </div>    
    </td>
  </tr>
<input type="hidden" name="BoardID" value="<%=BoardID%>">
</form>
</table>
            <form action="admin_bbs.asp?action=del" method=post>
              <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%> height="20"> 
                    <b>����ɾ���� </b>
                      ����ɾ��ĳ�û����ӣ���ˮ��������<input type="text" name="username" size="20">
			<input type="submit" name="Submit" value="�� ��"> <font color=<%=alertfontcolor%>>ɾ�����ָܻ���������ʹ��</font><br>
��ʦ����������ɾ���Լ��������ӣ�����Աֱ�Ӷ�������̳��������ɾ����
                  </td>
                </tr>
              </table>
            </form>
<%
		if err.number<>0 then err.clear
	end sub 

	sub showEmptyBoard()
%>
<TABLE bgColor='<%=Tableback%>' border=0 cellPadding=4 cellSpacing=1 width="95%" align=center>
  <TBODY>
  <TR bgColor='<%=Tabletitle%>'>
    <TD align=middle noWrap height=25><font color=<%=TableFont%>>״̬</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�� ��  (�������Ϊ���´����)</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�� �� </font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>�ظ�/����</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFont%>>����Ա����</font></TD></TR> 
  <tr bgColor="<%=Tablebody%>"><td colSpan=5 vAlign=center width="100%">����̳�������ݣ���ӭ��������</td></tr>
</TBODY></TABLE>
<%
	rs.close
	end sub
	
	sub boardlist()
%>
<table border="0" cellpadding="0" cellspacing="3" width="95%" align="center">
<form action=admin_bbs.asp method=get>
  <tr>
    <td width=100></td>
    <td valign="middle" nowrap>
<div align=right>
<select name='boardid' onchange='javascript:submit()'>
<option value="">��ת��̳
<option value="">
<%
	dim rs1,sql1
	set rs1=server.createobject("adodb.recordset")
	sql="select * from class order by id"
	rs.open sql,conn,1,1
	do while not rs.eof
	id=rs("id")
%>
<option value="1">>>&nbsp;<%=rs("class")%> <<
<%
   		sql1="select boardid,boardtype from board where class="&id&""
   		rs1.open sql1,conn,1,1
		if rs1.eof and rs1.bof then
%>
<option value="">û����̳
<%else%>
<%do while not rs1.eof%>
<option value="<%=rs1("boardid")%>"><%=rs1("boardtype")%>
<%
		rs1.movenext
		loop
		end if
		rs1.close
%>
<option value="">
<%
	rs.movenext
	loop
	rs.close
	set rs1=nothing
%>
</select>
<div>
    </td>
  </tr>
</form>
</table>
<%
	end sub

	sub del()
		if session("masterlogin")="superadmin" then
			sql="delete from bbs1 where username='"&trim(request("username"))&"'"
			conn.Execute(sql)
		else
			sql="delete from bbs1 where boardid="&session("manageboard")&" and  username='"&trim(request("username"))&"'"
			conn.Execute(sql)
		end if
	end sub

	Sub getInput()
        	'On Error Resume Next
        	Rem ------��ȡҳ��------
        	currentPage=request("page")
    	End Sub
    
    	sub chkInput
		'on error resume next
		if session("masterlogin")="superadmin" then
        		BoardID = Request("BoardID")
			if BoardID="" then
				BoardID=1
			elseif not isInteger(BoardID) then
				BoardID=1
			else
				BoardID=clng(BoardID)
				if err then
					BoardID=1
					err.clear
				end if
			end if
		else
			boardid=session("manageboard")
		end if
		if currentpage="" then
			currentpage=1
		elseif not isInteger(currentpage) then
			currentpage=1
		else
			currentpage=clng(currentpage)
			if err then
				currentpage=1
				err.clear
			end if
		end if
    	end sub
	set rs=nothing
	Call endConnection
	end if
%>
</BODY></HTML> 
