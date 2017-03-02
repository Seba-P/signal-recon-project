samples     = [ 1,4; 1,2; 0,5; 1,3; 1,6; 0,4; 0,5 ];
sig_lvls    = 0:7;

lvls = samples2lvls(samples, sig_lvls);

figure
stairs(lvls, '-bo')
