clear


%%��������ֵ
nc=zeros(1,8);
nc(1)=input('nss����������:');
nc(2)=input('nsl����������:');
nc(3)=input('sns����������:');
nc(4)=input('snl����������:');
nc(5)=input('wes����������:');
nc(6)=input('wel����������:');
nc(7)=input('ews����������:');
nc(8)=input('ewl����������:');

%%������������������ֵ
flag=0;
while flag==0
n=input('����������������:');
flag=1;
if n<max(nc)
    sprintf('������������С�ڵ����������������������������룡')
    flag=0;
end
end


%%��������ʱ�丳ֵ

d=input('��������ʱ��(s):');



%%���ʱ��������

lb=ones(1,9);
ub=Inf*ones(1,9);

%%�滮��ʼֵ
t0=ones(1,9);

%%����Լ������
A=zeros(8,9);
for i=1:8
    A(i,i)=n;
    A(i,9)=nc(i)-n;
end
b=-n*d*ones(8,1);

%%��ʽԼ������
Aeq=zeros(5,9);
Aeq(1,1)=1;Aeq(2,2)=1;Aeq(3,5)=1;Aeq(4,6)=1;
Aeq(1,3)=-1;Aeq(2,4)=-1;Aeq(3,7)=-1;Aeq(4,8)=-1;
Aeq(5,:)=1;Aeq(5,9)=-6;
beq=zeros(5,1);


%%Ŀ�꺯��
nc9=[nc 0];
fun=@(x)(1/x(9))*(sum(0.5*(x+d).*(x+d).*nc9.*(1+nc9./(n-nc9))));


%%�滮����
[t,T,exitflag]=fmincon(fun,t0,A,b,Aeq,beq,lb,ub);

%%������

if exitflag==1
    sprintf('�ϱ�ֱ�г������ʱ��%fs�̵�ʱ��%fs\n�ϱ���ת�������ʱ��%fs�̵�ʱ��%fs\n����ֱ�г������ʱ��%fs�̵�ʱ��%fs\n������ת�������ʱ��%fs�̵�ʱ��%fs',t(1),t(9)-t(1),t(2),t(9)-t(2),t(5),t(9)-t(5),t(6),t(9)-t(6))
else if exitflag==-2
    sprintf('��ǰ��·����������ض�����ӵ�£�')
    end
end