function create_environment(size,queens)

%function that populates the global data structure representing
%environmental information

%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS KM
   %    ENV_DATA.bm_size - length of environment edge in km
   %    ENV_DATA.food is  a bm_size x bm_size array containing distribution
   %    of food

global ENV_DATA

FCOUNT = 5400;
ENV_DATA.nests=[];
ENV_DATA.shape='square';
ENV_DATA.units='kilometres';
ENV_DATA.bm_size=size;
ENV_DATA.pheromone=floor(zeros(size,size)); % Array with value of pheromones
ENV_DATA.nest_locations=floor(zeros(size,size)); % Array of not-nest-locations
ENV_DATA.food=floor(zeros(size,size));       %generate patch where there is no food

ENV_DATA.food(round(0.45*size):round(0.55*size),round(0.45*size):round(0.55*size))=FCOUNT; % Array to distribute food in km x km squares
ENV_DATA.food(round(0.1*size):round(0.2*size),round(0.5*size):round(0.6*size))=FCOUNT/2; % Array to distribute food in km x km squares
ENV_DATA.food(round(0.5*size):round(0.6*size),round(0.1*size):round(0.2*size))=FCOUNT/2; % Array to distribute food in km x km squares
ENV_DATA.food(round(0.8*size):round(0.9*size),round(0.5*size):round(0.6*size))=FCOUNT/2; % Array to distribute food in km x km squares
ENV_DATA.food(round(0.5*size):round(0.6*size),round(0.8*size):round(0.9*size))=FCOUNT/2; % Array to distribute food in km x km squares
ENV_DATA.food = ENV_DATA.food + arrayfun(@(x) (x*randi([FCOUNT/100 FCOUNT/10])), randi([0 1],[size size]));

possible_nest_positions={[1,1],[size-5,size-5],[1,size-5],[size-5,1]}; % shape is x
% possible_nest_positions={[(size-5)/2,1],[1,(size-5)/2],[(size-5)/2,size-5],[size-5,(size-5)/2]}; % shape is +
% create new nest and update nest locations
for i=1:queens
    nest = struct("Number", i, "TLCorner", possible_nest_positions{i}, "FoodLevel", 0, "Length", 3, "Centre", [0,0] );
    ENV_DATA.nest_locations(round(nest.TLCorner(1):nest.TLCorner(1)+nest.Length),round(nest.TLCorner(2):nest.TLCorner(2)+nest.Length))=1;
    % change food level to be the amount of food in the nest location
    % nest_food_distribution = times(ENV_DATA.nest_locations,ENV_DATA.food);
    % nest_food_sum = sum(sum(nest_food_distribution));
    nest.FoodLevel = round(FCOUNT/queens);
    nxcoord = (nest.TLCorner(1)+nest.Length/2) + 1;
    nycoord = (nest.TLCorner(2)+nest.Length/2) + 1;
    nest.Centre = [nxcoord nycoord];
    ENV_DATA.nests=[ENV_DATA.nests nest];
end
