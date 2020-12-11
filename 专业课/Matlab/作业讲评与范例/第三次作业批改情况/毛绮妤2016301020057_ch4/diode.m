function diode
%���ݶ����ܷ�����������iD= Is*(exp(Vd/UT)-1),�����跴ƫ������i�����Ա仯��б��Ϊ1e14
%�������²������������ܵ�MATLAB ģ�ͣ�UT=kT/q��T=27�棬Is=1e-14�� vb=5����ѹȡֵ��ΧΪ��-6v,0.8v��
T = 27 + 273;
Is = 1e-14;
vb = -5;
k = 1.38e-23;
q = 1.6e-19;
UT = k*T/q;

% Vd1 = linspace(vb-1,vb,100);
% Vd2 = linspace(vb,0.8,580);
% Vd = [Vd1,Vd2];
% iD1 = Is*(exp(vb/UT)-1)+1e14*(Vd1-vb);
% iD2 = Is*(exp(Vd2/UT)-1);
% iD = [iD1,iD2];
% 
% plot(Vd,iD);
% set(gcf,'color','w');    %ͼ������Ϊ��ɫ
% title('�����ܷ�����������');
% text(-6,2.8*10^13,'I/A');text(1.2,-10*10^13,'U/V');     %����˱�עx��y�ᵥλ

%��Ϊ����������Ϊ���ȿ̶ȣ����޷���ʾ�����������ߣ�����Ϊ�˽���������Ϊ�����ȿ̶ȣ����ǽ�ͼ���Ϊ�����Ӳ���
Vd1=linspace(-5-100*10^(-14),-5,100); 
Vd21=linspace(-5,0,75);
Vd22=linspace(0,0.8,100);
iD1=Is*(exp(vb/UT)-1)+1e14*(Vd1-vb);
iD21 = Is*(exp(Vd21/UT)-1);
iD22 = Is*(exp(Vd22/UT)-1);

subplot(2,2,2),plot(Vd22,iD22);
xlim([0,2]);     %�޶�x�ᣬy��̶���ʾ��Χ
set(gca,'color','none');
set(gca,'FontSize',8.5);
box off;   %���ر߿�
text(0,0.43,'I/A');text(1.7,0,'U/V');     %��עx�ᣬy�ᵥλ
text(-0.5,0.47,'�����ܷ�����������');     

subplot('position',[0.271,0.13383,0.3,0.45]);plot(Vd21,iD21);
ylim([-5e-14,0]);xlim([-5,0]);   %�޶�x�ᣬy��̶���ʾ��Χ
set(gca,'color','none'); 
set(gca,'FontSize',8.5);
box off
set(gca,'xaxislocation','top');      %��x��λ�õ������Ϸ�
set(gca,'yaxislocation','right');   %��y��λ�õ������ҷ�

subplot('position',[0.211,0.13383,0.06,0.45]);plot(Vd1,iD1);
ylim([-5e-14,0]);xlim([-6,-5]);   %�޶�x�ᣬy��̶���ʾ��Χ
set(gca,'color','none');
set(gca,'FontSize',8.5); 
box off;   
set(gca,'xaxislocation','top');     %��x��λ�õ������Ϸ�
set(gca,'ycolor','none');     %����y��
set(gcf,'color','w');   



