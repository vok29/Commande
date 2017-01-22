function [dotx] = evolutionTricycle(x,u)
dotx = [x(4)*cos(x(5))*cos(x(3));
        x(4)*cos(x(5))*sin(x(3));
        x(4)*sin(x(5));
        u(1);
        u(2)];
end