function [Variationhauteur] = evolution3Bacs(h,u)
% 
% h=[1,2,3]
% u=[0,0];
Variationhauteur = [-sign(h(1))*sqrt(2*9.81*abs(h(1))) - sign(h(1) - h(2))*sqrt(2*9.81*abs((h(1)- h(2)))) + u(1);
            sign(h(1)-h(2))*sqrt(2*9.81*abs(h(1)-h(2))) - sign(h(1) - h(3))*sqrt(2*9.81*abs(h(1)- h(3)));
            -sign(h(3))*sqrt(2*9.81*abs(h(3))) + sign(h(2) - h(3))*sqrt(2*9.81*abs(h(2)- h(3))) + u(2)];

end