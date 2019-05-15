% Task 5 alternatives 2
% Task 5
% Input
% Spatial grid: (x,y,z) [m]
x = -3e-3:10e-6:3e-3 ; 
y = -3e-3:10e-6:3e-3 ; 
z = 0;
% Temporal axis: t [s]
t = 0:10e-9:3e-6 ;

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
[p] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t);
dim = size(p);

for i = 1:dim(1)
    for j = 1:dim(2)
        for k = 1:dim(3)
            for L = 1:dim(4)
            if p(i,j,k,L) > 0
                p(i,j,k,L) = 1/4/pi/sqrt((-3e-3+10e-6*(i-1))^2+...
                                        (-3e-3+10e-6*(j-1))^2+...
                                        (-3e-3+10e-6*(k-1))^2);
            end
            end
        end
    end
end


% Response pulse
[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);

G_tpos = zeros(1,41); G_tneg = zeros(1,41);
for P = 1:41
    if G_t(P) >0 
        G_tpos(P) = G_t(P);
    elseif G_t(P) <0
        G_tneg(P) = G_t(P);
    end
end

s_tpos = convn(p,G_tpos,'same');
s_tneg = convn(p,G_tneg,'same');

s_t = circshift(s_tpos,[10,0,0,0]) + s_tneg;
imagesc(s_t);


