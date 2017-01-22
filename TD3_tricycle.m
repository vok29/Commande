clear all;
close all;
clc;

%x = [x,y,theta, v, delta]';
x=[3,4,pi/6,0.2,pi/6]';

%u=[vitesse angulaire; acceleration ou vitesse]
u=[1;1];
hh=drawTricycle(x);
dt=0.1;

R = 5; f1 = 0.12; f2=0.2;
t=0:dt:100;
xd = R*sin(f1*t) + R*sin(f2*t);
yd = R*cos(f1*t) + R*cos(f2*t);
%affichage trajectoire
plot(xd,yd);
hold on;


for i=0:dt:100
    %mettre a jour la commande
    xd = R*sin(f1*i) + R*sin(f2*i);
    yd = R*cos(f1*i) + R*cos(f2*i);
    dxd = R*f1*cos(f1*i) + R*f2*cos(f2*i);
    dyd = -R*f1*sin(f1*i) - R*f2*sin(f2*i);
    ddxd = -R*f1*f1*sin(f1*i) - R*f2*f2*sin(f2*i);
    ddyd = -R*f1*f1*cos(f1*i) - R*f2*f2*cos(f2*i);
    %Régulateur (changement des equations par rapport au probleme question
    %5, ici ancienne version , a changer
    UTricycle = regulateurTricycle( x,xd,dxd,ddxd,yd,dyd,ddyd );
    % simulation du systeme char
   x = x + evolutionTricycle(x,UTricycle)*dt;
   delete(hh);
   hh=drawTricycle(x);
   plot(x(1),x(2),'+r');
   plot(xd,yd,'ok');
   drawnow;
   pause(dt);
end