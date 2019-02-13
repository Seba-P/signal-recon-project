
function plot_uniform_samples(fig, signal, step, t, plot_peak = 0)
    
    for i = step:step:length(signal)
        if (plot_peak)
            plot(fig, [t(i) t(i)], [signal(i) 0], '--m', 'LineWidth', 1);
        end

        plot(fig, t(i), signal(i), '*m', 'LineWidth', 4)
    end

end
