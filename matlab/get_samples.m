
function [samples, lvl0] = get_samples(signal, sig_lvls)

    N_signal    = length(signal);
    N_sig_lvls  = length(sig_lvls);
    
    samples = [];
    
    for curr_lvl = 1:N_sig_lvls
        if signal(1) < sig_lvls(curr_lvl)
           break; 
        end
    end
    
    curr_lvl    = curr_lvl - 1;
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
