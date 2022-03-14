function ssw_extract(goal,watermark,seed,wavelet,level)

data=imread(goal);
data=double(data)/255;
datared2=data(:,:,1);
%datared2 = double(datared2)/255;
%[Creal,Sreal]=wavedec2(datared,level,wavelet);
[row,list]=size(datared2);
standard1=max(row,list);
new=zeros(standard1,standard1);
if row<=list
   new(1:row,:)=datared2;
else
   new(:,1:list)=datared2;
end   


%С���ֽ�,��ȡ��Ƶϵ��
[C,S]=wavedec2(new,level,wavelet);
CA=appcoef2(C,S,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
%[M,N]=size(CA);
%CAmin=min(min(CA));
%CAmax=max(max(CA));
%CA=(1/(CAmax-CAmin))*(CA-CAmin);
%d=max(size(CA));
%�Ե�Ƶ��ϵ����ֵ�ֽ�
[U,sigma,V]=svd(CA);

%ˮӡͼ����
%ˮӡͼ�������һ���Ҷ�ͼ��
W = imread(watermark);
W = double(W)/255;
W = gold(W,seed);
[row2,list2]=size(W);
standard2=max(row2,list2);
W_new=zeros(standard2,standard2);
if row2<=list2
   W_new(1:row2,:)=W;
else
   W_new(:,1:list2)=W;
end 

[W_C,W_S]=wavedec2(W_new,level,wavelet);
W_CA=appcoef2(W_C,W_S,wavelet,level);
%�Ե�Ƶϵ�����й�һ������
%[W_M,W_N]=size(W_CA);
%W_CAmin=min(min(W_CA));
%W_CAmax=max(max(W_CA));
%W_CA=(1/(W_CAmax-W_CAmin))*(W_CA-W_CAmin);
%d=max(size(W_CA));

[U_,sigma_,V_] = svd(W_CA);

CAextract = U * sigma_ * V;
%CAextract = (CAmax-CAmin)*CAextract+CAmin;%ϵ����ԭ����һ����ǰ�ķ�Χ

%��¼����ˮӡ�ĵ�Ƶϵ��
waterCA=CAextract;
%if row<=list
%   waterCA=waterCA(1:Sreal(1,1),:);
%else
%   waterCA=waterCA(:,1:Sreal(1,2));
%end  

%below0=find(CAextract<0);
%CAextract(below0)=0;

%�ع�
CA_tilda=reshape(CAextract,1,W_S(1,1)*W_S(1,2));
W_C(1,1:W_S(1,1)*W_S(1,2))=CA_tilda;
watermarkimage=waverec2(W_C,W_S,wavelet);
%��ǰ�油�ϵı�Եȥ��
if row<=list
  watermarkimage=watermarkimage(1:row,:);
else
   watermarkimage=watermarkimage(:,1:list);
end   


extract_result = ungold(abs(watermarkimage),seed);
imwrite(extract_result,'extraction.bmp');

extr = imread('extraction.bmp');
watermarking = imread(watermark);

mistake = abs(extr - watermarking);
total = sum(sum(watermarking));
mistake_total = sum(sum(mistake));
rates = mistake_total/total;
disp(rates);