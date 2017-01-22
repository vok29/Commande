function [ hDraw ] = drawChar( x,color )
%matrice de points pour dessiner le char
C=[-1.5 0  0  -0.5 0.5  0  0 1.5  2   2   1.5 0   0   -0.5 0.5   0   0  -1.5 -1.5
  1   1 1.5 1.5  1.5 1.5 1  1  0.5 -0.5 -1  -1 -1.5 -1.5 -1.5 -1.5 -1  -1   1;
  ones(2,19)];
% x=[3,4,pi/2,0,-1];
%matrice 3d de rotation dans R2 
A33=[ cos(x(3)),-sin(x(3)),0;
  sin(x(3)),cos(x(3))   ,0 ;
  0     ,  0        ,1];
B31=[x(1);x(2);0];
%creation matrice identitee avant de mettre les 2 autres matrices dedans
TH=eye(4,4);
TH(1:3,1:3)=A33;
TH(1:3,4)=B31;
C=TH*C;
hDraw = plot(C(1,:),C(2,:),'Color',color,'LineWidth',2);
end