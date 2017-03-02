
function lvls = samples2lvls(samples, sig_lvls)

    N_samples   = length(samples);
    N_lvls      = length(sig_lvls);
    time_total  = sum(samples(:,2));
    
    lvls = zeros(1, time_total + 1);
    
    curr_lvl     = 1;
    curr_time    = 1;
        
    for i = 1:N_samples
        for k = 1:samples(i,2)
            lvls(curr_time) = sig_lvls(curr_lvl);
            curr_time = curr_time + 1;
        end
        
        curr_lvl = curr_lvl + 2 * samples(i,1) - 1;
    end
    
    lvls(time_total+1) = sig_lvls(curr_lvl);

end
