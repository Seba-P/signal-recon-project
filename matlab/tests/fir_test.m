
pkg load signal
addpath([ pwd(), '/../' ]);
addpath([ pwd(), '/../toolbox/' ]);
addpath([ pwd(), '/../bursty-lib/' ]);

close all ; clear all
[ x t lvl ] = generate_bursty_signal([]);

DOWNRATE = 20;
K        = 254;

xs = pick_samples(x, DOWNRATE);
ts = pick_samples(t, DOWNRATE);

signal   = xs;
sig_lvls = lvl(:,1)';
dts       = ts(2)-ts(1);

[samples, lvl0, lvls] = gen_samples_and_init_guess(xs, ts, (lvl(:,1))', 'piecewise-constant', 0);

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
fir_R       = length(fir_resp);
fir_delay   = floor(fir_R / 2);
fir_tail    = fir_R - fir_delay;

% 1st iteration
filt_sig_1  = conv(fir_resp, signal);
filt_lvls_1 = conv(fir_resp, lvls);
ver_lvls_1  = verify_lvls(filt_lvls_1, lvls, sig_lvls);
t1          = 0:dts:dts*(length(filt_sig_1)-1);

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

plot_sig_lvls(fig1, sig_lvls, ts+(fir_delay-2)*dts)
plot(fig1, ts+(fir_delay-2)*dts, signal, '--g')
plot(fig1, t1, filt_lvls_1, '-c')
plot(fig1, t1, filt_sig_1, '-g')
plot(fig1, t1, ver_lvls_1, '-b')
plot(fig1, 0:dts:dts*(length(fir_output)-1), fir_output, '-m')
stairs(fig1, ts+(fir_delay-2)*dts, lvls, '-r')
axis([ t1(1) t1(end) -1 max(filt_lvls_1)+1 ])

% Plot frequency responses
figure
hold on;

SIGNAL      = fft(signal);
FILT_LVLS   = fft(filt_lvls_1);
VER_LVLS    = fft(ver_lvls_1);
FIR_OUTPUT  = fft(fir_output);
FIR_RESP    = fft(fir_resp);
N = floor(length(signal) / length(fir_resp));

plot(0:length(SIGNAL)-1, mag2db(abs(SIGNAL./max(SIGNAL))), '-g');
plot(0:length(SIGNAL)-1, mag2db(abs(FILT_LVLS(1:length(SIGNAL))./max(FILT_LVLS(1:length(SIGNAL))))), '-c');
plot(0:length(SIGNAL)-1, mag2db(abs(VER_LVLS(1:length(SIGNAL))./max(VER_LVLS(1:length(SIGNAL))))), '-b');
plot(0:length(SIGNAL)-1, mag2db(abs(FIR_OUTPUT(1:length(SIGNAL))./max(FIR_OUTPUT(1:length(SIGNAL))))), '-m');
plot(0:N:N*length(FIR_RESP)-1, mag2db(abs(FIR_RESP)), '-k');
