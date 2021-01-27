function create_messages(nfe,nfo,nqu,nla,agent)

%function that populates the global data structure representing
%message information

%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
  %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
  %    (1=feeder, 2=forager, 3=queen, 4=larva, 0=dead agent)
  %    MESSAGES.pos - list of every agent position in [x y]
  %    MESSAGE.dead - n x 1 array containing ones for agents that have died
  %    in the current iteration

global MESSAGES

for an=1:length(agent)
    if isa(agent{an},'feeder')
        MESSAGES.atype(an)=1;
        MESSAGES.pos(an,:)=get(agent{an},'pos');
    elseif isa(agent{an},'forager')
        MESSAGES.atype(an)=2;
        MESSAGES.pos(an,:)=get(agent{an},'pos');
    elseif isa(agent{an},'queen')
        MESSAGES.atype(an)=3;
        MESSAGES.pos(an,:)=get(agent{an},'pos');
    elseif isa(agent{an},'larva')
        MESSAGES.atype(an)=4;
        MESSAGES.pos(an,:)=get(agent{an},'pos');
    else
        MESSAGES.atype(an)=0; 
        MESSAGES.pos(an,:)=[-1 -1];
    end
    MESSAGES.dead(an)=0;
end
