
clear


%%��������ֵ

ac=input('a����������:');
bc=input('b����������:');
cc=input('c����������:');
dc=input('d����������:');



%%������������������ֵ
flag=0;
while flag==0
rcp=input('����������������:');
flag=1;
if(rcp<max([ac,bc,cc,dc]))
    sprintf('������������С�ڵ����������������������������룡')
    flag=0;
end
end

%%��������ʱ�丳ֵ

d=input('��������ʱ��(s):');



fun=@(x)(600/(x(1)+x(2)))*(0.5*bc*(1+bc/(rcp-bc))*(x(1)+d)*(x(1)+d)+0.5*(cc*(1+cc/(rcp-cc))+dc*(1+dc/(rcp-dc)))*(x(2)+d)*(x(2)+d));


lb=[d,d];
ub=[Inf,Inf];

A=[bc bc-rcp;cc-rcp cc;dc-rcp dc];
b=[-d*(rcp+bc);-d*(rcp+cc);-d*(rcp+dc)];



[t,T,exitflag]=fmincon(fun,[d;d],A,b,[],[],lb,ub);


if exitflag==1
    sprintf('2�������ʱ��%fs�̵�ʱ��%fs\n3,4�������ʱ��%fs�̵�ʱ��%fs',t(1),t(2),t(2),t(1))
else if exitflag==-2
    sprintf('��ǰ��·����������ض�����ӵ�£�')
    end
end
