function [agt]=migrate(agt,cn)
 
%migration functions for class FORAGER
%agt=forager object
%cn - current agent number
 
%SUMMARY OF FORAGER MIGRATE RULE
%If a forager has not found food, it will pick a random migration direction
%If it will leave the edge of the model, the direction is incremented by 45
%degrees at it will try again (up to 8 times)
%modified by D Walker 11/4/08
 
global IT_STATS N_IT ENV_DATA
 
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%ENV_DATA is a data structure containing information about the model
%environment
  %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
  %    ENV_DATA.units - FIXED AS KM
  %    ENV_DATA.bm_size - length of environment edge in km
  %    ENV_DATA.food is  a bm_size x bm_size array containing distribution
  %    of food

agt.pos=keep_inside_map(agt.pos);
spd=agt.speed;   %forager migration speed in units per iteration - this is equal to the food search radius
pos=agt.pos;     %extract current position
maxf=agt.max_food;
carry=agt.carrying_food;
homenest=agt.home_nest;
p_nest = ENV_DATA.nests(agt.home_nest).Centre;

mig=0;
if carry==maxf
    mig=1;
    [npos,cfood] = follow_path_to_nest(agt);
    agt.carrying_food = cfood;
    npos = keep_inside_map(npos);
    % place pheromone on current location
    ENV_DATA.pheromone(round(npos(1)),round(npos(2))) = 1;
    ENV_DATA.pheromone(round(pos(1)),round(pos(2))) = 1;
        if mig==1
            agt.pos=npos;                                   %update agent memory
            IT_STATS.mig(N_IT+1)=IT_STATS.mig(N_IT+1)+1;    %update model statistics
        end
else
    try % check 2 spaces away for pheromone trail
        nearby_pheromones = ENV_DATA.pheromone(round(agt.pos(1))-2:round(agt.pos(1))+2,round(agt.pos(2))-2:round(agt.pos(2))+2);
    catch % if near the edge the pheromone grid won't be possible so just the current position
        nearby_pheromones = [];
    end
    if any(any(nearby_pheromones)) && rand > 0.3333
        mig = 1;
        [dirx,diry]=follow_strongest_pheromone(nearby_pheromones, homenest);
%         npos(1)=pos(1)+spd*sin(dirx);        %new x co-ordinate
%         npos(2)=pos(2)+spd*cos(diry);        %new y co-ordinate
        npos(1) = pos(1)+dirx;
        npos(2) = pos(2)+diry;
        
        if mig==1
            agt.pos=npos;                                   %update agent memory
            IT_STATS.mig(N_IT+1)=IT_STATS.mig(N_IT+1)+1;    %update model statistics
            
        end
    else
        cnt=1;
        dir=rand*2*pi;            %forager has been unable to find food, so chooses a random direction to move in

        while mig==0 && cnt<=8    %forager has up to 8 attempts to migrate (without leaving the edge of the model)
            npos(1)=pos(1)+spd*sin(dir);        %new x co-ordinate
            npos(2)=pos(2)+spd*cos(dir);        %new y co-ordinate
            if npos(1)<ENV_DATA.bm_size&npos(2)<ENV_DATA.bm_size&npos(1)>=1&npos(2)>=1    %check that forager has not left edge of model - correct if so.
                mig=1;
            end
            cnt=cnt+1;
            dir=dir+(pi/4);       %if migration not successful, then increment direction by 45 degrees and try again
        end

        if mig==1
            agt.pos=npos;                                   %update agent memory
            IT_STATS.mig(N_IT+1)=IT_STATS.mig(N_IT+1)+1;    %update model statistics
        end
    end
end