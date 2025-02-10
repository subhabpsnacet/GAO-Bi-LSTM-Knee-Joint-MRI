function [egy1 egy2] = LawsTextureMeasures(I)
warning off;


% Law's 1D filter kernels
L5  =  [  1   4   6   4   1  ];
E5  =  [ -1  -2   0   2   1  ];
S5  =  [ -1   0   2   0  -1  ];
W5  =  [ -1   2   0  -2   1  ];
R5  =  [  1  -4   6  -4   1  ];

temp = {L5, E5, S5, W5, R5};

L5L5 = zeros(length(L5));
E5L5 = L5L5; S5L5 = L5L5;  W5L5 = L5L5;  R5L5 = L5L5;
L5E5 = L5L5; E5E5 = L5L5;  S5E5 = L5L5;  W5E5 = L5L5;  R5E5 = L5L5;
L5S5 = L5L5;  E5S5 = L5L5;  S5S5 = L5L5;  W5S5 = L5L5;  R5S5 = L5L5;
L5W5 = L5L5;  E5W5 = L5L5;  S5W5 = L5L5;  W5W5 = L5L5;  R5W5 = L5L5;
L5R5 = L5L5;  E5R5 = L5L5;  S5R5 = L5L5;  W5R5 = L5L5;  R5R5 = L5L5;

% Converting 1D kernels into 2D filter kernels
lawKernels = cell(5);
for r = 1:5
    K1 = temp{r};
    K1 = K1';
    for c = 1:5
        K2 = temp{c};
        M = zeros(5);
        for m = 1:5
            C = conv(K1(m), K2);
            M(m,:) = C;
        end
        lawKernels{r,c} = M;
    end
end

% Filtering the input mammogram image with Law's 25 2D kernels and
% computing energy features
TEM = cell(5);
for p = 1:5
    for q = 1:5
        K = lawKernels{p,q};
        J = conv2(I, K,'same');

        % Fetaure Extraction

        blksz = 15;
        newsz = (blksz - 1)/2;
        [row col] = size(J);
        rown = row+(2*newsz);
        coln = col+(2*newsz);
        B = zeros([rown coln]);
        B(newsz+1:rown-newsz,newsz+1:coln-newsz) = J(1:end,1:end);

        fI = zeros(size(J));

        h = waitbar(0, 'Computing Features......');

        s = 1;
        for r = newsz+1:rown-newsz
            t = 1;
            for c = newsz+1:coln-newsz
                W = B(r-newsz:r+newsz, c-newsz:c+newsz);
                if(sum(W(:))~=0)
                    fI(s,t) = sum(abs(W(:)));
                end
                t = t+1;
            end
            s = s+1;
            waitbar(r/(rown-newsz));
        end
        TEM{p,q} = fI;
        close(h);
    end
end

M1 = TEM{1,1};
M2 = TEM{1,2};

egy1 = sum(sum(M1.^2));
egy2 = sum(sum(M2.^2));

% fprintf('Laws Texture Features:\n')
% fprintf('Mean : %f\nSTD : %f\nSkewness : %f\nKurtosis: %f\nEntrophy: %f\n', mean2(M1), std2(M1), skewness(skewness(M1)), kurtosis(kurtosis(M1)), entropy(M1))
% % figure(2), imshow(TEM{1,1},[]);
% title('Laws energy image image 1');

% figure(3), imshow(TEM{1,2},[]);
% title('Laws energy image image 2');
