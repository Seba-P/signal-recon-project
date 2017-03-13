
function sig = pick_samples(signal, step)

    N_signal = length(signal);
    sig = signal(1:step:N_signal);

end
