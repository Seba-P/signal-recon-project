
function [ signal_error_params, signal_orig_params, signal_recon_params ] = analyze_test_vector(test_vector, verbose = 0, do_plot = 0)

    curr_dir = pwd();
    addpath(curr_dir);

    [ vector_dir vector_name vector_ext ]  = fileparts(test_vector);

    [ parameters, sig_lvls, samples, signal_original, signal_reconstructed ] = parse_test_vector(test_vector, verbose);

    SEED = parameters(1); DOWNRATE = parameters(2); K = parameters(3);
    N_sig_lvls = parameters(4); lvl0 = parameters(5); n_iter = parameters(6); init_guess = parameters(7);

    printf('Analyzing test vector "%s"...\n', vector_name)

    cd([ vector_dir, '/', vector_name ]);

    % Calculate some useful stuff
    signal_error = signal_original - signal_reconstructed;

    sig_err_min = min(signal_error); sig_err_max = max(signal_error); sig_err_mean = mean(signal_error);
    sig_err_std = std(signal_error); sig_err_meansq = meansq(signal_error); sig_err_energy = sum(signal_error.^2);

    sig_orig_min = min(signal_original); sig_orig_max = max(signal_original); sig_orig_mean = mean(signal_original);
    sig_orig_std = std(signal_original); sig_orig_meansq = meansq(signal_original); sig_orig_energy = sum(signal_original.^2);

    sig_recon_min = min(signal_reconstructed); sig_recon_max = max(signal_reconstructed); sig_recon_mean = mean(signal_reconstructed);
    sig_recon_std = std(signal_reconstructed); sig_recon_meansq = meansq(signal_reconstructed); sig_recon_energy = sum(signal_reconstructed.^2);

    mkdir('./', 'analysis');

    % Dump calculated parameters
    fd = fopen('analysis/calc_params.txt', 'w');

    fprintf(fd, '# Test vector "%s".\n', vector_name);
    fprintf(fd, '# Analyzed on %s.\n', datestr(clock()));
    fprintf(fd, '\n');
    fprintf(fd, '$ SIGNAL_ERROR_MIN:     %u\n', sig_err_min);
    fprintf(fd, '$ SIGNAL_ERROR_MAX:     %u\n', sig_err_max);
    fprintf(fd, '$ SIGNAL_ERROR_MEAN:    %u\n', sig_err_mean);
    fprintf(fd, '$ SIGNAL_ERROR_STD:     %u\n', sig_err_std);
    fprintf(fd, '$ SIGNAL_ERROR_MEANSQ:  %u\n', sig_err_meansq);
    fprintf(fd, '$ SIGNAL_ERROR_ENERGY:  %u\n', sig_err_energy);
    fprintf(fd, '\n');
    fprintf(fd, '$ SIGNAL_ORIG_MIN :     %u\n', sig_orig_min);
    fprintf(fd, '$ SIGNAL_ORIG_MAX :     %u\n', sig_orig_max);
    fprintf(fd, '$ SIGNAL_ORIG_MEAN :    %u\n', sig_orig_mean);
    fprintf(fd, '$ SIGNAL_ORIG_STD :     %u\n', sig_orig_std);
    fprintf(fd, '$ SIGNAL_ORIG_MEANSQ :  %u\n', sig_orig_meansq);
    fprintf(fd, '$ SIGNAL_ORIG_ENERGY :  %u\n', sig_orig_energy);
    fprintf(fd, '\n');
    fprintf(fd, '$ SIGNAL_RECON_MIN:     %u\n', sig_recon_min);
    fprintf(fd, '$ SIGNAL_RECON_MAX:     %u\n', sig_recon_max);
    fprintf(fd, '$ SIGNAL_RECON_MEAN:    %u\n', sig_recon_mean);
    fprintf(fd, '$ SIGNAL_RECON_STD:     %u\n', sig_recon_std);
    fprintf(fd, '$ SIGNAL_RECON_MEANSQ:  %u\n', sig_recon_meansq);
    fprintf(fd, '$ SIGNAL_RECON_ENERGY:  %u\n', sig_recon_energy);

    fclose(fd);

    fd = fopen('analysis/signal_error.txt', 'w');
    fprintf(fd, '%f\n', signal_error);
    fclose(fd);

    cd(curr_dir);

    signal_error_params = [ sig_err_min sig_err_max sig_err_mean sig_err_std sig_err_meansq sig_err_energy ];
    signal_orig_params  = [ sig_orig_min sig_orig_max sig_orig_mean sig_orig_std sig_orig_meansq sig_orig_energy ];
    signal_recon_params = [ sig_recon_min sig_recon_max sig_recon_mean sig_recon_std sig_recon_meansq sig_recon_energy ];

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

        p_sigerr = plot(fig2, tn, signal_error, '-g', 'LineWidth', 4);

        % axis([ tn(1) tn(end) min(signal_original)-0.1 max(signal_original)+0.1 ])
        axis([ tn(1) tn(end) min(signal_error)-0.1 max(signal_error)+0.1 ])
    end

end
