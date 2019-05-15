function p = comp_press_field_point_source(c,p_0,x,y,z,x_s,y_s,z_s,t)

% form 3D grid in order to calculate r (dist from source)
[X_grid, Y_grid, Z_grid] = ndgrid(x-x_s, y-y_s, z-z_s);
r = sqrt(X_grid.^2 + Y_grid.^2 + Z_grid.^2);

% 3D matrix with exact time for pulse to reach r
time_r = r/c;

% round r/c to nearest value in the array t using interpolation
% means for every r, (t - r/c) will equal zero for some t
rRounded = interp1(t,t,time_r,'nearest');

% 4D array to act as the delta function
delta = zeros(length(x),length(y),length(z),length(t));

% calculating delta 4D array for every time step (4th dimension)
for n = 1:length(t)
    delta(:,:,:,n) = rRounded == t(n);
end

% calculating pressure through all time in 3D array
press(:,:,:) = p_0./(4*pi*r);

% prealocate 4D pressure size
p = zeros(size(delta));

% seperates 3D 'press' to 4D 'p'
% each time step only contains pressure values where r/c = t 
for n = 1:length(t)
    p(:,:,:,n) = delta(:,:,:,n).*press;
end

end