function [x, xs, tb, tn] = generateRandomBursty(t, kernel, N, B, BN, Bspread, baselineAmp, Nav)
if mod(N, 2) == 1
    error('N should be even');
end

kernelg = @(t)kernel(t/2, N/2).^2;
kernels = @(t)kernel(t, N);

% generate random centroids of burst
tb = rand(1, B)*N;
% generate time instants around each centroid
tn = zeros(B, BN);
for iB = 1:B
    tn(iB,:) = tb(iB)+Bspread*randn(1, BN);
end
tn = mod(tn(:), N);
% generate random weights
w = randn(B*BN, 1);

% generate slowly varying component
%%{
b = baselineAmp*randn(1, N);
b = [b b b];
h = ones(1, Nav)/Nav;
h = conv(h, h);
b = conv(h, b);
b = b(end/2-N/2+1:end/2+N/2)';
ts = 1:N;
% generate signal
x = kernelg(tsh(tn, t))*w + kernelg(tsh(ts, t))*b;
xs = kernelg(tsh(tn, ts))*w + kernelg(tsh(ts, ts))*b;
%{
xslow1 = kernelg(tsh(ts, t))*b;

% generate signal
% C = 4;
% TC = N/C;
b = baselineAmp*randn(N, 1);
% ts = TC:TC:N;
xslow2 = 0.05*kernelg(tsh(ts, t)/9)*b;

figure(3);
plot(t, [xslow1, xslow2]);
%x = kernelg(tsh(tn, t))*w + kernels(tsh(ts, t/C))*b;
%xs = [];
%}
