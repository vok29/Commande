clear all;
close all;
clc;

%x = [x,y,theta, v]';
xGlissant = [3,4,pi/6,0.2]';
xGlissant2 = [1,2,pi/6,0.2]';
xTricycle=[3,4,pi/6,0.2,pi/6]';
%u=[vitesse angulaire; acceleration ou vitesse]
u=[1;1];
hhG=drawChar(xGlissant,'g');
hhG2=drawChar(xGlissant2,'b');
hh=drawTricycle(xTricycle);
dt=0.01;

R = 5; f1 = 0.1; f2=0.1;
t=0:dt:100;
xd = R*sin(f1*t) + R*sin(f2*t);
yd = R*cos(f1*t) + R*cos(f2*t);
%affichage trajectoire
plot(xd,yd);
hold on;

for i=0:dt:15
    %mettre a jour la commande
    xd = R*sin(f1*i) + R*sin(f2*i);
    yd = R*cos(f1*i) + R*cos(f2*i);
    dxd = R*f1*cos(f1*i) + R*f2*cos(f2*i);
    dyd = -R*f1*sin(f1*i) - R*f2*sin(f2*i);
    ddxd = -R*f1*f1*sin(f1*i) - R*f2*f2*sin(f2*i);
    ddyd = -R*f1*f1*cos(f1*i) - R*f2*f2*cos(f2*i);
    %Régulateur
    %regulateur suiveur trajectoire initiale
%     uGlissant = regulateurGlissant( xGlissant,xd,dxd,yd,dyd );
%     uGlissant2 = regulateurGlissant( xGlissant2,xd,dxd,yd,dyd )   
    % changement de régulateur pour faire que les remorques suivent
    uGlissant = regulateurGlissantSuiveur( xGlissant,xTricycle(1),dxd,xTricycle(2),dyd );
    uGlissant2 = regulateurGlissantSuiveur( xGlissant2,xGlissant(1),dxd,xGlissant(2),dyd );
   
    UTricycle = regulateurTricycle( xTricycle,xd,dxd,ddxd,yd,dyd,ddyd );
    % simulation du systeme de la voiture et les deux remorques
   xGlissant = xGlissant + evolutionChar(xGlissant,uGlissant)*dt;
   xGlissant2 = xGlissant2 + evolutionChar(xGlissant2,uGlissant2)*dt;
   xTricycle = xTricycle + evolutionTricycle(xTricycle,UTricycle)*dt;
   delete(hhG);
   delete(hhG2);
   delete(hh);
   hhG=drawChar(xGlissant,'g');
   hhG2=drawChar(xGlissant2,'b');
   hh=drawTricycle(xTricycle);
%    svgX2=[svgX2;(xGlissant(3)*180)/pi];
   %affichage trajectoire suivie
   plot(xd,yd,'ok');
   %affichage trajectoire des vehicules
   plot(xGlissant(1),xGlissant(2),'+g');
   plot(xGlissant2(1),xGlissant2(2),'+b');
   plot(xTricycle(1),xTricycle(2),'+black');
   drawnow;
%    pause(dt);
end