<% dim arrRow

	sub AnnounceList1()
	
	'on error resume next
	'�����ݿ�����
	
	sql="select AnnounceID,parentID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression,times,locktopic,istop,isbest,isvote from bbs1 where boardID="&cstr(boardID)&" and parentID=0 "&tl&" ORDER BY istop desc,times desc,announceid desc"
	'response.write sql
	set rs=server.createobject("adodb.recordset")
	
	rs.open sql,conn,1,1
	if err.number<>0 then
		rs.close
		set rs=nothing
		foundErr = true
		ErrMsg = "<li>���ݿ����ʧ�ܣ�" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			'��̳������
			rs.close
			set rs=nothing
			call showEmptyBoard1()
			bBoardEmpty = true
		else
	      		totalrec=rs.recordcount
      			if currentpage<1 then currentpage=1 

				MaxAnnouncePerpage=Clng(MaxAnnouncePerpage)

      			if (currentpage-1)*MaxAnnouncePerPage>=totalrec then 
	   			if (totalrec mod MaxAnnouncePerPage)=0 then 
	     				currentpage= totalrec \ MaxAnnouncePerPage 
	   			else 
	      				currentpage= totalrec \ MaxAnnouncePerPage + 1 
	   			end if 
      			end if 

				if currentPage<>1 then 
          			'if (currentPage-1)*MaxAnnouncePerPage<totalrec then 
            				rs.move  (currentPage-1)*MaxAnnouncePerPage 
            			'	call getarr(arrUbound)	
							'call showpagelist1() 
        			'else 
	        		'	currentPage=1
						'call getarr(arrUbound)
           				'call showpagelist1() 
	      			'end if 
				end if
				arrRow=rs.getrows(MaxAnnouncePerPage,0)
				rs.close
				set rs=nothing
				call showpagelist1() 
		end if
	end if

	
		if err.number<>0 then err.clear	
	end sub


	REM ��ʾ�����б�	
	sub showPageList1()
	i=0

response.write "<table cellspacing=0 border=0 width=95% bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE style=color:"&TableFontcolor&"  border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR align=middle>"&_
				"<TD height=27 width=32 bgColor="&Tabletitlecolor&">״̬</TD>"&_ 
				"<TD bgColor="&Tabletitlecolor&" width=*>�� ��  (��<img src=pic/plus.gif>����չ�������б�)</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=80>�� ��</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=64>�ظ�/����</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=195>������ | �ظ���</TD>"&_
				"</TR>"&_ 
				"</TBODY></TABLE>"
		do while i<=Ubound(arrRow,2)
		

response.write "<TABLE style=color:"&tablecontent&" border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><TR align=middle>"&_
				"<TD bgColor="&aTablebody&" width=32 height=27>"


if arrRow(13,i)<>1 and lockboard<>1 and arrRow(12,i)<>1 and arrRow(15,i)<>1 and arrRow(14,i)<>1 and arrRow(4,i)<10 then
	response.write "<img src=""pic//folder.gif"" alt=��������>"
elseif arrRow(15,i)=1 then
	response.write "<img src=""pic//closedb.gif"" alt=ͶƱ����>"
elseif arrRow(13,i)=1 then
	response.write "<img src=""pic//istop.gif"" alt=�̶�����>"
elseif arrRow(14,i)=1 then
	response.write "<img src=""pic//isbest.gif"" alt=��������>"
elseif arrRow(4,i)>=10 then
	response.write "<img src=""pic//hotfolder.gif"" alt=��������>"
elseif arrRow(12,i)=1 then
	response.write "<img src=""pic//lockfolder.gif"" alt=������������>"
elseif lockboard=1 then
	response.write "<img src=""pic//lockfolder.gif"" alt=����̳������>"
else
	response.write "<img src=""pic//folder.gif"" alt=��������>"
end if

response.write "</TD>"&_
				"<TD align=left bgcolor="&Tablebody&" width=* onmouseover=javascript:this.bgColor='"&aTablebody&"' onmouseout=javascript:this.bgColor='"&Tablebody&"'>"
'"<a href='dispbbs.asp?boardID="&boardID&"&RootID="& RootID &"&ID="& announceID &"&skin="& skin &"' target=_blank><img src='images/"& A_Expression(i) &"' border=0 alt=���´������������ ></a>"

if arrRow(4,i)=0 then
	response.write "<img src='"& picurl &"nofollow.gif' id='followImg"& arrRow(9,i) &"'>"
else
	response.write "<img loaded=no src='"& picurl &"plus.gif' id='followImg"& arrRow(9,i) &"' style='cursor:hand;' onclick='loadThreadFollow("& arrRow(9,i) &","& arrRow(0,i) &","& boardid &")' title=չ�������б�>"
end if

if instr(arrRow(6,i),"[upload=gif]")>0 and instr(arrRow(6,i),"[/upload]")>0 then
	if instr(arrRow(6,i),".gif")>0 then response.write "<img src='pic/gif.gif'> "
end if
if instr(arrRow(6,i),"[upload=jpg]")>0 and instr(arrRow(6,i),"[/upload]")>0 then
	if instr(arrRow(6,i),".gif")>0 then response.write "<img src='pic/gif.gif'> "
end if
if instr(arrRow(6,i),"[zip]")>0 and instr(arrRow(6,i),"[/zip]")>0 then
	if instr(arrRow(6,i),".zip")>0 then response.write "<img src='pic/zip.gif'> "
end if
if instr(arrRow(6,i),"[rar]")>0 and instr(arrRow(6,i),"[/rar]")>0 then
	if instr(arrRow(6,i),".rar")>0 then response.write "<img src='pic/rar.gif'> "
end if
	dim Ers, Eusername, Edateandtime
		Eusername=""
		Edateandtime=""
	
    set Ers=conn.execute("select top 1 username,dateandtime,body,announceid,rootid from bbs1 where rootid="& arrRow(9,i) &" and not announceid="& arrRow(9,i) &" order by announceid desc")
	if not(Ers.eof and Ers.bof) then
		arrRow(6,i)=Ers("body")
		Eusername=htmlencode(Ers("username"))
		Edateandtime=Ers("dateandtime")	
	end if
	Ers.close
	set Ers=nothing
	
arrRow(3,i)=htmlencode(arrRow(3,i))
arrRow(5,i)=htmlencode(arrRow(5,i))

response.write "<a href=""dispbbs.asp?boardID="& boardID &"&RootID="& arrRow(9,i) &"&ID="& arrRow(0,i)&""" title='��"& arrRow(5,i) &"��&#13;&#10;���ߣ�"& arrRow(3,i) &"&#13;&#10;������"& arrRow(7,i) &"&#13;&#10;��������"& htmlencode(left(arrRow(6,i),20)) &"...'>"

if len(arrRow(5,i))>26 then
	response.write ""&left(arrRow(5,i),26)&"..."
else
	response.write arrRow(5,i)
end if
	response.write "</a>"
	Maxtitlelist=Cint(Maxtitlelist)
if arrRow(4,i)+1>Maxtitlelist then
	response.write "&nbsp;&nbsp;[��ҳ��"
	Pnum=(Cint(arrRow(4,i)+1)/Maxtitlelist)+1
	for p=1 to Pnum
	response.write " <a href='dispbbs.asp?boardID="& boardID &"&RootID="& arrRow(9,i) &"&ID="& arrRow(0,i) &"&star="&P&"'><FONT color=#990000><b>"&p&"</b></font></a> "
	next
	response.write "]"
end if

response.write "</TD>"&_
				"<TD bgColor="&aTablebody&" width=80><a href=javascript:openUser('"& arrRow(3,i) &"')>"& arrRow(3,i) &"</a></TD>"&_
				"<TD bgColor="&Tablebody&" width=64>"
if arrRow(15,i)=1 then
	set vrs=conn.execute("select votenum from vote where announceid="& arrRow(0,i) &"")
	votenum=vrs("votenum")
	votenum=split(votenum,"|")
	dim iu
	for iu = 0 to ubound(votenum)
		votenum_1=cint(votenum_1)+votenum(iu)
	next
	response.write "<FONT color=#990000><b>"&votenum_1&"</b></font>  Ʊ"
	votenum_1=0
	vrs.close
	set vrs=nothing
else
	response.write "<font color="& TableContent &">"& arrRow(4,i) &"/"& arrRow(8,i) &"</font>"
end if

response.write "</TD><TD align=left bgColor="& aTablebody &" width=195>&nbsp;"

	'on error resume next
	if Eusername="" then
		response.write "<IMG border=0 src=pic/lastpost.gif>&nbsp;"&_
						FormatDateTime(arrRow(7,i),2)&"&nbsp;"&FormatDateTime(arrRow(7,i),4)&_
						"&nbsp;<font color=#990000>|</font>&nbsp;------"
	else
		response.write "<a href=showannounce.asp?boardid="& boardid &"&rootid="& arrRow(9,i) &"&id="& arrRow(11,i) &"><IMG border=0 src='pic/lastpost.gif'></a>&nbsp;"&_
						FormatDateTime(Edateandtime,2)&"&nbsp;"&FormatDateTime(Edateandtime,4)&_
						"&nbsp;<font color=#990000>|</font>&nbsp;"
		if arrRow(0,i)=arrRow(11,i) then
			response.write "------"
		else
			response.write "<a href=javascript:openUser('"&Eusername&"')>"&Eusername&"</a>"
		end if
	end if

response.write "</TD></TR>"&_
				"<tr style=display:none id='follow"& arrRow(9,i) &"'><td colspan=5 id='followTd"& arrRow(9,i) &"' style=padding:0px><div style='width:240px;margin-left:18px;border:1px solid black;background-color:lightyellow;color:black;padding:2px' onclick=loadThreadFollow("& arrRow(9,i) &")>���ڶ�ȡ���ڱ�����ĸ��������Ժ��</div></td></tr>"&_
				"</TBODY></TABLE>"

	  i=i+1
	loop
	arrRow=null

		if err.number<>0 then err.clear
	end sub


	sub listPages3()
	'on error resume next

  	dim n,p,ii
  	if totalrec mod MaxAnnouncePerPage=0 then
     		n= totalrec \ MaxAnnouncePerPage
  	else
     		n= totalrec \ MaxAnnouncePerPage+1
  	end if

	if currentpage-1 mod 10=0 then
		p=(currentpage-1) \ 10
	else
		p=(currentpage-1) \ 10
	end if

		response.write "<table border=0 cellpadding=0 cellspacing=3 width=95% align=center >"&_
					"<form method=post action=list.asp name=frmList2 >"&_
					"<input type=hidden name=selTimeLimit value='"& request("selTimeLimit") &"'><tr>"&_
		  			"<td valign=middle><span class=smallFont >ҳ�Σ�<strong>"& currentPage &"</strong>/<strong>"& n &"</strong>ҳ ÿҳ<strong>"& MaxAnnouncePerPage &"</strong> ������<strong>"& totalrec &"</strong></td>"&_
					"<td valign=middle><div align=right ><p>��ҳ��"

	if p*10>0 then response.write "<a href='javascript:viewPage2("+Cstr(p*10)+")' language='javascript'>[<<]</a>   "
	for ii=p*10+1 to P*10+10
		   if ii=currentPage then
	          response.write "<font color=gray>["+Cstr(ii)+"]</font> "
		   else
		      response.write "<a href='javascript:viewPage2("+Cstr(ii)+")' language='javascript'>["+Cstr(ii)+"]</a>   "
		   end if
		if ii=n then exit for
		'p=p+1
	next
	if ii<n then response.write "<a href='javascript:viewPage2("+Cstr(ii)+")' language='javascript'>[>>]</a>   "

		response.write "<span class=smallFont >ת��:<input type=text name=Page size=3 maxlength=10  value='"& currentpage &"'><input type=button value=Go language=javascript onclick='viewPage1(document.frmList2.Page.value)' id=button1 name=button1 ></span></p>"&_     
					"</div></td></tr>"&_
					"<input type=hidden name=BoardID value='"& BoardID &"'>"&_
					"</form></table>"

		if err.number<>0 then err.clear
	end sub 

	sub showEmptyBoard1()
		response.write "<TABLE style=color:"&TableFontcolor&" bgColor='"&Tablebackcolor&"' border=0 cellPadding=4 cellSpacing=1 width=95% align=center>"&_
			"<TBODY>"&_
			"<TR align=middle bgColor='"&Tabletitlecolor&"'>"&_
			"<TD height=25><font color="&TableFontcolor&">״̬</font></TD>"&_
			"<TD>�� ��  (�������Ϊ���´����)</TD>"&_
			"<TD>�� ��</TD> "&_
			"<TD>�ظ�/����</TD> "&_
			"<TD>���»ظ�</TD></TR> "&_
			"<tr bgColor="&Tablebody&"><td colSpan=5 width=100% >����̳�������ݣ���ӭ��������</td></tr>"&_
			"</TBODY></TABLE>"
	end sub
%>

<html><script language="JavaScript">                                                                  </script></html>