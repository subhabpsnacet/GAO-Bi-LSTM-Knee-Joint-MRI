function [ltpImg] = lbp(img)

[row col] = size(img);
ltpImg = zeros(size(img));



H = [8 4 2;
    16 0 1;
    32 64 128];


for r= 2:row-1
    for c = 2:col-1
        
        W = img(r-1:r+1, c-1:c+1);
        gc = W(2,2);
        
        B = zeros(size(W));
        
        for p = 1:3
            for q = 1:3
                if(p==2 && q==2)
                    continue;
                else
                    if(W(p,q)>=gc)
                        B(p,q) = 1;
                    end
                end
            end
        end
    
    
        decV = sum(sum(H.*B));        
        ltpImg(r,c) = decV;        
    end
end

        