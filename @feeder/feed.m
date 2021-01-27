function [agt]=feed(agt,tgts)

%feeding function for class FEEDER
%agt=feeder object
%tgts=target object list (i.e. all other agents later to be filtered into queens and larvae)
%cn - current agent number

%ENV_DATA is a data structure containing information about the model
  %environment
  %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
  %    ENV_DATA.units - FIXED AS KM
  %    ENV_DATA.bm_size - length of environment edge in km
  %    ENV_DATA.food is  a bm_size x bm_size array containing distribution of food

%SUMMARY OF FEEDER FEED RULE
%feeder detects food level in its 1km x 1km square of the environment (the nest)
%if food> 1, feeder will give food to queen or larva
%assume feeder is in the appropriate nest

%Modified by D Walker 3/4/08

global ENV_DATA

pos=agt.pos;                             %extract current position 
cfood=agt.food;                          %get current tgts food level
cpos=round(pos);                         %round up position to nearest grid point
pfood=ENV_DATA.nests(agt.home_nest).FoodLevel;    %obtain environment food level at current location

% qu_filter=@(q) isa(q, 'queen');
la_filter=@(l) isa(l, 'larva');
% queens=tgts(cellfun(qu_filter, tgts));
larvae=tgts(cellfun(la_filter, tgts));

% feedable=[queens larvae];
feedable= larvae;

if pfood>6 && ~isempty(feedable)  %make sure you have food and there are ants available to feed
    lucky=feedable(randi(numel(feedable)));  %randomly pick an eligible ant to feed
    lucky = lucky{1};
    lucky.food=lucky.food+5;    %feedable agent is "force fed" here since using the eat fn does not work as expected
    lucky.total_food = lucky.total_food+5;
    %[~,~]=eat(lucky,0);        %it seems that cn is never used in the eat function so for now passing 0
                                %TODO make sure this is valid! otherwise remove cn entirely if unnecessary
    ENV_DATA.nests(agt.home_nest).FoodLevel=ENV_DATA.nests(agt.home_nest).FoodLevel-5;  %reduce environment food by one unit
end
