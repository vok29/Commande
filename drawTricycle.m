function [ thDraw ] = drawTricycle( x )
%matrice de points pour dessiner le char
C=[-1.5 0  0  -0.5 0.5  0  0 1.5  2   2   1.5 0   0   -0.5 0.5   0   0  -1.5 -1.5
  1   1 1.5 1.5  1.5 1.5 1  1  0.5 -0.5 -1  -1 -1.5 -1.5 -1.5 -1.5 -1  -1   1;
  ones(2,19)];
 R=[-0.5 0.5;
    0 0 ;
    ones(2,2)];
% x=[0,0,0,0,0];
%matrice 3d de rotation dans R2 
A33=[ cos(x(3)),-sin(x(3)),0;
  sin(x(3)),cos(x(3))   ,0 ;
  0     ,  0        ,1];

R33=[ cos(x(5)),-sin(x(5)),2.2;
  sin(x(5)),cos(x(5))   ,0 ;
  0     ,  0        ,1];

B31=[x(1);x(2);0];
T33=[2;0;0];
%creation matrice identitee avant de mettre les 2 autres matrices dedans
TH=eye(4,4);
TH(1:3,1:3)=A33;
TH(1:3,4)=B31;
THroue=eye(4,4);
THroue(1:3,1:3)=R33;
THroue(1:3,4)=T33;
C=TH*C;
R=TH*THroue*R;
hDraw = plot(C(1,:),C(2,:),'black','LineWidth',2);
hold on
thDraw = [hDraw,plot(R(1,:),R(2,:),'black','LineWidth',2)];
end