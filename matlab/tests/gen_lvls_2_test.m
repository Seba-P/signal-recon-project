
addpath('../')

% Common settings
fs          = 1e6;
dt          = 1/fs;
t           = 0:dt:200e-6;
N_sig       = length(t);
sig_lvls    = 0:1:8;

% TESTCASE 1 $
f_sig    = 10e3; 
signal_1 = 4 + 1.1*cos(2*pi*f_sig*t) + 1.3*cos(2*2*pi*f_sig*t) + ...
           1.2*cos(5*2*pi*f_sig*t) + 1.4*cos(9*2*pi*f_sig*t);

[samples_1, lvl0_1] = lvl_cross_samples(signal_1, sig_lvls);
lvls_1 = samples2lvls(samples_1, N_sig, sig_lvls, lvl0_1);

figure
fig = subplot(1, 1, 1);
hold(fig, 'on')
plot_sig_lvls(fig, sig_lvls, t)
stairs(t, lvls_1, '-r')
plot(t, signal_1, '-b')
