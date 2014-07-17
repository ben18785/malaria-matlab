function varargout = gui_patches(varargin)
% GUI_PATCHES MATLAB code for gui_patches.fig
%      GUI_PATCHES, by itself, creates a new GUI_PATCHES or raises the existing
%      singleton*.
%
%      H = GUI_PATCHES returns the handle to a new GUI_PATCHES or the handle to
%      the existing singleton*.
%
%      GUI_PATCHES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PATCHES.M with the given input arguments.
%
%      GUI_PATCHES('Property','Value',...) creates a new GUI_PATCHES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_patches_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_patches_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_patches

% Last Modified by GUIDE v2.5 15-Jul-2014 15:16:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_patches_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_patches_OutputFcn, ...
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


% --- Executes just before gui_patches is made visible.
function gui_patches_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_patches (see VARARGIN)

% Choose default command line output for gui_patches
handles.output = hObject;

handles.c_T = 100;
handles.c_chi = 0.2;
handles.c_eta = 0.5;
handles.c_sigma = 0.05;
handles.c_P0 = 225;


% Update handles structure
guidata(hObject, handles);


f_sim_runner_void(handles,hObject)



% --- Outputs from this function are returned to the command line.
function varargout = gui_patches_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% set chi
function slider1_Callback(hObject, eventdata, handles)
handles.c_chi = get(hObject,'Value');

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% Set eta
function slider2_Callback(hObject, eventdata, handles)
handles.c_eta = get(hObject,'Value');

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


% Set initial patches
function slider4_Callback(hObject, eventdata, handles)
handles.c_P0 = get(hObject,'Value');

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% Set sigma
function slider3_Callback(hObject, eventdata, handles)
handles.c_sigma = get(hObject,'Value');

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


% Set time
function slider5_Callback(hObject, eventdata, handles)
handles.c_T = round(get(hObject,'Value'));

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function [] = f_sim_runner_void(handles,hObject)
    f_graph_plotter_void(handles,hObject)
    f_parameter_update_void(handles,hObject)


function [] = f_graph_plotter_void(handles,hObject)
    
    c_N = 5000;
    c_theta_mean = 0.0001;
    c_U = 1500;
    c_area = c_U^2;
    
    % First generate the path of theta - for example the weather
    v_theta = c_area*c_theta_mean*f_series_ornstein_v(handles.c_T,c_N,handles.c_chi,handles.c_eta);
    c_dt = handles.c_T/c_N;
    v_t = 0:c_dt:handles.c_T-c_dt;

    % Parameters for the simulation of patches
    
    c_Nmax = 100;
    
    v_P = zeros(c_Nmax,1);
    v_P(1) = handles.c_P0;

    % While the count is less than the maximum number of iterations, increment
    % the time exponentially
    t = 0;
    k = 1;
    v_time = zeros(c_Nmax,1);

    while t < handles.c_T

        % Get the values of the series to dictate the time increment
        c_theta = interp1(v_t,v_theta,t);
        c_P = v_P(k);

        % Increment the time according to Gillespie
        c_r = rand();
        dt = (1/(handles.c_sigma*(c_theta+c_P)))*log(1/c_r);
        t = t + dt;

        % Now calculate the new level of patches
        v_P(k+1) = v_P(k) + handles.c_sigma*(c_theta - v_P(k));
        v_time(k+1) = t;

        k = k + 1;

    end
    v_P = remove_zeros(v_P);
    v_time = remove_zeros(v_time);
    v_time = [0;v_time];

    axes(handles.axes1)
    plot(v_time,v_P,'b--','LineWidth',3)
    hold on
    plot(v_t,v_theta,'m','LineWidth',2)
    hold off
    xlabel('Time')
    legend('Patches','Rainfall')
    xlim([0 handles.c_T])
    
    
    % Now linearly interpolate v_P to get values at time series
    % corresponding to times for v_theta
    v_P_small = interp1(v_time,v_P,v_t);
    
    axes(handles.axes2)
    scatter(v_theta,v_P_small,'x')
    xlabel('Rainfall')
    ylabel('Patches')
    h = lsline;
    set(h,'LineWidth',4,'color','r')


function [] = f_parameter_update_void(handles,hObject)
    handles = guidata(hObject);
    
    set(handles.slider1,'Value',handles.c_chi)
    set(handles.slider2,'Value',handles.c_eta)
    set(handles.slider5,'Value',handles.c_T)
    set(handles.slider3,'Value',handles.c_sigma)
    set(handles.slider4,'Value',handles.c_P0)
    set(handles.text2,'String',num2str(handles.c_chi))
    set(handles.text3,'String',num2str(handles.c_eta))
    set(handles.text6,'String',num2str(handles.c_T))
    set(handles.text4,'String',num2str(handles.c_sigma))
    set(handles.text5,'String',num2str(handles.c_P0))
