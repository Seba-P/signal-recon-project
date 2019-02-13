
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

run_reconstruction
clearvars -except x t lvl
close all

PLOT_SAMPLES    = 1;
PLOT_UNIFORM    = 0;
PLOT_SIG_LVLS   = 1;
PLOT_SUBLVL     = 0;
PLOT_STAIRS     = 0;
PLOT_SIGNAL     = 1;
PLOT_FILT_SIG   = 0;
PLOT_FILT_LVLS  = 0;
PLOT_VER_LVLS   = 0;
PROCESS_SIGNAL  = 0;

DOWNRATE = 1;
K        = 62;
N_ITER   = 2;

xs = pick_samples(x, DOWNRATE);
ts = pick_samples(t, DOWNRATE);

signal   = xs;
sig_lvls = lvl(:,1)';
% shift    = ((1:length(sig_lvls)).^2)/55;
% sig_lvls = sig_lvls+shift;
% sig_lvls = [ -0.9, -0.6, -0.4, -0.25, -0.20, -0.15, -0.10, -0.05, 0.05, 0.10, 0.15, 0.20, 0.25, 0.4, 0.6, 0.9 ];
dts      = ts(2)-ts(1);

[samples, lvl0, lvls] = gen_samples_and_levels(xs, ts, sig_lvls, 0);

%%%%%%%%%%%%%%%%%%%%%
% FILTERING PROCESS %
%%%%%%%%%%%%%%%%%%%%%
if (PROCESS_SIGNAL)
  fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
  fir_R       = length(fir_resp);
  fir_delay   = ceil(fir_R / 2);
  fir_tail    = floor(fir_R / 2);

  [ filt_sig, filt_lvls, ver_lvls ] = process_signal(signal, lvls, sig_lvls, fir_resp, N_ITER, 'normal');
end
tn = 0:dts:dts*(length(signal)-1);

%%%%%%%%%%%%%%%%
% TEST RESULTS %
%%%%%%%%%%%%%%%%
% Plot filtered signals and mark levels
figure
fig1 = subplot(1, 1, 1);
hold(fig1, 'on');
grid(fig1, 'on');
set(gca, 'GridLineStyle', ':')
set(gca, 'xtick', [0:5:90])
set(gca, 'ytick', [-1:0.05:1])

xlabel(fig1, 'Time', 'FontSize', 24, 'FontWeight','bold')
ylabel(fig1, 'Signal value', 'FontSize', 24, 'FontWeight','bold')
title(fig1, 'Level-crossing sampling', 'FontSize', 24, 'FontWeight','bold')

if (PLOT_SAMPLES)
  plot_samples(fig1, samples, sig_lvls, lvl0, tn, 0)
end
if (PLOT_SIG_LVLS)
  plot_sig_lvls(fig1, sig_lvls, tn, PLOT_SUBLVL)
end
if (PLOT_STAIRS)
  stairs(fig1, tn, lvls, '-r', 'LineWidth', 4)
end
if (PLOT_SIGNAL)
  plot(fig1, tn, signal, '-b', 'LineWidth', 4)
end
if (PROCESS_SIGNAL && PLOT_FILT_SIG)
  plot(fig1, tn, filt_sig(1, 1:end), '--g')
  plot(fig1, tn, filt_sig(end, 1:end), '-g')
end
if (PROCESS_SIGNAL && PLOT_FILT_LVLS)
  plot(fig1, tn, filt_lvls(1, 1:end), '--c')
  plot(fig1, tn, filt_lvls(end, 1:end), '-c')
end
if (PROCESS_SIGNAL && PLOT_VER_LVLS)
  plot(fig1, tn, ver_lvls(1, 1:end), '--b')
  plot(fig1, tn, ver_lvls(end, 1:end), '-b')
end

axis([ tn(1) tn(end) min(signal)-0.1 max(signal)+0.1 ])

if (PLOT_UNIFORM)
  figure
  fig2 = subplot(1, 1, 1);
  hold(fig2, 'on');
  grid(fig2, 'on');
  set(gca, 'GridLineStyle', ':')
  set(gca, 'xtick', [0:5:90])
  set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig2, 'Time', 'FontSize', 24, 'FontWeight','bold')
  ylabel(fig2, 'Signal value', 'FontSize', 24, 'FontWeight','bold')
  title(fig2, 'Uniform Sampling', 'FontSize', 24, 'FontWeight','bold')

  if (PLOT_SAMPLES)
    plot_uniform_samples(fig2, signal, 1/dts, tn, 0)
  end
  if (PLOT_SIG_LVLS)
  %  plot_sig_lvls(fig1, sig_lvls, tn, PLOT_SUBLVL)
  end
  if (PLOT_SIGNAL)
    plot(fig2, tn, signal, '-b', 'LineWidth', 4)
  end

  axis([ tn(1) tn(end) min(signal)-0.1 max(signal)+0.1 ])
end
