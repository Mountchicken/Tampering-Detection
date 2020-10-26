function S= Similarity(Hash1,Hash2,m)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

Hash1=Hash1(:);
Hash2=Hash2(:);
R=ones(size(Hash1));
for i=1:numel(Hash1)
    R(i)=exp(min(Hash1(i),Hash2(i)))/exp(max(Hash1(i),Hash2(i)));
end
R=sort(R);
S=prod(R(1:m))/prod(R(numel(R)-m+1:end));
end

