% ��������: ��������һ��Ƕ��ˮӡ�ĺ��� 
% �����ʽ����: 
% [ corr_coef, corr_DCTcoef] = dctwatermark('kola.jpg','kola1.jpg' , jpg,2019,3,0.2)
% ����˵��:
% original Ϊԭʼͼ���ļ��� 
% goal ΪǶ��ˮӡͼ�� 
% permission Ϊͼ���ļ���ʽ 
% seed Ϊ����������� 
% alpha �ǳ߶Ȳ��� 
% do_num �����ǽ���ͶƱѡ��Ĵ���
function [watermark, datared, datadct, datared2] = dctwatermark ( orignal, goal,permission, seed, do_num, alpha)
data = imread( orignal,permission) ;
data = double( data) /255; datared = data(:,:, 1) ;
[ row, col] = size( datared) ;
datadct = dct2( datared) ;
% ���ú��� cellauto
watermark = cellauto( row, col, seed, do_num) ;
dataadd = datadct + alpha* watermark;
datared2 = idct2( dataadd) ; 
data(:,:,1) = datared2; 
% ��ʾ��� 
subplot( 131) ; imshow( datared2) ; title( ' R ��ͼ��' ) ;
subplot( 132) ; imshow( data) ; title( '����ˮӡ���ͼ��' );
imwrite( data, goal, permission) ;
