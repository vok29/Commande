clear all;
close all;
clc;

%x = [h1,h2,h3];
etat=[2,2,3]'
u=[1;1];
dt=0.1;
drawRectangles(etat);
w=[2,4];
dw=[0,0];
z=[0,0];
for i=0:dt:25
   %regulation
   z(1)=z(1)+(w(1)- etat(1))*dt;
   z(2)=z(2)+(w(2)-etat(3))*dt;
   v=[z(1) + 2*(w(1)-etat(1))+dw(1);
      z(2) + 2*(w(2)-etat(3))+dw(2)];
   Ax = [1,0;
         0,1];
   bx = [-sign(etat(1))*sqrt(2*9.81*abs(etat(1))) - sign(etat(1) - etat(2))*sqrt(2*9.81*abs((etat(1)- etat(2))));
          -sign(etat(3))*sqrt(2*9.81*abs(etat(3))) + sign(etat(2) - etat(3))*sqrt(2*9.81*abs((etat(2)- etat(3))))];
   u = inv(Ax)*(v - bx); 
   %simulation
   etat=etat + evolution3Bacs(etat,u)*dt;
   clf;
   drawRectangles(etat);
   drawnow;
   pause(dt);
   
end
