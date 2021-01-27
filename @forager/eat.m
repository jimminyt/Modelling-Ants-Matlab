function [agt,eaten]=eat(agt,cn)

%eating function for class FORAGER
%agt=forager object
%cn - current agent number
%eaten = 1 if forager finds food, =0 otherwise

%ENV_DATA is a data structure containing information about the model
  %environment
  %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
  %    ENV_DATA.units - FIXED AS KM
  %    ENV_DATA.bm_size - length of environment edge in km
  %    ENV_DATA.food is  a bm_size x bm_size array containing distribution of food
  
%SUMMARY OF FORAGER EAT RULE
%forager detects food level in its 1km x 1km square of the environment
%if food> 1, forager will consume food
%otherwise forager food level decremented by 1.

%Modified by D Walker 3/4/08

global ENV_DATA PARAM

pos=agt.pos;                            %extract current position 
cfood=agt.food;                         %get current agent food level
cpos=round(pos);                        %round up position to nearest grid point

if cpos(1)<ENV_DATA.bm_size&cpos(2)<ENV_DATA.bm_size&cpos(1)>=1&cpos(2)>=1 % if statement accounting for rounding errors and being out of bounds
    pfood=ENV_DATA.food(cpos(1),cpos(2));   %obtain environment food level at current location
else
    if cpos(1)>ENV_DATA.bm_size
        tposx = ENV_DATA.bm_size;
    elseif cpos(1)< 1
        tposx = 1;
    else
        tposx = ceil(cpos(1));
    end
    if cpos(2)>ENV_DATA.bm_size
        tposy = ENV_DATA.bm_size;
    elseif cpos(1)< 1
        tposy = 1;
    else
        tposy = ceil(cpos(2));
    end
    try
        pfood=ENV_DATA.food(tposx,tposy);
    catch Error
        disp(Error)
        disp(tposx)
        disp(tposy)
        pfood=0;
    end
    cpos=[tposx,tposy]; %fixes calls below, doesn't change position of ant.
end

if pfood>=1 && cfood < (0.5*PARAM.FO_MAXEATFOOD)   %if food exists at this location and "stomach half empty"
    if pfood < 0.5*PARAM.FO_MAXEATFOOD
        efood = pfood;
    else
        efood = 0.5*PARAM.FO_MAXEATFOOD;
    end
    ENV_DATA.food(cpos(1),cpos(2))=ENV_DATA.food(cpos(1),cpos(2))-efood;  %reduce environment food by one unit
    agt.food=cfood+efood;                    %increase agent food by one unit
    eaten=1;                             %forager has eaten - set flag to one
    pfood=pfood-efood;
end    
if (pfood >=1) && (agt.carrying_food < agt.max_food)
    food_diff = agt.max_food - agt.carrying_food;
    if pfood >= food_diff
        ENV_DATA.food(cpos(1),cpos(2))=ENV_DATA.food(cpos(1),cpos(2))-food_diff;  %reduce environment food by one unit
        agt.carrying_food = agt.carrying_food + food_diff;
    else
        ENV_DATA.food(cpos(1),cpos(2))=ENV_DATA.food(cpos(1),cpos(2))-pfood;  %reduce environment food by one unit
        agt.carrying_food = agt.carrying_food + pfood;
    end
    eaten=1;
else
    agt.food=cfood-1;                   %decrease agent food by one unit
    eaten=0;                            %flag tells forager to migrate
end
