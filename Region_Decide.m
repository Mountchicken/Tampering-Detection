function [CordinatesLu, CordinatesRd, result]=Region_Decide(im,threshold)
%������й�ͳ�ƺ��ͼ�񣬰���ֵ���֣�����䱻���ο�ѡ�е�����
im_bw=im2bw(im,0.00001);
[im_labeled, blocks]=bwlabel(im_bw);
CordinatesLu=zeros(2,blocks); %2*n��ʸ����ÿһ�ж���һ�����Ͻǵ�����,��Ϊ�У���Ϊ��
CordinatesRd=zeros(2,blocks); %2*n��ʸ����ÿһ�ж���һ�����½ǵ����꣬��Ϊ�У���λ��
LeftBlockNum=0;
for i=1:blocks
    [r ,c]=find(im_labeled==i);
    %�����ĸ�����
    up_row=min(r);
    down_row=max(r);
    left_col=min(c);
    right_col=max(c);
    temp_block=im(up_row:down_row,left_col:right_col);
    %�жϸÿ��Ƿ�Գƣ����ǣ�ȫ����0��
    if temp_block==flip(temp_block) | temp_block==flip(temp_block,2)
        im(up_row:down_row,left_col:right_col)=0;
        continue;
    end
    %�жϸÿ����ֵ�Ƿ������ֵ
    if max(temp_block(:))<=threshold
        im(up_row:down_row,left_col:right_col)=0;
        continue
    end
    LeftBlockNum=LeftBlockNum+1;
    CordinatesLu(1,LeftBlockNum)=up_row;
    CordinatesLu(2,LeftBlockNum)=left_col;
    CordinatesRd(1,LeftBlockNum)=down_row;
    CordinatesRd(2,LeftBlockNum)=right_col;
end
if LeftBlockNum~=blocks
    CordinatesLu(:,LeftBlockNum+1:end)=[];
    CordinatesRd(:,LeftBlockNum+1:end)=[];
end
%���������ж�����ͼ���ѡ�򣬼������������һ�����ο��ݶ�Ϊȫ��ɫ
for i=1:LeftBlockNum
    im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i))=1;
    im(CordinatesLu(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
    im(CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
    im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i))=1;
end
result=im;
end

