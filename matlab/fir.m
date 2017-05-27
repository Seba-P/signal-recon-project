% N = 500;
% Fs = 44100;  % Sample rate
% Fp = 4410;    % Passband frequency in Hz
% Fst = 4910; % Stopband frequency in Hz
% Ap = 1;      % Passband ripple in dB
% Ast = 60;    % Stopband attenuation in dB
% 
% % Design the filter
% df = designfilt('lowpassfir','PassbandFrequency',Fp,...
%                 'StopbandFrequency',Fst,'PassbandRipple',Ap,...
%                 'StopbandAttenuation',Ast,'SampleRate',Fs);
% 
% % Analyze the filter response
% hfvt = fvtool(df,'Fs',Fs,'FrequencyScale','log',...
%   'FrequencyRange','Specify freq. vector','FrequencyVector',F);

K   = 95;           % FIR filter order
Fp  = 100e3;        % 100 kHz passband-edge frequency
Fs  = 1000e3;       % 1 MHz sampling frequency
Rp  = 0.00057565;   % Corresponds to 0.01 dB peak-to-peak ripple
Rst = 0.001;        % Corresponds to 60 dB stopband attenuation

fir_resp = firceqrip(K,Fp/(Fs/2),[Rp Rst],'passedge');
fvtool(fir_resp,'Fs',Fs,'Color','White')                % Visualize filter
