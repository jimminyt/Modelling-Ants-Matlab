function [npos, cfood]=follow_path_to_nest(agt)

global ENV_DATA

spd=agt.speed;   %forager migration speed in units per iteration - this is equal to the food search radius
pos=agt.pos;     %extract current position
maxf=agt.max_food;
p_nest = ENV_DATA.nests(agt.home_nest).Centre;

x_val = p_nest(1) - pos(1);
y_val = p_nest(2) - pos(2);
length = sqrt((x_val*x_val)+(y_val*y_val));
if length > spd
    dir = atan2(abs(p_nest(2) - pos(2)), abs(p_nest(1) - pos(1))); %choose direction of nest

    if (pos(1) < p_nest(1)) && (pos(2) > p_nest(2)) % SE
        dir = dir+(1/2)*pi;
    elseif (pos(1) > p_nest(1)) && (pos(2) > p_nest(2)) % SW
        dir = dir+pi;
    elseif (pos(1) > p_nest(1)) && (pos(2) < p_nest(2)) % NW
        dir = dir+(3/2)*pi;
    elseif (pos(1) == p_nest(1)) && (pos(2) < p_nest(2)) %E
        dir = (1/2)*pi;
    elseif (pos(1) == p_nest(1)) && (pos(2) > p_nest(2)) %W
        dir = (3/2)*pi;
    elseif (pos(1) < p_nest(1)) && (pos(2) == p_nest(2)) %N
        dir = 0;
    elseif (pos(1) > p_nest(1)) && (pos(2) == p_nest(2)) %S
        dir = pi;
    end
    npos(1)=pos(1)+spd*sin(dir);        %new x co-ordinate
    npos(2)=pos(2)+spd*cos(dir);        %new y co-ordinate
    if (pos(1) > p_nest(1)) && (pos(2) > p_nest(2)) % SW
        npos(1)=pos(1)+spd*sin(pi+(((3/2)*pi)-dir));        %new x co-ordinate
        npos(2)=pos(2)+spd*cos(pi+(((3/2)*pi)-dir));        %new y co-ordinate
    elseif (pos(1) < p_nest(1)) && (pos(2) < p_nest(2)) % NE
        npos(1)=pos(1)+spd*sin((((1/2)*pi)-dir));        %new x co-ordinate
        npos(2)=pos(2)+spd*cos((((1/2)*pi)-dir));        %new y co-ordinate
    end
else
    npos(1)=p_nest(1);
    npos(2)=p_nest(2);
    ENV_DATA.nests(agt.home_nest).FoodLevel = ENV_DATA.nests(agt.home_nest).FoodLevel + maxf;
    agt.carrying_food = 0;
end
npos = [npos(1),npos(2)];
cfood = agt.carrying_food;
