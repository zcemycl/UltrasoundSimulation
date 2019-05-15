function [G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t)
    t = -4*ohm:d_t:4*ohm ;
    ohm = ohm + eps;
    [F_0,OHM,T] = ndgrid(f_0,ohm,t);
    
    G = exp(-T.^2 ./(2.*OHM.^2)).*sin(2*pi.*F_0.*T);

    % steps
    dt = d_t;
    df = 1;
    do = 1;
    
    % G_t
    G2 = sum(G,1)*df;
    G1 = sum(G2,2)*do;
    G_t = G1(:);
end