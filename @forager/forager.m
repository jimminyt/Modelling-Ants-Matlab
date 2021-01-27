% Forager ant which spends its time outside the colony, collecting food. It
% places pheromones to aid it back towards the nest, but when it is
% carrying food, it releases a much larger quantity of pheromones.

classdef forager                      %declares forager object
    properties                        %define forager properties (parameters)
        age;
        food;
        pos;
        speed;
        carrying_food;
        max_food;
        home_nest;
    end
    methods                           %note that this class definition mfile contains only the constructor method!
                                      %all additional member functions associated with this class are included as separate mfiles in the @forager folder.
        function f=forager(varargin)  %constructor method for forager  - assigns values to forager properties
                %f=forager(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that forager has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

            switch nargin             %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0                %create default object
                    f.age=[];
                    f.food=[];
                    f.pos=[];
                    f.speed=[];
                    f.carrying_food=[];
                    f.max_food=[];
                    f.home_nest=[];
                case 1                %input is already a forager, so just return!
                    if (isa(varargin{1},'forager'))
                        f=varargin{1};
                    else
                        error('Input argument is not a forager')
                    end
                case 7                %create a new forager (currently the only constructor method used)
                    f.age=varargin{1};              %age of forager object in number of iterations
                    f.food=varargin{2};             %current food content (arbitrary units)
                    f.pos=varargin{3};              %current position in Cartesian co-ords [x y]
                    f.speed=varargin{4};            %number of kilometres forager can migrate in 1 day
                    f.carrying_food=varargin{5};    %=1 if forager is carrying food, =0 otherwise.
                    f.max_food=varargin{6};
                    f.home_nest=varargin{7};
                otherwise
                    error('Invalid no. of input arguments for forager')
            end
        end
    end
end
