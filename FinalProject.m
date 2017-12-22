function varargout = FinalProject(varargin)
% FINALPROJECT MATLAB code for FinalProject.fig
% By Nikhil Menon
%      FINALPROJECT, by itself, creates a new FINALPROJECT or raises the existing
%      singleton*.
%
%      H = FINALPROJECT returns the handle to a new FINALPROJECT or the handle to
%      the existing singleton*.
%
%      FINALPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALPROJECT.M with the given input arguments.
%
%      FINALPROJECT('Property','Value',...) creates a new FINALPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalProject

% Last Modified by GUIDE v2.5 10-May-2015 15:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FinalProject_OpeningFcn, ...
    'gui_OutputFcn',  @FinalProject_OutputFcn, ...
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


% --- Executes just before FinalProject is made visible.
function FinalProject_OpeningFcn(hObject,~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalProject (see VARARGIN)

% Choose default command line output for FinalProject
handles.output = hObject;

lc=154; % Bond length of a C-C bond

x=[0 0 lc*sqrt(8)/3*cos(pi/6) 2*lc*sqrt(8)/3*cos(pi/6) 2*lc*sqrt(8)/3*cos(pi/6) lc*sqrt(8)/3*cos(pi/6) 0];
y=[0 lc lc+lc*sqrt(8)/3*sin(pi/6) lc 0 -lc*sqrt(8)/3*sin(pi/6) 0];
z=[0 lc/3 0  lc/3 0 lc/3 0];
r=[70 70 70 70 70 70 70];
prec=35;
[posx,posy,posz]=ConstructMol(x,y,z,r,prec);

for i=1:6
    ti=prec*i;
    surf(posx((ti-(prec-1)):ti,:),posy((ti-(prec-1)):ti,:),posz((ti-(prec-1)):ti,:));
    map = [0 0 1];
    colormap(map);
    hold on
end

line(x,y,z,'LineWidth',6,'Color',[0 0 0]);
handles.xdata=posx;
handles.ydata=posy;
handles.zdata=posz;
handles.posdata=[x(1:6);y(1:6);z(1:6)];
handles.prec=prec;
handles.submat=repmat([1 1 0 0],6,1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalProject_OutputFcn(hObject, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function Test_Callback(hObject, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=str2double(get(handles.edit1,'String'));
molr=str2double(get(handles.edit3,'String'));
times=str2double(get(handles.edit4,'String'));

totalrate=[];
sub1=handles.sub1;
sub2=handles.sub2;

r=handles.r;
r=[r ones(6,1)*70];
pos=handles.posdata;

for t=1:times
    sucreac = SimtestMol(N,sub1,sub2,pos,r,molr);
    rate=sucreac/N * 100;
    totalrate=[totalrate rate];
end

avgrate=sum(totalrate)/length(totalrate);
s=strcat(num2str(avgrate),'%');
set(handles.edit2,'String',s);

guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function ShowMol_Callback(hObject, ~, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1);

submat=handles.submat;
x1=handles.posdata(1,:);
y1=handles.posdata(2,:);
z1=handles.posdata(3,:);
posx=handles.xdata;
posy=handles.ydata;
posz=handles.zdata;
prec=handles.prec;

% x1=[x1 0];
% y1=[y1 0];
% z1=[z1 0];
% Redraws the carbon ring
for i=1:6
    ti=prec*i;
    surf(posx((ti-(prec-1)):ti,:),posy((ti-(prec-1)):ti,:),posz((ti-(prec-1)):ti,:))
    map = [0 0 1];
    colormap(map);
    hold on
end
line([x1 0],[y1 0],[z1 0],'LineWidth',6,'Color',[0 0 0]);

l=zeros(6,2);
r=zeros(6,2);

% Assigns bond lengths and atomic radii
for n=1:6
    for m=1:2
        if submat(n,m) == 1
            l(n,m) = 109;
            r(n,m) = 53;
        elseif submat(n,m) == 2
            l(n,m) = 135;
            r(n,m) = 42;
        elseif submat(n,m) == 3
            l(n,m) = 177;
            r(n,m) = 79;
        elseif submat(n,m) == 4
            l(n,m) = 194;
            r(n,m) = 94;
        end
    end
end

% Coefficients for equatorial substituents
xcoeff=[-1 -1 0 1 1 0];
ycoeff=[-1 1 1/sin(pi/6) 1 -1 -1/sin(pi/6)];
zcoeff1=[1 -1 1 -1 1 -1];

% Coefficients for axial substituents
zcoeff2=-zcoeff1;

sub1x=zeros(1,6);
sub1y=zeros(1,6);
sub1z=zeros(1,6);
sub2x=zeros(1,6);
sub2y=zeros(1,6);
sub2z=zeros(1,6);

for n=1:6
    % Calculates positions for axial substituents
    sub1x(n)=x1(n);
    sub1y(n)=y1(n);
    sub1z(n)=z1(n)+zcoeff2(n)*l(n,1);
    [posx,posy,posz]=ConstructMol(sub1x(n),sub1y(n),sub1z(n),r(n,1),prec);
    
    if submat(n,3) == 1
        surf(posx,posy,posz,'FaceColor','g');
    else
        surf(posx,posy,posz,'FaceColor','b');
    end
    xdist=[sub1x(n),x1(n)];
    ydist=[sub1y(n),y1(n)];
    zdist=[sub1z(n),z1(n)];
    line(xdist,ydist,zdist,'LineWidth',6,'Color',[0 0 0]);
    
    % Calculates positions for equatorial substituents
    sub2x(n)=x1(n)+xcoeff(n)*l(n,2)*2*sqrt(2)/3*cos(pi/6);
    sub2y(n)=y1(n)+ycoeff(n)*l(n,2)*2*sqrt(2)/3*sin(pi/6);
    sub2z(n)=z1(n)+zcoeff1(n)*l(n,1)/3;
    [posx,posy,posz]=ConstructMol(sub2x(n),sub2y(n),sub2z(n),r(n,2),prec);
    
    if submat(n,4) == 1
        surf(posx,posy,posz,'FaceColor','g');
    else
        surf(posx,posy,posz,'FaceColor','b');
    end
    xdist=[sub2x(n),x1(n)];
    ydist=[sub2y(n),y1(n)];
    zdist=[sub2z(n),z1(n)];
    line(xdist,ydist,zdist,'LineWidth',6,'Color',[0 0 0]);
end
check1=submat(:,3)';
check2=submat(:,4)';
sub1=[sub1x;sub1y;sub1z;check1];
sub2=[sub2x;sub2y;sub2z;check2];
handles.sub1=sub1;
handles.sub2=sub2;
handles.r=r;
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function SetMol_Callback(hObject, ~, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
submat=handles.submat;
tmol=get(handles.popupmenu4,'Value');
sub1=get(handles.popupmenu5,'Value');
sub2=get(handles.popupmenu6,'Value');
checkval1=get(handles.checkbox1,'Value');
checkval2=get(handles.checkbox2,'Value');
submat(tmol,:)=[sub1 sub2 checkval1 checkval2];
handles.submat=submat;
guidata(hObject, handles);


function NumberMolecule_Callback(hObject, ~, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=str2double(get(hObject,'String'));
if N<0 || isnan(N) || ~isreal(N)
    set(handles.pushbutton1,'String','Incorrect number of molecules')
    set(handles.pushbutton1,'Enable','off')
else
    set(handles.pushbutton1,'String','Test')
    set(handles.pushbutton1,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


function MoleculeRadius_Callback(hObject, ~, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=str2double(get(hObject,'String'));
if N<0 || isnan(N) || ~isreal(N)
    set(handles.pushbutton1,'String','Incorrect molecular')
    set(handles.pushbutton1,'Enable','off')
else
    set(handles.pushbutton1,'String','Test')
    set(handles.pushbutton1,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


function TimeSim_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=str2double(get(hObject,'String'));
if N<0 || isnan(N) || ~isreal(N)
    set(handles.pushbutton1,'String','Incorrect time')
    set(handles.pushbutton1,'Enable','off')
else
    set(handles.pushbutton1,'String','Test')
    set(handles.pushbutton1,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
