
function lvls = samples2linear(samples, N_sig, sig_lvls, lvl0)
    
    N_samples   = length(samples);
    N_lvls      = length(sig_lvls);
    lvls_step   = [sig_lvls(2:end) - sig_lvls(1:end-1), sig_lvls(end) - sig_lvls(end-1)];

    lvls = zeros(1, N_sig);
    
    curr_lvl        = lvl0;
    curr_cross_dir  = samples(1,1);
    curr_time       = 1;


    for i = 1:N_samples
        prev_cross_dir  = curr_cross_dir;
        curr_cross_dir  = samples(i,1);
        point_step      = lvls_step(curr_lvl) / samples(i,2);

        for k = 1:samples(i,2)
            delta = (k-1)*point_step*(2*curr_cross_dir-1);

            if (k > samples(i,2)/2)
                if (curr_cross_dir == prev_cross_dir)
                    wave = delta;
                else
                    wave = (2*prev_cross_dir-1)*lvls_step(curr_lvl) + delta;
                end
            else
                if (curr_cross_dir == prev_cross_dir)
                    wave = delta;
                else
                    wave = -delta;
                end
            end

            if (prev_cross_dir)
                lvls(curr_time) = sig_lvls(curr_lvl) + wave;
            else 
                lvls(curr_time) = sig_lvls(curr_lvl) + wave + lvls_step(curr_lvl);
            end

            curr_time = curr_time + 1;
        end
        
        curr_lvl = min(N_lvls, max(1, curr_lvl+2*curr_cross_dir-1));
    end

    point_step = 0.5*lvls_step(curr_lvl)/(N_sig-curr_time);

    for k = 1:N_sig-curr_time
        delta = (k-1)*point_step*(2*curr_cross_dir-1);

        if (curr_cross_dir)
            lvls(curr_time) = sig_lvls(curr_lvl) + delta;
        else
            lvls(curr_time) = sig_lvls(curr_lvl) + delta + lvls_step(curr_lvl);
        end

        curr_time = curr_time + 1;
    end

end
