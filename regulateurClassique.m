function [ Uclassique ] = regulateurClassique( x,xd,dxd,ddxd,yd,dyd,ddyd )
    %Régulateur
    Ax = [ -x(4)*sin(x(3)) cos(x(3));
            x(4)*cos(x(3)) sin(x(3))];
        
    vclassique=[xd - x(1) + 2*(dxd - x(4)*cos(x(3))) +ddxd;
        yd - x(2) + 2*(dyd - x(4)*sin(x(3))) +ddyd];
    Uclassique = Ax\vclassique;
end