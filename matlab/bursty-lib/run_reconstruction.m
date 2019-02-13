clear all;

% ============================== Parameters ===============================
REGULARIZATION__ = 1;
QUANTIZATION__ = 1;
% upsampling
kResolution = 200;
kLambda = 2;

% sinc/dirichlet
kRecKernel = 'sinc';
kGenKernel = 'sinc';
% randomspectrum/bursty
kSignalType = 'bursty';%bursty/mitbih

% burst parameters
kBurstNum = 4;
kBurstComponents = 5;
kBurstSpread = 2;
kAveragerLen = 40;
kBaselineAmp = 2;

% MITBIH parameters
kSignalNumber = 2;
kLength = 1e3;
kBegin = 1;
kUps = 50;

% STATISTICAL__/single signal simulation 
STATISTICAL__ = 0;

if STATISTICAL__ == 1
    % number of repetitions
    R = 1e3;
    % level distance
    DD = [.2 .1 .05];
    % observation period
    N = 100;
    % algorithm parameters
    kGuessAlg       = {'Piecewise constant', ... %
                       'Piecewise linear'};%, ...%
                       %'Warped BL', ... %
                       %'Smooth, warped BL'};
    kRecoveryAlg    = {'guess', ...%
                       'I-POCS', ...%
                       'OS-POCS'}; %
    kParam = {0, [5, 10, 50], [1e-2, 1e-3, 1e-4]};
    
    kRecoveryAlg    = {'I-POCS'}; %
    kParam = {100};
else
    % number of repetitions
    R = 1;
    % level distance
    DD = .1;
    % observation period
    N = 100;%100;
    % seed for random generator (set to [] to generate seed)
    % seed = 866;%artyku�-127; 935; oscylacje-913,22
    seed = [];
    seed = 938; % 266, 297, 16, 866, 562
    % 300@.1 -> 100 pr�bek
    
    % algorithm parameters
    %kGuessAlg       = {'Piecewise linear'}; kGuessAlgDesc       = {'$\lambda_\Omega(t)$ (guess)'};
    kGuessAlg       = {'Piecewise constant'}; kGuessAlgDesc       = {'$\theta^\pm_\Omega(t)$ (guess)'};
    kRecoveryAlg    = {'guess', ...%
                       'I-POCS', ...%
                       'OS-POCS', 'Shannon1', 'Shannon2'}; %
                   
    
    
    kRecoveryAlgDesc    = {'guess', ...%
                       '$\hat{x}(t)$, I-POCS', ...%
                       '$\hat{x}(t)$, OS-POCS'}; %
    kParam = {NaN, 10, 1e-3, NaN, NaN};
end


%% ========================== Signal generation =========================== 

% kernel type (sinc/dirichlet)

if strcmp(kRecKernel, 'dirichlet')
    kernelr = @(t,N)dirichlet(t, N);
elseif strcmp(kRecKernel, 'sinc')
    kernelr = @(t,N)sinc(t);
end

if strcmp(kGenKernel, 'dirichlet')
    kernelg = @(t,N)dirichlet(t, N);
elseif strcmp(kGenKernel, 'sinc')
    kernelg = @(t,N)sinc(t);
end

Dlen = length(DD);
Glen = length(kGuessAlg);
Alen = length(kRecoveryAlg);
Plen = 3;
E = zeros(R, Dlen, Glen, Alen, Plen);
Nsamp = zeros(R, Dlen);

t = 1/kResolution:1/kResolution:N;

kernel = @(t)kernelr(t,N);

if STATISTICAL__
    seed = 1;
    Eiter = zeros(max(kParam{1})+1, R, Dlen, Glen);
elseif isempty(seed)
    seed = round(1000*rem(cputime, 1))
end

randn('state', seed);
rand('state', seed);

textprogressbar('Simulation...');
fprintf('\n');
tic
for iR = 1:R

    % generate signal
    if strcmp(kSignalType, 'bursty') 
        x = generateRandomBursty(t, kernelg, N, kBurstNum, ...
                                 kBurstComponents, kBurstSpread, ...
                                 kBaselineAmp, kAveragerLen);                      
        x = fftbandlimit(x, N);
    elseif strcmp(kSignalType, 'mitbih')
        load mitbih.mat; 
        range = kBegin:(kBegin+kLength-1);
        x = Signals{kSignalNumber}.x(range);
        t1 = Signals{kSignalNumber}.t(range);
        x = x-mean(x);
        fs = Signals{kSignalNumber}.fs;

        fstop = 0.22;
        stopw = 0.05;
        h = firls(200, [0 fstop-stopw fstop+stopw 1], [1 1 0 0]);
        t2 = linspace(t1(1), t1(end), kLength*kUps);
        x = interp1(t1, filterc(h, x), t2, 'pchip')';
    end                
    x = x./max(abs(x));
    
    for iD = 1:Dlen
        D = DD(iD);

        % Level-crossing sampling
        [xn, tn, n, qx, lx, ux, lvl] = samplingLC(x, t, D, QUANTIZATION__);
        Nsamp(iR,iD) = length(xn);
        
        ns = round(linspace(1,length(t), Nsamp(iR,iD)));
        ts = t(ns);
        xs = x(ns);
        
        U = Nsamp(iR,iD)/N;
        
        % Initial guess
        for iG = 1:Glen
            if strcmp(kGuessAlg{iG}, 'Zero')
                g = qx*0; 
            elseif strcmp(kGuessAlg{iG}, 'Piecewise constant')
                g = qx; 
            elseif strcmp(kGuessAlg{iG}, 'Piecewise linear')
                g = reconstructLinear(xn, tn, ux, lx, n, t); 
            elseif strcmp(kGuessAlg{iG}, 'Warped BL')
                g = reconstructWarpedShannon(xn, tn, ux, lx, n, t, 'piecewise');
            elseif strcmp(kGuessAlg{iG}, 'Smooth, warped BL')
                g = reconstructWarpedShannon(xn, tn, ux, lx, n, t, 'smooth');
            end
            % filtering initial guess signal 
            g_bl = fftbandlimit(g, N);
            
            % Reconstructions
            Y = zeros(length(x), Alen);
            for iA = 1:Alen
                for iP = 1:length(kParam{iA})
                    if strcmp(kRecoveryAlg{iA}, 'guess')
                        Y(:,iA,iP) = g_bl;
                    elseif strcmp(kRecoveryAlg{iA}, 'OS-POCS')
                        % One-step POCS
                        gn_bl = g_bl(n);
                        Y(:,iA,iP) = reconstructMMSE(xn-gn_bl, tn, t, kernel, REGULARIZATION__, kParam{iA}(iP))+g_bl;
                    elseif strcmp(kRecoveryAlg{iA}, 'I-POCS')
                        % Iterative POCS    
                        if kParam{iA}(iP) == max(kParam{iA})
                            [Y(:,iA,iP), YY] = reconstructMPOCS(g_bl, lx, ux, N, kParam{iA}(iP), kLambda);
                        else
                            Y(:,iA,iP) = reconstructMPOCS(g_bl, lx, ux, N, kParam{iA}(iP), kLambda);
                        end
                    elseif strcmp(kRecoveryAlg{iA}, 'Shannon1')
                        % original bandwidth
                        Y(:,iA,iP) = sinc(tsh(ts, t))*xs;
                    elseif strcmp(kRecoveryAlg{iA}, 'Shannon2')
                        % sampling rate bandwidth
                        Y(:,iA,iP) = sinc(tsh(ts, t)*U)*xs;
                    end
                    E(iR,iD,iG,iA,iP) = sqrt(mean((x-Y(:,iA,iP)).^2)/mean(x.^2));
                    if strcmp(kRecoveryAlg{iA}, 'I-POCS') && kParam{iA}(iP) == max(kParam{iA})
                        
                        Eiter(:,iR,iD,iG) = sqrt(mean((x*ones(1, max(kParam{iA})+1)-YY).^2, 1)'./mean(x.^2));
                    end
                    if ~STATISTICAL__
                        fprintf('Error %.4f%%, ',     100*E(iR,iD,iG,iA,iP));
                        fprintf('algorithm %s, ',   kRecoveryAlg{iA});
                        fprintf('param=%f, ',       kParam{iA}(iP));
                        fprintf('guess "%s", ',     kGuessAlg{iG});
                        fprintf('delta=%f.\n',      DD(iD));
                    end
                end
            end % Alg loop
        end % initial guess loop
    end % delta loop
    textprogressbar(ceil(100*iR/R));
end % R loop
textprogressbar('');
toc
    
%% ============================ Visualisations ============================
figure(1);
if STATISTICAL__
    plot_statistical;  
else
    plot_nonstatistical;
    title(sprintf('%.0f%% Nyquist rate; error: %.4f%% of total energy', ...
        100*[length(tn)/N, E(1,1,1,3,1)]));
    %ylim([0.0 0.2]);
    %xlim([0,50]);
end


