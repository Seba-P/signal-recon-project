
function [ signal_error_params, error_energy_params ] = analyze_test_vector(test_vector, verbose = 0, do_plot = 0)

    curr_dir = pwd();
    addpath(curr_dir);

    [ vector_dir vector_name vector_ext ]  = fileparts(test_vector);

    [ parameters, sig_lvls, samples, signal_original, signal_reconstructed ] = parse_test_vector(test_vector, verbose);

    SEED = parameters(1); DOWNRATE = parameters(2); K = parameters(3);
    N_sig_lvls = parameters(4); lvl0 = parameters(5); n_iter = parameters(6); init_guess = parameters(7);

    printf('Analyzing test vector "%s"...\n', vector_name)

    cd([ vector_dir, '/', vector_name ]);

    % Calculate some useful stuff
    signal_error  = signal_original - signal_reconstructed;
    error_energy  = signal_error.^2;

    min_sig_err = min(abs(signal_error)); max_sig_err = max(abs(signal_error)); mean_sig_err = mean(abs(signal_error));
    min_err_eng = min(abs(error_energy)); max_err_eng = max(abs(error_energy)); mean_err_eng = mean(abs(error_energy));

    mkdir('./', 'analysis');

    % Dump calculated parameters
    fd = fopen('analysis/calc_params.txt', 'w');

    fprintf(fd, '# Test vector "%s".\n', vector_name);
    fprintf(fd, '# Analyzed on %s.\n', datestr(clock()));
    fprintf(fd, '\n');
    fprintf(fd, '$ SIGNAL_ERROR_MIN:  %u\n', min_sig_err);
    fprintf(fd, '$ SIGNAL_ERROR_MAX:  %u\n', max_sig_err);
    fprintf(fd, '$ SIGNAL_ERROR_MEAN: %u\n', mean_sig_err);
    fprintf(fd, '\n');
    fprintf(fd, '$ ERROR_ENERGY_MIN:  %u\n', min_err_eng);
    fprintf(fd, '$ ERROR_ENERGY_MAX:  %u\n', max_err_eng);
    fprintf(fd, '$ ERROR_ENERGY_MEAN: %u\n', mean_err_eng);

    fclose(fd);

    fd = fopen('analysis/signal_error.txt', 'w');
    fprintf(fd, '%f\n', signal_error);
    fclose(fd);

    fd = fopen('analysis/error_energy.txt', 'w');
    fprintf(fd, '%f\n', error_energy);
    fclose(fd);

    cd(curr_dir);

    signal_error_params = [ min_sig_err max_sig_err mean_sig_err ];
    error_energy_params = [ min_err_eng max_err_eng mean_err_eng ];

    if (do_plot)
        dts = 0.001;
        tn  = 0:dts:dts*(length(signal_original)-1);

        % Plot filtered signals and mark levels
        figure
        fig1 = subplot(2, 1, 1);
        hold(fig1, 'on');
        grid(fig1, 'on');
        set(gca, 'GridLineStyle', ':')
        set(gca, 'xtick', [0:5:90])
        set(gca, 'ytick', [-1:0.05:1])

        xlabel(fig1, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
        ylabel(fig1, 'Signal value', 'FontSize', 24, 'FontWeight', 'bold')
        title(fig1, 'Signal reconstruction', 'FontSize', 24, 'FontWeight', 'bold')

        plot_samples(fig1, samples, sig_lvls, lvl0, tn, 0)
        plot_sig_lvls(fig1, sig_lvls, tn, 1)
        plot_sig_limits(fig1, samples, sig_lvls, lvl0, tn)

        if (init_guess == 2)
            lvls = samples2linear(samples, length(tn), sig_lvls, lvl0);
            p_init = plot(fig1, tn, lvls, '-r', 'LineWidth', 4);
        else    
            lvls = samples2lvls(samples, length(tn), sig_lvls, lvl0);
            p_init = stairs(fig1, tn, lvls, '-r', 'LineWidth', 4);
        end

        p_orig  = plot(fig1, tn, signal_original, '-b', 'LineWidth', 4);
        p_recon = plot(fig1, tn, signal_reconstructed, '-m', 'LineWidth', 4);

        axis([ tn(1) tn(end) min(signal_original)-0.1 max(signal_original)+0.1 ])
        % legend([ p_init p_orig p_recon ], 'init guess', 'original', 'reconstructed', 'FontSize', 24, 'FontWeight', 'bold')
        legend([ p_init p_orig p_recon ], 'init guess', 'original', 'reconstructed')

        fig2 = subplot(2, 1, 2);
        hold(fig2, 'on');
        grid(fig2, 'on');
        set(gca, 'GridLineStyle', ':')
        set(gca, 'xtick', [0:5:90])
        set(gca, 'ytick', [-1:0.05:1])

        xlabel(fig2, 'Time', 'FontSize', 24, 'FontWeight', 'bold')
        ylabel(fig2, 'Error value', 'FontSize', 24, 'FontWeight', 'bold')
        title(fig2, 'Reconstruction error', 'FontSize', 24, 'FontWeight', 'bold')

        p_sigerr = plot(fig2, tn, signal_error, '-m', 'LineWidth', 4);

        % axis([ tn(1) tn(end) min(signal_original)-0.1 max(signal_original)+0.1 ])
        axis([ tn(1) tn(end) min(signal_error)-0.1 max(signal_error)+0.1 ])
    end

end
