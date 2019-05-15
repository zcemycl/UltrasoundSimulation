function [p] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t)
    [X,Y,Z,T] = ndgrid(x,y,z,t); 
    R = sqrt((X-x_s).^2 + (Y-y_s).^2 + (Z-z_s).^2);
    R = R + eps; % add eps to avoid NaN
    t_r = round(R./c,8);
    p = p_0./(4*pi.*R).*dirac(T-t_r) ;
end 