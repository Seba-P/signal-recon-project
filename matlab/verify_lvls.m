
function ver_lvls = verify_lvls(filt_lvls, lvls, sig_lvls)
    
    N_sig_lvls  = length(sig_lvls);
    N_signal    = length(filt_lvls);
    lvls_step   = [ sig_lvls(2:end) - sig_lvls(1:end-1), ...
                   sig_lvls(end) - sig_lvls(end-1) ];
    fir_R       = N_signal - length(lvls);
    fir_delay   = ceil(fir_R/2);
    fir_tail    = floor(fir_R/2);
    
    lvls_del = [ zeros(1, fir_delay), lvls, zeros(1, fir_tail) ];
    ver_lvls = zeros(1,length(lvls_del));
    
    for i = 1:N_signal
        curr_lvl = find(sig_lvls > lvls_del(i), 1);
        if isempty(curr_lvl)
            curr_lvl = N_sig_lvls;
            upper_limit = sig_lvls(N_sig_lvls) + lvls_step(N_sig_lvls);
        elseif curr_lvl == 1
            upper_limit = sig_lvls(1);
        else
            curr_lvl    = curr_lvl - 1;
            upper_limit = sig_lvls(curr_lvl+1);
        end
        lower_limit = sig_lvls(curr_lvl);
        
        ver_lvls(i) = min(upper_limit, max(lower_limit, filt_lvls(i)));
    end
    
end
