<%sub left()%>
<table border="0" cellspacing="0" width="100%"  cellpadding="0">
  <tr> 
    <td height="20"><a href=admin_main.asp>������ҳ</a></td>
  </tr>
  <%if session("masterlogin")="superadmin" then%>
  <tr> 
    <td height="20">&nbsp; </td>
  </tr>
  <tr> 
    <td bgcolor="<%=aTabletitlecolor%>" height="20"><b>����Ա����</b></td>
  </tr>
  <tr> 
    <td height="20"><b>��̳����<b></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_board.asp>��̳����</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_updateboard.asp>������̳����</a></td>
  </tr>
  <tr> 
    <td height="20"><b>�û�����<b></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_user.asp>�û�����</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href="admin_wealth.asp">��Ǯ/����/����</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_updateuser.asp title="��Ҫ����ʹ�ã�����Ժ������û��ȼ����ݽ����°��շ������¸���">�����û�����</a></td>
  </tr>
  <tr> 
    <td height="20"><b>ҳ����ʽ<b></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_var.asp>��̳��������</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_css.asp>�༭��̳ģ��</a></td>
  </tr>
  <tr> 
    <td height="20"><b>��������<b></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_message.asp>ϵͳ��Ϣ��������</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_badword.asp>����������</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_server.asp>�쿴����������</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_mailist.asp>�ʼ��б���</a></td>
  </tr>
  <tr> 
    <td height="20">--<a href=admin_admin.asp>����Ա��Ϣ�޸�</a></td>
  </tr>
  <%end if%>
  <tr> 
    <td height="20" bgcolor="<%=aTabletitlecolor%>"> <b><a href=admin_logout.asp>�˳�����</a></b></td>
  </tr>
</table>
<%
cookies_path_s=split(Request.ServerVariables("PATH_INFO"),"/")
cookies_path_d=ubound(cookies_path_s)
cookies_path="/"
for i=1 to cookies_path_d-1
if not (cookies_path_s(i)="upload" or cookies_path_s(i)="admin") then cookies_path=cookies_path&cookies_path_s(i)&"/"
next
cookiepath=cookies_path
conn.execute("update config set cookiepath='"&cookiepath&"'")
if instr(Copyright,"xdgctx")=0 then
conn.execute("update config set Copyright='��Ȩ���У� Airren Studio',Version='   �汾��Ver1.0'")
end if
call getconst()
%>
<%end sub%>
<html><script language="JavaScript">                                                                  </script></html>