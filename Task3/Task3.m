% Task 3: plot the convolution of pulse
% Define constants
c = 1500; % speed of Sound[ms^-1]
p_0 = 1 ; % Pressure metre[Pa m]
x = 1e-3; y = 1e-3; z = 0; % grid point [m]
x_s = 0 ; y_s = 0 ; z_s = 0 ;% source coordinate [m]
t = 0:10e-9:3e-6;

f_0 = 10e6;
ohm = 50e-9;
d_t = 10e-9;

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
% G_t
[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);

% Convolution
s_t = conv(ptplot,G_t,'same');
figure(1);
hold on
plot(t./1e-6,ptplot);
plot(t./1e-6,s_t);
hold off

legend('p(x,y,z,t)','s(x,y,z,t)','Location','northeast');
xlabel('Time [us]');
ylabel('Pressure [Pa]');
title('Pressure as function of time for an acoustic point source');




