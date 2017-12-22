function varargout = Project5(varargin)
%PROJECT5 M-file for Project5.fig
%      PROJECT5, by itself, creates a new PROJECT5 or raises the existing
%      singleton*.
%
%      H = PROJECT5 returns the handle to a new PROJECT5 or the handle to
%      the existing singleton*.
%
%      PROJECT5('Property','Value',...) creates a new PROJECT5 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Project5_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PROJECT5('CALLBACK') and PROJECT5('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PROJECT5.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Project5

% Last Modified by GUIDE v2.5 26-Apr-2015 14:27:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Project5_OpeningFcn, ...
    'gui_OutputFcn',  @Project5_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
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


% --- Executes just before Project5 is made visible.
function Project5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Project5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project5_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function checkbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (get(handles.checkbox1,'Value') == get(handles.checkbox1,'Max'))
    set(handles.edit2,'Enable','off');
else
    set(handles.edit2,'Enable','on');
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=str2double(get(hObject,'String'));
if floor(sqrt(N))~=sqrt(N)
    set(handles.pushbutton3,'String','Must have square number of atoms')
    set(handles.pushbutton3,'Enable','off')
else
    set(handles.pushbutton3,'String','Plot')
    set(handles.pushbutton3,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
KEn=str2double(get(hObject,'String'));
if KEn<0
    set(handles.pushbutton3,'String','Kinetic Energy must be positive')
    set(handles.pushbutton3,'Enable','off')
elseif isnan(KEn) || ~isreal(KEn)
    set(handles.pushbutton3,'String','Kinetic Energy must be a number')
    set(handles.pushbutton3,'Enable','off')
else
    set(handles.pushbutton3,'String','Plot')
    set(handles.pushbutton3,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Gets initial values
N = str2double(get(handles.edit1,'String'));
KEn = str2double(get(handles.edit2,'String'));
T = str2double(get(handles.edit3,'String'));
if (get(handles.checkbox1,'Value') == get(handles.checkbox1,'Max'))
    KEn=0;
end

[tE,tKE,tPE,allxpos,allypos]= SimMotion(N,KEn,T,0.01);

% Draws graphs
for t=1:T
    time=1:t;
    cla(handles.axes3);
    axis(handles.axes3,[0 8 0 8])
    
%     for i=1:N
%         axes(handles.axes3);
%         rectangle('Curvature', [1 1],'Position',[allxpos(t,i),allypos(t,i),.1,.1]);
%     end
    
    % Comment above for loop and use scatter for faster speed
    scatter(handles.axes3,allxpos(t,:),allypos(t,:));
    drawnow;
    
    plot(handles.axes4,time,tE(1,1:t),time,tKE(1,1:t),time,tPE(1,1:t));
    axis(handles.axes4,[0 T -inf inf])
    drawnow
    
    if get(handles.pushbutton3,'Userdata') == 1
        cla(handles.axes4);
        axis(handles.axes4,[0 T -inf inf]);
        
        t1=t;
        set(handles.pushbutton3,'Userdata',0)
        
        for t=t1:T
            time=t1:t;
            
%             for i=1:N
%                 axes(handles.axes3);
%                 rectangle('Curvature', [1 1],'Position',[allxpos(t,i),allypos(t,i),.1,.1]);
%             end
            
            % Comment above for loop and use scatter for faster speed
            scatter(handles.axes3,allxpos(t,:),allypos(t,:));
            drawnow
            
            plot(handles.axes4,time,tE(1,t1:t),time,tKE(1,t1:t),time,tPE(1,t1:t));
            drawnow
        end
        break
    end
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton3,'Userdata',1)


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=str2double(get(handles.edit3,'String'));
if isnan(T) || ~isreal(T)
    set(handles.pushbutton3,'String','Incorrect Number of Time Steps')
    set(handles.pushbutton3,'Enable','off')
else
    set(handles.pushbutton3,'String','Plot')
    set(handles.pushbutton3,'Enable','on')
end
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
