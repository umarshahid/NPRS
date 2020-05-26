function [A,bw]  = project(img)
a=imread(img);
%a=medfilt2(a);
imshow(a);
title('CROP ROI','Color','r')
 a=imcrop;
% a=rgb2gray(a);
level=graythresh(a);
bw=im2bw(a,level);

bw=imcomplement(bw);
%figure , imshow(bw);
se = strel('rectangle',[2,3]);        
bw = imerode(bw,se);
%bw = imfill(bw,'holes');
%figure , imshow(bw);
[L,n]=bwlabel(bw,8);
%[r, c]=size(X);
count=0;
A=zeros(1,400);
for i=1:n
[r,c]=find(L==i);
h=find(L==i);
if length(h)<700
    continue
end
count=count+1;
toprow=min(r);
bottomRow=max(r);
leftColumn=min(c);
rightColumn=max(c);
I=bw(toprow-5:bottomRow+5,leftColumn-5:rightColumn+5);

I2=imresize (I,[20,20]);
% figure,imshow(I2);
A(count,:)=I2(:)';

end
A=A';
% load('digits_100.mat')
% load('ex3data1.mat')
% yo=zeros(5000:10);
% st=1;
% ed=500;
% for n=1:10
% yo(st:ed,n,:)=1;
% st=st+500;
% ed=ed+500;
% end
% 
% %X=X';
% %yo=yo';
% inputs=X;
% targets=yo;
% hiddenLayerSize = 10;
% net = patternnet(hiddenLayerSize);
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% 
% [net,tr] = train(net,inputs,targets);
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs)
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(errors)
% simpleclassOutputs = sim(net,inputs);
% plotconfusion(targets,simpleclassOutputs);

