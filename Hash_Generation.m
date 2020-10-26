function output= Hash_Generation(image,direction)
%该函数通过DWT，CANNY算子，来生成哈希序列，注意，生成的哈希序列是没有转成行向量的
%blocksize一般为偶数
%以便于检测篡改位置。

%先对图像进行一下预处理
if numel(size(image))==3
    image=RGB2HSI(image);
    image=image(:,:,3);
%     image=rgb2gray(image);
end

%对图像进行小波变换
[LL,LH,HL,HH]=dwt2(image,'haar');

%对小波变换结果用Canny算子提取边缘
switch direction
    case 'Transverse'
        output=edge(LH,'prewitt');
    case 'Lengthway'
        output=edge(HL,'prewitt');
    case 'Diagonal'
        output=edge(HH,'prewitt');
end


