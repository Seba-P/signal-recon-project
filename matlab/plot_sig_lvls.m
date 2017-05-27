
function plot_sig_lvls(fig, sig_lvls, t)
    
    N_sig_lvls  = length(sig_lvls);
    N_sig       = length(t);
    
    for i = 1:N_sig_lvls-1
       lvl_line(1:N_sig)    = sig_lvls(i);
       sublvl_line(1:N_sig) = (sig_lvls(i) + sig_lvls(i+1)) / 2;
       h = plot(fig, t, lvl_line, '--k', t, sublvl_line, '--k');
       set(h, {'LineWidth'}, {2; 1})
    end

    lvl_line(1:N_sig) = sig_lvls(N_sig_lvls);
    plot(fig, t, lvl_line, '--k','LineWidth', 2) 
    
end
