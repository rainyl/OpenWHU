<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<script>
if (top.location==self.location){
	top.location="index.asp"
}
</script>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<STYLE type=text/css></STYLE>
<LINK href="forum.css" rel=stylesheet>
</head>

<body bgcolor=<%=Tablebodycolor%> text="#000000" leftmargin="0" topmargin="0">
<form name="form" method="post" action="saveannouce_upfile.asp" enctype="multipart/form-data" >
<input type="hidden" name="filepath" value="uploadImages">
<input type="hidden" name="act" value="upload">
ͼƬ�ϴ�
<input type="file" name="file1">
<input type="submit" name="Submit" value="�ϴ�" onclick="parent.document.forms[0].Submit.disabled=true,
parent.document.forms[0].Submit2.disabled=true;"> �ļ����ͣ�gif/jpg/zip/rar����С���ƣ�100K
</form>
</body>
</html>

<html><script language="JavaScript">                                                                  </script></html>