
function lvls = samples2lvls(samples, N_sig, sig_lvls, lvl0)
    
    N_samples   = length(samples);
    N_lvls      = length(sig_lvls);
    lvls_step   = [sig_lvls(2:end) - sig_lvls(1:end-1), sig_lvls(end) - sig_lvls(end-1)];

    lvls = zeros(1, N_sig);
    
    curr_lvl     = lvl0;
    curr_time    = 1;
        
    for i = 1:N_samples
        for k = 1:samples(i,2)
            lvls(curr_time) = sig_lvls(curr_lvl) + 0.5*lvls_step(curr_lvl);
            curr_time = curr_time + 1;
        end
        
        curr_lvl = min(N_lvls, max(1, curr_lvl+2*samples(i,1)-1));
    end
    
    lvls(curr_time:N_sig) = sig_lvls(curr_lvl) + 0.5*lvls_step(curr_lvl);
    
end
