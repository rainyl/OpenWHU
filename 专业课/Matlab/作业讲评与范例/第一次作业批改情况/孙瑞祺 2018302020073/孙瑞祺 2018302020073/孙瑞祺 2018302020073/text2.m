clc;
close all;
clear;
x=zeros(100,100);
for k=15:1:60 %��15�뿪ʼ��������̵�ʱ�����̲�����ʵ�����
  for j=15:1:60
      if(k>=2*(1/5)*j) %�ڴ����жϣ�������̵��޷����ϴκ�ƻ��۵�С��ȫ�����ߵ���С��Խ��Խ��
          y1=floor(j/5)+ceil((k-2*floor(j/5))/5);
          %���̵����̱��ʱ���ڹ��ֵ�С���������Ѿ���ȫ���֣����̵��ɺ����ʱ�¼����С�����������С����
      else
          break
      end
      if(j>1.5*0.3*k)
          y2=floor(0.3*k)+ceil(0.3*(j-1.5*floor(0.3*k)));
      else 
          continue
      end
      y3=floor(0.1*k)+ceil(0.1*(j-0.75*floor(0.1*k)));
      y=(y1+y2+y3)/(k+j);
      x(k,j)=y;
  end
end
max(max(x))