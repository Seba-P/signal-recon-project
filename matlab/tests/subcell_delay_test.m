
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

close all

DOWNRATE = 40;
K        = 62;
N_ITER   = 6;

lvl = -0.95:0.10:0.95;
ts  = 0:0.001:0.5;
xs  = -0.05 + 0.05*sin(2*pi*20*ts);

signal   = xs;
sig_lvls = lvl;
dts      = ts(2)-ts(1);

[samples, lvl0, lvls] = gen_samples_and_levels(xs, ts, lvl, 0);
save_samples('../samples.txt', samples, 'text');
save_samples('../samples.bin', samples, 'binary');

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
fir_R       = length(fir_resp);
fir_delay   = ceil(fir_R / 2);
fir_tail    = floor(fir_R / 2);

[ filt_sig, filt_lvls, ver_lvls ] = process_signal(signal, lvls, sig_lvls, fir_resp, N_ITER, 'normal');
tn          = 0:dts:dts*(length(signal)-1);

% tb_output 	= load_results('../tb_output.txt', 'binary');
tb_output 	= load_results('../tb_output.txt', 'text');
% tb_delay 	= N_ITER*(fir_delay-1)+1;
tb_delay 	= N_ITER*(fir_delay-1)+1;

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

plot_sig_lvls(fig1, sig_lvls, tn)
plot(fig1, tn, signal, '--r')
% plot(fig1, tn, filt_sig(1, 1:end), '--g')
plot(fig1, tn, filt_sig(end, 1:end), '-g')
% plot(fig1, tn, filt_lvls(1, 1:end), '--c')
plot(fig1, tn, filt_lvls(end, 1:end), '-c')
% plot(fig1, tn, ver_lvls(1, 1:end), '--b')
plot(fig1, tn, ver_lvls(end, 1:end), '-ob')
plot(fig1, tn, [ tb_output(tb_delay:end) zeros(1,length(tn)-length(tb_output(tb_delay:end))) ], '-ok')
stairs(fig1, tn, lvls, '-r')
axis([ tn(1) tn(end) -1 max(filt_lvls(end))+1 ])
