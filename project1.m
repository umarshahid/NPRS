function [A,bw]  = project1(img)
%  a=imread(img);
a=img;
%a=medfilt2(a);
imshow(a);
%%%%%%%%%%%%%%%%%%%%%%%  CROP ROI  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
title('CROPPED ROI','Color','r')
 %a=imcrop;
 plateImage = img;
% plateImage = imread(img);
eccentricityThreshold = 0.995;
boxes = helperDetectText(plateImage,'TextPolarity','DarkTextOnLight',...
    'MaxEccentricity', eccentricityThreshold, 'SizeRange', [200,5000]);
% figure; imshow(plateImage); title('License plates'); hold on
for i=1:size(boxes,1)
    rectangle('Position', boxes(i,:),'EdgeColor','r')
    a=imcrop(plateImage, boxes(i,:)+[-10 -10 20 20]);
% imshow(a);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Image Processing %%%%%%%%%%%%%%%%%%%%%%%%
% a=rgb2gray(a);
level=graythresh(a);
bw=im2bw(a,level);

bw=imcomplement(bw);
%figure , imshow(bw);
% se = strel('rectangle',[2,3]);        
% bw = imerode(bw,se);
%bw = imfill(bw,'holes');
%figure , imshow(bw);
[L,n]=bwlabel(bw,8);
%[r, c]=size(X);
st = regionprops(bw, 'BoundingBox' );
count=0;
A=zeros(1,400);
for i=1:n
[r,c]=find(L==i);
h=find(L==i);
if length(h)<700
    continue
end
count=count+1;
% toprow=min(r);
% bottomRow=max(r);
% leftColumn=min(c);
% rightColumn=max(c);
% I=bw(toprow-5:bottomRow+5,leftColumn-5:rightColumn+5);
I = imcrop(bw ,[st(i).BoundingBox]+[-5 -5 10 10]);
I2=imresize (I,[20,20]);
% figure,imshow(I2);
A(count,:)=I2(:)';

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% CREATING DATA SET OF LABEL %%%%%%%%%%%%%%%%%%
A=A';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%