% Task 5 alternatives
% Task 5
clear 
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
                p(i,j,k,L) = 1/4/pi/sqrt((10e-6*(i-301))^2+...
                                        (10e-6*(j-301))^2);
            end
            end
        end
    end
end

colormap hot;
sp1 = subplot(1,2,1);
% % imagesc(x/1e-3 , y/1e-3, pdisplay);
imagesc(x/1e-3, y/1e-3, p(:,:,1,101));
p2d = reshape(p,length(x)*length(y)*length(z),length(t));

daspect([601,601,1]);
colorbar;
caxis([-60 60]);
xlabel('x [mm]');
ylabel('y [mm]');
title('Impulse Response p');

% Response pulse
[G_t] = comp_Gaussian_tone_burst(f_0,ohm,d_t);
s2d = zeros(size(p2d));
for h = 1:length(x)*length(y)*length(z)
    s2d(h,:) = conv(p2d(h,:),G_t, 'same');
end
clear p2d

s = reshape(s2d, length(x), length(y), length(z), length(t));
clear s2d


sp2 = subplot(1,2,2);

imagesc(x/1e-3,y/1e-3,s(:,:,101));

daspect([601,601,1]);
colorbar;
caxis([-60 60]);
xlabel('x [mm]');
ylabel('y [mm]');
title('Response to a Gaussian tone burst s');










% 
% % animation part
% colormap hot;
% for L = 1:301
% s_tdisplay = s_tpro(:,:,1,L);
% imagesc(x/1e-3,y/1e-3,s_tdisplay);
% daspect([601,601,1]);
% drawnow;
% end
% 
% % array animation
% s_tproarray = s_tpro;
% for s = -70:1:70
% s_tproarray = circshift(s_tpro,[s,0,0,0]) + s_tproarray;
% end
% colormap hot;
% for L = 1:301
% s_tdisplay = s_tproarray(:,:,1,L);
% imagesc(x/1e-3,y/1e-3,s_tdisplay);
% daspect([601,601,1]);
% drawnow;
% end


