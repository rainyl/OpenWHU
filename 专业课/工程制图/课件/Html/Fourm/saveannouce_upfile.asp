<!--#include FILE="upload.inc"-->
<!--#include FILE="conn.asp"-->
<!--#include FILE="inc/const.asp"-->
<html>
<head>
<title>�ļ��ϴ�</title>
</head>
<body bgcolor=<%=Tablebodycolor%> leftmargin="5" topmargin="3" >
<script>
parent.document.forms[0].Submit.disabled=false;
parent.document.forms[0].Submit2.disabled=false;
</script>
<%
dim upNum
upNum=request.cookies("xdgctx")("upNum")
if upNum>3 then
 	response.write "<font size=2>һ��ֻ���ϴ������ļ���</font>"
	response.end
end if

response.write "<FONT color=red>"&upNum&"</font>"
dim upload,file,formName,formPath,iCount,filename,fileExt
set upload=new upload_5xSoft ''�����ϴ�����




 formPath=upload.form("filepath")
 ''��Ŀ¼���(/)
 if right(formPath,1)<>"/" then formPath=formPath&"/" 


iCount=0
for each formName in upload.file ''�г������ϴ��˵��ļ�
 set file=upload.file(formName)  ''����һ���ļ�����
 if file.filesize<100 then
 	response.write "<font size=2>����ѡ����Ҫ�ϴ����ļ���[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]</font>"
	response.end
 end if
 	
 if file.filesize>100000 then
 	response.write "<font size=2>�ļ���С���������� 100K��[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]</font>"
	response.end
 end if

 fileExt=lcase(right(file.filename,4))

 if fileEXT<>".gif" and fileEXT<>".jpg" and fileEXT<>".zip" and fileEXT<>".rar" then
 	response.write "<font size=2>�ļ���ʽ����ȷ��[ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]</font>"
	response.end
 end if 

 randomize
 ranNum=int(90000*rnd)+10000
 filename=formPath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&fileExt
 
' filename=formPath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&file.FileName
 
 if file.FileSize>0 then         ''��� FileSize > 0 ˵�����ļ�����
  file.SaveAs Server.mappath(FileName)   ''�����ļ�
'  response.write file.FilePath&file.FileName&" ("&file.FileSize&") => "&formPath&File.FileName&" �ɹ�!<br>"
 	if fileEXT=".gif" then
 	response.write "<script>parent.frmAnnounce."&session("antry")&".value+='[upload=gif]"&FileName&"[/upload]'</script>"
 	elseif fileEXT=".jpg" then
 	response.write "<script>parent.frmAnnounce."&session("antry")&".value+='[upload=jpg]"&FileName&"[/upload]'</script>"
 	elseif fileEXT=".zip" then
 	response.write "<script>parent.frmAnnounce."&session("antry")&".value+='[zip]"&FileName&"[/zip]'</script>"
 	elseif fileEXT=".rar" then
 	response.write "<script>parent.frmAnnounce."&session("antry")&".value+='[rar]"&FileName&"[/rar]'</script>"
 	end if
 iCount=iCount+1
 end if
 set file=nothing
next
set upload=nothing  ''ɾ���˶���

Htmend iCount&" ���ļ��ϴ�����!"

sub HtmEnd(Msg)
 set upload=nothing
 if upNum="" then upNum=1
 response.cookies("xdgctx")("upNum")=upNum+1
 response.write "<font size=2>�ļ��ϴ��ɹ� [ <a href=# onclick=history.go(-1)>�����ϴ�</a> ]</font>"
 response.end
end sub


%>
</body>
</html>