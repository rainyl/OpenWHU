function [ S,P_value ] = kafang2( image)
% �������ܣ��ȶ�ͼ����Ƕ����Ϊrate����˳��LSBǶ�룬Ȼ����п�����д����
% ���������input��ԭʼͼ��rate��Ƕ���ʣ�ȡֵ��[0,1]
% ���������S��ſ���ͳ��ֵ��P�����Ӧ��pֵ�����۲�ֵ�����ֵ���Ƴ̶ȵĸ���
% �������ӣ�[ S,P_value ] = kafang( 'livingroom.tif',0.5 )
%��һ��ͼ��

ste_cover=image; 
[m,n]=size(ste_cover); 

for i = 1 : 1 : m
    for j = 1 : 1 : n
        if ste_cover(i, j) < 0
            ste_cover(i, j) = 256 + ste_cover(i, j);
        end
    end
end

 %��ste_coverת��Ϊuint8���ͣ�ʹ��imhist������������
 ste_cover=uint8( ste_cover);
 
 S=[];
 P_value=[];
 
 %��ͼ��5%�ķָһ���ֳ�20��
 interval=n/10;
 for j=0:9
    h=imhist(ste_cover(:,floor(j* interval)+1:floor((j+1)* interval)));
    h(1) = 0;
    h(2) = 0;
    h_length=size(h);
    p_num=floor(h_length/2);   
    Spov=0; %��¼����ͳ����
    K=0;
    for i=1:p_num
        if(h(2*i-1)+h(2*i))~=0
            Spov=Spov+(h(2*i-1)-h(2*i))^2/(2*(h(2*i-1)+h(2*i))); 
            K=K+1;
        end
    end
    %SpovΪ����ͳ������K-1Ϊ���ɶ�
    P=1-chi2cdf(Spov,K-1);   
    
    if j~=0
      Spov=Spov+S(j); %����ע����Ϊ�ۼƿ���ͳ���� 
    end
    
    S=[S Spov];
    P_value=[ P_value P];
 end

%��ʾ�仯���ߣ�x_label�Ǻ����꣬�����������ռ����ͼ��İٷֱ�
x_label=0.1:0.1:1;
figure,
plot(x_label,P_value,'LineWidth',2),title('pֵ�����ͼ������ر�����ϵ');
xlabel('����ͼ������ر���');
ylabel('pֵ');
ylim([0, 1])

