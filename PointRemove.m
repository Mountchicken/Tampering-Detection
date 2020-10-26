function result=PointRemove(Bimage)
%该函数通过遍历原图像，去除孤立点
[row,col]=size(Bimage);
for i=2:row-1
    for j=2:col-1
        if Bimage(i-1,j)==1 || Bimage(i+1,j)==1 || Bimage(i,j+1)==1 || Bimage(i,j-1)==1 || Bimage(i+1,j+1)==1 || Bimage(i+1,j-1)==1 || Bimage(i-1,j+1)==1 || Bimage(i-1,j-1)==1
           continue
        else
            Bimage(i,j)=0;
        end
    end
end
result=Bimage;
end

