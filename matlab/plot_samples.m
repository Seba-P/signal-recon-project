
function plot_samples(fig, samples, sig_lvls, lvl0, t, plot_peak = 0)

    curr_lvl  = lvl0;
    curr_t    = t(1);
    dt        = t(2)-t(1);
    
    for i = 1:length(samples)
        if (samples(i,1))
            lvl_crossed = curr_lvl + 1;
            curr_lvl    = curr_lvl + 1;
        else
            lvl_crossed = curr_lvl;
            curr_lvl    = curr_lvl - 1;
        end

        curr_t   = curr_t + samples(i,2)*dt;

        if (plot_peak)
            plot(fig, [curr_t curr_t], [sig_lvls(lvl_crossed) 0], '--m', 'LineWidth', 1);
        end

        plot(fig, curr_t, sig_lvls(lvl_crossed), '*m', 'LineWidth', 4)
    end

end
