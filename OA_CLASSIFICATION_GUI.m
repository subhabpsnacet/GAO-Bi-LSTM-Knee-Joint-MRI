function varargout = OA_CLASSIFICATION_GUI(varargin)
% OA_CLASSIFICATION_GUI M-file for OA_CLASSIFICATION_GUI.fig
%      OA_CLASSIFICATION_GUI, by itself, creates a new OA_CLASSIFICATION_GUI or raises the existing
%      singleton*.
%
%      H = OA_CLASSIFICATION_GUI returns the handle to a new OA_CLASSIFICATION_GUI or the handle to
%      the existing singleton*.
%
%      OA_CLASSIFICATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OA_CLASSIFICATION_GUI.M with the given input arguments.
%
%      OA_CLASSIFICATION_GUI('Property','Value',...) creates a new OA_CLASSIFICATION_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OA_CLASSIFICATION_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OA_CLASSIFICATION_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OA_CLASSIFICATION_GUI

% Last Modified by GUIDE v2.5 16-Feb-2017 23:44:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OA_CLASSIFICATION_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OA_CLASSIFICATION_GUI_OutputFcn, ...
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


% --- Executes just before OA_CLASSIFICATION_GUI is made visible.
function OA_CLASSIFICATION_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OA_CLASSIFICATION_GUI (see VARARGIN)

% Choose default command line output for OA_CLASSIFICATION_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OA_CLASSIFICATION_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.hSrcImage, 'XTick',[],'YTick',[],'XTickLabel',[], 'YTickLabel',[],'XGrid','off','YGrid','off','xcolor',get(handles.hSrcImage,'color'),'ycolor',get(handles.hSrcImage,'color'));
set(handles.axes22, 'XTick',[],'YTick',[],'XTickLabel',[], 'YTickLabel',[],'XGrid','off','YGrid','off','xcolor',get(handles.hSrcImage,'color'),'ycolor',get(handles.axes22,'color'));
set(handles.axes23, 'XTick',[],'YTick',[],'XTickLabel',[], 'YTickLabel',[],'XGrid','off','YGrid','off','xcolor',get(handles.hSrcImage,'color'),'ycolor',get(handles.axes23,'color'));
set(handles.axes25, 'XTick',[],'YTick',[],'XTickLabel',[], 'YTickLabel',[],'XGrid','off','YGrid','off','xcolor',get(handles.hSrcImage,'color'),'ycolor',get(handles.axes25,'color'));

addpath('./CWT')
addpath('./CNN_Toolbox')

% --- Outputs from this function are returned to the command line.
function varargout = OA_CLASSIFICATION_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global hiddenImage
varargout{1} = hiddenImage;


% --- Executes on button press in hKneeImage.
function hKneeImage_Callback(hObject, eventdata, handles)
% hObject    handle to hKneeImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg testKneeImg_ORG
[fileTest pathTest] = uigetfile({'*.png';'*.jpg';'*.*'},'Please select an Test Knee X-Ray Image');
if fileTest==0
    warndlg('Select Input Image');
else
    testKneeImg = imread([pathTest fileTest]);
    if(size(testKneeImg,3)>1)
        testKneeImg = rgb2gray(testKneeImg);
    end
    axes(handles.hSrcImage);
    imshow(testKneeImg);
    testKneeImg_ORG = testKneeImg;
    testKneeImg = imresize(testKneeImg, [256 256]);  

end



% --- Executes on button press in hExtractFeatures.
function hExtractFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to hExtractFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg FeatVectTestImage

[FeatVectTestImage glcmFeat] = GetFeatures(testKneeImg);
glcmFeatT = [glcmFeat.contr glcmFeat.corrm glcmFeat.energ glcmFeat.homom];
set(handles.uitable1, 'Data', glcmFeatT');

% --- Executes on button press in hMorphology.
function hMorphology_Callback(hObject, eventdata, handles)
% hObject    handle to hMorphology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FeatVectTestImage testKneeImg

load anfisStructBenignTumorMalignantTumor.mat

C1 = evalfis(norm(FeatVectTestImage(:)),out_fis);
if((C1/100)<1)
    disp('Benign Knee');
else
    disp('Malignant Knee');
    [row col nch] = size(testKneeImg);
    if(nch>1)
        testKneeImgGray = rgb2gray(testKneeImg);
        R = testKneeImg(:,:,1);
        G = testKneeImg(:,:,2);
        B = testKneeImg(:,:,3);
    else
        testKneeImgGray = testKneeImg;
        R = testKneeImg;
        G = testKneeImg;
        B = testKneeImg;
    end
    
    tumorRegion = testKneeImgGray>200;
    figure(3),
    subplot(2,2,1)
    imshow(tumorRegion,[]);
    title('Thresholded Binary Image');
    tumorRegion = bwareaopen(tumorRegion, 100);
    figure(3),
    subplot(2,2,2)
    imshow(tumorRegion,[]);
    title('Noised removed Binary Image');
    tumorRegion = imdilate(edge(tumorRegion), strel('disk', 1));
    figure(3),
    subplot(2,2,3)
    imshow(tumorRegion,[]);
    title('Dilated Binary Image');
    
    R(find(tumorRegion~=0)) = 255;
    G(find(tumorRegion~=0)) = 255;
    B(find(tumorRegion~=0)) = 0;
    tumorOverlayImage(:,:,1) = R;
    tumorOverlayImage(:,:,2) = G;
    tumorOverlayImage(:,:,3) = B;
    figure(3),
    subplot(2,2,4)
    imshow(tumorOverlayImage,[]);
    title('Tumor Marked Image');
    
    fprintf('\nPerformence Analysis - Morphology Features:\n')
    [labelled nobjs] = bwlabel(imfill(tumorRegion, 'holes'));
    stats = regionprops(labelled,'Area','Centroid','BoundingBox','MajorAxisLength',...
        'MinorAxisLength','Eccentricity','Orientation','EquivDiameter','Solidity','Extent','Perimeter')
end
% --- Executes on button press in hEncrypt.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to hEncrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hAddNoise.
function hAddNoise_Callback(hObject, eventdata, handles)
% hObject    handle to hAddNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hDenoising.
function hDenoising_Callback(hObject, eventdata, handles)
% hObject    handle to hDenoising (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global testKneeImg denoiseImageSEPD
noiseImage = testKneeImg;
denoiseImageSEPD = SEPD(noiseImage);
axes(handles.hDenoisedImage);
imshow(denoiseImageSEPD);


% --- Executes on button press in hClassification.
function hClassification_Callback(hObject, eventdata, handles)
% hObject    handle to hClassification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg FeatVectTestImage
load OA_CNN_model.mat

[cnn, convFeatMaps] = ffcnn(cnn, imresize(testKneeImg,[128 128]));
[a, C]=max(cnn.layers{cnn.no_of_layers}.outputs, [],1);
disp(C)
if(C == 1)
    set(handles.editType,'String','Osteo Arthritis');    
else
    set(handles.editType,'String','Normal');    
end




function editStage_Callback(hObject, eventdata, handles)
% hObject    handle to editStage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editStage as text
%        str2double(get(hObject,'String')) returns contents of editStage as a double


% --- Executes during object creation, after setting all properties.
function editStage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editStage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hCWT.
function hComplexWavelet_Callback(hObject, eventdata, handles)
% hObject    handle to hCWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg testKneeImgRot fusedKneeramImg
J = 1; % number of decomposition levels
[Faf,Fsf] = FSfarras; % first stage filters
[af,sf] = dualfilt1;  % second stage filters

% image decomposition
w1 = cplxdual2D(double(coverImage),J,Faf,af);
D1_1=w1{1}{1}{1}{1};
D1_2=w1{1}{1}{1}{2};
D1_3=w1{1}{1}{1}{3};
D1_4=w1{1}{1}{2}{1};
D1_5=w1{1}{1}{2}{2};
D1_6=w1{1}{1}{2}{3};
D1_7=w1{1}{2}{1}{1};
D1_8=w1{1}{2}{1}{2};
D1_9=w1{1}{2}{1}{3};
D1_10=w1{1}{2}{2}{1};
D1_11=w1{1}{2}{2}{2};
D1_12=w1{1}{2}{2}{3};
cwtCoverImg = [D1_1 D1_2 D1_3 D1_4;
    D1_5 D1_6 D1_7 D1_8;
    D1_9 D1_10 D1_11 D1_12];
axes(handles.axes23), imshow(cwtCoverImg,[]);

% --- Executes on button press in hGabor.
function hGabor_Callback(hObject, eventdata, handles)
% hObject    handle to hGabor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg
% Gabor Parameter spefications
t = 4;
l = 8;
f = 1/t;
sx = t / (2*(sqrt(2*log(2))));
sy = l*sx;

k = 0:179;
theta = -pi/2 + ((pi*k)/180);

gaboutAll = cell(length(f), length(theta));
% Gabor wavelet decomposition
for r = 1:length(f)
    for t = 1:length(theta)
        [G,gabout] = gaborfilter(testKneeImg,4,4,f(r),theta(t));
        gaboutAll{r, t} = gabout;
    end
end
        
% Estimating magnitude and orientation field of gabor decomposed image
[row col nch] = size(testKneeImg);
Kmax = zeros(size(testKneeImg));
orientField = zeros(size(Kmax));
for p = 1: row
    for q = 1: col
        cnt = 1;
        for r = 1:length(f)
            for t = 1: length(theta)
                temp(cnt) = gaboutAll{r, t}(p, q);
                cnt = cnt+1;
            end
        end
        [maxV ind] = max(temp);
        Kmax(p, q) = maxV;
        orientField(p, q) = ind;
    end
end

axes(handles.axes25);
imshow(Kmax,[]);


% --- Executes on button press in hCWT.
function hCWT_Callback(hObject, eventdata, handles)
% hObject    handle to hCWT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg 

J = 1; % number of decomposition levels
[Faf,Fsf] = FSfarras; % first stage filters
[af,sf] = dualfilt1;  % second stage filters

% image decomposition
w1 = cplxdual2D(double(testKneeImg),J,Faf,af);
D1_1=w1{1}{1}{1}{1};
D1_2=w1{1}{1}{1}{2};
D1_3=w1{1}{1}{1}{3};
D1_4=w1{1}{1}{2}{1};
D1_5=w1{1}{1}{2}{2};
D1_6=w1{1}{1}{2}{3};
D1_7=w1{1}{2}{1}{1};
D1_8=w1{1}{2}{1}{2};
D1_9=w1{1}{2}{1}{3};
D1_10=w1{1}{2}{2}{1};
D1_11=w1{1}{2}{2}{2};
D1_12=w1{1}{2}{2}{3};
cwtImg = [D1_1 D1_2 D1_3 D1_4;
    D1_5 D1_6 D1_7 D1_8;
    D1_9 D1_10 D1_11 D1_12];
axes(handles.axes23), imagesc(uint8(cwtImg),[min(min(cwtImg)) max(max(cwtImg))]);


% --- Executes on button press in hEnhance.
function hEnhance_Callback(hObject, eventdata, handles)
% hObject    handle to hEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testKneeImg testKneeImg_ORG
EnhancedImg = adapthisteq((testKneeImg));
axes(handles.axes22);
imshow(imresize(EnhancedImg, [size(testKneeImg_ORG,1) size(testKneeImg_ORG,2)]));
