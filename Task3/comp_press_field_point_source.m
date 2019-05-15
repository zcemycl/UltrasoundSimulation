function [px,py,pz,pt] = comp_press_field_point_source(c,p_0,x,x_s,y,y_s,z,z_s,t)
    [X,Y,Z,T] = ndgrid(x,y,z,t); 
    R = sqrt((X-x_s).^2 + (Y-y_s).^2 + (Z-z_s).^2);
    R = R + eps; % add eps to avoid NaN
    t_r = round(R./c,8);
    p = p_0./(4*pi.*R).*dirac(T-t_r) ;
    % rearrange p 4D arrays to 1D array of px,py,pz,pt
    % constant dx,dy,dz,dt
    if length(x) > 1
        dx = x(2) - x(1);
    else
        dx = 1e-3;
    end
    if length(y) > 1
        dy = y(2) - y(1);
    else
        dy = 1e-3;
    end
    if length(z) > 1
        dz = z(2) - z(1);
    else
        dz = 1e-3;
    end
    if length(t) > 1
        dt = t(2) - t(1);
    else
        dt = 10e-9;
    end
    % px
    px3 = sum(p,4)*dt;
    px2 = sum(px3,3)*dz;
    px = sum(px2,2)*dy;

    % py
    py3 = sum(p,4)*dt;
    py2 = sum(py3,3)*dz;
    py1 = sum(py2,1)*dx;
    py = py1(:);
    % pz 
    pz3 = sum(p,4)*dt;
    pz2 = sum(pz3,2)*dy;
    pz1 = sum(pz2,1)*dx;
    pz = pz1(:);
    % pt
    pt3 = sum(p,3)*dz;
    pt2 = sum(pt3,2)*dy;
    pt1 = sum(pt2,1)*dx;
    pt = pt1(:);
    
    
end 