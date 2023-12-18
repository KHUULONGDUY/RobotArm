function varargout = UI_ROBOT(varargin)
% UI_ROBOT MATLAB code for UI_ROBOT.fig
%      UI_ROBOT, by itself, creates a new UI_ROBOT or raises the existing
%      singleton*.
%
%      H = UI_ROBOT returns the handle to a new UI_ROBOT or the handle to
%      the existing singleton*.
%
%      UI_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI_ROBOT.M with the given input arguments.
%
%      UI_ROBOT('Property','Value',...) creates a new UI_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_ROBOT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_ROBOT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI_ROBOT

% Last Modified by GUIDE v2.5 09-Dec-2023 10:33:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_ROBOT_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_ROBOT_OutputFcn, ...
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


% --- Executes just before UI_ROBOT is made visible.
function UI_ROBOT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI_ROBOT (see VARARGIN)

% Choose default command line output for UI_ROBOT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global arduino;
arduino = serialport("COM5",9600);

% handles.arduino = serialport('COM5',9600);

% UIWAIT makes UI_ROBOT wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = UI_ROBOT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Y_pos_Callback(hObject, eventdata, handles)
% hObject    handle to Y_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_pos as text
%        str2double(get(hObject,'String')) returns contents of Y_pos as a double


% --- Executes during object creation, after setting all properties.
function Y_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Z_pos_Callback(hObject, eventdata, handles)
% hObject    handle to Z_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_pos as text
%        str2double(get(hObject,'String')) returns contents of Z_pos as a double


% --- Executes during object creation, after setting all properties.
function Z_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function X_pos_Callback(hObject, eventdata, handles)
% hObject    handle to X_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_pos as text
%        str2double(get(hObject,'String')) returns contents of X_pos as a double


% --- Executes during object creation, after setting all properties.
function X_pos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Execute.
function Execute_Callback(hObject, eventdata, handles)
% hObject    handle to Execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function Axis1_Callback(hObject, eventdata, handles)
% hObject    handle to Axis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global arduino;
data1 = get(handles.Axis1,'Value');
data2 = get(handles.Axis2,'Value');
data3 = get(handles.Axis3,'Value');
data1 = num2str(round(data1));
data2 = num2str(round(data2));
data3 = num2str(round(data3));
pos =" "+data1+","+data2+","+data3
disp(pos);
writeline(arduino,pos);


% --- Executes during object creation, after setting all properties.
function Axis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Axis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Axis2_Callback(hObject, eventdata, handles)
% hObject    handle to Axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global arduino;
data1 = get(handles.Axis1,'Value');
data2 = get(handles.Axis2,'Value');
data3 = get(handles.Axis3,'Value');
% disp(data1)
% disp(data2)
% disp(data3)

data1 = num2str(round(data1));
data2 = num2str(round(data2));
data3 = num2str(round(data3));
pos =" "+data1+","+data2+","+data3
disp(pos);
writeline(arduino,pos);

% --- Executes during object creation, after setting all properties.
function Axis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Axis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Axis3_Callback(hObject, eventdata, handles)
% hObject    handle to Axis3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global arduino;
data1 = get(handles.Axis1,'Value');
data2 = get(handles.Axis2,'Value');
data3 = get(handles.Axis3,'Value');
% disp(data1)
% disp(data2)
% disp(data3)

data1 = num2str(round(data1));
data2 = num2str(round(data2));
data3 = num2str(round(data3));
pos =" "+data1+","+data2+","+data3
disp(pos);
writeline(arduino,pos);


% --- Executes during object creation, after setting all properties.
function Axis3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Axis3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in AUTO.
function AUTO_Callback(hObject, eventdata, handles)
% hObject    handle to AUTO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"5");

% --- Executes on button press in HOME.
function HOME_Callback(hObject, eventdata, handles)
% hObject    handle to HOME (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"1");

% --- Executes on button press in END_EFFECTOR_ON.
function END_EFFECTOR_ON_Callback(hObject, eventdata, handles)
% hObject    handle to END_EFFECTOR_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"2");

% --- Executes on button press in TEACH.
function TEACH_Callback(hObject, eventdata, handles)
% hObject    handle to TEACH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"4");


% --- Executes on button press in END_EFFECTOR_OFF.
function END_EFFECTOR_OFF_Callback(hObject, eventdata, handles)
% hObject    handle to END_EFFECTOR_OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"3");


% --- Executes on button press in FORGET.
function FORGET_Callback(hObject, eventdata, handles)
% hObject    handle to FORGET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global arduino;
writeline(arduino,"6");
