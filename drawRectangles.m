function [ hDraw ] = drawRectangles(h)

if(h(1)>0 && h(2)>0 && h(3)>0) 
    %rectangle('Position',[x,y,largeur,hauteur],'FaceColor','b','EdgeColor','none');
    rectangle('Position',[0,0,18,1],'FaceColor','b','EdgeColor','none');
    rectangle('Position',[1,1,4,h(1)],'FaceColor','b','EdgeColor','none');
    rectangle('Position',[7,1,4,h(2)],'FaceColor','b','EdgeColor','none');
    rectangle('Position',[13,1,4,h(3)],'FaceColor','b','EdgeColor','none');

line([0,18],[0,0],'Color','k','LineWidth',2);
line([0,1],[1,1],'Color','k','LineWidth',2);
line([5,7],[1,1],'Color','k','LineWidth',2);
line([11,13],[1,1],'Color','k','LineWidth',2);
line([17,18],[1,1],'Color','k','LineWidth',2);
end

end