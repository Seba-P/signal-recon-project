

fs_dt   = 1000000;      % 1 MHz "analog" sampling rate
dt      = 1/fs_dt;      % 1 us sampling period
t       = 0:dt:0.02;	% time distance

fs = 44000;
f_sig = 1000;
step = floor(fs_dt/fs);
signal = 1.2*sin(2*pi*f_sig*t);
sig = undersampl(signal, step);

signal_n = signal + 0.9*sin(2*pi*10000*t);
sig_n = pick_samples(signal_n, step);
sig_n_filt = conv(fir_resp, sig_n);

figure
hold
plot(t, signal_n, 'b')
plot(0:dt*step:0.02, sig_n, '.r')
plot(0:dt*step:dt*step*(length(sig_n_filt)-1), sig_n_filt, 'g', 'LineWidth', 3)
