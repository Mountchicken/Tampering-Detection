function result=PointRemove(Bimage)
%�ú���ͨ������ԭͼ��ȥ��������
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

