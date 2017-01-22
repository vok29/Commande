clear all;
close all;
clc;

%x = [x,y,theta, v]';
x=[3,4,pi/6,0.2]';
xGlissant = [3,4,pi/6,0.2]';

svgX1=[];
svgX2=[];
%u=[vitesse angulaire; acceleration ou vitesse]
u=[1;1];
hh=drawChar(x,'b');
hhG=drawChar(xGlissant,'g');
dt=0.01;

R = 5; f1 = 0.1; f2=0.2;
t=0:dt:100;
xd = R*sin(f1*t) + R*sin(f2*t);
yd = R*cos(f1*t) + R*cos(f2*t);
%affichage trajectoire
plot(xd,yd);
hold on;

for i=0:dt:5
    %mettre a jour la commande
    xd = R*sin(f1*i) + R*sin(f2*i);
    yd = R*cos(f1*i) + R*cos(f2*i);
    dxd = R*f1*cos(f1*i) + R*f2*cos(f2*i);
    dyd = -R*f1*sin(f1*i) - R*f2*sin(f2*i);
    ddxd = -R*f1*f1*sin(f1*i) - R*f2*f2*sin(f2*i);
    ddyd = -R*f1*f1*cos(f1*i) - R*f2*f2*cos(f2*i);
    %Régulateur
    uClassique = regulateurClassique( x,xd,dxd,ddxd,yd,dyd,ddyd );
    
    uGlissant = regulateurGlissant( xGlissant,xd,dxd,yd,dyd );
    % simulation du systeme char
   x = x + evolutionChar(x,uClassique)*dt;
%    x(4) = x(4) + (rand()-0.5);
   xGlissant = xGlissant + evolutionChar(xGlissant,uGlissant)*dt;
%    xGlissant(4) = xGlissant(4) + (rand()-0.5);
   delete(hh);
   delete(hhG);
   hh=drawChar(x,'b');
   hhG=drawChar(xGlissant,'g');
   svgX1=[svgX1;(x(3)*180)/pi];
   svgX2=[svgX2;(xGlissant(3)*180)/pi];
   plot(x(1),x(2),'+r');
   plot(xd,yd,'ok');
   plot(xGlissant(1),xGlissant(2),'+g');
   drawnow;
%    pause(dt);
end

figure;
plot(svgX1,'r');
hold on;
plot(svgX2,'g');