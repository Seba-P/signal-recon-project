
function fir_resp = gen_fir_resp()

    K   = 95;           % FIR filter order
    Fp  = 100e3;        % 100 kHz passband-edge frequency
    Fs  = 1000e3;       % 1 MHz sampling frequency
    Rp  = 0.00057565;   % Corresponds to 0.01 dB peak-to-peak ripple
    Rst = 0.001;        % Corresponds to 60 dB stopband attenuation

    fir_resp = firceqrip(K,Fp/(Fs/2),[Rp Rst],'passedge');
    fvtool(fir_resp,'Fs',Fs,'Color','White')                % Visualize filter

end
