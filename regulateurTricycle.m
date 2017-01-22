function [ UTricycle ] = regulateurTricycle( x,xd,dxd,ddxd,yd,dyd,ddyd )
    %Régulateur (changement des equations par rapport au probleme question
%     %5
%     Ax = [cos(x(5) + x(3)) -x(4)*sin(x(5) + x(3));
%           sin(x(5) + x(3)) x(4)*cos(x(5) + x(3))];
%         
%     v=[xd - x(1) + 2*(dxd - x(4)*cos(x(5))*cos(x(3))) +ddxd - x(4)^2*sin(x(5))*(-sin(x(5)+x(3)));
%         yd - x(2) + 2*(dyd - x(4)*cos(x(5))*sin(x(3))) +ddyd - x(4)^2*sin(x(5))*(cos(x(5)+x(3)))];
%     UTricycle = Ax\v;
%     
    v = [ xd - x(1) + 2*(dxd - x(4)*cos(x(3))) + ddxd ;
           yd - x(2) + 2*(dyd - x(4)*sin(x(3))) + ddyd ];
    Ax = [ cos(x(3)+x(5)) -x(4)*sin(x(3)+x(5)) ;
           sin(x(3)+x(5)) x(4)*cos(x(3)+x(5)) ];
    Bx = [ x(4)*x(4) * sin(x(5)) * (-sin(x(3)+x(5))) ;
           x(4)*x(4) * sin(x(5)) * ( cos(x(3)+x(5))) ];
    UTricycle = Ax\(v-Bx); 
end