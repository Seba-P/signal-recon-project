
function samples_struct = generate_test_vector(vector_name, lvl0, sig_lvls, n_iter, init_shape, samples, signal_original = [], signal_reconstructed = [], params = [ NaN NaN NaN ])

    N_sig_lvls  = length(sig_lvls);
    SEED        = params(1);
    DOWNRATE    = params(2);
    K           = params(3);

    if strcmp(tolower(init_shape), 'piecewise-linear')
        init_guess = 2;
    else
        init_guess = 1;
    end

    cd('../vectors');
    mkdir('./', vector_name);

    % Dump simulation parameters
    fd = fopen(sprintf('%s/readme.txt', vector_name), 'w');

    fprintf(fd, '# Test vector "%s".\n', vector_name);
    fprintf(fd, '# Generated on %s.\n', datestr(clock()));
    fprintf(fd, '\n');
    fprintf(fd, '$ SEED:     %u\n', SEED);
    fprintf(fd, '$ DOWNRATE: %u\n', DOWNRATE);
    fprintf(fd, '$ K:        %u\n', K);

    fclose(fd);

    % Generate configuration for POCS engine
    fd = fopen(sprintf('%s/config.txt', vector_name), 'w');

    fprintf(fd, '##### PARAMETERS #####\n');
    fprintf(fd, '\n');
    fprintf(fd, '>>> PARAMS <<<\n');
    fprintf(fd, '$ LVLS_NUM:   %u\n', N_sig_lvls);
    fprintf(fd, '$ INIT_LVL:   %u\n', lvl0);
    fprintf(fd, '$ ITER_NUM:   %u\n', n_iter);
    fprintf(fd, '$ INIT_GUESS: %u\n', init_guess);
    fprintf(fd, '\n');
    fprintf(fd, '##### SIGNAL LVLS #####\n');

    for i = 1:N_sig_lvls
        if (mod(i,2))
            fprintf(fd, '\n');
            fprintf(fd, '>>> LVL_VAL_%02u_%02u <<<\n', i-1, i);
        end

        fprintf(fd, '$ LVL_VAL_%02u: 0x%04X\n', i-1, floor(32768*(sig_lvls(i) + 2*(sig_lvls(i) < 0))));
    end

    fclose(fd);

    % Generate set of samples
    save_samples(sprintf('%s/samples.txt', vector_name), samples, 'text');

    % Generate original & reconstructed signals if applicable
    if (!isempty(signal_original))
        save_signal(sprintf('%s/signal_original.txt', vector_name), signal_original, 'text');
    end

    if (!isempty(signal_reconstructed))
        save_signal(sprintf('%s/signal_reconstructed.txt', vector_name), signal_reconstructed, 'text');
    end

    % Archive test_vector and clean up the files
    tar(sprintf('%s.tar', vector_name), sprintf('%s/*', vector_name));

    confirm_recursive_rmdir(0);
    rmdir(sprintf('%s', vector_name), 's');

    cd('../tests');
end
