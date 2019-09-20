
pkg load signal

addpath([ pwd(), '/../' ]);

VERBOSE     = 0;
DO_PLOT     = 0;

SEED_RANGE  = [5,8,9,10,12,14,16,17,21,23];
% SEED_RANGE  = [8,14,16,17,23];
MODE_RANGE  = 1:2;
% MODE_RANGE  = 1
% ITER_RANGE  = 1:99;
ITER_RANGE  = [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,99];
% ITER_RANGE  = [1,5,10,50,99];

% Nice seeds: 1,3,4,5,7,8*,9,10,12,13*,14*,16*,17*,19,21,22,23*
% Bad seeds:  0,2,6*,11,15,18,20,24

dts         = 0.001;
seed_idx    = 1;
mode_idx    = 1;
iter_idx    = 1;

signal_error_params = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);
signal_orig_params  = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);
signal_recon_params = zeros(numel(SEED_RANGE), numel(MODE_RANGE), numel(ITER_RANGE), 6);

more off
for seed = SEED_RANGE
    for init_shape = MODE_RANGE
        for iter = ITER_RANGE
            [ sig_err_par, sig_orig_par, sig_rec_par ] = analyze_test_vector(sprintf('../vectors/vector_seed_%03u_iter_%02u_mode_%02u.tar', seed, iter, init_shape), VERBOSE, DO_PLOT);

            signal_error_params(seed_idx, mode_idx, iter_idx, 1:end) = sig_err_par;
            signal_orig_params(seed_idx, mode_idx, iter_idx, 1:end)  = sig_orig_par;
            signal_recon_params(seed_idx, mode_idx, iter_idx, 1:end) = sig_rec_par;

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

sig_err_min_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_min_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_min_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_min_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

sig_err_max_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_max_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_max_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_max_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

sig_err_mean_min    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_mean_max    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_mean_mean   = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_mean_std    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

sig_err_std_min     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_std_max     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_std_mean    = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_std_std     = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

sig_err_meansq_min  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_meansq_max  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_meansq_mean = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_meansq_std  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

sig_err_energy_min  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_energy_max  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_energy_mean = zeros(numel(MODE_RANGE), numel(ITER_RANGE));
sig_err_energy_std  = zeros(numel(MODE_RANGE), numel(ITER_RANGE));

for init_shape = numel(MODE_RANGE)
	for iter = numel(ITER_RANGE)
		sig_err_min_min 	= min(signal_error_params(:, init_shape, iter, 1));
		sig_err_min_max 	= max(signal_error_params(:, init_shape, iter, 1));
		sig_err_min_mean 	= mean(signal_error_params(:, init_shape, iter, 1));
		sig_err_min_std 	= std(signal_error_params(:, init_shape, iter, 1));

		sig_err_max_min 	= min(signal_error_params(:, init_shape, iter, 2));
		sig_err_max_max 	= max(signal_error_params(:, init_shape, iter, 2));
		sig_err_max_mean 	= mean(signal_error_params(:, init_shape, iter, 2));
		sig_err_max_std 	= std(signal_error_params(:, init_shape, iter, 2));

		sig_err_mean_min 	= min(signal_error_params(:, init_shape, iter, 3));
		sig_err_mean_max 	= max(signal_error_params(:, init_shape, iter, 3));
		sig_err_mean_mean 	= mean(signal_error_params(:, init_shape, iter, 3));
		sig_err_mean_std 	= std(signal_error_params(:, init_shape, iter, 3));

		sig_err_std_min 	= min(signal_error_params(:, init_shape, iter, 4));
		sig_err_std_max 	= max(signal_error_params(:, init_shape, iter, 4));
		sig_err_std_mean 	= mean(signal_error_params(:, init_shape, iter, 4));
		sig_err_std_std 	= std(signal_error_params(:, init_shape, iter, 4));

		sig_err_meansq_min 	= min(signal_error_params(:, init_shape, iter, 5));
		sig_err_meansq_max 	= max(signal_error_params(:, init_shape, iter, 5));
		sig_err_meansq_mean = mean(signal_error_params(:, init_shape, iter, 5));
		sig_err_meansq_std 	= std(signal_error_params(:, init_shape, iter, 5));

		sig_err_energy_min 	= min(signal_error_params(:, init_shape, iter, 6));
		sig_err_energy_max 	= max(signal_error_params(:, init_shape, iter, 6));
		sig_err_energy_mean = mean(signal_error_params(:, init_shape, iter, 6));
		sig_err_energy_std 	= std(signal_error_params(:, init_shape, iter, 6));
	end
end

sig_err_min_min
sig_err_min_max
sig_err_min_mean
sig_err_min_std

sig_err_max_min
sig_err_max_max
sig_err_max_mean
sig_err_max_std

sig_err_mean_min
sig_err_mean_max
sig_err_mean_mean
sig_err_mean_std

sig_err_std_min
sig_err_std_max
sig_err_std_mean
sig_err_std_std

sig_err_meansq_min
sig_err_meansq_max
sig_err_meansq_mean
sig_err_meansq_std

sig_err_energy_min
sig_err_energy_max
sig_err_energy_mean
sig_err_energy_std
