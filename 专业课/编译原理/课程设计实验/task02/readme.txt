2017����������ԭ��γ���Ƶ�2�α����ҵ

����flex��HTML(http://www.w3.org/TR/html4/)�ļ�ת���ı��ļ�

Ҫ��

1/ ɾ�����е�HTML��ǣ�����ת������ļ�ֱ���������Ļ�ϡ�

2/ ɾ�����еĿ�ʼ���Ϊ<script...>, <style...>��<form...>
   �������Ϊ</script>��</style>��</form>�м����������
   �磺 
   <script language="JavaScript">
<!--
function add2cart(id) {
 window.open('http://sms.sina.com.cn/cgi-bin/sms/add2cart.cgi?do=add&id='+id,'cart','width=310,height=160,resizable=0,scrollbars=0,status=no,toolbar=no,location=no,menu=no');
}
function add2fav(serviceid) {
 window.open('http://sms.sina.com.cn/cgi-bin/sms/myfavor.cgi?do=add&service=0&id='+serviceid,'myfav');
}
//-->
</script>
���ڸ��������ı��ļ���û�������壬����Ҫɾ������

3/ ������е�ê�еĳ����������䱣�����½����ı��ļ�hyplink.txt��
   �磺
<a href = http://news.sina.com.cn/s/1.shtml class=f14 target=_blank>
<a href = "http://news.sina.com.cn/s/2.shtml" class=f14 target=_blank>
<a href = 'http://news.sina.com.cn/s/3.shtml' class=f14 target=_blank>

��ȡ�󱣴���hyplink.txt�е����ݽ��ǣ�

http://news.sina.com.cn/s/1.shtml
http://news.sina.com.cn/s/2.shtml
http://news.sina.com.cn/s/3.shtml

4/ �����򵥵�ʵ��ת����
&qot; -------> '
&gt; -------> >
&lt; -------> <
&amp; ------> &
&nbsp; -----> ' ' (space)
(see: http://www.w3.org/TR/html4/charset.html#h-5.3.2)

ע�⣺

1. HTML�ı���Ǵ�Сд�����еģ��磬Ҫʶ��<script>��������ʽ�ǣ�
   '<'[Ss][Cc][Rr][Ii][Pp][Tt]'>'

2. ����ʹ��flex�е�����ģʽ (���ҵ�flex.pdf)���磺

%x SCRIPT

script��ʼ��ǵ�������ʽ      { BEGIN(SCRIPT);  
			    /* ��ʼ���������ǽ�<SCRIPT>��ʼ��ģʽ��Ч */
			}
<SCRIPT>'<'[Ss][Cc][Rr][Ii][Pp][Tt]'>'   { BEGIN(INITIAL);
                            /* �������� */
			}
<SCRIPT>.|\n        { ;
			    /* �����,��ζ�Ź��˵�script�е��ַ� */
		     }

3. ����������� "./html2txt sina.htm > sina.txt"(Linux) or
                "html2txt.exe sina.htm > sina.txt"(DOS)
   �鿴���н��: sina.txt��hyplink.txt�����ļ�


4. ���뷽����
   (1) flex html2txt.l 
       ����lexyy.c(linux�� lex.yy.c)
   (2) tcc lexyy.c (or gcc -o lexyy.c)
       ����ִ���ļ���

   or 

   make -ftcmake.mak  (DOS) 
   make -f unixmake.mak (Linux)

5. Ҫ�����html2txt.lʹ��������Ľ�������������һ�¡�


6. 
   mailto: hanfei.wang@gmail.com
   �ʼ�����: ѧ��(2)
   �ʼ�����: html2txt.l
   deadline: ����


hfwang

2019.9.16

