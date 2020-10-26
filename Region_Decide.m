function [CordinatesLu, CordinatesRd, result]=Region_Decide(im,threshold)
%输入进行过统计后的图像，按阈值划分，输出其被矩形框选中的区域
im_bw=im2bw(im,0.00001);
[im_labeled, blocks]=bwlabel(im_bw);
CordinatesLu=zeros(2,blocks); %2*n的矢量，每一列都是一个左上角的坐标,上为行，下为列
CordinatesRd=zeros(2,blocks); %2*n的矢量，每一列都是一个右下角的坐标，上为行，下位列
LeftBlockNum=0;
for i=1:blocks
    [r ,c]=find(im_labeled==i);
    %定义四个界限
    up_row=min(r);
    down_row=max(r);
    left_col=min(c);
    right_col=max(c);
    temp_block=im(up_row:down_row,left_col:right_col);
    %判断该块是否对称，若是，全部置0；
    if temp_block==flip(temp_block) | temp_block==flip(temp_block,2)
        im(up_row:down_row,left_col:right_col)=0;
        continue;
    end
    %判断该块最大值是否低于阈值
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
%接下来进行对输入图像的选框，即将坐标点练成一个矩形框，暂定为全白色
for i=1:LeftBlockNum
    im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i))=1;
    im(CordinatesLu(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
    im(CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
    im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i))=1;
end
result=im;
end

