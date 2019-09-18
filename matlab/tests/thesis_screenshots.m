
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

close all ; clear all
[ x t lvl ] = generate_bursty_signal([172]);

PLOT_SAMPLES    = 1;
PLOT_UNIFORM    = 0;
PLOT_SIG_LVLS   = 1;
PLOT_SIG_LIMITS = 1;
PLOT_SUBLVL     = 1;
PLOT_STAIRS     = 0;
PLOT_SIGNAL     = 1;
PLOT_FILT_SIG   = 0;
PLOT_FILT_LVLS  = 0;
PLOT_VER_LVLS   = 1;
PLOT_SPECTRUM   = 0;
PROCESS_SIGNAL  = 1;
SIGNAL_DIFF     = 0;
INIT_LINEAR     = 0;

DOWNRATE = 1;  % 40
K        = 2046;  % 62
N_ITER   = 10;   % 2

xs = pick_samples(x, DOWNRATE);
ts = pick_samples(t, DOWNRATE);

signal   = xs;
sig_lvls = lvl(:,1)';
% shift    = ((1:length(sig_lvls)).^2)/55;
% sig_lvls = sig_lvls+shift;
% sig_lvls = [ -0.9, -0.6, -0.4, -0.25, -0.20, -0.15, -0.10, -0.05, 0.05, 0.10, 0.15, 0.20, 0.25, 0.4, 0.6, 0.9 ];
dts      = ts(2)-ts(1);

if (INIT_LINEAR)
  [samples, lvl0, lvls] = gen_samples_and_init_guess(signal, ts, sig_lvls, 'piecewise-linear', 0);
else
  [samples, lvl0, lvls] = gen_samples_and_init_guess(signal, ts, sig_lvls, 'piecewise-constant', 0);
end

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

xlabel(fig1, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
ylabel(fig1, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
title(fig1, 'Test results', 'FontSize', 24, 'FontWeight', 'bold')

if (PLOT_SAMPLES)
  plot_samples(fig1, samples, sig_lvls, lvl0, tn, 0)
end
if (PLOT_SIG_LVLS)
  plot_sig_lvls(fig1, sig_lvls, tn, PLOT_SUBLVL)
end
if (PLOT_SIG_LIMITS)
  plot_sig_limits(fig1, samples, sig_lvls, lvl0, tn)
end
if (PLOT_STAIRS)
  if (INIT_LINEAR)
    plot(fig1, tn, lvls, '-r', 'LineWidth', 4)
  else    
    stairs(fig1, tn, lvls, '-r', 'LineWidth', 4)
  end
end
if (PLOT_SIGNAL)
  p_sig = plot(fig1, tn, signal, '-r', 'LineWidth', 4)
end
if (PROCESS_SIGNAL && PLOT_FILT_SIG)
  p_fsig1 = plot(fig1, tn, filt_sig(1, 1:end), '-b', 'LineWidth', 4)
  p_fsign = plot(fig1, tn, filt_sig(end, 1:end), '-b', 'LineWidth', 4)
end
if (PROCESS_SIGNAL && PLOT_FILT_LVLS)
  % plot(fig1, tn, filt_lvls(1, 1:end), '-b', 'LineWidth', 4)
  p_flvl = plot(fig1, tn, filt_lvls(end, 1:end), '-b', 'LineWidth', 4)
end
if (PROCESS_SIGNAL && PLOT_VER_LVLS)
  p_ver = plot(fig1, tn, ver_lvls(1, 1:end), '-b', 'LineWidth', 4)
  % plot(fig1, tn, ver_lvls(end, 1:end), '-b', 'LineWidth', 4)
end

axis([ tn(1) tn(end) min(signal)-0.1 max(signal)+0.1 ])
legend([ p_sig p_ver ], 'original', 'reconstructed')

if (PLOT_UNIFORM)
  figure
  fig2 = subplot(1, 1, 1);
  hold(fig2, 'on');
  grid(fig2, 'on');
  set(gca, 'GridLineStyle', ':')
  set(gca, 'xtick', [0:5:90])
  set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig2, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig2, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig2, 'Uniform Sampling', 'FontSize', 24, 'FontWeight', 'bold')

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

if (PLOT_SPECTRUM)
  SIGNAL = fft(signal);

  SIGNAL_MAGN = 20.*log10(abs(SIGNAL)./max(abs(SIGNAL)));
  SIGNAL_FREQ = 0:length(SIGNAL)-1;

  if (PROCESS_SIGNAL)
    % FILT_LVLS = fft(filt_lvls(1, 1:end));
    FILT_LVLS = fft(filt_lvls(end, 1:end));
    VER_LVLS  = fft(ver_lvls(1, 1:end));
    % VER_LVLS  = fft(ver_lvls(end, 1:end));

    FILT_LVLS_MAGN  = 20.*log10(abs(FILT_LVLS)./max(abs(FILT_LVLS)));
    FILT_LVLS_FREQ  = 0:length(FILT_LVLS)-1;
    VER_LVLS_MAGN   = 20.*log10(abs(VER_LVLS)./max(abs(VER_LVLS)));
    VER_LVLS_FREQ   = 0:length(VER_LVLS)-1;
  end

  figure
  fig3 = subplot(1, 1, 1);
  hold(fig3, 'on');
  grid(fig3, 'on');
  set(gca, 'GridLineStyle', ':')
  % set(gca, 'xtick', [0:5:90])
  % set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig3, 'Frequency', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig3, 'Magnitude', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig3, 'Frequency spectrum', 'FontSize', 24, 'FontWeight', 'bold')

  if (PLOT_SIGNAL)
    % plot(SIGNAL_FREQ, SIGNAL_MAGN, 'b', 'LineWidth', 4);
    fill(fig3, [SIGNAL_FREQ flip(SIGNAL_FREQ)], [SIGNAL_MAGN' -100*ones(1,length(SIGNAL_MAGN))], 0.9*[0.3 0 1], 'EdgeColor', 'none');
  end
  if (PLOT_FILT_LVLS)
    % plot(FILT_LVLS_FREQ, FILT_LVLS_MAGN, 'b', 'LineWidth', 4);
    fill(fig3, [FILT_LVLS_FREQ flip(FILT_LVLS_FREQ)], [FILT_LVLS_MAGN -100*ones(1,length(FILT_LVLS_MAGN))], 0.9*[0.3 0 1], 'EdgeColor', 'none');
  end
  if (PLOT_VER_LVLS)
    % plot(VER_LVLS_FREQ, VER_LVLS_MAGN, 'b', 'LineWidth', 4);
    fill(fig3, [VER_LVLS_FREQ flip(VER_LVLS_FREQ)], [VER_LVLS_MAGN -100*ones(1,length(VER_LVLS_MAGN))], 0.9*[0.3 0 1], 'EdgeColor', 'none');
  end
end

if (SIGNAL_DIFF)
  start_l = 77*1/dts+1; % seed 938
  end_l   = 97*1/dts;
  % start_l = 65*1/dts+1; % seed 16
  % end_l   = 80*1/dts;
  start_h = 42*1/dts+1; % seed 16
  end_h   = 57*1/dts;

  % t_l     = 0:dts:(end_l-start_l)*dts;
  % t_h     = 0:dts:(end_h-start_h)*dts;
  t_l   = tn(start_l:end_l);
  t_h   = tn(start_h:end_h);

  signal_l  = signal(start_l:end_l);
  signal_h  = signal(start_h:end_h);

  figure
  fig4 = subplot(1, 1, 1);
  hold(fig4, 'on');
  grid(fig4, 'on');
  set(gca, 'GridLineStyle', ':')
  set(gca, 'xtick', [0:5:90])
  set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig4, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig4, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig4, 'Level-crossing sampling', 'FontSize', 24, 'FontWeight', 'bold')

  figure
  fig5 = subplot(1, 1, 1);
  hold(fig5, 'on');
  grid(fig5, 'on');
  set(gca, 'GridLineStyle', ':')
  set(gca, 'xtick', [0:5:90])
  set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig5, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig5, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig5, 'Level-crossing sampling', 'FontSize', 24, 'FontWeight', 'bold')

  if (PLOT_SAMPLES)
    plot_samples(fig4, samples, sig_lvls, lvl0, tn, 0)
    plot_samples(fig5, samples, sig_lvls, lvl0, tn, 0)
  end
  if (PLOT_SIG_LVLS)
    plot_sig_lvls(fig4, sig_lvls, tn, PLOT_SUBLVL)
    plot_sig_lvls(fig5, sig_lvls, tn, PLOT_SUBLVL)
  end
  if (PLOT_SIG_LIMITS)
    plot_sig_limits(fig4, samples, sig_lvls, lvl0, tn)
    plot_sig_limits(fig5, samples, sig_lvls, lvl0, tn)
  end
  % if (PLOT_STAIRS)
  %   stairs(fig4, tn, lvls, '-r', 'LineWidth', 4)
  % end
  if (PLOT_SIGNAL)
    plot(fig4, t_l, signal_l, '-b', 'LineWidth', 4)
    plot(fig5, t_h, signal_h, '-b', 'LineWidth', 4)
  end

  SIGNAL_L = fft(signal_l);
  SIGNAL_H = fft(signal_h);

  SIGNAL_L_MAGN = 20.*log10(abs(SIGNAL_L)./max(abs(SIGNAL_L)));
  SIGNAL_H_MAGN = 20.*log10(abs(SIGNAL_H)./max(abs(SIGNAL_H)));
  SIGNAL_L_FREQ = 0:length(SIGNAL_L)-1;
  SIGNAL_H_FREQ = 0:length(SIGNAL_H)-1;

  figure
  fig6 = subplot(1, 1, 1);
  hold(fig6, 'on');
  grid(fig6, 'on');
  set(gca, 'GridLineStyle', ':')
  % set(gca, 'xtick', [0:5:90])
  % set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig6, 'Frequency', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig6, 'Magnitude', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig6, 'Frequency spectrum', 'FontSize', 24, 'FontWeight', 'bold')
  % plot(fig6, SIGNAL_L_FREQ, SIGNAL_L_MAGN, 'b', 'LineWidth', 4);
  fill(fig6, [SIGNAL_L_FREQ flip(SIGNAL_L_FREQ)], [SIGNAL_L_MAGN' -100*ones(1,length(SIGNAL_L_MAGN))], 0.9*[0.3 0 1], 'EdgeColor', 'none');
  
  figure
  fig7 = subplot(1, 1, 1);
  hold(fig7, 'on');
  grid(fig7, 'on');
  set(gca, 'GridLineStyle', ':')
  % set(gca, 'xtick', [0:5:90])
  % set(gca, 'ytick', [-1:0.05:1])

  xlabel(fig7, 'Frequency', 'FontSize', 24, 'FontWeight', 'bold')
  ylabel(fig7, 'Magnitude', 'FontSize', 24, 'FontWeight', 'bold')
  title(fig7, 'Frequency spectrum', 'FontSize', 24, 'FontWeight', 'bold')
  % plot(fig7, SIGNAL_H_FREQ, SIGNAL_H_MAGN, 'b', 'LineWidth', 4);
  fill(fig7, [SIGNAL_H_FREQ flip(SIGNAL_H_FREQ)], [SIGNAL_H_MAGN' -100*ones(1,length(SIGNAL_H_MAGN))], 0.9*[0.3 0 1], 'EdgeColor', 'none');
end
