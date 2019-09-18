
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

DUMP_SIGNAL = 1;

DOWNRATE    = 40;
K           = 62;
N_ITER      = 99;
SEED_RANGE  = 0:99;

fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
fir_R       = length(fir_resp);
fir_delay   = ceil(fir_R / 2);
fir_tail    = floor(fir_R / 2);

more off
for seed = SEED_RANGE
	[ x t lvl ] = generate_bursty_signal(seed);

	xs = pick_samples(x, DOWNRATE);
	ts = pick_samples(t, DOWNRATE);

	signal   = xs;
	sig_lvls = lvl(:,1)';
	dts      = ts(2)-ts(1);

	for init_shape = 1:2
		if (init_shape == 1)
			INIT_GUESS = 'piecewise-constant';
		else
			INIT_GUESS = 'piecewise-linear';
		end

		[samples, lvl0, lvls] = gen_samples_and_init_guess(xs, ts, (lvl(:,1))', INIT_GUESS, 0);

		if (DUMP_SIGNAL)
			[ filt_sig, filt_lvls, ver_lvls ] = process_signal(signal, lvls, sig_lvls, fir_resp, N_ITER, 'normal');
		end

		for iter = 1:N_ITER
			printf('Generating test vector "vector_seed_%03u_iter_%02u_mode_%02u"...\n', seed, iter, init_shape)
			generate_test_vector(sprintf('vector_seed_%03u_iter_%02u_mode_%02u', seed, iter, init_shape), lvl0, sig_lvls, iter, INIT_GUESS,
									samples, signal, ver_lvls(iter, 1:end), [ seed DOWNRATE K ]);
		end
	end
end
more on
