% A static agent which lives within the nest, it is only fed if there is a
% feeder ant able to feed it. Depending on its total food upon reaching max
% age, will dictate the speed attribute it attains on maturation.

classdef larva                        %declares larva object
    properties                        %define larva properties (parameters)
        age;
        food;
        pos;
        total_food;
        home_nest;
        %
    end
    methods                           %note that this class definition mfile contains only the constructor method!
                                      %all additional member functions associated with this class are included as separate mfiles in the @larva folder.
        function l=larva(varargin)    %constructor method for larva - assigns values to larva properties
                %l=larva(age,food,pos....)
                %
                %age of agent (usually 0)
                %food - amount of food that larva has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by Martin Bayley on 29/01/13

            switch nargin             %Use switch statement with nargin,varargin contructs to overload constructor methods
                case 0                %create default object
                    l.age=[];
                    l.food=[];
                    l.pos=[];
                    l.total_food=[];
                    l.home_nest=[];
                    %
                case 1                %input is already a larva, so just return!
                    if (isa(varargin{1},'larva'))
                        l=varargin{1};
                    else
                        error('Input argument is not a larva')
                    end
                case 5                %create a new larva (currently the only constructor method used)
                    l.age=varargin{1};              %age of larva object in number of iterations
                    l.food=varargin{2};             %current food content (arbitrary units)
                    l.pos=varargin{3};              %current position in Cartesian co-ords [x y]
                    l.total_food=varargin{4};       %total food consumed, dictates speed of ant at maturation
                    l.home_nest=varargin{5};
                    %
                otherwise
                    error('Invalid no. of input arguments for larva')
            end
        end
    end
end
