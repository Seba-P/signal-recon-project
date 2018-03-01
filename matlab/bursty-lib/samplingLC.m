function [xn, tn, n, qx, lx, ux, lvl] = samplingLC(x, t, D, quantization)

    qx = x+D/2-mod(x+D/2, D);
    % lower bound
    lx = x-mod(x+D/2, D);
    % upper bound
    ux = x+D-mod(x+D/2, D);

    id = 1:length(t);
    n = id( abs(diff(qx)) > 1e-9 );
    
    % levels (for plotting)
    lvl = ([fliplr(-D/2:-D:min(x)) D/2:D:max(x)])'*ones(1, length(t));
    
    if quantization == 0
        xn = x(n);
        tn = t(n);
    else
        xn = (qx(n)+qx(n+1))/2;
        tn = (t(n)+t(n+1))/2;
    end;