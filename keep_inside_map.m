function [pos]=keep_inside_map(pos)

global ENV_DATA

x = round(pos(1));
y = round(pos(2));
if x > ENV_DATA.bm_size
    x = ENV_DATA.bm_size;
elseif x < 1
    x = 1;
else
    x = pos(1);
end
if y > ENV_DATA.bm_size
    y = ENV_DATA.bm_size;
elseif y < 1
    y = 1;
else
    y = pos(2);
end
pos=[x,y];
