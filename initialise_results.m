function initialise_results(nfe,nfo,nqu,nla,nsteps)

 global  IT_STATS ENV_DATA

%set up data structure to record statistics for each model iteration
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc)
%ENV_DATA - data structure representing the environment

 IT_STATS=struct('fe_div',[zeros(1,nsteps+1);],...            %no. births per iteration
                'fo_div',[zeros(1,nsteps+1)],...
                'qu_div',[zeros(1,nsteps+1);],...            %no. births per iteration
                'la_div',[zeros(1,nsteps+1)],...
                'fe_died',[zeros(1,nsteps+1)],...			%no. agents dying per iteration
                'fo_died',[zeros(1,nsteps+1)],...
                'qu_died',[zeros(1,nsteps+1)],...			%no. agents dying per iteration
                'la_died',[zeros(1,nsteps+1)],...
                'mig',[zeros(1,nsteps+1)],...                %no. agents migrating per iteration
                'tot',[zeros(1,nsteps+1)],...				%total no. agents in model per iteration
                'fe_tot',[zeros(1,nsteps+1)],...             % total no. feeders
                'fo_tot',[zeros(1,nsteps+1)],...             % total no. foragers
                'qu_tot',[zeros(1,nsteps+1)],...             % total no. queens
                'la_tot',[zeros(1,nsteps+1)],...             % total no. larvae
                'tfood',[zeros(1,nsteps+1)],...               %remaining vegetation level
                'n1food',[zeros(1,nsteps+1)],...               %remaining vegetation level
                'n2food',[zeros(1,nsteps+1)],...               %remaining vegetation level
                'n3food',[zeros(1,nsteps+1)],...               %remaining vegetation level
                'n4food',[zeros(1,nsteps+1)]);               %remaining vegetation level


 IT_STATS.tot(1)=nfe+nfo+nqu+nla;
 IT_STATS.fe_tot(1)=nfe;
 IT_STATS.fo_tot(1)=nfo;
 IT_STATS.qu_tot(1)=nqu;
 IT_STATS.la_tot(1)=nla;

 nfs = [0,0,0,0];
 nnests=length(ENV_DATA.nests);

 for i = 1:nnests
     nfs(i) = extractfield(ENV_DATA.nests(i),"FoodLevel");
 end

 n1f=sum(sum(ENV_DATA.food));            %remaining food is summed over all squares in the environment
 IT_STATS.n1food(1)=nfs(1);
 IT_STATS.n2food(1)=nfs(2);
 IT_STATS.n3food(1)=nfs(3);
 IT_STATS.n4food(1)=nfs(4);
 IT_STATS.tfood(1)=n1f;
