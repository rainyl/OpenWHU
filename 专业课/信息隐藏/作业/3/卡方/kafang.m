function count = kafang(input)
ste_cover = imread(input);
count=imhist(ste_cover);
h_length=size(count);
p_num=floor(h_length/2);   
r=0; %��¼����ͳ����
K=0;
p_num = p_num-1;
for i=1:p_num
    if(count(2*i-1)+count(2*i))~=0
        r=r+(count(2*i-1)-count(2*i))^2/(2*(count(2*i-1)+count(2*i))); 
        K=K+1;
    end
end
    %rΪ����ͳ������K-1Ϊ���ɶ�
flag = chi2cdf(r,K-1);
P=1-flag;   
   
disp (P);

if P>0.8
    disp('ͼ������Ϣ����֮���');
else
    disp('ͼ������Ϣ����֮ǰ��');
end


end


