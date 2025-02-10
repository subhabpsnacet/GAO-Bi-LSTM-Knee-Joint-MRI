function [mif1 mif2] = getMomentInvariantFeatures(I)

%Moment Invariant Based Features

I = double(I);
blksz = 3;
newsz = (blksz - 1)/2;
[row col] = size(I);
rown = row+(2*newsz);
coln = col+(2*newsz);
B = zeros([rown coln]);
B(newsz+1:rown-newsz,newsz+1:coln-newsz) = I(1:end,1:end);

mif1 = zeros(size(I));
mif2 = mif1;

[X,Y] = meshgrid(1:blksz,1:blksz);
H = fspecial('gaussian', [17 17], 1.7);
h = waitbar(0, 'Computing Moment Invariant Features......');

s = 1;
for r = newsz+1:rown-newsz
    t = 1;
    for c = newsz+1:coln-newsz

        W = B(r-newsz:r+newsz, c-newsz:c+newsz);
        W = conv2(W, H,'same');

        m00 = sum(sum(W.*(X.^0).*(Y.^0)));

        m10 = sum(sum(W.*(X.^0).*(Y.^1)));
        m01 = sum(sum(W.*(X.^1).*(Y.^0)));

        centgrav_i = m10/m00;
        centgrav_j = m01/m00;

        % compute centre of moment of order
        cm00 = sum(sum(W.*((X-centgrav_i).^0).*((Y-centgrav_j).^0)));
        cm11 = sum(sum(W.*((X-centgrav_i).^1).*((Y-centgrav_j).^1)));
        cm02 = sum(sum(W.*((X-centgrav_i).^2).*((Y-centgrav_j).^0)));
        cm20 = sum(sum(W.*((X-centgrav_i).^0).*((Y-centgrav_j).^2)));

        % Compute normalised centre of moment
        ncm11 = cm11 / (cm00^((1+1)/2 + 1));
        ncm02 = cm02 / (cm00^((0+2)/2 + 1));
        ncm20 = cm20 / (cm00^((2+0)/2 + 1));

        % Compute Hu Moment Invariants
        hmi1 = ncm20 + ncm02;
        hmi2 = (ncm20 + ncm02)^2 + 4 * (ncm11^2);

        mif1(s, t) = abs(log(hmi1));
        mif2(s, t) = abs(log(hmi2));

        t = t+1;

    end
    s = s+1;
    waitbar(r/(rown-newsz));
end

close(h);

