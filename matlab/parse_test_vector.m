
function [ parameters, sig_lvls, samples, signal_original, signal_reconstructed ] = parse_test_vector(test_vector, verbose = 0)

    curr_dir = pwd();
    addpath(curr_dir);

    [ vector_dir vector_name vector_ext ]  = fileparts(test_vector);

    cd(vector_dir);

    % Unpack test_vector
    unpack(sprintf('%s%s', vector_name, vector_ext));

    printf('Parsing test vector "%s"...\n', vector_name)

    % Extract simulation parameters
    fd = fopen(sprintf('%s/readme.txt', vector_name), 'r');

    fskipl(fd); % fprintf(fd, '# Test vector "%s".\n', vector_name, "C");
    fskipl(fd); % fprintf(fd, '# Generated on %s.\n', datestr(clock()), "C");
    fskipl(fd); % fprintf(fd, '\n', "C");
    SEED      = fscanf(fd, '$ SEED:     %u\n', "C");
    DOWNRATE  = fscanf(fd, '$ DOWNRATE: %u\n', "C");
    K         = fscanf(fd, '$ K:        %u\n', "C");

    fclose(fd);

    % Extract configuration for POCS engine
    fd = fopen(sprintf('%s/config.txt', vector_name), 'r');

    fskipl(fd); % fprintf(fd, '##### PARAMETERS #####\n', "C");
    fskipl(fd); % fprintf(fd, '\n', "C");
    fskipl(fd); % fprintf(fd, '>>> PARAMS <<<\n', "C");
    N_sig_lvls  = fscanf(fd, '$ LVLS_NUM:   %u\n', "C");
    lvl0        = fscanf(fd, '$ INIT_LVL:   %u\n', "C");
    n_iter      = fscanf(fd, '$ ITER_NUM:   %u\n', "C");
    init_guess  = fscanf(fd, '$ INIT_GUESS: %u\n', "C");
    % fskipl(fd); % fprintf(fd, '\n', "C");
    fskipl(fd); % fprintf(fd, '##### SIGNAL LVLS #####\n', "C");

    sig_lvls = 1:N_sig_lvls;

    for i = 1:N_sig_lvls
        if (mod(i,2))
            fskipl(fd); % fprintf(fd, '\n', "C");
            fskipl(fd); % fprintf(fd, '>>> LVL_VAL_%02u_%02u <<<\n', i-1, i, "C");
        end

        tmp_str = fgetl(fd);
        sig_lvls(i) = sscanf(substr(tmp_str, -6), '0x%04x\n', "C");
    end

    sig_lvls = sig_lvls - 65536*(sig_lvls>32767);
    sig_lvls = cast(1 / 32768 * sig_lvls, 'single');

    fclose(fd);

    % Print extracted parameters
    if (verbose)
        printf('### PARAMETERS: ###\n')
        printf('SEED = %u; DOWNRATE = %u; K = %u;\n',
                    SEED, DOWNRATE, K)
        printf('LVLS_NUM = %u; INIT_LVL = %u; ITER_NUM = %u; INIT_GUESS = %u;\n',
                    N_sig_lvls, lvl0, n_iter, init_guess)

        printf('### SIGNAL LVLS: ###\n')
        for i = 1:N_sig_lvls
            printf('LVL_VAL_%02u = 0x%04X; ', i-1, sig_lvls(i))
        end
        printf('\n')
    end

    % Extract set of samples
    samples = load_samples(sprintf('%s/samples.txt', vector_name), 'text');

    % Extract original & reconstructed signals if applicable
    signal_original       = load_signal(sprintf('%s/signal_original.txt', vector_name), 'text');
    signal_reconstructed  = load_signal(sprintf('%s/signal_reconstructed.txt', vector_name), 'text');

    % % Archive test_vector and clean up the files
    % tar(sprintf('%s.tar', vector_name), sprintf('%s/*', vector_name));

    % confirm_recursive_rmdir(0);
    % rmdir(sprintf('%s', vector_name), 's');

    parameters = [SEED, DOWNRATE, K, N_sig_lvls, lvl0, n_iter, init_guess];

    cd(curr_dir);
end
