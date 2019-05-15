% Task 6 % Single source at(0,0,0)
clear 
% Input
% Spatial grid: (x,y,z) [m]
x = -2e-3:10e-6:2e-3 ; 
y = 0:10e-6:4e-3 ; 
z = 0;
% Temporal axis: t [s]
t = 0:10e-9:4e-6 ;


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
                p(i,j,k,L) = 1/4/pi/sqrt((10e-6*(i-41))^2+...
                                        (10e-6*(j-1))^2);
            end
            end
        end
    end
end

% grid point
gridpt = zeros(401,401,1,401);
ngrid = 5;
for i = 1:dim(1)
    for j = 1:dim(2)
        for k = 1:dim(3)
            for L = 1:dim(4)
                if rem(i-1,ngrid) ==0 && rem(j-1,ngrid) == 0
                    gridpt(i,j,k,L) = -inf;
                end
            end
        end
    end
end


colormap hot;
p2d = reshape(p,length(x)*length(y)*length(z),length(t));

% Response pulse
[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);
s2d = zeros(size(p2d));
for h = 1:length(x)*length(y)*length(z)
    s2d(h,:) = conv(p2d(h,:),G_t, 'same');
end
clear p2d

s = reshape(s2d, length(x), length(y), length(z), length(t));
clear s2d

sgrid = s +gridpt;

for L = 1:length(t)
    
    imagesc(x/1e-3,y/1e-3,sgrid(:,:,1,L)');

    daspect([601,601,1]);
    colorbar;
    caxis([-60 60]);
    xlabel('x [mm]');
    ylabel('y [mm]');
    drawnow;
end
