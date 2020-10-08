
pkg load signal

addpath([ pwd(), '/../' ]);

VERBOSE     = 0;
DO_PLOT     = 1;

% SEED_RANGE  = [5,8,9,10,12,14,16,17,21,23];
% SEED_RANGE  = [866];
% SEED_RANGE  = [8,14,16,17,23];
SEED_RANGE  = [127,935,913,22,866,625,266,297,531,625];
% SEED_RANGE  = [127];
% MODE_RANGE  = 1:2;
MODE_RANGE  = 1;
ITER_RANGE  = 1;
% ITER_RANGE  = 1:99;
% ITER_RANGE  = [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,99];
% ITER_RANGE  = [1,5,10,50,99];

% SEED_RANGE = [127,935,913,22,866,172,625,266,297,16,562,862,531,625];
% SEED_RANGE = [127,935,913,22,866,625,266,297,531,625];
% SEED_RANGE = [172,16,562,862]; % the best for title figure
% SEED_RANGE = [172]; % northwest
% SEED_RANGE = [16,862]; % northeast
% SEED_RANGE = [17]; % northwest
% MODE_RANGE = 1:2
% MODE_RANGE = 1;
% ITER_RANGE = 1:99;

% Nice seeds: 1,3,4,5,7,8*,9,10,12,13*,14*,16*,17*,19,21,22,23*
% Bad seeds:  0,2,6*,11,15,18,20,24

dts         = 0.001;
seed_idx    = 1;
mode_idx    = 1;
iter_idx    = 1;

signal_error_params = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);
signal_orig_params  = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);
signal_recon_params = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);

error_div_signal_energy = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 1);

more off
for seed = SEED_RANGE
    for init_shape = MODE_RANGE
        for iter = ITER_RANGE
            [ sig_err_par, sig_orig_par, sig_rec_par ] = analyze_test_vector(sprintf('../vectors/vector_seed_%03u_iter_%02u_mode_%02u.tar', seed, iter, init_shape), VERBOSE, DO_PLOT);

            signal_error_params(seed_idx, mode_idx, iter_idx, 1:end) = sig_err_par;
            signal_orig_params(seed_idx, mode_idx, iter_idx, 1:end)  = sig_orig_par;
            signal_recon_params(seed_idx, mode_idx, iter_idx, 1:end) = sig_rec_par;

            error_div_signal_energy(seed_idx, mode_idx, iter_idx, 1) = signal_error_params(seed_idx, mode_idx, iter_idx, 6) / signal_orig_params(seed_idx, mode_idx, iter_idx, 6);

            iter_idx = iter_idx + 1;
        end

        mode_idx = mode_idx + 1;
        iter_idx = 1;
    end

    seed_idx = seed_idx + 1;
    mode_idx = 1;
    iter_idx = 1;
end
more on

% sig_err_min_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_min_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_min_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_min_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% sig_err_max_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_max_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_max_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_max_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% sig_err_mean_min    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_mean_max    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_mean_mean   = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_mean_std    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% sig_err_std_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_std_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_std_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_std_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% sig_err_meansq_min  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_meansq_max  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_meansq_mean = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_meansq_std  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% sig_err_energy_min  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_energy_max  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_energy_mean = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% sig_err_energy_std  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% err_div_sig_energy_min  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% err_div_sig_energy_max  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% err_div_sig_energy_mean = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
% err_div_sig_energy_std  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

% for init_shape = 1:numel(MODE_RANGE)
%     for iter = 1:numel(ITER_RANGE)
%         sig_err_min_min(init_shape,iter)      = min(signal_error_params(:, init_shape, iter, 1));
%         sig_err_min_max(init_shape,iter)      = max(signal_error_params(:, init_shape, iter, 1));
%         sig_err_min_mean(init_shape,iter)     = mean(signal_error_params(:, init_shape, iter, 1));
%         sig_err_min_std(init_shape,iter)      = std(signal_error_params(:, init_shape, iter, 1));

%         sig_err_max_min(init_shape,iter)      = min(signal_error_params(:, init_shape, iter, 2));
%         sig_err_max_max(init_shape,iter)      = max(signal_error_params(:, init_shape, iter, 2));
%         sig_err_max_mean(init_shape,iter)     = mean(signal_error_params(:, init_shape, iter, 2));
%         sig_err_max_std(init_shape,iter)      = std(signal_error_params(:, init_shape, iter, 2));

%         sig_err_mean_min(init_shape,iter)     = min(signal_error_params(:, init_shape, iter, 3));
%         sig_err_mean_max(init_shape,iter)     = max(signal_error_params(:, init_shape, iter, 3));
%         sig_err_mean_mean(init_shape,iter)    = mean(signal_error_params(:, init_shape, iter, 3));
%         sig_err_mean_std(init_shape,iter)     = std(signal_error_params(:, init_shape, iter, 3));

%         sig_err_std_min(init_shape,iter)      = min(signal_error_params(:, init_shape, iter, 4));
%         sig_err_std_max(init_shape,iter)      = max(signal_error_params(:, init_shape, iter, 4));
%         sig_err_std_mean(init_shape,iter)     = mean(signal_error_params(:, init_shape, iter, 4));
%         sig_err_std_std(init_shape,iter)      = std(signal_error_params(:, init_shape, iter, 4));

%         sig_err_meansq_min(init_shape,iter)   = min(signal_error_params(:, init_shape, iter, 5));
%         sig_err_meansq_max(init_shape,iter)   = max(signal_error_params(:, init_shape, iter, 5));
%         sig_err_meansq_mean(init_shape,iter)  = mean(signal_error_params(:, init_shape, iter, 5));
%         sig_err_meansq_std(init_shape,iter)   = std(signal_error_params(:, init_shape, iter, 5));

%         sig_err_energy_min(init_shape,iter)   = min(signal_error_params(:, init_shape, iter, 6));
%         sig_err_energy_max(init_shape,iter)   = max(signal_error_params(:, init_shape, iter, 6));
%         sig_err_energy_mean(init_shape,iter)  = mean(signal_error_params(:, init_shape, iter, 6));
%         sig_err_energy_std(init_shape,iter)   = std(signal_error_params(:, init_shape, iter, 6));

%         err_div_sig_energy_min(init_shape,iter)   = min(error_div_signal_energy(:, init_shape, iter, 1));
%         err_div_sig_energy_max(init_shape,iter)   = max(error_div_signal_energy(:, init_shape, iter, 1));
%         err_div_sig_energy_mean(init_shape,iter)  = mean(error_div_signal_energy(:, init_shape, iter, 1));
%         err_div_sig_energy_std(init_shape,iter)   = std(error_div_signal_energy(:, init_shape, iter, 1));
%     end
% end

% sig_err_min_min
% sig_err_min_max
% sig_err_min_mean
% sig_err_min_std

% sig_err_max_min
% sig_err_max_max
% sig_err_max_mean
% sig_err_max_std

% sig_err_mean_min
% sig_err_mean_max
% sig_err_mean_mean
% sig_err_mean_std

% sig_err_std_min
% sig_err_std_max
% sig_err_std_mean
% sig_err_std_std

% sig_err_meansq_min
% sig_err_meansq_max
% sig_err_meansq_mean
% sig_err_meansq_std

% sig_err_energy_min
% sig_err_energy_max
% sig_err_energy_mean
% sig_err_energy_std

% err_div_sig_energy_min
% err_div_sig_energy_max
% err_div_sig_energy_mean
% err_div_sig_energy_std

% % dts = 0.001;
% % tn  = 0:dts:dts*(length(signal_original)-1);

% mode1_mean_error = err_div_sig_energy_mean(1,1:end)
% mode2_mean_error = err_div_sig_energy_mean(2,1:end)
% % mode1_mean_error = sig_err_mean_mean(1,1:end);
% % mode2_mean_error = sig_err_mean_mean(2,1:end);

% mode1_mean_error = [ ...
%    0.057413   0.050408   0.050530   0.048405   0.048459   0.047500   0.047029   0.047053   0.048217   0.045693 ...
%    0.044691   0.044840   0.044992   0.042771   0.040563   0.040740   0.038553   0.036385   0.034206 ...
%    ];

% mode2_mean_error =  [ ...
%    0.014171   0.014271   0.014322   0.014359   0.014388   0.014410   0.014429   0.014448   0.014467   0.014483 ...
%    0.014597   0.014682   0.014773   0.014869   0.014972   0.015083   0.015203   0.015332   0.015457 ...
%    ];

% figure
% fig1 = subplot(1, 1, 1);
% hold(fig1, 'on');
% grid(fig1, 'on', 'minor');
% set(gca, 'GridLineStyle', ':')
% set(gca, 'xtick', [1:1:99])
% set(gca, 'ytick', [0:0.005:1])

% xlabel(fig1, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
% ylabel(fig1, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
% title(fig1, 'Signal reconstruction', 'FontSize', 24, 'FontWeight', 'bold')

% p_mode1 = semilogx(fig1, ITER_RANGE, mode1_mean_error, '-r', 'LineWidth', 4);
% % p_mode2 = semilogx(fig1, ITER_RANGE, mode2_mean_error, '-r', 'LineWidth', 4);
% % p_mode1 = plot(fig1, ITER_RANGE, mode1_mean_error, '-r', 'LineWidth', 4);
% % p_mode2 = plot(fig1, ITER_RANGE, mode2_mean_error, '-r', 'LineWidth', 4);

% % axis([ ITER_RANGE(1) ITER_RANGE(end) min(mode1_mean_error)-0.1 max(mode1_mean_error)+0.1 ], 'tic', 'labelxy')
% % axis([ ITER_RANGE(1) ITER_RANGE(end) min(mode1_mean_error)-0.05 max(mode1_mean_error)+0.05 ], 'on')
% % axis('on', 'tight')
% % set(gca,'xscale','log');
% % set(gca,'yscale','log');
% % legend([ p_mode1 p_mode2 ], 'piecewise-constant', 'piecewise-linear', 'Location', 'northeast')

% figure
% fig2 = subplot(1, 1, 1);
% hold(fig2, 'on');
% grid(fig2, 'on', 'minor');
% set(gca, 'GridLineStyle', ':')
% set(gca, 'xtick', [1:1:99])
% set(gca, 'ytick', [0:0.0005:1])

% xlabel(fig2, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
% ylabel(fig2, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
% title(fig2, 'Signal reconstruction', 'FontSize', 24, 'FontWeight', 'bold')

% % p_mode1 = semilogx(fig2, ITER_RANGE, mode1_mean_error, '-r', 'LineWidth', 4);
% p_mode2 = semilogx(fig2, ITER_RANGE, mode2_mean_error, '-r', 'LineWidth', 4);
% % p_mode1 = plot(fig2, ITER_RANGE, mode1_mean_error, '-r', 'LineWidth', 4);
% % p_mode2 = plot(fig2, ITER_RANGE, mode2_mean_error, '-r', 'LineWidth', 4);

% % axis([ ITER_RANGE(1) ITER_RANGE(end) min(mode1_mean_error)-0.1 max(mode1_mean_error)+0.1 ], 'tic', 'labelxy')
% % axis([ ITER_RANGE(1) ITER_RANGE(end) min(mode1_mean_error)-0.05 max(mode1_mean_error)+0.05 ], 'on')
% % axis('on', 'tight')
% % set(gca,'xscale','log');
% % set(gca,'yscale','log');
