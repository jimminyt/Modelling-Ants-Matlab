function [agt, new]=transform(agt,cn)

%breeding function for class LARVA
%agt=larva object
%cn - current agent number
%new - contains new  agent object if created, otherwise empty

global PARAM IT_STATS N_IT 
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%PARAM is data structure containing relevant parameters

alim=PARAM.LA_MAXAGE;              %minimum food level required for transforming
%
cfood=agt.food;                     %get current agent food level
tfood=agt.total_food;
age=agt.age;                        %get current agent age
%
pos=agt.pos;                        %current position

spawn_chance=rand;                  %random number to pick a transformation class

if cfood >= PARAM.LA_FOODBRD                       %if food > threshold then transform
    if spawn_chance<=PARAM.FE_CHANCE
        new=feeder(0,cfood/2,pos,PARAM.FO_SPD,agt.home_nest);             %new feeder agent
        new.food=cfood/2;           %divide food level between 2 agents
        new.age=age+1;
        IT_STATS.fe_div(N_IT+1)=IT_STATS.fe_div(N_IT+1)+1;  %update statistics
    else
        % decide forager stats
        new=forager(0,cfood/2,pos,PARAM.FO_SPD+(tfood/10),0,PARAM.FO_MAXFOOD+tfood/10,agt.home_nest);          %new forager agent
        new.food=cfood/2;           %divide food level between 2 agents
        new.age=age+1;
        IT_STATS.fo_div(N_IT+1)=IT_STATS.fo_div(N_IT+1)+1;  %update statistics
    end
    [~,~]=die(agt,cn,1);
else
    agt.age=age+1;                  %not able to transform, so increment age by 1
    new=[];
end
