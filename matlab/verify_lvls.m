
function ver_lvls = verify_lvls(filt_lvls, lvls, sig_lvls)
    
    N_sig_lvls  = length(sig_lvls);
    N_signal    = length(filt_lvls);
    lvls_step   = [sig_lvls(2:end) - sig_lvls(1:end-1), sig_lvls(end) - sig_lvls(end-1)];
    fir_R       = N_signal - length(lvls);
    fir_delay   = ceil(fir_R/2);
    fir_tail    = fir_R - fir_delay;
    
    lvls_del = [ zeros(1, fir_delay), lvls, zeros(1, fir_tail)];
    
    curr_time   = 0;
    ver_lvls    = zeros(1,length(lvls_del));
    
    for i = 1:N_signal
       curr_time = curr_time + 1;
       curr_lvl = max(find(sig_lvls > lvls_del(curr_time), 1) - 1, 1);
       if isempty(curr_lvl)
          curr_lvl = sig_lvls(end); 
       end
       
       ver_lvls(i) = min(sig_lvls(min(length(sig_lvls), curr_lvl+1)), max(sig_lvls(max(1, curr_lvl-1)), filt_lvls(i)));
    end
    
end
