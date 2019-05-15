% Task 4: Fourier Transform
% Define constants
c = 1500; % speed of Sound[ms^-1]
p_0 = 1 ; % Pressure metre[Pa m]
x = 1e-3; y = 1e-3; z = 0; % grid point [m]
x_s = 0 ; y_s = 0 ; z_s = 0 ;% source coordinate [m]
t = 0:10e-9:3e-6;

d_t = 10e-9;

% frequency array
f = linspace(0,100,301);
f = f(1:151);
% compute pressure pt and Gaussian distribution G_t
% pt
[px,py,pz,pt] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t);
for i = 1:length(pt)
if pt(i)>0
    ptplot(i) = p_0/4/pi/sqrt((x-x_s)^2+(y-y_s)^2+(z-z_s)^2);
else
    ptplot(i) = 0;
end
end

figure(1);

% ------------------------------------------------------------------ %
% f_0 = 10 MHz; ohm = 50ns;
% ------------------------------------------------------------------ %
f_01 = 10e6;
ohm1 = 50e-9;
% G_t
[G_t1] = comp_Gaussian_tone_burst(f_01,ohm1,d_t);
% Convolution
s_t1 = conv(ptplot,G_t1,'same');
% Fourier Transform
S_f1 = abs(fft(s_t1));
S_f1 = S_f1(1:151);
% plot
sp1 = subplot(3,2,1);
plot(f,S_f1);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp1,'Amplitude spectrum of Gaussian tone burst: f_0 = 10 MHz, \sigma = 50 ns');
% ------------------------------------------------------------------ %
% f_0 = 10 Mz ; ohm = 250 ns;
% ------------------------------------------------------------------ %
f_02 = 10e6;
ohm2 = 250e-9;
% G_t
[G_t2] = comp_Gaussian_tone_burst(f_02,ohm2,d_t);
% Convolution
s_t2 = conv(ptplot,G_t2,'same');
% Fourier Transform
S_f2 = abs(fft(s_t2));
S_f2 = S_f2(1:151);
% plot
sp2 = subplot(3,2,3);
plot(f,S_f2);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp2,'Amplitude spectrum of Gaussian tone burst: f_0 = 10 MHz, \sigma = 250 ns');
% ------------------------------------------------------------------ %
% f_0 = 10 Mz ; ohm = 500 ns;
% ------------------------------------------------------------------ %
f_03 = 10e6;
ohm3 = 500e-9;
% G_t
[G_t3] = comp_Gaussian_tone_burst(f_03,ohm3,d_t);
% Convolution
s_t3 = conv(ptplot,G_t3,'same');
% Fourier Transform
S_f3 = abs(fft(s_t3));
S_f3 = S_f3(1:151);
% plot
sp3 = subplot(3,2,5);
plot(f,S_f3);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp3,'Amplitude spectrum of Gaussian tone burst: f_0 = 10 MHz, \sigma = 500 ns');
% ------------------------------------------------------------------ %
% f_0 = 40 Mz ; ohm = 50 ns;
% ------------------------------------------------------------------ %
f_04 = 40e6;
ohm4 = 50e-9;
% G_t
[G_t4] = comp_Gaussian_tone_burst(f_04,ohm4,d_t);
% Convolution
s_t4 = conv(ptplot,G_t4,'same');
% Fourier Transform
S_f4 = abs(fft(s_t4));
S_f4 = S_f4(1:151);
% plot
sp4 = subplot(3,2,2);
plot(f,S_f4);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp4,'Amplitude spectrum of Gaussian tone burst: f_0 = 40 MHz, \sigma = 50 ns');
% ------------------------------------------------------------------ %
% f_0 = 40 Mz ; ohm = 250 ns;
% ------------------------------------------------------------------ %
f_05 = 40e6;
ohm5 = 250e-9;
% G_t
[G_t5] = comp_Gaussian_tone_burst(f_05,ohm5,d_t);
% Convolution
s_t5 = conv(ptplot,G_t5,'same');
% Fourier Transform
S_f5 = abs(fft(s_t5));
S_f5 = S_f5(1:151);
% plot
sp5 = subplot(3,2,4);
plot(f,S_f5);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp5,'Amplitude spectrum of Gaussian tone burst: f_0 = 40 MHz, \sigma = 250 ns');
% ------------------------------------------------------------------ %
% f_0 = 40 MHz ; ohm = 500 ns;
% ------------------------------------------------------------------ %
f_06 = 40e6;
ohm6 = 500e-9;
% G_t
[G_t6] = comp_Gaussian_tone_burst(f_06,ohm6,d_t);
% Convolution
s_t6 = conv(ptplot,G_t6,'same');
% Fourier Transform
S_f6 = abs(fft(s_t6));
S_f6 = S_f6(1:151);
% plot
sp6 = subplot(3,2,6);
plot(f,S_f6);
xlabel('Frequency [MHz]');
ylabel('Modulus of FFT');
title(sp6,'Amplitude spectrum of Gaussian tone burst: f_0 = 40 MHz, \sigma = 500 ns');

% ------------------------------------------------------------------ %
% Observation
% ------------------------------------------------------------------ %
% When increasing f_0, the peak shifts to the right along the 
% frequency axis. When decreasing f_0, the peak shifts back to 
% the left along the frequency axis. 

% When increasing the sigma, the amplitude of peak rises, and the 
% peak width decreases. When decreasing the sigma, the amplitude of
% the peak reduces, and the peak width increases. 