function [agent]=create_agents(nfe,nfo,nqu,nla)

 %creates the objects representing each agent

%agent - cell array containing list of objects representing agents
%nfo - number of foragers
%nfe - number of feeders
%nqu - number of queens
%nla - number of larvae

%global parameters
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

 global ENV_DATA MESSAGES PARAM

nof_nests=size(ENV_DATA.nests, 2);
bm_size=ENV_DATA.bm_size;
foloc=(bm_size-1)*rand(nfo,2)+1;      %generate random initial positions for forages

nestcoloc={};
for i=1:nof_nests
    nest=ENV_DATA.nests(i);
    length=nest.Length;
    base=1+nest.TLCorner;
    nestcoloc{i}=length*rand((nfe+nqu+nla)/nof_nests,2)+base;
end
nestcoloc{nof_nests+1}='row';

nestcoloc=interleave2(nestcoloc{:});

%generate all forager agents and record their positions
%assuming only 1 queen per nest
for fo=1:nfo
    pos=foloc(fo,:);
    %create forager agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+80;
    c_food=false;
    initsize=round(rand*10);
    agent{fo}=forager(age,food,pos,PARAM.FO_SPD,c_food,PARAM.FO_MAXFOOD+initsize,randi(nof_nests));
end

%generate all feeder agents and record their positions
for fe=nfo+1:nfo+nfe
    homenest = nof_nests-mod(nof_nests+fe,nof_nests);
    pos=nestcoloc(fe-nfo,:);
    %create feeder agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+80;
    agent{fe}=feeder(age,food,pos,PARAM.FE_SPD,homenest);
end

for qu=nfo+nfe+1:nfo+nfe+nqu
    homenest = nof_nests-mod(nof_nests+qu,nof_nests);
    pos=nestcoloc(qu-nfo-nfe,:);
    %create queen agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+80;
    lbreed=round(rand*PARAM.QU_BRDFREQ);
    agent{qu}=queen(age,food,pos,PARAM.QU_SPD,lbreed,homenest);
end

for la=nfo+nfe+nqu+1:nfo+nfe+nqu+nla
    homenest = nof_nests-mod(nof_nests+la,nof_nests);
    pos=nestcoloc(la-nfo-nfe-nqu,:);
    %create larvae agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+20;
    t_food = food;
    agent{la}=larva(age,food,pos,t_food,homenest);
end

MESSAGES.pos=[foloc;nestcoloc];
