
function [samples, lvl0] = lvl_cross_samples(signal, sig_lvls)

    N_signal    = length(signal);
    N_sig_lvls  = length(sig_lvls);
    
    samples = [];
        
    curr_lvl = max(find(sig_lvls > signal(1), 1) - 1, 1);
    if isempty(curr_lvl)
       curr_lvl = sig_lvls(end); 
    end
    lvl0        = curr_lvl;
    curr_time   = 0;
    
    for i = 2:N_signal
        curr_time = curr_time + 1;
       if signal(i) >= sig_lvls(min(length(sig_lvls), curr_lvl+1))
           samples      = [ samples; 1,curr_time ];
           curr_lvl     = min(length(sig_lvls), curr_lvl+1); 
           curr_time    = 0;
       elseif signal(i) <= sig_lvls(max(1, curr_lvl-1))
           samples      = [ samples; 0,curr_time ];
           curr_lvl     = max(1, curr_lvl-1); 
           curr_time    = 0;
       end
    end

end
