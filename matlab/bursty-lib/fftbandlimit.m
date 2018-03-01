function y = fftbandlimit(x, N)

C = ceil(N/2)+1;
X = fft(x);
X(C:end-C+2) = 0;
y = real(ifft(X));
% semilogy(abs([Xin Xbl Xfilt]));
% pause;