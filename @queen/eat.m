function [agt,eaten]=eat(agt,cn)

%eating function for class QUEEN
%agt=queen object
%cn - current agent number
%eaten = 1 if queen finds food, =0 otherwise

%ENV_DATA is a data structure containing information about the model
  %environment
  %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
  %    ENV_DATA.units - FIXED AS KM
  %    ENV_DATA.bm_size - length of environment edge in km
  %    ENV_DATA.food is  a bm_size x bm_size array containing distribution of food
  
%SUMMARY OF QUEEN EAT RULE
%queen detects food level in its 1km x 1km square of the environment
%if food> 1, queen will consume food
%otherwise queen food level decremented by 1.

%queen can only eat if fed by a feeder, therefore this function will only be called
%when feeder.feed is called

%Modified by D Walker 3/4/08

global ENV_DATA PARAM

cfood=agt.food;                         %get current agent food level
pfood=ENV_DATA.nests(agt.home_nest).FoodLevel;   %obtain environment food level at the nest

if pfood>=10 && cfood < 0.5*PARAM.QU_MAXEATFOOD     %if food exists at this location
    ENV_DATA.nests(agt.home_nest).FoodLevel=ENV_DATA.nests(agt.home_nest).FoodLevel-10;  %reduce environment food by one unit
    agt.food=cfood+10;                    %increase agent food by one unit
    eaten=1;                             %queen has eaten - set flag to one
else
    agt.food=cfood-1;                   %decrease agent food by one unit
    eaten=0;                            %flag tells queen to migrate
end
