function varargout = compression_gui(varargin)
% COMPRESSIONGUI MATLAB code for CompressionGUI.fig
%      COMPRESSIONGUI, by itself, creates a new COMPRESSIONGUI or raises the existing
%      singleton*.
%
%      H = COMPRESSIONGUI returns the handle to a new COMPRESSIONGUI or the handle to
%      the existing singleton*.
%
%      COMPRESSIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPRESSIONGUI.M with the given input arguments.
%
%      COMPRESSIONGUI('Property','Value',...) creates a new COMPRESSIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompressionGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompressionGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompressionGUI

% Last Modified by GUIDE v2.5 03-Dec-2013 15:27:46

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompressionGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CompressionGUI_OutputFcn, ...
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


% --- Executes just before CompressionGUI is made visible.
function CompressionGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompressionGUI (see VARARGIN)

% Choose default command line output for CompressionGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CompressionGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axes(handles.axes1);
axes(handles.axes2);
set(handles.axes1, 'Visible', 'off')
set(handles.axes2, 'Visible', 'off')

% --- Outputs from this function are returned to the command line.
function varargout = CompressionGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
v = get(hObject,'Value')
if (v==2)
    axes(handles.axes1);
    [fname, pname] = uigetfile('*.*');
    filename = strcat(pname,fname);
    image = imread(filename);
    imshow(image, 'Parent', handles.axes1);
    compressed_name = sprintf('%s-compressed.rle',filename);
    compress(image, 0, compressed_name);
    disp('Done')
    set(handles.axes1, 'Visible', 'on')
    set(gca,'xtick',[],'ytick',[])
elseif (v==3)
    axes(handles.axes1);
    [fname, pname] = uigetfile('*.*');
    threshold = inputdlg('Enter an integer');
    threshold = str2num(char(threshold));
    %threshold = str2num(inpt);  
    filename = strcat(pname,fname);
    image = imread(filename);
    imshow(filename, 'Parent', handles.axes1);
    compressed_name = sprintf('%s-compressed.rle',filename);
    compress(image, threshold, compressed_name);
    set(handles.axes1, 'Visible', 'on')
    set(gca,'xtick',[],'ytick',[])
end
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
v = get(hObject,'Value')
if (v==2)
    axes(handles.axes2);
    [fname, pname] = uigetfile('*.*');
    strng2 = strcat(pname,fname)
    image = decompress_image(strng2)
    imshow(image, 'Parent', handles.axes2);
    set(handles.axes2, 'Visible', 'on')
    set(gca,'xtick',[],'ytick',[])
    filename = sprintf('%s-decompressed.png',strng2);
    imwrite(image,filename);
end
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
