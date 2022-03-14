% ��������: ����һ������ SC ͼ�ĺ��� 
% �����ʽ����: 
%[corr_Wcoef, corr_Dcoef] = plotcorr_coef( 'test.png','kola.jpg',20,'db6',2,0.1, 0.99); 
% ����˵��: 
% test Ϊ����ͼ�� 
% original Ϊԭʼͼ��
% testMAXseed Ϊʵ��ʹ�õ�������������
% wavelet Ϊʹ�õ�С������ 
% level ΪС���ֽ�ĳ߶� 
% alpha Ϊˮӡǿ�� 
% ratio Ϊ�㷨�� d /n �ı���
% corr_Wcoef, corr_Dcoef �ֱ�Ϊ���ò�ͬ���Ӽ����������ֵ�ļ���
function [corr_Wcoef, corr_Dcoef] = plotcorr_coef( test, original, testMAXseed, wavelet, level,alpha, ratio)
corr_Wcoef = zeros( testMAXseed,1) ;
corr_Dcoef = zeros( testMAXseed, 1) ;
s =1; 
for i = 1:testMAXseed
    [corr_coef, corr_DCTcoef] = wavedetect(test, original, i, wavelet,level, alpha,ratio);
    corr_Wcoef(s) = corr_coef;
    corr_Dcoef(s) = corr_DCTcoef;
    s = s +1;
end
subplot( 211) ;
plot( abs( corr_Wcoef) ) ; 
title( '��������ֵ����' ) ; 
xlabel( ' ����' ) ; 
ylabel( '�����ֵ' ) ; 
subplot( 212) ; plot( abs( corr_Dcoef) ) ; 
%���� 
title( 'DCT �任������ֵ����' ) ; 
xlabel( '����' ) ;
ylabel( '�����ֵ' ) ;