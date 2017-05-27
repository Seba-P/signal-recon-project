
%%%%%%%%%%%%%%%%%%%%%%
% TEST CONFIGURATION %
%%%%%%%%%%%%%%%%%%%%%%
% "Analog" parameters
fs      = 1e6;              % 1 MHz "analog" sampling rate
dt      = 1/fs;             % 1 us sampling period
t       = 0:dt:0.2e-3;      % 0.2 ms time distance
N_sig   = length(t);        % number of "analog" samples

% Uniform sampling parameters
%fs_s    = 200e3;            % 200 kHz sampling rate, just to make sure 
                            % there are no frequencies above 100 kHz
fs_s    = fs;               % for now fs_s = "analog"
step    = floor(fs/fs_s);   % undersampling constant
t_s     = 0:dt*step:0.2e-3; % 0.2 ms time distance
N_sig_s = length(t_s);      % number of uniform samples

% Level-crossing parameters
sig_lvls    = 0:1:8;
N_sig_lvls  = length(sig_lvls);

% Signal parameters
f_sig       = 10e3;
signal      = 4 + 1.1*cos(2*pi*f_sig*t) + 1.3*cos(2*2*pi*f_sig*t) + ...
              1.2*cos(5*2*pi*f_sig*t) + 1.4*cos(9*2*pi*f_sig*t);
signal_s    = pick_samples(signal, step);

%%%%%%%%%%%%%%%%%%%%
% SAMPLING PROCESS %
%%%%%%%%%%%%%%%%%%%%
% "Analog" signal
[samples_a, lvl0_a] = lvl_cross_samples(signal, sig_lvls);
lvls_a              = samples2lvls(samples_a, N_sig, sig_lvls, lvl0_a);
% Signal sampled with fs_s
[samples, lvl0] = lvl_cross_samples(signal_s, sig_lvls);
lvls            = samples2lvls(samples, N_sig_s, sig_lvls, lvl0);

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_R       = length(fir_resp);
fir_delay   = floor(fir_R / 2);
fir_tail    = fir_R - fir_delay;

% 1st iteration
filt_sig_1  = conv(fir_resp, signal_s);
filt_lvls_1 = conv(fir_resp, lvls);
ver_lvls_1  = verify_lvls(filt_lvls_1, lvls, sig_lvls);
t1          = 0:dt*step:dt*step*(length(filt_sig_1)-1);

% 2nd iteration
filt_sig_2  = conv(fir_resp, filt_sig_1);
filt_lvls_2 = conv(fir_resp, ver_lvls_1);
ver_lvls_2  = verify_lvls(filt_lvls_2, ver_lvls_1, sig_lvls);
t2          = 0:dt*step:dt*step*(length(filt_sig_2)-1);

%%%%%%%%%%%%%%%%
% TEST RESULTS %
%%%%%%%%%%%%%%%%
% Frequency spectrum of input/output signals
LVLS        = fftshift(fft(lvls/N_sig_s));
SIGNAL      = fftshift(fft(signal_s/N_sig_s));
freq_s      = linspace(-fs_s/2, fs_s/2, N_sig_s);

% Plot signal and it's samples
figure
fig1 = subplot(2, 1, 1);    % signal sampled with fs_s
hold(fig1, 'on');
xlabel(fig1, 'Time')
ylabel(fig1, 'Signal value')
title(fig1, 'Signal sampled with fs_s')

plot_sig_lvls(fig1, sig_lvls, t_s)
plot(fig1, t_s, signal_s, '-b')
stairs(fig1, t_s, lvls, '-r')


fig2 = subplot(2, 1, 2);    % "analog" signal
hold(fig2, 'on');
xlabel(fig2, 'Time')
ylabel(fig2, 'Signal value')
title(fig2, '"Analog" signal')

plot_sig_lvls(fig2, sig_lvls, t)
plot(fig2, t, signal, '-b')
stairs(fig2, t, lvls_a, '-r')


% Plot signals' frequency spectrum magnitude
figure 
fig1 = subplot(2, 1, 1);
hold(fig1, 'on');
xlabel(fig1, 'Frequency')
ylabel(fig1, 'Magnitude')
title(fig1, 'Frequency spectrum')

grid on
grid minor
plot(fig1, freq_s, abs(LVLS), 'r')
plot(fig1, freq_s, abs(SIGNAL), 'b')

% Plot filtered signals and mark levels
figure
fig1 = subplot(3, 1, 1);    % signal sampled with fs_s
hold(fig1, 'on');
xlabel(fig1, 'Time')
ylabel(fig1, 'Signal value')
title(fig1, 'Sampled signal')

plot_sig_lvls(fig1, sig_lvls, t_s)
plot(fig1, t_s, signal_s, '-g')
stairs(fig1, t_s, lvls, '-r')
axis([ t2(1) t2(end) -1 max(filt_lvls_2)+1 ])

fig2 = subplot(3, 1, 2);    % 1st iteration
hold(fig2, 'on');
xlabel(fig2, 'Time')
ylabel(fig2, 'Signal value')
title(fig2, '#1 filtering iteration')

plot_sig_lvls(fig2, sig_lvls, t1)
plot(fig2, t1, filt_lvls_1, '-c')
plot(fig2, t1, filt_sig_1, '-g')
plot(fig2, t1, ver_lvls_1, '-b')
stairs(fig2, t_s+fir_delay*dt*step, lvls, '-r')
axis([ t2(1) t2(end) -1 max(filt_lvls_2)+1 ])

fig3 = subplot(3, 1, 3);    % 2nd iteration
hold(fig3, 'on');
xlabel(fig3, 'Time')
ylabel(fig3, 'Signal value')
title(fig3, '#2 filtering iteration')

plot_sig_lvls(fig3, sig_lvls, t2)
plot(fig3, t2, filt_lvls_2, '-c')
plot(fig3, t2, filt_sig_2, '-g')
plot(fig3, t2, ver_lvls_2, '-b')
stairs(fig3, t_s+fir_R*dt*step, lvls, '-r')
axis([ t2(1) t2(end) -1 max(filt_lvls_2)+1 ])
