function result= Originalmage_Region_Decide(im,CordinatesLu,CordinatesRd,linewidth)
times=size(CordinatesLu,2);
im=im2double(im);
%8±¶Æµ
CordinatesLu=8*CordinatesLu;
CordinatesRd=8*CordinatesRd;
if numel(size(im))==3
    R=im(:,:,1);
    G=im(:,:,2);
    B=im(:,:,3);
    for i=1:times
        R(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i):CordinatesLu(2,i)+linewidth)=1;
        R(CordinatesLu(1,i):CordinatesLu(1,i)+linewidth,CordinatesLu(2,i):CordinatesRd(2,i))=1;
        R(CordinatesRd(1,i)-linewidth:CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
        R(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i)-linewidth:CordinatesRd(2,i))=1;
        G(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i):CordinatesLu(2,i)+linewidth)=0;
        G(CordinatesLu(1,i):CordinatesLu(1,i)+linewidth,CordinatesLu(2,i):CordinatesRd(2,i))=0;
        G(CordinatesRd(1,i)-linewidth:CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=0;
        G(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i)-linewidth:CordinatesRd(2,i))=0;
         B(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i):CordinatesLu(2,i)+linewidth)=0;
        B(CordinatesLu(1,i):CordinatesLu(1,i)+linewidth,CordinatesLu(2,i):CordinatesRd(2,i))=0;
        B(CordinatesRd(1,i)-linewidth:CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=0;
        B(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i)-linewidth:CordinatesRd(2,i))=0;
    end
    result=cat(3,R,G,B);
else
     for i=1:times
        im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesLu(2,i):CordinatesLu(2,i)+linewidth)=1;
        im(CordinatesLu(1,i):CordinatesLu(1,i)+linewidth,CordinatesLu(2,i):CordinatesRd(2,i))=1;
        im(CordinatesRd(1,i)-linewidth:CordinatesRd(1,i),CordinatesLu(2,i):CordinatesRd(2,i))=1;
        im(CordinatesLu(1,i):CordinatesRd(1,i),CordinatesRd(2,i)-linewidth:CordinatesRd(2,i))=1;
     end
    result=im;
end
end

