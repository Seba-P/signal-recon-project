
function plot_sig_limits(fig, samples, sig_lvls, lvl0, t)

    N_sig_lvls  = length(sig_lvls);

    curr_lvl    = lvl0;
    upper_limit = sig_lvls(lvl0+1);
    lower_limit = sig_lvls(lvl0);

    start_t = t(1);
    end_t   = t(1);
    dt      = t(2)-t(1);

    for i = 1:length(samples)
        start_t = end_t;
        end_t   = end_t + samples(i,2)*dt;

        x   = start_t:dt:end_t;
        y_u = ones(size(x)) * upper_limit;
        y_l = ones(size(x)) * lower_limit;

        fill(fig, [x flip(x)], [y_u y_l], 0.9*[1 1 1], 'EdgeColor', 'none')

        if (samples(i,1))
            if (curr_lvl >= N_sig_lvls-1)
              upper_limit = 1;
            else
              upper_limit = sig_lvls(curr_lvl+2);
            end

            lower_limit = sig_lvls(curr_lvl+1);
            curr_lvl    = curr_lvl + ~(curr_lvl == N_sig_lvls);
        else
            upper_limit = sig_lvls(curr_lvl);

            if (curr_lvl == 1)
              lower_limit = -1;
              curr_lvl    = 1;
            else
              lower_limit = sig_lvls(curr_lvl-1);
              curr_lvl    = curr_lvl - 1;
            end
        end
    end

    x   = end_t:dt:t(end);
    y_u = ones(size(x)) * upper_limit;
    y_l = ones(size(x)) * lower_limit;

    fill(fig, [x flip(x)], [y_u y_l], 0.9*[1 1 1], 'EdgeColor', 'none')
    
end
