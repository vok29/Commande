function [ UGlissant ] = regulateurGlissantSuiveur( x,xd,dxd,yd,dyd )
     %R�gulateur
    K=15;
%     decalerX=2.5*cos(x(3));
%     decalerY=2.5*sin(x(3));
%     dxd=-2.5*x(3)*sin(x(3));
%     dyd=2.5*x(3)*cos(x(3));
%     dxd = 0;
%     dyd = 0;
    Ax = [ -x(4)*sin(x(3)) cos(x(3));
            x(4)*cos(x(3)) sin(x(3))];
    vGlissant = [xd - x(1) + dxd - x(4)*cos(x(3));
        yd - x(2) + dyd - x(4)*sin(x(3))];
    UGlissant = Ax\(K*sign(vGlissant));
end