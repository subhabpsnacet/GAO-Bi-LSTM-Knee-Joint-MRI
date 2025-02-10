clc;
clear all;
close all;
warning off;

%       GLCM Features (Soh, 1999; Haralick, 1973; Clausi 2002)
%           f1. Uniformity / Energy / Angular Second Moment (done)
%           f2. Entropy (done)
%           f3. Dissimilarity (done)
%           f4. Contrast / Inertia (done)
%           f5. Inverse difference    
%           f6. correlation
%           f7. Homogeneity / Inverse difference moment
%           f8. Autocorrelation
%           f9. Cluster Shade
%          f10. Cluster Prominence
%          f11. Maximum probability
%          f12. Sum of Squares
%          f13. Sum Average
%          f14. Sum Variance
%          f15. Sum Entropy
%          f16. Difference variance
%          f17. Difference entropy
%          f18. Information measures of correlation (1)
%          f19. Information measures of correlation (2)
%          f20. Maximal correlation coefficient
%          f21. Inverse difference normalized (INN)
%          f22. Inverse difference moment normalized (IDN)


I = imread('tn_im7b.jpeg');
I = rgb2gray(I);
figure(1), imshow(I);
title('Original Mammogram Image');

GLCM = graycomatrix(I,'Offset',[2 0;0 2]);
stats = GLCM_features(GLCM,0);
stats