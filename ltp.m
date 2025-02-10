function [ltpImg1 ltpImg2] = ltp(img)

[row col] = size(img);
ltpImg1 = zeros(size(img));
ltpImg2 = zeros(size(img));

t = 5;

H = [8 4 2;
    16 0 1;
    32 64 128];


for r= 2:row-1
    for c = 2:col-1
        
        W = img(r-1:r+1, c-1:c+1);
        %W = W>=W(2,2);
        gc = W(2,2);
        
        t1 = gc+t;
        t2 = gc-t;
        
        B = zeros(size(W));
        
        for p = 1:3
            for q = 1:3
                if(p==2 && q==2)
                    continue;
                else
                    if(W(p,q)>=t1)
                        B(p,q) = 1;
                    else
                        if(W(p,q)<=t2)
                            B(p,q) = -1;
                        end
                    end
                end
            end
        end
    
    
        B1 = B;
        B1(find(B1==-1)) = 0;   
        
        B2 = B;
        B2(find(B1==1)) = 0;   
        B2 = B2*-1;
        
        
        decV1 = sum(sum(H.*B1));
        decV2 = sum(sum(H.*B2));
        
        
        ltpImg1(r,c) = decV1;
        ltpImg2(r,c) = decV2;
        
    end
end

        