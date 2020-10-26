function [result]=Tampering_Detection(Prewitt1,Prewitt2,blocksize)
%��������ͼ���Prewittͼ�������ڼ��㴦���ͼ
[M,N]=size(Prewitt1);
t1=ceil(2*M/blocksize-1);
t2=ceil(2*N/blocksize-1);

%��ͼ���Ե�������䣬�Ա��ܸպ�ɨ��
if mod(2*M,blocksize)~=0
    Prewitt1=padarray(Prewitt1,[blocksize/2-mod(M,blocksize/2),0],0,'post');
    Prewitt2=padarray(Prewitt2,[blocksize/2-mod(M,blocksize/2),0],0,'post');
end
if mod(2*N,blocksize)~=0
    Prewitt1=padarray(Prewitt1,[0,blocksize/2-mod(N,blocksize/2)],0,'post');
    Prewitt2=padarray(Prewitt2,[0,blocksize/2-mod(N,blocksize/2)],0,'post');
end
final_Prewitt1=abs(Prewitt1-Prewitt2);
final_Prewitt2=PointRemove(final_Prewitt1); %ȥ��
final_Prewitt2=BarRemove(final_Prewitt2);
%��ȡ��ϣ����
temp_Prewitt=final_Prewitt2;
temp_hash=zeros(t1,t2);
for i=1:t1 %��j��
    for j=1:t2 %��z��
        temp_block=temp_Prewitt(blocksize/2*(i-1)+1:blocksize/2*(i-1)+blocksize,blocksize/2*(j-1)+1:blocksize/2*(j-1)+blocksize);
        temp_hash(i,j)=sum(temp_block(:))/(blocksize*blocksize);
    end
end
%��������Ҫ�Ծ�����мӷ�
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

