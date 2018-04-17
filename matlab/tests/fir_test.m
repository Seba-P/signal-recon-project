
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

run_reconstruction
close all

DOWNRATE = 16;
K        = 500;

x = pick_samples(x, DOWNRATE);
t = pick_samples(t, DOWNRATE);

signal   = x;
sig_lvls = lvl(:,1)';
dt       = t(2)-t(1);

[samples, lvl0, lvls] = gen_samples_and_levels(x, t, (lvl(:,1))', 0);
clearvars -except samples lvl0 lvls x t lvl signal sig_lvls dt DOWNRATE K

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_resp    = gen_fir_resp(K, DOWNRATE*0.004, '../fir_coeffs.txt', 0);
fir_R       = length(fir_resp);
fir_delay   = floor(fir_R / 2);
fir_tail    = fir_R - fir_delay;

% 1st iteration
filt_sig_1  = conv(fir_resp, signal);
filt_lvls_1 = conv(fir_resp, lvls);
ver_lvls_1  = verify_lvls(filt_lvls_1, lvls, sig_lvls);
t1          = 0:dt:dt*(length(filt_sig_1)-1);

save_binary_input('../../de1soc/hps_sw/apps/sgdma_demo/input-fir_test.bin', lvls);
fir_output  = load_binary_output('../../de1soc/hps_sw/apps/sgdma_demo/output-fir_test.bin');

%%%%%%%%%%%%%%%%
% TEST RESULTS %
%%%%%%%%%%%%%%%%
% Plot filtered signals and mark levels
figure
fig1 = subplot(1, 1, 1);
hold(fig1, 'on');
xlabel(fig1, 'Time')
ylabel(fig1, 'Signal value')
title(fig1, 'Sampled signal before/after filtering')

plot_sig_lvls(fig1, sig_lvls, t+(fir_delay-2)*dt)
plot(fig1, t+(fir_delay-2)*dt, signal, '--g')
plot(fig1, t1, filt_lvls_1, '-c')
plot(fig1, t1, filt_sig_1, '-g')
plot(fig1, t1, ver_lvls_1, '-b')
%plot(fig1, (0:dt:dt*(length(fir_output)-1))+(fir_delay-2)*dt, fir_output, '-c')
stairs(fig1, t+(fir_delay-2)*dt, lvls, '-r')
axis([ t1(1) t1(end) -1 max(filt_lvls_1)+1 ])

% Plot frequency responses
figure
hold on;

SIGNAL      = fft(signal);
FILT_LVLS   = fft(filt_lvls_1);
VER_LVLS    = fft(ver_lvls_1);
FIR_RESP    = fft(fir_resp);
N = floor(length(signal) / length(fir_resp));

plot(0:length(SIGNAL)-1, mag2db(abs(SIGNAL./max(SIGNAL))), '-g');
plot(0:length(SIGNAL)-1, mag2db(abs(FILT_LVLS(1:length(SIGNAL))./max(FILT_LVLS(1:length(SIGNAL))))), '-c');
plot(0:length(SIGNAL)-1, mag2db(abs(VER_LVLS(1:length(SIGNAL))./max(VER_LVLS(1:length(SIGNAL))))), '-b');
plot(0:N:N*length(FIR_RESP)-1, mag2db(abs(FIR_RESP)), '-k');