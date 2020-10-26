function [result]=Tampering_Detection(Prewitt1,Prewitt2,blocksize)
%输入两幅图像的Prewitt图，做差在计算处结果图
[M,N]=size(Prewitt1);
t1=ceil(2*M/blocksize-1);
t2=ceil(2*N/blocksize-1);

%将图像边缘进行扩充，以便能刚好扫描
if mod(2*M,blocksize)~=0
    Prewitt1=padarray(Prewitt1,[blocksize/2-mod(M,blocksize/2),0],0,'post');
    Prewitt2=padarray(Prewitt2,[blocksize/2-mod(M,blocksize/2),0],0,'post');
end
if mod(2*N,blocksize)~=0
    Prewitt1=padarray(Prewitt1,[0,blocksize/2-mod(N,blocksize/2)],0,'post');
    Prewitt2=padarray(Prewitt2,[0,blocksize/2-mod(N,blocksize/2)],0,'post');
end
final_Prewitt1=abs(Prewitt1-Prewitt2);
final_Prewitt2=PointRemove(final_Prewitt1); %去噪
final_Prewitt2=BarRemove(final_Prewitt2);
%提取哈希序列
temp_Prewitt=final_Prewitt2;
temp_hash=zeros(t1,t2);
for i=1:t1 %第j行
    for j=1:t2 %第z列
        temp_block=temp_Prewitt(blocksize/2*(i-1)+1:blocksize/2*(i-1)+blocksize,blocksize/2*(j-1)+1:blocksize/2*(j-1)+blocksize);
        temp_hash(i,j)=sum(temp_block(:))/(blocksize*blocksize);
    end
end
%接下来还要对矩阵进行加法
temp_hash=padarray(temp_hash,[1,1],'replicate');
final_temp=ones(size(temp_hash));
for i=2:t1
    for j=2:t2
        final_temp(i,j)=temp_hash(i,j)+temp_hash(i-1,j)+temp_hash(i+1,j)+temp_hash(i,j+1)+temp_hash(i,j-1);
    end
end
result=final_temp(2:end-1,2:end-1);
result(end,:)=[];
result(:,end)=[];

end

