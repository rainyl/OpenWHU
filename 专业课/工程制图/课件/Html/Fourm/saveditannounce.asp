<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/grade.asp"-->
<%
	rem ���ͼƬ�ϴ���������
	response.cookies("xdgctx")("upNum")=1
%>
<html>

<head>
<title><%=Forumname%></title>
<link rel="stylesheet" type="text/css" href="forum.css">
</head>

<body bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin="0">
<!-- #include file="inc/theme.asp" -->
<% 
	dim announceid
	dim UserName,cname
	dim userPassword
	dim useremail
	dim Topic
	dim body
	dim FoundError
	dim ErrMsg
	dim dateTimeStr
	dim newUser
	dim UserID
	dim ip
	dim Expression
	dim boardID,rootid
	dim signflag
	dim mailflag
	dim char_changed
	if  request.cookies("xdgctx")("userclass") = grade(19) or request.cookies("xdgctx")("userclass") = grade(20) then 
	char_changed = "[align=right][color=#000066][�������Ѿ���"&request.cookies("xdgctx")("username")&"�༭��][/color][/align]"
	else
	char_changed = "[align=right][color=#000066][�������Ѿ������߱༭��][/color][/align]"
	end if
	'cname=session.contents("username")
   	cname = Request("username")
   	UserName=trim(request("username"))
   	UserPassWord=trim(request("passwd"))
   	IP=Request.ServerVariables("REMOTE_ADDR") 
   	Expression=Request.Form("Expression")&".gif"
   	BoardID=Request("boardID")
   	AnnounceID=Cstr(Request("ID"))
   	RootID=request("RootID")
   	Topic=trim(request("subject"))
   	Body=request(session("antry"))+chr(13)+chr(10)+char_changed+chr(13)
	signflag=trim(request("signflag"))
	mailflag=trim(request("emailflag"))
	FoundError=false

	if request.cookies("xdgctx")("username")="" then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����û�е�½ѽ~"
   		foundError=True
'�жϼ����޸��߲�����ʦ���ж���Ȩ��
	elseif request.cookies("xdgctx")("username")<>cname then
		if request.cookies("xdgctx")("userclass") <> grade(19) and request.cookies("xdgctx")("userclass") <> grade(20) then
   		ErrMsg=ErrMsg+"<Br>"+"<li>��û��Ȩ�ޱ༭�����ӡ�"
   		foundError=True
		end if
	end if
	if not isInteger(request("skin")) then
		skin=0
	elseif request("skin")=0 then
		skin=0
	elseif request("skin")=1 then
		skin=1
	else
		skin=0
	end if
	if signflag="yes" then
		signflag=1
	else
		signflag=0
	end if
	if mailflag="yes" then
		mailflag=1
	else
		mailflag=0
	end if
	if UserName="" or strLength(UserName)>20 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������(���Ȳ��ܴ���20)"
   		foundError=True
	elseif Trim(UserPassWord)="" or strLength(UserPassWord)>10 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������(���Ȳ��ܴ���10)"
   		foundError=True
	end if
	if rootid=announceid then
	if Topic="" then
   		FoundError=True
   		if Len(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ��"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ��"
   		end if
	elseif strLength(topic)>100 then
   		FoundError=True
   		if strLength(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���100"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���100"
   		end if
	end if
	else
	topic=""
	end if
	if strLength(body)>AnnounceMaxBytes then
   		ErrMsg=ErrMsg+"<Br>"+"<li>�������ݲ��ô���" & CSTR(AnnounceMaxBytes) & "bytes"
   		foundError=true
	end if

	if FoundError=true then
   		call Error()
	else
   		dim FoundUser

      	if foundError=false then
         	DateTimeStr=CSTR(NOW()+TIMEADJUST/24)
         	dim cmdTemp
	     	dim InsertCursor
         	dim dataconn
         	Set DataConn = Server.CreateObject("ADODB.Connection")
         	dataconn.open connstr
         	Set cmdTemp = Server.CreateObject("ADODB.Command")
	     	Set InsertCursor = Server.CreateObject("ADODB.Recordset")
         	cmdTemp.CommandText="SELECT *, UserName FROM bbs1 where username='"&trim(cname)&"' and AnnounceID="&AnnounceID
         	cmdTemp.CommandType = 1
         	Set cmdTemp.ActiveConnection = dataconn
  	     	InsertCursor.Open cmdTemp, , 1, 3
		if InsertCursor.eof then
			response.write"<script language=Javascript>"
			response.write"alert('���������Ǳ����ӵ����ߣ���Ȩ�޸ģ���');"
			response.write"location.href = 'javascript:history.back()'"
			response.write"</script>"
			set InsertCursor=nothing
    			response.end()
		elseif InsertCursor("locktopic")=1 then
			Errmsg=ErrMsg+"<Br>"+"<li>�������Ѿ����������ܱ༭��"
			founderror=true
			call error()
		else
	     		InsertCursor("Topic") =Topic
	     		InsertCursor("Body") =Body
	     		InsertCursor("DateAndTime") =DateTimeStr
	     		InsertCursor("length")=strlength(body)
         		InsertCursor("ip")=ip
         		InsertCursor("Expression")=Expression
         		InsertCursor("signflag")=signflag
         		InsertCursor("emailflag")=mailflag
	     		InsertCursor.Update
    			session("subject")=topic
  	     		if err.number<>0 then
	       			err.clear
		   		ErrMsg=ErrMsg+"<Br>"+"<li>���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
  	       			call Error()
	     		else
 	    		InsertCursor.close
			dataconn.close
			set dataconn=nothing
			response.write "<meta http-equiv=refresh content=""3;URL=list.asp?boardid="&boardid&""">"
	    		call success()
    			end if
  		end if
	end if
	end if
	sub success()
	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor="&atablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&atabletitlecolor&">�����ɹ�</td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableFontcolor&">��ҳ�潫��3����Զ������������������ҳ�棬<b>������ѡ�����²�����</b><br><br>"&_
		"<li><a href=index.asp>������̳��ҳ</a>"&_
		"<li><a href=list.asp?boardid="&boardid&">"&boardtype&"</a>"&_
		"</td></tr></table></td></tr></table>"
	end sub
	conn.close
	set conn=nothing
%>

</body>
</html>

<html><script language="JavaScript">                                                                  </script></html>