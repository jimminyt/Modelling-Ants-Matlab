function [agt, new]=breed(agt,cn)

%breeding function for class QUEEN
%agt=queen object
%cn - current agent number
%new - contains new  agent object if created, otherwise empty

global PARAM IT_STATS N_IT
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%PARAM is data structure containing relevant parameters

flim=PARAM.QU_FOODBRD;              %minimum food level required for breeding
tlim=PARAM.QU_BRDFREQ;              %minimum interval required for breeding
cfood=agt.food;                     %get current agent food level
age=agt.age;                        %get current agent age
last_breed=agt.last_breed;          %length of time since agent last reproduced
pos=agt.pos;                        %current position

if cfood>=flim && last_breed>=tlim  %if food > threshold and age > interval, then create offspring
   new=larva(0,cfood/2,pos,0,agt.home_nest);      %new larva agent %TODO might want to create more than one?
   agt.food=cfood/2;                %divide food level between 2 agents %TODO why do this?
   agt.last_breed=0;
   agt.age=age+1;
   IT_STATS.la_div(N_IT+1)=IT_STATS.la_div(N_IT+1)+1;    %update statistics %TODO should this be la_div or qu_div?
else                            
    agt.age=age+1;                  %not able to breed, so increment age by 1
    agt.last_breed=last_breed+1;
    new=[];
end
