
function [samples, lvl0] = lvl_cross_samples(signal, sig_lvls)
    
    N_signal    = length(signal);
    N_sig_lvls  = length(sig_lvls);
    
    samples = [];
    
    curr_lvl = find(sig_lvls > signal(1), 1);
    if isempty(curr_lvl)
        curr_lvl = N_sig_lvls;
    end
    lvl0        = curr_lvl;
    upper_limit = sig_lvls(min(N_sig_lvls, curr_lvl+1));
    lower_limit = sig_lvls(curr_lvl);
    curr_time   = 0;
    
    for i = 2:N_signal
        curr_time = curr_time + 1;
        if signal(i) > upper_limit
            if curr_lvl == N_sig_lvls
                continue
            end
            samples      = [ samples; 1,curr_time ];
            curr_lvl     = curr_lvl+1;
            upper_limit  = sig_lvls(min(N_sig_lvls, curr_lvl+1));
            lower_limit  = sig_lvls(curr_lvl);
            curr_time    = 0;
        elseif signal(i) < lower_limit
            if curr_lvl == 1
                upper_limit = sig_lvls(curr_lvl);
                continue
            end
            samples      = [ samples; 0,curr_time ];
            curr_lvl     = curr_lvl-1;
            upper_limit  = sig_lvls(curr_lvl+1);
            lower_limit  = sig_lvls(curr_lvl);
            curr_time    = 0;
        end
    end
    
end
