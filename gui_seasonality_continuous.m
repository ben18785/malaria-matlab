function varargout = gui_seasonality_continuous(varargin)
% GUI_SEASONALITY_CONTINUOUS MATLAB code for gui_seasonality_continuous.fig
%      GUI_SEASONALITY_CONTINUOUS, by itself, creates a new GUI_SEASONALITY_CONTINUOUS or raises the existing
%      singleton*.
%
%      H = GUI_SEASONALITY_CONTINUOUS returns the handle to a new GUI_SEASONALITY_CONTINUOUS or the handle to
%      the existing singleton*.
%
%      GUI_SEASONALITY_CONTINUOUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SEASONALITY_CONTINUOUS.M with the given input arguments.
%
%      GUI_SEASONALITY_CONTINUOUS('Property','Value',...) creates a new GUI_SEASONALITY_CONTINUOUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_seasonality_continuous_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_seasonality_continuous_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_seasonality_continuous

% Last Modified by GUIDE v2.5 15-Jul-2014 11:55:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_seasonality_continuous_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_seasonality_continuous_OutputFcn, ...
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


% --- Executes just before gui_seasonality_continuous is made visible.
function gui_seasonality_continuous_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_seasonality_continuous (see VARARGIN)

% Choose default command line output for gui_seasonality_continuous
handles.output = hObject;

handles.theta = 0;
handles.sigma = 0;
handles.T = 1000;

handles.ybar = 0;
handles.yvar = 0;

% Update handles structure
guidata(hObject, handles);

f_sim_runner_void(handles,hObject)



% --- Outputs from this function are returned to the command line.
function varargout = gui_seasonality_continuous_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Set rho
function slider2_Callback(hObject, eventdata, handles)
handles.theta = get(hObject,'Value');

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

    T = handles.T; N = 5000; dt = T/N;
    P = zeros(1,N);
    P(1) = 1;
    X = zeros(1,N);
    mu = 0;
    
    for t = 1:N-1
        dW = sqrt(dt)*randn();
        X(t+1) = X(t) + handles.theta*(mu - X(t))*dt + handles.sigma*dW;
        P(t+1) = P(t) + (handles.theta*(mu - log(P(t))) + 0.5*(handles.sigma^2))*P(t)*dt + handles.sigma*P(t)*dW;
    end
    
    Z = exp(X);
    handles.ybar = mean(Z);
    
    
    c_renorm = 1/handles.ybar;
    Z = c_renorm*Z;
    handles.ybar = mean(Z);
    handles.yvar = std(Z)^2;
    
    axes(handles.axes1)
    plot([0:dt:T-dt],Z)
%     hold on
%     plot([0:dt:T-dt],P,'r')
%     hold off
    
    xlabel('Time')
    ylabel('Magnitude')
%     ylim([0 100])
    
    N = 10000;
    z = abs(fft(Z,N));
    axes(handles.axes2)
    z = z.^2;
    z = fftshift(z);
    f = [-N/2:(N/2)-1]/N;
    plot(log10(f(N/2:end)),log10(z(N/2:end)))
    xlabel('Log(Frequency)')
    ylabel('log(Magnitude)')
    
    
    % Update handles structure
    guidata(hObject, handles);
    
    
    
function [] = f_parameter_update_void(handles,hObject)
    handles = guidata(hObject);
    set(handles.slider2,'Value',handles.theta)
    set(handles.slider3,'Value',handles.sigma)
    set(handles.slider4,'Value',handles.T)
    set(handles.text5,'String',num2str(handles.ybar))
    set(handles.text23,'String',num2str(handles.theta))
    set(handles.text24,'String',num2str(handles.sigma))
    set(handles.text26,'String',num2str(handles.T))
    set(handles.text28,'String',num2str(handles.yvar))
   
function [] = f_sim_runner_void(handles,hObject)
    f_graph_plotter_void(handles,hObject)
    f_parameter_update_void(handles,hObject)
    
   


% Set time
function slider4_Callback(hObject, eventdata, handles)
handles.T= round(get(hObject,'Value'));

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
