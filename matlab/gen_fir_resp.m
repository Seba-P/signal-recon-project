
function fir_resp = gen_fir_resp(K = 95, Fp_div_Fs_2 = 0.08, ...
                                    output_file = 'fir_coeffs.txt', do_plot = 0)

    addpath('../toolbox')

    Rp  = 0.00057565;   % Corresponds to 0.01 dB peak-to-peak ripple
    Rst = 0.001;        % Corresponds to 60 dB stopband attenuation

    fir_resp = firceqrip(K, Fp_div_Fs_2, [Rp Rst],'passedge');
    [h1, w1]    = freqz(fir_resp);

    if(do_plot)
        freqz_plot(w1, h1, 1);
    end
    save(output_file, 'fir_resp', '-ascii');

end
