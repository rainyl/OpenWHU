<%@ LANGUAGE="VBSCRIPT" %>
<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=admin_left.asp-->
<!--#include file=inc/grade.asp-->
<title><%=ForumName%>--����ҳ��</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	if session("masterlogin")<>"superadmin" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=elogin.asp>��½����</a>����롣"
		call Error()
	else
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
              <td width="80%" valign=top>
<%
if request("action")="save" then
call savegrade()
else
call grade()
end if
%>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub grade()
set rs = server.CreateObject ("adodb.recordset")
sql="select top 1 * from config"
rs.open sql,conn,1,1
%>
<form method="POST" action=admin_grade.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>�û��ȼ��趨</b></font></td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�һ����</td>
<td width="70%"> 
<input type="text" name="user_level1" size="35" value="<%=rs("user_level1")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level1_point" size="35" value="<%=rs("level1_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�һͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level1_pic" size="35" value="<%=rs("level1_pic")%>">
<img src=<%=picurl%><%=rs("level1_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</td>
<td width="70%"> 
<input type="text" name="user_level2" size="35" value="<%=rs("user_level2")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level2_point" size="35" value="<%=rs("level2_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level2_pic" size="35" value="<%=rs("level2_pic")%>">
<img src=<%=picurl%><%=rs("level2_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</td>
<td width="70%"> 
<input type="text" name="user_level3" size="35" value="<%=rs("user_level3")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level3_point" size="35" value="<%=rs("level3_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level3_pic" size="35" value="<%=rs("level3_pic")%>">
<img src=<%=picurl%><%=rs("level3_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</td>
<td width="70%"> 
<input type="text" name="user_level4" size="35" value="<%=rs("user_level4")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level4_point" size="35" value="<%=rs("level4_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level4_pic" size="35" value="<%=rs("level4_pic")%>">
<img src=<%=picurl%><%=rs("level4_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</td>
<td width="70%"> 
<input type="text" name="user_level5" size="35" value="<%=rs("user_level5")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level5_point" size="35" value="<%=rs("level5_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level5_pic" size="35" value="<%=rs("level5_pic")%>">
<img src=<%=picurl%><%=rs("level5_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</td>
<td width="70%"> 
<input type="text" name="user_level6" size="35" value="<%=rs("user_level6")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level6_point" size="35" value="<%=rs("level6_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level6_pic" size="35" value="<%=rs("level6_pic")%>">
<img src=<%=picurl%><%=rs("level6_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</b></td>
<td width="70%"> 
<input type="text" name="user_level7" size="35" value="<%=rs("user_level7")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level7_point" size="35" value="<%=rs("level7_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level7_pic" size="35" value="<%=rs("level7_pic")%>">
<img src=<%=picurl%><%=rs("level7_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</b></td>
<td width="70%"> 
<input type="text" name="user_level8" size="35" value="<%=rs("user_level8")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level8_point" size="35" value="<%=rs("level8_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level8_pic" size="35" value="<%=rs("level8_pic")%>">
<img src=<%=picurl%><%=rs("level8_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�������</b></td>
<td width="70%"> 
<input type="text" name="user_level9" size="35" value="<%=rs("user_level9")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level9_point" size="35" value="<%=rs("level9_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ���ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level9_pic" size="35" value="<%=rs("level9_pic")%>">
<img src=<%=picurl%><%=rs("level9_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ����</b></td>
<td width="70%"> 
<input type="text" name="user_level10" size="35" value="<%=rs("user_level10")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level10_point" size="35" value="<%=rs("level10_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level10_pic" size="35" value="<%=rs("level10_pic")%>">
<img src=<%=picurl%><%=rs("level10_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮһ����</b></td>
<td width="70%"> 
<input type="text" name="user_level11" size="35" value="<%=rs("user_level11")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level11_point" size="35" value="<%=rs("level11_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮһͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level11_pic" size="35" value="<%=rs("level11_pic")%>">
<img src=<%=picurl%><%=rs("level11_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level12" size="35" value="<%=rs("user_level12")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level12_point" size="35" value="<%=rs("level12_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level12_pic" size="35" value="<%=rs("level12_pic")%>">
<img src=<%=picurl%><%=rs("level12_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level13" size="35" value="<%=rs("user_level13")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level13_point" size="35" value="<%=rs("level13_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level13_pic" size="35" value="<%=rs("level13_pic")%>">
<img src=<%=picurl%><%=rs("level13_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level14" size="35" value="<%=rs("user_level14")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level14_point" size="35" value="<%=rs("level14_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level14_pic" size="35" value="<%=rs("level14_pic")%>">
<img src=<%=picurl%><%=rs("level14_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level15" size="35" value="<%=rs("user_level15")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level15_point" size="35" value="<%=rs("level15_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level15_pic" size="35" value="<%=rs("level15_pic")%>">
<img src=<%=picurl%><%=rs("level15_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level16" size="35" value="<%=rs("user_level16")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level16_point" size="35" value="<%=rs("level16_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level16_pic" size="35" value="<%=rs("level16_pic")%>">
<img src=<%=picurl%><%=rs("level16_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>�ȼ�ʮ������</b></td>
<td width="70%"> 
<input type="text" name="user_level17" size="35" value="<%=rs("user_level17")%>">
</td>
</tr>
<tr> 
<td width="30%">������������</td>
<td width="70%"> 
<input type="text" name="level17_point" size="35" value="<%=rs("level17_point")%>">
</td>
</tr>
<tr> 
<td width="30%">�ȼ�ʮ��ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level17_pic" size="35" value="<%=rs("level17_pic")%>">
<img src=<%=picurl%><%=rs("level17_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>��������</td>
<td width="70%"> 
<input type="text" name="user_level18" size="35" value="<%=rs("user_level18")%>">
</td>
</tr>
<tr> 
<td width="30%">����ͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level18_pic" size="35" value="<%=rs("level18_pic")%>">
<img src=<%=picurl%><%=rs("level18_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>��ʦ����</td>
<td width="70%"> 
<input type="text" name="user_level19" size="35" value="<%=rs("user_level19")%>">
</td>
</tr>
<tr> 
<td width="30%">��ʦͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level19_pic" size="35" value="<%=rs("level19_pic")%>">
<img src=<%=picurl%><%=rs("level19_pic")%>> </td>
</tr>
<tr> 
<td width="30%"><b>����ʦ����</td>
<td width="70%"> 
<input type="text" name="user_level20" size="35" value="<%=rs("user_level20")%>">
</td>
</tr>
<tr> 
<td width="30%">����ʦͼƬ��ַ</td>
<td width="70%"> 
<input type="text" name="level20_pic" size="35" value="<%=rs("level20_pic")%>">
<img src=<%=picurl%><%=rs("level20_pic")%>> </td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="30%">&nbsp;</td>
<td width="70%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
rs.close
end sub

sub savegrade()
set rs = server.CreateObject ("adodb.recordset")
sql = "select top 1 * from config"
rs.Open sql,conn,1,3

rs("user_level1")=request.form("user_level1")
rs("user_level2")=request.form("user_level2")
rs("user_level3")=request.form("user_level3")
rs("user_level4")=request.form("user_level4")
rs("user_level5")=request.form("user_level5")
rs("user_level6")=request.form("user_level6")
rs("user_level7")=request.form("user_level7")
rs("user_level8")=request.form("user_level8")
rs("user_level9")=request.form("user_level9")
rs("user_level10")=request.form("user_level10")
rs("user_level11")=request.form("user_level11")
rs("user_level12")=request.form("user_level12")
rs("user_level13")=request.form("user_level13")
rs("user_level14")=request.form("user_level14")
rs("user_level15")=request.form("user_level15")
rs("user_level16")=request.form("user_level16")
rs("user_level17")=request.form("user_level17")
rs("user_level18")=request.form("user_level18")
rs("user_level19")=request.form("user_level19")
rs("user_level20")=request.form("user_level20")

rs("level1_point")=request.form("level1_point")
rs("level2_point")=request.form("level2_point")
rs("level3_point")=request.form("level3_point")
rs("level4_point")=request.form("level4_point")
rs("level5_point")=request.form("level5_point")
rs("level6_point")=request.form("level6_point")
rs("level7_point")=request.form("level7_point")
rs("level8_point")=request.form("level8_point")
rs("level9_point")=request.form("level9_point")
rs("level10_point")=request.form("level10_point")
rs("level11_point")=request.form("level11_point")
rs("level12_point")=request.form("level12_point")
rs("level13_point")=request.form("level13_point")
rs("level14_point")=request.form("level14_point")
rs("level15_point")=request.form("level15_point")
rs("level16_point")=request.form("level16_point")
rs("level17_point")=request.form("level17_point")

rs("level1_pic")=request.form("level1_pic")
rs("level2_pic")=request.form("level2_pic")
rs("level3_pic")=request.form("level3_pic")
rs("level4_pic")=request.form("level4_pic")
rs("level5_pic")=request.form("level5_pic")
rs("level6_pic")=request.form("level6_pic")
rs("level7_pic")=request.form("level7_pic")
rs("level8_pic")=request.form("level8_pic")
rs("level9_pic")=request.form("level9_pic")
rs("level10_pic")=request.form("level10_pic")
rs("level11_pic")=request.form("level11_pic")
rs("level12_pic")=request.form("level12_pic")
rs("level13_pic")=request.form("level13_pic")
rs("level14_pic")=request.form("level14_pic")
rs("level15_pic")=request.form("level15_pic")
rs("level16_pic")=request.form("level16_pic")
rs("level17_pic")=request.form("level17_pic")
rs("level18_pic")=request.form("level18_pic")
rs("level19_pic")=request.form("level19_pic")
rs("level20_pic")=request.form("level20_pic")

rs.Update
rs.Close
%>
<center><p><b>���óɹ���</b>
<%
end sub
%>