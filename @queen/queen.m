%
%
%

classdef queen                        %declares queen object
    properties                        %define queen properties (parameters)
        age; 
        food;
        pos;
        speed;
        last_breed;
        home_nest;
    end
    methods                           %note that this class definition mfile contains only the constructor method!
                                      %all additional member functions associated with this class are included as separate mfiles in the @queen folder.
        function q=queen(varargin)    %constructor method for queen - assigns values to queen properties
                %q=queen(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that queen has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

            switch nargin             %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0                %create default object
                    q.age=[];
                    q.food=[];
                    q.pos=[];
                    q.speed=[];
                    q.last_breed=[];
                    q.home_nest=[];
                case 1                %input is already a queen, so just return!
                    if (isa(varargin{1},'queen'))
                        q=varargin{1};
                    else
                        error('Input argument is not a queen')
                    end
                case 6                %create a new queen (currently the only constructor method used)
                    q.age=varargin{1};              %age of queen object in number of iterations
                    q.food=varargin{2};             %current food content (arbitrary units)
                    q.pos=varargin{3};              %current position in Cartesian co-ords [x y]
                    q.speed=varargin{4};            %number of kilometres queen can migrate in 1 day
                    q.last_breed=varargin{5};       %number of iterations since queen last reproduced.
                    q.home_nest=varargin{6};
                otherwise
                    error('Invalid no. of input arguments for queen')
            end
        end
    end
end
