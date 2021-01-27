% Feeder will remain stationary within the nest
% Feeders spend time nurturing and feeding larva, or eating
%

classdef feeder                       %declares feeder object
    properties                        %define feeder properties (parameters)
        age;
        food;
        pos;
        speed;
        home_nest;
        %
    end
    methods                           %note that this class definition mfile contains only the constructor method!
                                      %all additional member functions associated with this class are included as separate mfiles in the @feeder folder.
        function f=feeder(varargin)   %constructor method for feeder - assigns values to feeder properties
                %f=feeder(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that feeder has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

            switch nargin             %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0                %create default object
                    f.age=[];
                    f.food=[];
                    f.pos=[];
                    f.speed=[];
                    f.home_nest=[];
                    %
                case 1                %input is already a feeder, so just return!
                    if (isa(varargin{1},'feeder'))
                        f=varargin{1};
                    else
                        error('Input argument is not a feeder')
                    end
                case 5                %create a new feeder (currently the only constructor method used)
                    f.age=varargin{1};              %age of feeder object in number of iterations
                    f.food=varargin{2};             %current food content (arbitrary units)
                    f.pos=varargin{3};              %current position in Cartesian co-ords [x y]
                    f.speed=varargin{4};            %number of kilometres feeder can migrate in 1 day
                    f.home_nest=varargin{5};
                    %
                otherwise
                    error('Invalid no. of input arguments for feeder')
            end
        end
    end
end
