function corr_coef = waterdetect2(test,original,seed,do_num,alpha)
%����˵��:���DCTˮӡ�ĺ���
%����˵��
%test Ϊ������RGBͼ���ļ�
%original Ϊԭʼͼ���ļ�
%seed Ϊ�����������
%alpha �ǳ߶Ȳ���
%do_num �ǽ���ͶƱѡ��Ĵ���
%corr_coef �Ǽ�����ֵ
imgorg=imread(original);
imgtest=imread(test);
imgorg=imgorg(:,:,1);
[m,n]=size(imgorg);
imgtest=imgtest(:,:,1);
%��ȡ����ˮӡ��ͼ���DCTϵ��
waterdct=dct2(imgtest);
%��ȡԭʼͼ���DCTϵ��
waterdcto=dct2(imgorg);
%��������ˮӡ
realwatermark=cellauto(m,n,seed,do_num);
testwatermark=(waterdct-waterdcto)/alpha;
%���������ֵ
corr_coef=trace(realwatermark'*testwatermark)/(norm(realwatermark,'fro') * norm(testwatermark,'fro'));
end

