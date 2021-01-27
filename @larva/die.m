function [agt,klld]=die(agt,cn,tform)

%death function for class LARVA
%agt=larva object
%cn - current agent number
%klld=1 if agent dies, =0 otherwise

%larvae die if their food level reaches zero or they are older than max_age
%or if the tform parameter is set to 1 (i.e. "instant death" when transforming)

global PARAM IT_STATS N_IT MESSAGES
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%PARAM is data structure containing migration speed, breeding
%frequency, and other parameters for feeders, foragers, larvae, and queen
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=feeder, 2=forager, 3=queen, 4=larva, 0=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x 1 array containing ones for agents that have died
   %    in the current iteration

klld=0;
thold_food=PARAM.LA_MINFOOD;  %threshold minimum food value for death to occur
thold_age=PARAM.LA_MAXAGE;    %threshold maximum age value for death to occur
cfood=agt.food;               %get current agent food level
age=agt.age;                  %get current agent age

if cfood<=thold_food || age>thold_age || tform==1  %if food level < threshold and age > max age  or transforming then agent dies
    IT_STATS.la_died(N_IT+1)=IT_STATS.la_died(N_IT+1)+1;  %update statistics
    MESSAGES.dead(cn)=1;                           %update message list
    klld=1;
end