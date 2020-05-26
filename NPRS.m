function varargout = NPRS(varargin)
% NPRS MATLAB code for NPRS.fig
%      NPRS, by itself, creates a new NPRS or raises the existing
%      singleton*.
%
%      H = NPRS returns the handle to a new NPRS or the handle to
%      the existing singleton*.
%
%      NPRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NPRS.M with the given input arguments.
%
%      NPRS('Property','Value',...) creates a new NPRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NPRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NPRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NPRS

% Last Modified by GUIDE v2.5 14-Jul-2018 17:23:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NPRS_OpeningFcn, ...
                   'gui_OutputFcn',  @NPRS_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before NPRS is made visible.
function NPRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NPRS (see VARARGIN)
pc=imread('logo2.png');
axes(handles.axes7);
imshow(pc);
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
% axes(handles.vidBox);
% vid = videoinput('winvideo');
% vidRes = get(vid, 'VideoResolution');
% nBands = get(vid, 'NumberOfBands');
% hImage = image( zeros(vidRes(2),vidRes(1) , nBands),'parent',  handles.vidBox );
% % Display the video data in your GUI.
% preview(vid, hImage);
% handles.obj=hImage;
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose default command line output for NPRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NPRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NPRS_OutputFcn(hObject, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% %  wcam=webcamlist;
% %  if(size(wcam)~=0)
% %      cam=webcam;
% %      handles.Mycam=cam;
% %      preview(handles.Mycam);
% %  else
% %      msgbox('Camera Not Found! Give Image Path.');
% %  end
% %  handles.camList=wcam;
% Get default command line output from handles structure
varargout{1} = handles.output;
guidata(hObject, handles);


function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% net= AdvNet();
load('net.mat');
handles.myNet=net;
% nntraintool close
guidata(hObject, handles);

% --- Executes on button press in btnTest.
function btnTest_Callback(hObject, eventdata, handles)
% hObject    handle to btnTest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lblOutput,'string',' ');
set(handles.lblText,'string',' ');
% img=get(handles.txtPic,'string');
% [v , bw]=test(handles.myNet , img);
[v , bw]=test(handles.myNet , handles.myImg);
axes(handles.axes6);
imshow(bw);
title('BW IMAGE')
set(handles.lblOutput,'string',v);
fn='NPdata.xlsx';
[n, t, r]=xlsread(fn);
p=0;
for i=1:length(t)
    x=strcmp(v,t(:,1));
    if(x(i,:)==1)
        
        p=p+1;
        
    end
end
if ~(p==0)
    set(handles.lblText,'string','Authorized');
else
    set(handles.lblText,'string','Unauthorized');
end
handles.myOtpt=v;
guidata(hObject, handles);

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=handles.myOtpt;
fn='NPdata.xlsx';
[n, t, r]=xlsread(fn);
p=0;
for i=1:length(t)
    x=strcmp(v,t(:,1));
    if(x(i,:)==1)
        
        p=p+1;
        
    end
end
if ~(p==0)
    msgbox('Recoard already exist and Not Saved!');
else
    xlsappend(fn,cellstr(handles.myOtpt),1);
msgbox('Recoard Saved!');
end



% --- Executes during object creation, after setting all properties.



function txtPic_Callback(hObject, eventdata, handles)
% hObject    handle to txtPic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPic as text
%        str2double(get(hObject,'String')) returns contents of txtPic as a double


% --- Executes during object creation, after setting all properties.
function txtPic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.lblOutput,'string',' ');
set(handles.lblText,'string',' ');
% % if(size(handles.camList)~=0)
% %     pic=snapshot(handles.Mycam);
% % else
    img=get(handles.txtPic,'string');
    pic=imread(img);
% % end
%  pic=getimage(handles.obj);
% 
axes(handles.picBox);
imshow(pic);
title('LOADED IMAGE')
handles.myImg=pic;
guidata(hObject, handles);



% --- Executes on button press in btnHelp.
function btnHelp_Callback(hObject, eventdata, handles)
% hObject    handle to btnHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('Help.pdf')
%% ================= PROJECT1.M ======================%%
function [A,bw]  = project1(img)
a=img;
imshow(a);
%%%%%%%%%%%%%  CROP ROI  %%%%%%%%%%%%%
title('CROPPED ROI','Color','r')
plateImage = img;
eccentricityThreshold = 0.995;
boxes = helperDetectText(plateImage,'TextPolarity','DarkTextOnLight',...
    'MaxEccentricity', eccentricityThreshold, 'SizeRange', [200,5000]);
for i=1:size(boxes,1)
    rectangle('Position', boxes(i,:),'EdgeColor','r')
    a=imcrop(plateImage, boxes(i,:)+[-10 -10 20 20]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Image Processing %%%%%%%%%%%%
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
st = regionprops(bw, 'BoundingBox' );
count=0;
A=zeros(1,400);
for i=1:n
h=find(L==i);
if length(h)<700
    continue
end
count=count+1;
I = imcrop(bw ,[st(i).BoundingBox]+[-5 -5 10 10]);
I2=imresize (I,[20,20]);
A(count,:)=I2(:)';

end
%%%%% CREATING DATA SET OF LABEL %%%%%
A=A';

%% ===================== TEST.M ======================%%
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
    end
end
v=[j ' ' k];
