function [gf1 gf2 gf3 gf4 gf5] = getGrayLevelFeatures(I)
% Gray level Descriptors

I = double(I);

blksz = 3;
newsz = (blksz - 1)/2;
[row col] = size(I);
rown = row+(2*newsz);
coln = col+(2*newsz);
B = zeros([rown coln]);
B(newsz+1:rown-newsz,newsz+1:coln-newsz) = I(1:end,1:end);

gf1 = zeros(size(I));
gf2 = gf1;
gf3 = gf1;
gf4 = gf1;
gf5 = gf1;

h = waitbar(0, 'Computing Gray Level Features......');

s = 1;
for r = newsz+1:rown-newsz
    t = 1;
    for c = newsz+1:coln-newsz
      
        W = B(r-newsz:r+newsz, c-newsz:c+newsz);

        gf1(s,t) = I(s,t) - min(W(:));
        gf2(s,t) = max(W(:)) - I(s,t);
        gf3(s,t) = abs(I(s,t) - mean2(W));
        gf4(s,t) = std(W(:));
        gf5(s,t) = I(s,t);
        t = t+1;

    end
    s = s+1;
    waitbar(r/(rown-newsz));
end

close(h);
