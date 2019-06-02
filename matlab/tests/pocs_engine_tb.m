
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

close all ; clear all
seed = [];
[ x t lvl ] = generate_bursty_signal(seed);

DOWNRATE 	= 40;
K        	= 62;
N_ITER   	= 2;
INIT_GUESS 	= 'piecewise-constant';

xs = pick_samples(x, DOWNRATE);
ts = pick_samples(t, DOWNRATE);

signal   = xs;
sig_lvls = lvl(:,1)';
dts      = ts(2)-ts(1);

[samples, lvl0, lvls] = gen_samples_and_init_guess(xs, ts, (lvl(:,1))', INIT_GUESS, 0);

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
fir_R       = length(fir_resp);
fir_delay   = ceil(fir_R / 2);
fir_tail    = floor(fir_R / 2);

[ filt_sig, filt_lvls, ver_lvls ] = process_signal(signal, lvls, sig_lvls, fir_resp, N_ITER, 'normal');
tn          = 0:dts:dts*(length(signal)-1);
%%%%%%%%%%%%%%%%
% TEST RESULTS %
%%%%%%%%%%%%%%%%
generate_test_vector('POCS_ENGINE_TB', lvl0, sig_lvls, N_ITER, INIT_GUESS, samples, signal, ver_lvls, [ NaN DOWNRATE K ]);

tb_output 	= load_results('../tb_output.txt', 'text');
tb_delay 	= N_ITER*(fir_delay-1)+1;

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
