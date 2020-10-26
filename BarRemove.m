function result= BarRemove(image)
%移除图像中的双连点区域
[row,col]=size(image);
pattern1=[ 1 1 1;1 0 1;1 0 1 ; 1 1 1];
pattern2=pattern1';
for i=2:row-2
    for j=2:col-2
        if image(i,j)==1
            temp=image(i-1:i+2,j-1:j+1);
            temp=xor(temp,pattern1);
            if sum(temp(:))==12
                image(i,j)=0; image(i+1,j)=0;
            end
            temp=image(i-1:i+1,j-1:j+2);
            temp=xor(temp,pattern2);
            if sum(temp(:))==12
                image(i,j)=0; image(i,j+1)=0;
            end
        end
    end
end
result=image;
end

