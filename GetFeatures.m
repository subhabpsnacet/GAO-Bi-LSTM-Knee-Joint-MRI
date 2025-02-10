function [mamFeat glcmFeat_feat] = GetFeatures(I)
warning off;

[row col nch] = size(I);
if(nch>1)
    I = rgb2gray(I);
end
I = imresize(I,[256 256]);
[row col nch] = size(I);

% Local Trinary Pattern
[ltpImg1 ltpImg2] = ltp(I);
ltpImages{1,1} = ltpImg1;
ltpImages{1,2} = ltpImg2;
h = waitbar(0, 'Computing gray level Features......');
%gray level features
I = double(I);
blksz = 9;
newsz = (blksz - 1)/2;
[row col] = size(I);
rown = row+(2*newsz);
coln = col+(2*newsz);
B = zeros([rown coln]);
B(newsz+1:rown-newsz,newsz+1:coln-newsz) = I(1:end,1:end);
f1 = zeros(size(I));
f2 = f1;
f3 = f1;
f4 = f1;
f5 = f1;
s = 1;
for r = newsz+1:rown-newsz
    t = 1;
    for c = newsz+1:coln-newsz
        W = B(r-newsz:r+newsz, c-newsz:c+newsz);
        f1(s,t) = I(s,t) - min(W(:));
        f2(s,t) = max(W(:)) - I(s,t);
        f3(s,t) = abs(I(s,t) - mean2(W));
        f4(s,t) = std(W(:));
        f5(s,t) = I(s,t);
        t = t+1;
    end
    s = s+1;
    waitbar(r/(rown-newsz));
end
close(h);
% Wavelet Features
[LL1 LH1 HL1 HH1] = dwt2(I,'db4','mode','per');
waveFeat = [sum(LH1.^2) sum(HL1.^2) sum(HH1.^2)];
[LL2 LH2 HL2 HH2] = dwt2(LL1,'db4','mode','per');
[LL3 LH3 HL3 HH3] = dwt2(LL2,'db4','mode','per');
glcmFeat = GLCM_Features(double(I));
glcmFeat_feat = glcmFeat;
LL2 = [LL3 LH3;HL3 HH3];
LL1 = [LL2 LH2;HL2 HH2];
recI = [LL1 LH1;HL1 HH1];

LL2(1:size(LL3,1),1:size(LL3,2)) = LL3(:,:);
sprintf('GLCM Features\n')
glcmFeat
glcmFeat = cell2mat(struct2cell(glcmFeat));
% Laws Texture Energy Features
[egy1 egy2] = LawsTextureMeasures(I);
mamFeat = [waveFeat';glcmFeat;egy1;egy2];
[mif1 mif2] = getMomentInvariantFeatures(I);
retImgs = {ltpImg1,ltpImg2,recI};


