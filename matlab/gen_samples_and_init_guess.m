
function [samples, lvl0, lvls] = gen_samples_and_init_guess(signal, t, sig_lvls, init_shape = 'piecewise-constant', do_plot = 0)

    % Signal parameters
    dt      = t(2)-t(1);
    fs      = 1/dt;
    N_sig   = length(t);

    % Level-crossing parameters
    N_sig_lvls  = length(sig_lvls);

    % "Analog" signal
    [samples, lvl0] = lvl_cross_samples(signal, sig_lvls);

    if strcmp(tolower(init_shape), 'piecewise-linear')
        lvls = samples2linear(samples, N_sig, sig_lvls, lvl0);
    else
        lvls = samples2lvls(samples, N_sig, sig_lvls, lvl0);
    end

    if (do_plot)
        % Frequency spectrum of input/output signals
        LVLS    = fftshift(fft(lvls/N_sig));
        SIGNAL  = fftshift(fft(signal/N_sig));
        freq_s  = linspace(-fs/2, fs/2, N_sig);

        % Plot signals' frequency spectrum magnitude
        figure 
        fig1 = subplot(1, 1, 1);
        hold(fig1, 'on');
        xlabel(fig1, 'Frequency')
        ylabel(fig1, 'Magnitude')
        title(fig1, 'Frequency spectrum')

        grid on
        grid minor
        plot(fig1, freq_s, abs(LVLS)/max(abs(LVLS)), 'r')
        plot(fig1, freq_s, abs(SIGNAL)/max(abs(SIGNAL)), 'b')

        figure
        fig1 = subplot(1, 1, 1);    % "analog" signal
        hold(fig1, 'on');
        xlabel(fig1, 'Time')
        ylabel(fig1, 'Signal value')

        plot_sig_lvls(fig1, sig_lvls, t)
        plot(fig1, t, signal, '-b')
        stairs(fig1, t, lvls, '-r')
    end

end
