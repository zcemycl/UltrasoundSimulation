% Task 1: plot the impulse
% Define Constants [Units]
c = 1500; % speed of Sound[ms^-1]
p_0 = 1 ; % Pressure metre[Pa m]
x = 1e-3; y = 1e-3; z = 0; % grid point [m]
x_s = 0 ; y_s = 0 ; z_s = 0 ;% source coordinate [m]
t = 0:10e-9:3e-6;


% Use the function
[px,py,pz,pt] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t);
for i = 1:length(pt)
if pt(i)>0
    ptplot(i) = p_0/4/pi/sqrt((x-x_s)^2+(y-y_s)^2+(z-z_s)^2);
else
    ptplot(i) = 0;
end
end
plot(t./1e-6,ptplot);
xlabel('Time [us]');
ylabel('Pressure [Pa]');
title('Pressure as function of time for an acoustic point source');