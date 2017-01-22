function [ UGlissant ] = regulateurGlissantSuiveur( x,xd,dxd,yd,dyd )
     %Régulateur
    K=15;
    L=1.5;
    dxd=0;
    dyd=0;
    Ax = [ -x(4)*sin(x(3)) cos(x(3));
            x(4)*cos(x(3)) sin(x(3))];
    vGlissant = [(xd-L) - x(1) + dxd - x(4)*cos(x(3));
        (yd-L) - x(2) + dyd - x(4)*sin(x(3))];
    UGlissant = Ax\(K*sign(vGlissant));
end