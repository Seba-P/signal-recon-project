% clear all;

function [ x t lvl ] = generate_bursty_signal(seed = [])

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
            end % delta loop
        end % R loop
    toc

end