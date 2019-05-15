% Task 2: plot the Gaussian distribution
% Define constants
f_0 = 10e6;
ohm = 50e-9;
d_t = 10e-9;

% define t scale
t = -4*ohm:d_t:4*ohm;

% Use the function
[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);
plot(t./1e-6,G_t);
xlabel('Time [us]');
ylabel('Amplitude [a.u.]');
title('Gaussian tone burst');
