function [nagent,nn]=agnt_solve(agent)

%sequence of functions called to apply agent rules to current agent population.
%%%%%%%%%%%%
%[nagent,nn]=agnt_solve(agent)
%%%%%%%%%%%
%agent - list of existing agent structures
%nagent - list of updated agent structures
%nn - total number of live agents at end of update

%Created by Dawn Walker 3/4/08

n=length(agent);    %current no. of agents
n_new=0;            %no. new agents
prev_n=n;           %remember current agent number at the start of this iteration

%execute existing agent update loop
for cn=1:n
    curr=agent{cn};

    if isa(curr,'larva')
        [curr,eaten]=eat(curr,cn);
        [curr,klld]=die(curr,cn,0);             %death rule (from starvation or old age)
        if klld==0
            new=[];
            [curr,new]=transform(curr,cn);
            if ~isempty(new)                    %if current agent has transformed during this iteration
                n_new=n_new+1;                  %increase new agent number
                agent{n+n_new}=new;             %add new to end of agent list
            end
        end
        agent{cn}=curr;                         %update cell array with modified agent data structure

    elseif isa(curr,'queen')
        [curr,eaten]=eat(curr,cn);              %eating rules
        [curr,klld]=die(curr,cn);               %death rule (from starvation or old age)
        if klld==0
            new=[];
            [curr,new]=breed(curr,cn);          %breeding rule
            if ~isempty(new)                    %if current agent has bred during this iteration
                 n_new=n_new+1;                 %increase new agent number
                 agent{n+n_new}=new;            %add new to end of agent list
            end
        end
        agent{cn}=curr;                         %update cell array with modified agent data structure

    elseif isa(curr,'forager')
        [curr,eaten]=eat(curr,cn);              %eating rules
        if eaten==0
            curr=migrate(curr,cn);              %if no food was eaten, then migrate in search of some
        end
        [curr,klld]=die(curr,cn);               %death rule (from starvation or old age)
        agent{cn}=curr;                         %update cell array with modified agent data structure

    elseif isa(curr,'feeder')
        [curr,eaten]=eat(curr,cn);              %eating rules
        [curr]=feed(curr,agent);             %feeding rules for queen and larvae agents in the nest
        [curr,klld]=die(curr,cn);               %death rule (from starvation or old age)
        agent{cn}=curr;                         %update cell array with modified agent data structure
    end
end

temp_n=n+n_new;                                     %new agent number (before accounting for agent deaths)
[nagent,nn]=update_messages(agent,prev_n,temp_n);   %function which update message list and 'kills off' dead agents.
