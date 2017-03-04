% Common settings
time        = 0:0.01:2*pi;
N_sig       = length(time);
sig_lvls    = 0:7;

% TESTCASE 1 $
signal_1      = 3.5 + 3.2*sin(time);

[samples_1, lvl0_1] = get_samples(signal_1, sig_lvls);
lvls_1 = samples2lvls(samples_1, N_sig, sig_lvls, lvl0_1);

figure
hold
stairs(time, lvls_1, '-r')
plot(time, signal_1, '-b')

% TESTCASE 2 $
signal_2      = 3.5 + 1.2*sin(time) + 2*rand(1,length(time));

[samples_2, lvl0_2] = get_samples(signal_2, sig_lvls);
lvls_2 = samples2lvls(samples_2, N_sig, sig_lvls, lvl0_2);

figure
hold
stairs(time, lvls_2, '-r')
plot(time, signal_2, '-b')

% TESTCASE 3 $
signal_3      = 3 + 3*square(time);

[samples_3, lvl0_3] = get_samples(signal_3, sig_lvls);
lvls_3 = samples2lvls(samples_3, N_sig, sig_lvls, lvl0_3);

figure
hold
stairs(time, lvls_3, '-r')
plot(time, signal_3, '-b')
