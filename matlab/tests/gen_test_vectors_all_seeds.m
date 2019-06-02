
pkg load signal
addpath('../')
addpath('../toolbox/')
addpath('../bursty-lib/')

DUMP_SIGNAL = 1;

more off
for seed = 0:999
	[ x t lvl ] = generate_bursty_signal(seed);

	DOWNRATE    = 40;
	K           = 62;
	N_ITER      = 2;
	INIT_GUESS  = 'piecewise-constant';

	xs = pick_samples(x, DOWNRATE);
	ts = pick_samples(t, DOWNRATE);

	signal   = xs;
	sig_lvls = lvl(:,1)';
	dts      = ts(2)-ts(1);
	ver_lvls = [];

	[samples, lvl0, lvls] = gen_samples_and_init_guess(xs, ts, (lvl(:,1))', INIT_GUESS, 0);

	if (DUMP_SIGNAL)
		fir_resp    = gen_fir_resp(K, DOWNRATE*0.005, '../fir_coeffs.txt', 0);
		fir_R       = length(fir_resp);
		fir_delay   = ceil(fir_R / 2);
		fir_tail    = floor(fir_R / 2);

		[ filt_sig, filt_lvls, ver_lvls ] = process_signal(signal, lvls, sig_lvls, fir_resp, N_ITER, 'normal');
		tn          = 0:dts:dts*(length(signal)-1);
	end

	printf('Generating test vector "vector_seed_%03u_iter_%02u_mode_%02u"...\n', seed, N_ITER, 0)
	generate_test_vector(sprintf('vector_seed_%03u_iter_%02u_mode_%02u', seed, N_ITER, 0), lvl0, sig_lvls, N_ITER, INIT_GUESS,
							samples, signal, ver_lvls, [ seed DOWNRATE K ]);
end
more on
