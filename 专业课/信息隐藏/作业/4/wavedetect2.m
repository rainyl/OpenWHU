% ��������: ��������һ����� DCT ˮӡ�ĺ��� 
% �����ʽ����: 
% corr_coef = wavedetect2( 'kolal.jpg','jpg','lenna. jpg','jpg',2019,3,0.2) 
% ����˵��: 
% test Ϊ������ RGB ͼ���ļ��� 
% permission1 Ϊ������ RGB ͼ���ļ���ʽ 
% original Ϊԭʼͼ���ļ���
% permission2 Ϊԭʼͼ���ļ���ʽ
% seed Ϊ����������� 
% do_num �����ǽ���ͶƱѡ��Ĵ��� 
% alpha �ǳ߶Ȳ��� 
% corr_coef �Ǽ�����ֵ
function corr_coef = wavedetect2( test, permission1, original, permission2, seed, do_num, alpha)
dataoriginal = imread( original, permission2);
datatest = imread(test,permission1);
dataoriginal = dataoriginal( : , : , 1) ;
[ m, n] = size( dataoriginal) ;
datatest = datatest( : , : ,1) ; 
% ��ȡ����ˮӡ��ͼ��� DCT ϵ��
waterdct = dct2( datatest) ; 
% ��ȡԭʼͼ��� DCT ϵ��
waterdcto = dct2( dataoriginal) ; 
% ��������ˮӡ
realwatermark = cellauto( m, n, seed, do_num) ;
testwatermark = (waterdct-waterdcto) /alpha; 
% ���������ֵ 
corr_coef = trace( realwatermark' * testwatermark) /( norm( realwatermark, 'fro' ) * norm( testwatermark, 'fro' ) ) ; 
%[ corr_Wcoef, corr_Dcoef] = plotcorr_coef(test,original,20, 'db6' ,2,alpha,1);
