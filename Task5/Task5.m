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
p = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t);
dim = size(p);

for i = 1:dim(1)
    for j = 1:dim(2)
        if p(i,j) > 0
            p(i,j) = 1/4/pi/sqrt((-3e-3+10e-6*(i-1))^2+(-3e-3+10e-6*(j-1))^2);
        end
    end
end
sp1 = subplot(1,2,1);
imagesc(x/1e-3,y/1e-3,p(:,:)');
daspect([601,601,1]);
colormap hot;
colorbar;
caxis([-60 60]);
xlabel('x [mm]');
ylabel('y [mm]');
title('Impulse Response p');

[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);
s_t = conv2(p,G_t,'same');
s_tpro = zeros(601,601);
for deg = 0:45:315
    s_tim = imrotate(s_t,deg);
    dims = size(s_tim);
    xdim = dims(1); ydim = dims(2);
    if dims(1) == 601
        xup = 601; xlow = 1;
    else
        xlow = ceil((xdim-dim(1))/2);
        xup = xlow + 600;
    end
    if dims(2) == 601
        yup = 601; ylow = 1;
    else
        ylow = ceil((ydim-dim(2))/2);
        yup = ylow + 600;
    end
    s_tpro = s_tpro +  s_tim(xlow:xup,ylow:yup);
end

s_tpro = s_tpro.*11e15;
sp2 = subplot(1,2,2);
imagesc(x/1e-3,y/1e-3,s_tpro(:,:)');
daspect([601,601,1]);
colorbar;
caxis([-60 60]);
xlabel('x [mm]');
ylabel('y [mm]');
title('Response to a Gaussian tone burst s');







