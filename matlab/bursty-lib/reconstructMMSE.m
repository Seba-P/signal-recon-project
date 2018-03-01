function y = reconstructMMSE(xn, tn, t, kernel, reg, eps)
    SS = kernel(tsh(tn,tn));
    if reg == 1
        if eps > 0
            c = (SS+eps*eye(length(tn)))\xn;
        else
            c = pinv(SS)*xn;
        end;
    else
        c = SS\xn;
    end;
    y = kernel(tsh(tn,t))*c;
    
            