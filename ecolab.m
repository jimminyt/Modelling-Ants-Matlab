function ecolab(size,nfe,nfo,nqu,nla,nsteps,fmode,outImages)

%ECO_LAB  agent-based predator-prey model, developed for
%demonstration purposes only for University of Sheffield module
%COM3001/6006/6009

%AUTHOR Dawn Walker d.c.walker@sheffield.ac.uk
%Created April 2008

%ecolab(size,nr,nf,nsteps)
%size = size of model environmnet in km (sugested value for plotting
%purposes =50)
%nfe - initial number of feeder agents
%nfo - initial number of forager agents
%nqu - initial number of queens, and therefore nests
%nla - number of larva, if there are multiple nests they will be *insert
%      distribution info here*.
%nsteps - number of iterations required

%definition of global variables:
%N_IT - current iteration number
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc). iniitialised in initialise_results.m
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)

    %clear any global variables/ close figures from previous simulations
    clear global
    close all

    global N_IT IT_STATS ENV_DATA CONTROL_DATA

    if nargin == 6
        fmode=true;
        outImages=false;
    elseif nargin == 7
        outImages=false;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL INITIALISATION
    create_control;                     %sets up the parameters to control fmode (speed up the code during experimental testing
    create_params;                      %sets the parameters for this simulation
    create_environment(size,nqu);       %creates environment data structure, given an environment size
    random_selection(1);                %randomises random number sequence (NOT agent order). If input=0, then simulation should be identical to previous for same initial values
    [agent]=create_agents(nfe,nfo,nqu,nla);       %create n ants and places them in a cell array called 'agents'
    create_messages(nfe,nfo,nqu,nla,agent);       %sets up the initial message lists
    initialise_results(nfe,nfo,nqu,nla,nsteps);   %initilaises structure for storing results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL EXECUTION
    for n_it=1:nsteps                   %the main execution loop

        % pheromone decay
        for px=1:size
            for py=1:size
                if ENV_DATA.pheromone(px,py) < 0.05
                    ENV_DATA.pheromone(px,py) = 0;
                else
                    ENV_DATA.pheromone(px,py) = ENV_DATA.pheromone(px,py) * exp(-0.05);
                end
            end
        end
        % set IT nest stats

        nnests=length(ENV_DATA.nests);
        nfs = [0,0,0,0];
        for i = 1:nnests
            nfs(i) = extractfield(ENV_DATA.nests(i),"FoodLevel");
        end
        IT_STATS.n1food(n_it+1)=nfs(1);
        IT_STATS.n2food(n_it+1)=nfs(2);
        IT_STATS.n3food(n_it+1)=nfs(3);
        IT_STATS.n4food(n_it+1)=nfs(4);


        N_IT=n_it;
        [agent,n]=agnt_solve(agent);     %the function which calls the rules
        plot_results(agent,nsteps,fmode,outImages); %updates results figures and structures
        %mov(n_it)=getframe(fig3);
        if n<=0                          %if no more agents, then stop simulation
            break
            disp('General convergence criteria satisfied - no agents left alive! > ')
        end
        if fmode == true                                       % if fastmode is used ...
            for test_l=1 : 5                                    % this checks the total number agents and adjusts the CONTROL_DATA.fmode_display_every variable accoringly to help prevent extreme slowdown
                if n > CONTROL_DATA.fmode_control(1,test_l)     % CONTROL_DATA.fmode_control contains an array of thresholds for agent numbers and associated fmode_display_every values
                    CONTROL_DATA.fmode_display_every = CONTROL_DATA.fmode_control(2,test_l);
                end
            end
            if IT_STATS.qu_tot(n_it) == 0             %fastmode convergence - all queens are dead
                disp('Fast mode convergence criteria satisfied - no queens left alive! > ')
                break
            end
        end
    end
eval(['save results_nfe_' num2str(nfe) '_nfo_' num2str(nfo) '_nqu_' num2str(nqu) '_nla_' num2str(nla) '.mat IT_STATS ENV_DATA' ]);
clear global
