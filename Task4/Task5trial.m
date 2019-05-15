% Task 5
% Input
% Spatial grid: (x,y,z) [m]
x = -3e-3:10e-6:3e-3 ; 
y = -3e-3:10e-6:3e-3 ; 
z = 0;
% Temporal axis: t [s]
t = 1e-6; %0:10e-9:3e-6 ;

c = 1500 ; % Speed of Sound [ms-1]
p_0 = 1 ; % Pressure metre [Pa m]

% Source location: (x_s,y_s,z_s) [m]
x_s = 0; y_s = 0; z_s = 0;

% Gaussian tone burst parameters
f_0 = 10e6; % frequency [Hz]
ohm = 50e-9; % sigma standard deviation [s]
d_t = 10e-9; % temporal step size [s]


% ---------------------------------------------------------------- %
% function use
% ---------------------------------------------------------------- %
[px,py,pz,pt] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t);
p = zeros(601,601);

for i = 1:601
    for j = 1:601
        if p(i,j) > 0
            p(i,j) = 1/4/pi/sqrt((-3e-3+10e-6*(i-1))^2+(-3e-3+10e-6*(j-1))^2);
        end
    end
end

[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);


% Consider the pixel that would display the peak
% one direction
n = t*c / 10e-6;