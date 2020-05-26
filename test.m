function [v , bw] = test(net , img)
[A,bw]=project1(img);
outputs = net(A);
[~ , i]=max(outputs);

j=[];
k=[];
for n=1:length(i)
    
    if i(n)==1
        k=[k '0'];
    elseif i(n)==2
        k=[k '1'];
    
    elseif i(n)==3
        k=[k '2'];
    
    elseif i(n)==4
        k=[k '3'];
    
    elseif i(n)==5
        k=[k '4'];
   
    elseif i(n)==6
        k=[k '5'];
    
    elseif i(n)==7
        k=[k '6'];
    
    elseif i(n)==8
        k=[k '7'];
    
    elseif i(n)==9
        k=[k '8'];
    
    elseif i(n)==10
        k=[k '9'];
 
    elseif i(n)==11
        j=[j 'A'];
    
    elseif i(n)==12
        j=[j 'B'];
    
    elseif i(n)==13
        j=[j 'C'];
    
    elseif i(n)==14
        j=[j 'D'];
   
    elseif i(n)==15
        j=[j 'E'];
    
    elseif i(n)==16
        j=[j 'F'];
    
    elseif i(n)==17
        j=[j 'G'];
    
    elseif i(n)==18
        j=[j 'H'];
    
    elseif i(n)==19
        j=[j 'I'];
    
    elseif i(n)==20
        j=[j 'J'];
    
    elseif i(n)==21
        j=[j 'K'];
    
    elseif i(n)==22
        j= [j 'L'];
    
    elseif i(n)==23
        j=[j 'M'];
    
    elseif i(n)==24
        j=[j 'N'];
    
    elseif i(n)==25
        j=[j 'O'];
    
    elseif i(n)==26
        j=[j 'P'];
    
    elseif i(n)==27
        j=[j 'Q'];
    
    elseif i(n)==28
        j=[j 'R'];
    
    elseif i(n)==29
        j=[j 'S'];
    
    elseif i(n)==30
        j=[j 'T'];
    
    elseif i(n)==31
        j=[j 'U'];
    
    elseif i(n)==32
        j=[j 'V'];
    
    elseif i(n)==33
        j=[j 'W'];
    elseif i(n)==34
        j=[j 'X'];
    
    elseif i(n)==35
        j=[j 'Y'];
    
    elseif i(n)==36
        j=[j 'Z'];
%     else
%         j=[j i-1];
    end
end
v=[j ' ' k];


% xlswrite(fn,cellstr(v));
 
% fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
%     fprintf(fid,'%s\n',v);      % to the text file, if executed a notepad file with the
%     fclose(fid);                      % name noPlate.txt will be open with the number plate written.
%     winopen('noPlate.txt')