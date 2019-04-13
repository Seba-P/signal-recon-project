
function samples_struct = generate_test_vector(vector_name, lvl0, sig_lvls, n_iter, samples)

    mkdir('../vectors/', vector_name);

    % Generate configuration for POCS engine
    fd = fopen(sprintf('../vectors/%s/config.txt', vector_name), 'w');

    N_sig_lvls = length(sig_lvls);

    fprintf(fd, '##### PARAMETERS #####\n');
    fprintf(fd, '\n');
    fprintf(fd, '>>> PARAMS <<<\n');
    fprintf(fd, '$ LVLS_NUM: %u\n', N_sig_lvls);
    fprintf(fd, '$ INIT_LVL: %u\n', lvl0);
    fprintf(fd, '$ ITER_NUM: %u\n', n_iter);
    fprintf(fd, '\n');
    fprintf(fd, '##### SIGNAL LVLS #####\n', n_iter);

    for i = 1:N_sig_lvls
        if (mod(i,2))
            fprintf(fd, '\n');
            fprintf(fd, '>>> LVL_VAL_%02u_%02u <<<\n', i-1, i);
        end

        fprintf(fd, '$ LVL_VAL_%02u: 0x%04X\n', i-1, floor(32768*(sig_lvls(i) + 2*(sig_lvls(i) < 0))));
    end

    fclose(fd);

    % Generate set of samples
    save_samples(sprintf('../vectors/%s/samples.txt', vector_name), samples, 'text');

end
