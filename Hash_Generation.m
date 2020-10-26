function output= Hash_Generation(image,direction)
%�ú���ͨ��DWT��CANNY���ӣ������ɹ�ϣ���У�ע�⣬���ɵĹ�ϣ������û��ת����������
%blocksizeһ��Ϊż��
%�Ա��ڼ��۸�λ�á�

%�ȶ�ͼ�����һ��Ԥ����
if numel(size(image))==3
    image=RGB2HSI(image);
    image=image(:,:,3);
%     image=rgb2gray(image);
end

%��ͼ�����С���任
[LL,LH,HL,HH]=dwt2(image,'haar');

%��С���任�����Canny������ȡ��Ե
switch direction
    case 'Transverse'
        output=edge(LH,'prewitt');
    case 'Lengthway'
        output=edge(HL,'prewitt');
    case 'Diagonal'
        output=edge(HH,'prewitt');
end


