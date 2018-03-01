
addpath('../')
addpath('../bursty-lib/')

run_reconstruction
close all

signal = x;
sig_lvls = lvl(:,1)';
dt = t(2)-t(1);

[samples, lvl0, lvls] = gen_samples_and_levels(x, t, (lvl(:,1))', 1);
clearvars -except samples lvl0 lvls x t lvl signal sig_lvls dt

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
fir_resp    = gen_fir_resp();
fir_R       = length(fir_resp);
fir_delay   = floor(fir_R / 2);
fir_tail    = fir_R - fir_delay;

% 1st iteration
filt_sig_1  = conv(fir_resp, signal);
filt_lvls_1 = conv(fir_resp, lvls);
ver_lvls_1  = verify_lvls(filt_lvls_1, lvls, sig_lvls);
t1          = 0:dt:dt*(length(filt_sig_1)-1);

% 2nd iteration
filt_sig_2  = conv(fir_resp, filt_sig_1);
filt_lvls_2 = conv(fir_resp, ver_lvls_1);
ver_lvls_2  = verify_lvls(filt_lvls_2, ver_lvls_1, sig_lvls);
t2          = 0:dt:dt*(length(filt_sig_2)-1);

%%%%%%%%%%%%%%%%
% TEST RESULTS %
%%%%%%%%%%%%%%%%
% Plot filtered signals and mark levels
figure
fig1 = subplot(3, 1, 1);    % signal sampled with fs_s
hold(fig1, 'on');
xlabel(fig1, 'Time')
ylabel(fig1, 'Signal value')
title(fig1, 'Sampled signal')

plot_sig_lvls(fig1, sig_lvls, t)
plot(fig1, t, signal, '-g')
stairs(fig1, t, lvls, '-r')
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
stairs(fig2, t+fir_delay*dt, lvls, '-r')
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
stairs(fig3, t+fir_R*dt, lvls, '-r')
axis([ t2(1) t2(end) -1 max(filt_lvls_2)+1 ])
