clc;
close all;
clear;
y1=zeros(1,9);
y2=zeros(1,9);
while(1)  
x=randperm(9); %����һ����ά�����������Ԫ��Ϊ1~9������%
 if (x(1)*1000+x(2)*100+x(3)*10+x(4))*x(5)==(x(6)*1000+x(7)*100+x(8)*10+x(9))
  y1=x;
  break
  end
end
while(1)  
x=randperm(9);
 if (x(1)*1000+x(2)*100+x(3)*10+x(4))*x(5)==(x(6)*1000+x(7)*100+x(8)*10+x(9))
  if (x==y1) %Ϊ��ֹ���������ֵ��ͬһ���⣬�ڴ����жϣ���x���һ������������ѭ��%
  else
  y2=x ;
  break
  end
 end
end
y1
y2
