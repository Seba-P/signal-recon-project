
function [ filt_sig_n, filt_lvls_n, ver_lvls_n ] = process_signal(signal, lvls, sig_lvls, fir_resp, n_iter, filtering_type = 'normal')

    fir_R       = length(fir_resp);
    fir_delay   = ceil(fir_R / 2);
    fir_tail    = floor(fir_R / 2);

    filt_sig    = zeros(n_iter, length(signal));
    filt_lvls   = zeros(n_iter, length(signal));
    ver_lvls    = zeros(n_iter, length(signal));

    if strcmp(tolower(filtering_type), 'piecewise-isolated')
        p = 1;
        while p < length(signal)
            p_range = min(fir_R, length(signal)-p+1);

            filt_sig(1, p:p+p_range-1)  = conv(fir_resp, signal(p:p+p_range-1))(fir_delay:end-fir_tail);
            filt_lvls(1, p:p+p_range-1) = conv(fir_resp, lvls(p:p+p_range-1))(fir_delay:end-fir_tail);
            ver_lvls(1, p:p+p_range-1)  = verify_lvls(filt_lvls(1, p:p+p_range-1), lvls(p:p+p_range-1), sig_lvls);

            for iter = 2:n_iter
                filt_sig(iter, p:p+p_range-1)   = conv(fir_resp, filt_sig(iter-1, p:p+p_range-1))(fir_delay:end-fir_tail);
                filt_lvls(iter, p:p+p_range-1)  = conv(fir_resp, filt_lvls(iter-1, p:p+p_range-1))(fir_delay:end-fir_tail);
                ver_lvls(iter, p:p+p_range-1)   = verify_lvls(filt_lvls(iter, p:p+p_range-1), filt_lvls(iter-1, p:p+p_range-1), sig_lvls);
            end

            p = p + p_range;
        end
    elseif strcmp(tolower(filtering_type), 'piecewise-preserved') % not working properly - TBD
        filt_sig(1, 1:fir_R)  = conv(fir_resp, [zeros(1, fir_R) signal(1:fir_R)'])(fir_delay+fir_R:end-fir_tail);
        filt_lvls(1, 1:fir_R) = conv(fir_resp, [zeros(1, fir_R) lvls(1:fir_R)])(fir_delay+fir_R:end-fir_tail);
        ver_lvls(1, 1:fir_R)  = verify_lvls(filt_lvls(1, 1:fir_R), lvls(1:fir_R), sig_lvls);

        for iter = 2:n_iter
            filt_sig(iter, 1:fir_R)   = conv(fir_resp, filt_sig(iter-1, 1:fir_R))(fir_delay:end-fir_tail);
            filt_lvls(iter, 1:fir_R)  = conv(fir_resp, filt_lvls(iter-1, 1:fir_R))(fir_delay:end-fir_tail);
            ver_lvls(iter, 1:fir_R)   = verify_lvls(filt_lvls(iter, 1:fir_R), filt_lvls(iter-1, 1:fir_R), sig_lvls);
        end

        p = fir_R + 1;
        while p < length(signal)
            p_range = min(fir_R, length(signal)-p+1);
            p_pres  = p-fir_R;

            filt_sig(1, p:p+p_range-1)  = conv(fir_resp, [signal(p_pres:p_pres+fir_R-1)' signal(p:p+p_range-1)'])(fir_delay+fir_R:end-fir_tail);
            filt_lvls(1, p:p+p_range-1) = conv(fir_resp, [lvls(p_pres:p_pres+fir_R-1) lvls(p:p+p_range-1)])(fir_delay+fir_R:end-fir_tail);
            ver_lvls(1, p:p+p_range-1)  = verify_lvls(filt_lvls(1, p:p+p_range-1), lvls(p:p+p_range-1), sig_lvls);

            for iter = 2:n_iter
                filt_sig(iter, p:p+p_range-1)   = conv(fir_resp, filt_sig(iter-1, p:p+p_range-1))(fir_delay:end-fir_tail);
                filt_lvls(iter, p:p+p_range-1)  = conv(fir_resp, filt_lvls(iter-1, p:p+p_range-1))(fir_delay:end-fir_tail);
                ver_lvls(iter, p:p+p_range-1)   = verify_lvls(filt_lvls(iter, p:p+p_range-1), filt_lvls(iter-1, p:p+p_range-1), sig_lvls);
            end

            p = p + p_range;
        end
    else
        filt_sig(1, 1:end)  = (conv(fir_resp, signal))(fir_delay:end-fir_tail);
        filt_lvls(1, 1:end) = (conv(fir_resp, lvls))(fir_delay:end-fir_tail);
        ver_lvls(1, 1:end)  = verify_lvls(filt_lvls(1, 1:end), lvls, sig_lvls);

        for iter = 2:n_iter
            filt_sig(iter, 1:end)   = conv(fir_resp, filt_sig(iter-1, 1:end))(fir_delay:end-fir_tail);
            filt_lvls(iter, 1:end)  = conv(fir_resp, filt_lvls(iter-1, 1:end))(fir_delay:end-fir_tail);
            ver_lvls(iter, 1:end)   = verify_lvls(filt_lvls(iter, 1:end), filt_lvls(iter-1, 1:end), sig_lvls);
        end
    end

    filt_sig_n  = filt_sig;
    filt_lvls_n = filt_lvls;
    ver_lvls_n  = ver_lvls;

end
