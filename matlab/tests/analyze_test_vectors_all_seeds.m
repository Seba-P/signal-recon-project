
pkg load signal

addpath([ pwd(), '/../' ]);

VERBOSE     = 0;
DO_PLOT     = 1;

N_ITER      = 99;
SEED_RANGE  = 0:99;
% Nice seeds: 1
% Bad seeds:  0

dts         = 0.001;
seed_idx    = 1;

signal_error_params = zeros(length(SEED_RANGE), N_ITER, 3);
error_energy_params = zeros(length(SEED_RANGE), N_ITER, 3);

more off
for seed = SEED_RANGE
    for init_shape = 1:2
        for iter = 1:N_ITER
            parameters = analyze_test_vector(sprintf('../vectors/vector_seed_%03u_iter_%02u_mode_%02u.tar', seed, iter, init_shape), VERBOSE, DO_PLOT);

            signal_error_params(seed_idx, iter) = parameters(1); error_energy_params(seed_idx, iter) = parameters(2);
        end
    end

    seed_idx = seed_idx + 1;
end
more on
