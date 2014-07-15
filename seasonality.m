function varargout = seasonality(varargin)
% SEASONALITY MATLAB code for seasonality.fig
%      SEASONALITY, by itself, creates a new SEASONALITY or raises the existing
%      singleton*.
%
%      H = SEASONALITY returns the handle to a new SEASONALITY or the handle to
%      the existing singleton*.
%
%      SEASONALITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEASONALITY.M with the given input arguments.
%
%      SEASONALITY('Property','Value',...) creates a new SEASONALITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before seasonality_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to seasonality_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help seasonality

% Last Modified by GUIDE v2.5 14-Jul-2014 16:15:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @seasonality_OpeningFcn, ...
                   'gui_OutputFcn',  @seasonality_OutputFcn, ...
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


% --- Executes just before seasonality is made visible.
function seasonality_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to seasonality (see VARARGIN)

% Choose default command line output for seasonality
handles.output = hObject;

handles.rho = 0.7;
handles.c = 0;
handles.sigma = 0.1;

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)



% --- Outputs from this function are returned to the command line.
function varargout = seasonality_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Set c
function slider1_Callback(hObject, eventdata, handles)

handles.c = get(hObject,'Value');

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)

function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% Set rho
function slider2_Callback(hObject, eventdata, handles)
handles.rho = get(hObject,'Value');

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% Set sigma
function slider3_Callback(hObject, eventdata, handles)
handles.sigma = get(hObject,'Value');

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function [] = f_graph_plotter_void(handles,hObject)
    T = 1000;

    e = randn(T,1);
    x = zeros(T,1);

    % Start at the series' average
    xbar = handles.c/(1-handles.rho);
    x(1) = xbar;

    % Now form the AR(1) series
    for t = 1:T-1
       x(t+1) = handles.c + handles.rho*x(t) + handles.sigma*e(t+1);
    end
    y = x.^2;
    plot(y)
    ylim([0 10])
    
function [] = f_parameter_update_void(handles,hObject)
    set(handles.text4,'String',num2str(handles.c))
    set(handles.text5,'String',num2str(handles.rho))
    set(handles.text6,'String',num2str(handles.sigma))
    set(handles.slider1,'Value',handles.c)
    set(handles.slider2,'Value',handles.rho)
    set(handles.slider3,'Value',handles.sigma)

   
function [] = f_sim_runner_void(handles,hObject)
    f_graph_plotter_void(handles,hObject)
    f_parameter_update_void(handles,hObject)
    
    
    

        
        
