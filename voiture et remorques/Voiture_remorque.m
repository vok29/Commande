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
hrem1=plot(xGlissant(1),xGlissant(2),'or');
hrem2=plot(xGlissant2(1),xGlissant2(2),'or');
dt=0.01;
Ev = [];
Er1 = [];
Er2 = [];
R = 5;
f1 = 0.1; f2=0.1;
t=0:dt:100;
xd = 10*cos(f1*t);
yd = 10*sin(3*f2*t);
%     xd = R*sin(f1*i) + R*sin(f2*i);
%     yd = R*cos(f1*i) + R*cos(f2*i);
%affichage trajectoire
plot(xd,yd);
hTricycle=plot(xd,yd,'ok');
hold on;

for i=0:dt:10
    %mettre a jour la commande
   %differentes trajectoires 
%     xd = R*sin(f1*i) + R*sin(f2*i);
%     yd = R*cos(f1*i) + R*cos(f2*i);
%     dxd = R*f1*cos(f1*i) + R*f2*cos(f2*i);
%     dyd = -R*f1*sin(f1*i) - R*f2*sin(f2*i);
%     ddxd = -R*f1*f1*sin(f1*i) - R*f2*f2*sin(f2*i);
%     ddyd = -R*f1*f1*cos(f1*i) - R*f2*f2*cos(f2*i);
    xd = 10*cos(f1*i);
    yd = 10*sin(3*f2*i);
    dxd = -10*f1*sin(f1*i);
    dyd = 10*3*f2*cos(3*f2*i);
    ddxd = -10*f1*f1*cos(f1*i);
    ddyd = -10*9*f2*f2*sin(3*f2*i);
    
    %Creation X et Y pour les remorques
    xRem1 = xTricycle(1)-3*cos(xTricycle(3));
    yRem1 = xTricycle(2)-3*sin(xTricycle(3));
    
    xRem2 = xGlissant(1)-3*cos(xGlissant(3));
    yRem2 = xGlissant(2)-3*sin(xGlissant(3));
     
    %Régulateur
    %regulateur suiveur trajectoire initiale
%     uGlissant = regulateurGlissant( xGlissant,xd,dxd,yd,dyd );
%     uGlissant2 = regulateurGlissant( xGlissant2,xd,dxd,yd,dyd )   
    % changement de régulateur pour faire que les remorques suivent
    uGlissant = regulateurGlissantSuiveur( xGlissant,xRem1,0,yRem1,0 );
    uGlissant2 = regulateurGlissantSuiveur( xGlissant2,xRem2,0,yRem2,0 );
   
    if(xTricycle(5) >(xTricycle(3) + 30))
        xTricycle(5) = xTricycle(3) + 30;
    elseif(xTricycle(5) < (xTricycle(3) - 30))
           xTricycle(5) = xTricycle(3) - 30;
    else
         xTricycle(5) =  xTricycle(5);
    end
        
    
    UTricycle = regulateurTricycle( xTricycle,xd,dxd,ddxd,yd,dyd,ddyd );
    % simulation du systeme de la voiture et les deux remorques
   xGlissant = xGlissant + evolutionChar(xGlissant,uGlissant)*dt;
   xGlissant2 = xGlissant2 + evolutionChar(xGlissant2,uGlissant2)*dt;
   xTricycle = xTricycle + evolutionTricycle(xTricycle,UTricycle)*dt;
   delete(hhG);
   delete(hhG2);
   delete(hh);
   delete(hrem1);
   delete(hrem2);
   delete(hTricycle);
   hhG=drawChar(xGlissant,'g');
   hhG2=drawChar(xGlissant2,'b');
   hh=drawTricycle(xTricycle);
%    svgX2=[svgX2;(xGlissant(3)*180)/pi];
   %affichage trajectoire suivie
   hTricycle=plot(xd,yd,'ok');
   hrem1=plot(xRem1,yRem1,'og');
   hrem2=plot(xRem2,yRem2,'ob');
   %affichage trajectoire des vehicules
%    plot(xGlissant(1),xGlissant(2),'+g');
%    plot(xGlissant2(1),xGlissant2(2),'+b');
%    plot(xTricycle(1),xTricycle(2),'+black');
   drawnow;
   %Affichage erreur voiture, remorque 1 et 2
   Ev = [Ev;(abs(xd-xTricycle(1)) + abs(yd - xTricycle(2)))]
   Er1 = [Er1;(abs(xRem1-xGlissant(1)) + abs(yRem1 - xGlissant(2)))];
   Er2 = [Er2;(abs(xRem2-xGlissant2(1)) + abs(yRem2 - xGlissant2(2)))];
%    pause(dt);
end


figure;
plot(Ev(:,1));
hold on;
plot(Er1(:,1));
hold on;
plot(Er2(:,1));
legend('Erreur de la voiture','Erreur remorque 1','Erreur remorque 2');
title('Différentes erreurs du système');