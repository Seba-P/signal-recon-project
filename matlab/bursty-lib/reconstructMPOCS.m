function [y varargout] = reconstructMPOCS(y, lx, ux, N, M, lambda)
% Reconstruction of bounded signal using projection onto convex sets
% y        - initial estimate
% lx       - signal lower bound
% ux       - signal upper bound
% N        - length of signal (bandwidth = 0.5Hz)
% M        - number of iterations
% lambda   - relaxation parameter (0..2)

if nargout > 1
    yy = y;
end;

for i = 1:M
    % projection onto the space of functions bounded by a levels
    Py = max(y, lx);
    Py = min(Py, ux);
    % projection onto the space of bandlimited functions
    Py = fftbandlimit(Py, N); 
    y = lambda*Py+(1-lambda)*y;
    if nargout > 1
        yy = [yy y];
    end;
end;    
if nargout > 1
    varargout{1} = yy;
end;
